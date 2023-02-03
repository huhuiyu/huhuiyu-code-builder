package top.huhuiyu.codebuilder.ui;

import java.io.Serializable;

/**
 * 默认配置信息
 * 
 * @author 胡辉煜
 *
 */
public class DefaultInfoParameter implements Serializable {

  private static final long serialVersionUID = -3412967848537719355L;
  private String project;
  private String packageName;
  private String author;
  private String ip;
  private String port;
  private String username;
  private String password;
  private String database;
  private String outputDir;

  private String redisDatabase;
  private String redisHost;
  private String redisPort;
  private String redisPassword;

  public DefaultInfoParameter() {
  }

  public DefaultInfoParameter(String project, String packageName, String author, String ip, String port, String username, String password, String database, String outputDir, String redisDatabase,
      String redisHost, String redisPort, String redisPassword) {
    this.project = project;
    this.packageName = packageName;
    this.author = author;
    this.ip = ip;
    this.port = port;
    this.username = username;
    this.password = password;
    this.database = database;
    this.outputDir = outputDir;
    this.redisDatabase = redisDatabase;
    this.redisHost = redisHost;
    this.redisPort = redisPort;
    this.redisPassword = redisPassword;
  }

  public String getProject() {
    return project;
  }

  public void setProject(String project) {
    this.project = project;
  }

  public String getPackageName() {
    return packageName;
  }

  public void setPackageName(String packageName) {
    this.packageName = packageName;
  }

  public String getAuthor() {
    return author;
  }

  public void setAuthor(String author) {
    this.author = author;
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

  public String getDatabase() {
    return database;
  }

  public void setDatabase(String database) {
    this.database = database;
  }

  public String getOutputDir() {
    return outputDir;
  }

  public void setOutputDir(String outputDir) {
    this.outputDir = outputDir;
  }

  public String getRedisDatabase() {
    return redisDatabase;
  }

  public void setRedisDatabase(String redisDatabase) {
    this.redisDatabase = redisDatabase;
  }

  public String getRedisHost() {
    return redisHost;
  }

  public void setRedisHost(String redisHost) {
    this.redisHost = redisHost;
  }

  public String getRedisPort() {
    return redisPort;
  }

  public void setRedisPort(String redisPort) {
    this.redisPort = redisPort;
  }

  public String getRedisPassword() {
    return redisPassword;
  }

  public void setRedisPassword(String redisPassword) {
    this.redisPassword = redisPassword;
  }
}