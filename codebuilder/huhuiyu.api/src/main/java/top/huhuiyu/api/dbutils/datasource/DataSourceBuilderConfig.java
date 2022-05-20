package top.huhuiyu.api.dbutils.datasource;

import java.util.List;

import top.huhuiyu.api.beanutil.BaseInfoBean;

/**
 * 数据源构造器配置信息
 * 
 * @author 胡辉煜
 *
 */
public class DataSourceBuilderConfig extends BaseInfoBean {
  private static final long serialVersionUID = 901470952555532664L;

  private List<DriverInfo> driverInfos;

  public DataSourceBuilderConfig() {
  }

  public List<DriverInfo> getDriverInfos() {
    return driverInfos;
  }

  public void setDriverInfos(List<DriverInfo> driverInfos) {
    this.driverInfos = driverInfos;
  }

}
