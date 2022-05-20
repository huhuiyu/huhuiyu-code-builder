package top.huhuiyu.api.dbutils.meta;

import java.util.ArrayList;
import java.util.List;
import top.huhuiyu.api.beanutil.BaseInfoBean;
import top.huhuiyu.api.utils.StringUtils;

/**
 * 表信息
 * 
 * @author 胡辉煜
 */
public class TableInfo extends BaseInfoBean {
  private static final long serialVersionUID = -1750488227458775097L;

  private String database;
  private String user;
  private String name;
  private List<TableColumnInfo> columnInfos = new ArrayList<>();
  private List<String> pks = new ArrayList<>();
  private List<ImportKeyInfo> fks = new ArrayList<>();

  public TableInfo() {
  }

  public TableInfo(String database, String user, String name) {
    this.database = database;
    this.user = user;
    this.name = name;
  }

  public String getDatabase() {
    return database;
  }

  public void setDatabase(String database) {
    this.database = database;
  }

  public String getUser() {
    return user;
  }

  public void setUser(String user) {
    this.user = user;
  }

  public String getName() {
    return name;
  }

  public void setName(String name) {
    this.name = name;
  }

  public List<TableColumnInfo> getColumnInfos() {
    return columnInfos;
  }

  public void setColumnInfos(List<TableColumnInfo> columnInfos) {
    this.columnInfos = columnInfos;
  }

  public List<String> getPks() {
    return pks;
  }

  public void setPks(List<String> pks) {
    this.pks = pks;
  }

  public List<ImportKeyInfo> getFks() {
    return fks;
  }

  public void setFks(List<ImportKeyInfo> fks) {
    this.fks = fks;
  }

  /**
   * 获取列的外键信息(不是外键返回null)
   * 
   * @param col 列名称
   * 
   * @return col的外键信息
   */
  public ImportKeyInfo getImportInfo(String col) {
    col = StringUtils.trim(col);
    if ("".equals(col)) {
      return null;
    }
    for (ImportKeyInfo ik : fks) {
      if (col.equals(ik.getColumnName())) {
        return ik;
      }
    }
    return null;
  }

  /**
   * 获取主键列集合
   * 
   * @return 主键列集合
   */
  public List<TableColumnInfo> getPrimaryKeys() {
    List<TableColumnInfo> list = new ArrayList<>();
    for (TableColumnInfo tableColumnInfo : columnInfos) {
      if (tableColumnInfo.isPrimaryKey()) {
        list.add(tableColumnInfo);
      }
    }
    return list;
  }

  /**
   * 获取非主键列集合
   * 
   * @return 非主键列集合
   */
  public List<TableColumnInfo> getNotPrimaryKeys() {
    List<TableColumnInfo> list = new ArrayList<>();
    for (TableColumnInfo tableColumnInfo : columnInfos) {
      if (!tableColumnInfo.isPrimaryKey()) {
        list.add(tableColumnInfo);
      }
    }
    return list;
  }
}