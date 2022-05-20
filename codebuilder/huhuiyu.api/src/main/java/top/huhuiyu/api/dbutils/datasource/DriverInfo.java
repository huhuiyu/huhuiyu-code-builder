package top.huhuiyu.api.dbutils.datasource;

import top.huhuiyu.api.beanutil.BaseInfoBean;

/**
 * 驱动模板信息
 * 
 * @author 胡辉煜
 *
 */
public class DriverInfo extends BaseInfoBean {
  private static final long serialVersionUID = -3675383923071212216L;
  private String name;
  private String description;
  private String driver;
  private String urlTemplate;

  public DriverInfo() {
  }

  public String getName() {
    return name;
  }

  public void setName(String name) {
    this.name = name;
  }

  public String getDescription() {
    return description;
  }

  public void setDescription(String description) {
    this.description = description;
  }

  public String getDriver() {
    return driver;
  }

  public void setDriver(String driver) {
    this.driver = driver;
  }

  public String getUrlTemplate() {
    return urlTemplate;
  }

  public void setUrlTemplate(String urlTemplate) {
    this.urlTemplate = urlTemplate;
  }

}
