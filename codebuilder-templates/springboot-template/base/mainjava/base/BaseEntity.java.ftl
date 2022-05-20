package ${builderUtil.getSubPackage("base")};

import java.io.Serializable;

import ${builderUtil.getSubPackage("utils")}.JsonUtil;

/**
 * 实体类基类
 * 
 * @author ${baseInfo.author}
 *
 */
public abstract class BaseEntity implements Serializable {

  private static final long serialVersionUID = ${builderUtil.serialVersionUid};

  @Override
  public String toString() {
    try {
      return JsonUtil.stringify(this);
    } catch (Exception ex) {
      throw new RuntimeException(ex);
    }
  }
}
