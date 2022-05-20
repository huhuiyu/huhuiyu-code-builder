package top.huhuiyu.api.dbutils.datasource;

import top.huhuiyu.api.beanutil.BaseInfoBean;

/**
 * 数据源信息
 *
 * @author 胡辉煜
 *
 */
public class DataSourceInfo extends BaseInfoBean {

  private static final long serialVersionUID = -8467345037042645182L;
  private String url;
  private String username;
  private String password;
  private String driver;

  public DataSourceInfo() {
  }

  public DataSourceInfo(String url, String username, String password, String driver) {
    this.url = url;
    this.username = username;
    this.password = password;
    this.driver = driver;
  }

  public String getUrl() {
    return url;
  }

  public void setUrl(String url) {
    this.url = url;
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

  public String getDriver() {
    return driver;
  }

  public void setDriver(String driver) {
    this.driver = driver;
  }

}
