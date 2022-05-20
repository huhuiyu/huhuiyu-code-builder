package ${builderUtil.getSubPackage("ws.base")};

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import ${builderUtil.getSubPackage("base")}.BaseEntity;

/**
 * 请求参数类型
 * 
 * @author ${baseInfo.author}
 *
 */
@Getter
@Setter
@NoArgsConstructor
public class BaseParameter extends BaseEntity {
  private static final long serialVersionUID = ${builderUtil.serialVersionUid};
  /**
   * 请求的动作（时间戳回应）
   */
  public static final String ACTION_TIMESTAMP = "timestamp";
  
  /**
   * 请求的动作
   */
  String action;

}
