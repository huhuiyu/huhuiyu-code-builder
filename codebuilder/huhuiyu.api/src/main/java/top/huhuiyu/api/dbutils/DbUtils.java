package top.huhuiyu.api.dbutils;

import top.huhuiyu.api.dbutils.meta.TableColumnInfo;
import top.huhuiyu.api.dbutils.meta.TableInfo;
import top.huhuiyu.api.utils.StringUtils;

/**
 * 数据库工具集
 * 
 * @author 胡辉煜
 */
public class DbUtils {
  public static final String DB_SPLIT = "_";
  public static final String IS = "is";
  public static final String GET = "get";
  public static final String SET = "set";
  public static final int FIDLE_MIN_LENGTH = 2;
  public static final String GETTER = "get%s";
  public static final String SETTER = "set%s";
  public static final String IS_GETTER = "is%s";

  /**
   * 获取名称对应的字段名称
   * 
   * @param name 对象名
   * 
   * @return 名称对应的字段名称
   */
  public String getFieldName(String name) {
    name = StringUtils.trim(name);
    if (name.length() <= FIDLE_MIN_LENGTH) {
      return name.toLowerCase();
    } else {
      return name.substring(0, FIDLE_MIN_LENGTH).toLowerCase() + name.substring(FIDLE_MIN_LENGTH);
    }
  }

  /**
   * 获取表对应的实体类名称
   *
   * @param tableName 表名称
   * 
   * @return 表对应的实体类名称
   */
  public String getEntityName(String tableName) {
    if (tableName == null || tableName.trim().equals("")) {
      return tableName;
    }
    String[] entitys = tableName.trim().split(DB_SPLIT);
    StringBuilder entity = new StringBuilder();
    for (String info : entitys) {
      entity.append(StringUtils.firstToUpper(info));
    }
    return entity.toString();
  }

  /**
   * 获取表对应的实体类名称
   *
   * @param tableInfo 表信息
   * 
   * @return 表对应的实体类名称
   */
  public String getEntityName(TableInfo tableInfo) {
    return getEntityName(tableInfo.getName());
  }

  /**
   * 获取表名对应的getter名称
   * 
   * @param tableName 表名称
   * 
   * @return 表对应的getter名称
   */
  public String getTableGetter(String tableName) {
    return String.format(GETTER, getEntityName(tableName));
  }

  /**
   * 获取表名对应的getter名称
   * 
   * @param tableInfo 表信息
   * 
   * @return 表对应的getter名称
   */
  public String getTableGetter(TableInfo tableInfo) {
    return String.format(GETTER, getEntityName(tableInfo.getName()));
  }

  /**
   * 获取表名对应的setter名称
   * 
   * @param tableName 表名称
   * 
   * @return 表对应的setter名称
   */
  public String getTableSetter(String tableName) {
    return String.format(SETTER, getEntityName(tableName));
  }

  /**
   * 获取表对应的setter名称
   * 
   * @param tableInfo 表信息
   * 
   * @return 表对应的setter名称
   */
  public String getTableSetter(TableInfo tableInfo) {
    return String.format(SETTER, getEntityName(tableInfo.getName()));
  }

  /**
   * 获取表对应的实体类字段名称
   *
   * @param tableName 表名称
   * 
   * @return 表对应的实体类字段名称
   */
  public String getEntityFieldName(String tableName) {
    return getFieldName(getEntityName(tableName));
  }

  /**
   * 获取表对应的实体类字段名称
   *
   * @param tableInfo 表信息
   * 
   * @return 表对应的实体类字段名称
   */
  public String getEntityFieldName(TableInfo tableInfo) {
    return getFieldName(getEntityName(tableInfo.getName()));
  }

  /**
   * 转换数据库列名称为java字段名称
   *
   * @param columnName 数据库列名称
   * 
   * @return java字段名称
   */
  public String getJavaFieldName(String columnName) {
    if (columnName == null || columnName.trim().equals("")) {
      return columnName;
    }
    String field = columnName.trim();
    if (field.length() <= FIDLE_MIN_LENGTH || field.equals(field.toUpperCase())) {
      // 字段如果是全部大写或者长度小于等于最小长度要求就全部转换成小写
      field = field.toLowerCase();
    } else {
      // 否则确保前二字符小写
      field = getEntityFieldName(field);
      field = field.substring(0, 2).toLowerCase() + field.substring(2);
    }
    return field;
  }

  /**
   * 转换数据库列名称为java字段名称
   *
   * @param columnInfo 数据库列名称
   * 
   * @return java字段名称
   */
  public String getJavaFieldName(TableColumnInfo columnInfo) {
    return getJavaFieldName(columnInfo.getName());
  }

  /**
   * 获取数据库字段的java getter名称
   *
   * @param columnName 数据库字段名称
   * @param className  字段的java类名
   * 
   * @return 数据库字段的java getter名称
   */
  public String getJavaGetter(String columnName, String className) {
    String result = StringUtils.firstToUpper(getJavaFieldName(columnName));
    if (className.equals(Boolean.class.getName()) || className.equals(boolean.class.getName())) {
      return String.format(IS_GETTER, result);
    } else {
      return String.format(GETTER, result);
    }
  }

  /**
   * 获取数据库字段的java getter名称
   *
   * @param columnInfo 数据库字段信息
   * 
   * @return 数据库字段的java getter名称
   */
  public String getJavaGetter(TableColumnInfo columnInfo) {
    return getJavaGetter(columnInfo.getName(), columnInfo.getClassName());
  }

  /**
   * 获取数据库字段的java setter名称
   *
   * @param columnName 数据库字段名称
   * 
   * @return 数据库字段的java setter名称
   */
  public String getJavaSetter(String columnName) {
    String result = StringUtils.firstToUpper(getJavaFieldName(columnName));
    return String.format(SETTER, result);
  }

  /**
   * 获取数据库字段的java setter名称
   *
   * @param columnInfo 数据库字段信息
   * 
   * @return 数据库字段的java setter名称
   */
  public String getJavaSetter(TableColumnInfo columnInfo) {
    return getJavaSetter(columnInfo.getName());
  }

}
