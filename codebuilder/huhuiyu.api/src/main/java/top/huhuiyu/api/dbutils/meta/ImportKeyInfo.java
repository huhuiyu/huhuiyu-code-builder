package top.huhuiyu.api.dbutils.meta;

import top.huhuiyu.api.beanutil.BaseInfoBean;

/**
 * 数据库外键信息
 *
 * @author 胡辉煜
 *
 */
public class ImportKeyInfo extends BaseInfoBean {
  private static final long serialVersionUID = -2920329271149493149L;
  /**
   * 列名称
   */
  private String columnName;
  /**
   * 参考列名称
   */
  private String importName;
  /**
   * 参考表名称
   */
  private String importTableName;

  public ImportKeyInfo() {
  }

  public String getColumnName() {
    return columnName;
  }

  public void setColumnName(String columnName) {
    this.columnName = columnName;
  }

  public String getImportName() {
    return importName;
  }

  public void setImportName(String importName) {
    this.importName = importName;
  }

  public String getImportTableName() {
    return importTableName;
  }

  public void setImportTableName(String importTableName) {
    this.importTableName = importTableName;
  }

}