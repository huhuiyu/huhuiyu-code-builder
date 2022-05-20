package top.huhuiyu.api.dbutils.meta;

import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import top.huhuiyu.api.dbutils.datasource.DataSourceInfo;

/**
 * 数据库元数据工具
 * 
 * @author 胡辉煜
 *
 */
public class MetaUtilsBean {

  private static final Logger log = LoggerFactory.getLogger(MetaUtilsBean.class);
  public static final String TABLE_QUERY = "SELECT * FROM %s WHERE 1=2";
  public static final String TABLE_INFO_JOIN = ".";

  private DataSourceInfo dataSourceInfo;
  private String schema;

  public MetaUtilsBean(DataSourceInfo dataSourceInfo) {
    this(dataSourceInfo, null);
  }

  public MetaUtilsBean(DataSourceInfo dataSourceInfo, String schame) {
    this.dataSourceInfo = dataSourceInfo;
    this.schema = schame;
  }

  public List<TableInfo> processMetaInfo() {
    try {
      List<TableInfo> tables = new ArrayList<>();
      processTable(tables);
      processTableColumn(tables);

      return tables;
    } catch (Exception ex) {
      throw new RuntimeException(ex);
    }
  }

  private void processTable(List<TableInfo> tables) throws Exception {
    Connection conn = getConnection();
    String[] tableTypes = new String[] { "TABLE" };
    DatabaseMetaData meta = conn.getMetaData();
    // 表基本信息
    ResultSet rsTable = meta.getTables(conn.getCatalog(), schema, "%", tableTypes);
    while (rsTable.next()) {
      TableInfo table = new TableInfo(rsTable.getString(1), rsTable.getString(2), rsTable.getString(3));
      log.debug(String.format("表信息：%s", table));
      // 表主键信息
      ResultSet rsKey = meta.getPrimaryKeys(table.getDatabase(), table.getUser(), table.getName());
      while (rsKey.next()) {
        table.getPks().add(rsKey.getString(4));
      }
      rsKey.close();
      // 表外键信息
      rsKey = meta.getImportedKeys(table.getDatabase(), table.getUser(), table.getName());
      while (rsKey.next()) {
        ImportKeyInfo keyInfo = new ImportKeyInfo();
        keyInfo.setColumnName(rsKey.getString(8));
        keyInfo.setImportName(rsKey.getString(4));
        keyInfo.setImportTableName(rsKey.getString(3));
        table.getFks().add(keyInfo);
      }
      rsKey.close();
      tables.add(table);
    }
    rsTable.close();
    conn.close();
  }

  private void processTableColumn(List<TableInfo> tables) throws Exception {
    List<TableInfo> removeTables = new ArrayList<>();
    Connection conn = getConnection();
    Statement statement = conn.createStatement();
    for (TableInfo tableInfo : tables) {
      String tableName = tableInfo.getName();
      ResultSet rs = null;
      try {
        // 尝试执行基础的表查询
        rs = statement.executeQuery(String.format(TABLE_QUERY, tableName));
      } catch (Exception ex) {
        log.error("", ex);
        if (rs != null) {
          rs.close();
        }
        rs = null;
      }
      String user = tableInfo.getUser();
      boolean nouser = (user == null || "".equals(user));
      if (rs == null && nouser) {
        try {
          // 尝试执行带用户的表查询
          tableName = String.format("%s%s%s", tableInfo.getUser(), TABLE_INFO_JOIN, tableInfo.getUser());
          rs = statement.executeQuery(String.format(TABLE_QUERY, tableName));
        } catch (Exception ex) {
          log.error("", ex);
          if (rs != null) {
            rs.close();
          }
          rs = null;
        }
      }
      if (rs == null) {
        log.error(String.format("跳过了表：%s", tableInfo.getName()));
        removeTables.add(tableInfo);
        continue;
      }
      processTableColumnInfo(rs, tableInfo);
      rs.close();
    }
    conn.close();
    tables.removeAll(removeTables);
  }

  private void processTableColumnInfo(ResultSet rs, TableInfo tableInfo) throws Exception {
    ResultSetMetaData rsmeta = rs.getMetaData();
    for (int i = 1; i <= rsmeta.getColumnCount(); i++) {
      TableColumnInfo columnInfo = new TableColumnInfo(rsmeta.getColumnName(i), rsmeta.getColumnClassName(i), rsmeta.getColumnDisplaySize(i), rsmeta.getColumnLabel(i), rsmeta.getColumnType(i),
          rsmeta.getColumnTypeName(i), rsmeta.getPrecision(i), rsmeta.getScale(i), rsmeta.isAutoIncrement(i), rsmeta.isCurrency(i), (rsmeta.isNullable(i) == 1));
      log.debug(String.format("%s的列信息：%s", tableInfo.getName(), columnInfo));
      columnInfo.setPrimaryKey(tableInfo.getPks().contains(columnInfo.getName()));
      columnInfo.setImportKeyInfo(tableInfo.getImportInfo(columnInfo.getName()));
      tableInfo.getColumnInfos().add(columnInfo);
    }
  }

  private Connection getConnection() throws Exception {
    Class.forName(dataSourceInfo.getDriver());
    Connection connection = DriverManager.getConnection(dataSourceInfo.getUrl(), dataSourceInfo.getUsername(), dataSourceInfo.getPassword());
    return connection;
  }

}
