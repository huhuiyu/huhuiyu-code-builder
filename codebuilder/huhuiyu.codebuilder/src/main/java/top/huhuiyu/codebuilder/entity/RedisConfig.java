package top.huhuiyu.codebuilder.entity;

import java.io.Serializable;

/**
 * redis配置信息
 * 
 * @author 胡辉煜
 *
 */
public class RedisConfig implements Serializable {

  private static final long serialVersionUID = -6015946590768891573L;

  private String database;
  private String host;
  private String port;
  private String password;

  public RedisConfig() {
  }

  public RedisConfig(String database, String host, String port, String password) {
    this.database = database;
    this.host = host;
    this.port = port;
    this.password = password;
  }

  public String getDatabase() {
    return database;
  }

  public void setDatabase(String database) {
    this.database = database;
  }

  public String getHost() {
    return host;
  }

  public void setHost(String host) {
    this.host = host;
  }

  public String getPort() {
    return port;
  }

  public void setPort(String port) {
    this.port = port;
  }

  public String getPassword() {
    return password;
  }

  public void setPassword(String password) {
    this.password = password;
  }

}
