package top.huhuiyu.api.dbutils.datasource;

import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import top.huhuiyu.api.fileutil.FileUtil;
import top.huhuiyu.api.utils.JsonUtils;

/**
 * 数据源构建器
 * 
 * @author 胡辉煜
 *
 */
public class DataSourceBuilder {
  private DataSourceBuilderConfig config;
  private Map<String, DriverInfo> driverInfoMap;
  private String database;
  private String ip;
  private String port;
  private String username;
  private String password;
  private String schema;

  public DataSourceBuilder() {
    // 读取配置信息
    try {
      String configInfo = FileUtil.readTextFile(DataSourceBuilder.class.getResourceAsStream("/DataSourceBuilder.json"));
      config = JsonUtils.parse(configInfo, DataSourceBuilderConfig.class);
      driverInfoMap = new HashMap<>(20);
      List<DriverInfo> driverInfos = config.getDriverInfos();
      for (DriverInfo driverInfo : driverInfos) {
        driverInfoMap.put(driverInfo.getName(), driverInfo);
      }
    } catch (Exception ex) {
      throw new RuntimeException(ex);
    }
  }

  /**
   * 设置数据源信息
   * 
   * @param database 数据库名称
   * @param ip       数据库ip地址或者域名
   * @param username 数据库用户名
   * @param password 数据库密码
   */
  public void setInfo(String database, String ip, String username, String password) {
    setInfo(database, ip, null, username, password, null);
  }

  /**
   * 设置数据源信息
   * 
   * @param database 数据库名称
   * @param ip       数据库ip地址或者域名
   * @param username 数据库用户名
   * @param password 数据库密码
   * @param port     数据库端口
   * @param schema   数据库架构名
   */
  public void setInfo(String database, String ip, String port, String username, String password, String schema) {
    setDatabase(database);
    setIp(ip);
    setPort(port);
    setUsername(username);
    setPassword(password);
    setSchema(schema);
  }

  /**
   * 获取MySQL数据源信息
   * 
   * @return MySQL数据源信息
   */
  public DataSourceInfo getMySQLDataSourceInfo() {
    return getDataSourceInfo("mysql");
  }

  /**
   * 获取SQL Server数据源信息
   * 
   * @return SQL Server数据源信息
   */
  public DataSourceInfo getMSSQLDataSourceInfo() {
    return getDataSourceInfo("mssql");
  }

  /**
   * 获取oracle数据源信息
   * 
   * @return oracle数据源信息
   */
  public DataSourceInfo getOracleDataSourceInfo() {
    return getDataSourceInfo("oracle");
  }

  /**
   * 获取驱动信息对应的数据源信息
   * 
   * @param driverInfo 驱动信息
   * 
   * @return 数据源信息
   */
  public DataSourceInfo getDataSourceInfo(DriverInfo driverInfo) {
    DataSourceInfo dataSourceInfo = new DataSourceInfo();
    dataSourceInfo.setDriver(driverInfo.getDriver());
    dataSourceInfo.setUsername(username);
    dataSourceInfo.setPassword(password);
    String url = driverInfo.getUrlTemplate();
    url = url.replace("${ip}", ip);
    url = url.replace("${port}", port);
    url = url.replace("${database}", database);
    dataSourceInfo.setUrl(url);
    return dataSourceInfo;
  }

  private DataSourceInfo getDataSourceInfo(String type) {
    return getDataSourceInfo(driverInfoMap.get(type));
  }

  /**
   * 获取驱动模板信息
   * 
   * @return 驱动模板信息
   */
  public Map<String, DriverInfo> getDriverInfoMap() {
    return Collections.unmodifiableMap(driverInfoMap);
  }

  public String getDatabase() {
    return database;
  }

  public void setDatabase(String database) {
    this.database = database;
  }

  public String getIp() {
    return ip;
  }

  public void setIp(String ip) {
    this.ip = ip;
  }

  public String getPort() {
    return port;
  }

  public void setPort(String port) {
    this.port = port;
  }

  public String getUsername() {
    return username;
  }

  public void setUsername(String username) {
    this.username = username;
  }

  public String getPassword() {
    return password;
  }

  public void setPassword(String password) {
    this.password = password;
  }

  public String getSchema() {
    return schema;
  }

  public void setSchema(String schema) {
    this.schema = schema;
  }

}
