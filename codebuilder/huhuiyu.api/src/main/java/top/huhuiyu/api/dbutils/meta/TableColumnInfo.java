package top.huhuiyu.api.dbutils.meta;

import top.huhuiyu.api.beanutil.BaseInfoBean;

/**
 * 表的列信息
 * 
 * @author 胡辉煜
 *
 */
public class TableColumnInfo extends BaseInfoBean {

  private static final long serialVersionUID = 2735038495296093997L;
  private String name;
  private String className;
  private int displaySize;
  private String label;
  private int type;
  private String typeName;
  private int precision;
  private int scale;
  private boolean autoIncrement;
  private boolean currency;
  private boolean nullable;
  private boolean primaryKey;
  private ImportKeyInfo importKeyInfo;

  public TableColumnInfo() {
  }

  public TableColumnInfo(String name, String className, int displaySize, String label, int type, String typeName, int precision, int scale, boolean autoIncrement, boolean currency, boolean nullable) {
    this.name = name;
    this.className = className;
    this.displaySize = displaySize;
    this.label = label;
    this.type = type;
    this.typeName = typeName;
    this.precision = precision;
    this.scale = scale;
    this.autoIncrement = autoIncrement;
    this.currency = currency;
    this.nullable = nullable;
  }

  public String getName() {
    return name;
  }

  public void setName(String name) {
    this.name = name;
  }

  public String getClassName() {
    return className;
  }

  public void setClassName(String className) {
    this.className = className;
  }

  public int getDisplaySize() {
    return displaySize;
  }

  public void setDisplaySize(int displaySize) {
    this.displaySize = displaySize;
  }

  public String getLabel() {
    return label;
  }

  public void setLabel(String label) {
    this.label = label;
  }

  public int getType() {
    return type;
  }

  public void setType(int type) {
    this.type = type;
  }

  public String getTypeName() {
    return typeName;
  }

  public void setTypeName(String typeName) {
    this.typeName = typeName;
  }

  public int getPrecision() {
    return precision;
  }

  public void setPrecision(int precision) {
    this.precision = precision;
  }

  public int getScale() {
    return scale;
  }

  public void setScale(int scale) {
    this.scale = scale;
  }

  public boolean isAutoIncrement() {
    return autoIncrement;
  }

  public void setAutoIncrement(boolean autoIncrement) {
    this.autoIncrement = autoIncrement;
  }

  public boolean isCurrency() {
    return currency;
  }

  public void setCurrency(boolean currency) {
    this.currency = currency;
  }

  public boolean isNullable() {
    return nullable;
  }

  public void setNullable(boolean nullable) {
    this.nullable = nullable;
  }

  public boolean isPrimaryKey() {
    return primaryKey;
  }

  public void setPrimaryKey(boolean isPrimary) {
    this.primaryKey = isPrimary;
  }

  public ImportKeyInfo getImportKeyInfo() {
    return importKeyInfo;
  }

  public void setImportKeyInfo(ImportKeyInfo importKeyInfo) {
    this.importKeyInfo = importKeyInfo;
  }

}
