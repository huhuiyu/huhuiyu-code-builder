package top.huhuiyu.codebuilder.entity;

import java.io.Serializable;

/**
 * 应用配置文件
 *
 * @author 胡辉煜
 */
public class Config implements Serializable {

  private static final long serialVersionUID = 2147326265239491545L;
  private String templateConfigFile;

  public Config() {
  }

  public String getTemplateConfigFile() {
    return templateConfigFile;
  }

  public void setTemplateConfigFile(String templateConfigFile) {
    this.templateConfigFile = templateConfigFile;
  }

}
