package ${builderUtil.getSubPackage("ws.entity")};

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import ${builderUtil.getSubPackage("ws.base")}.BaseParameter;

/**
 * 聊天信息
 * 
 * @author ${baseInfo.author}
 *
 */
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class ChatInfo extends BaseParameter {
  private static final long serialVersionUID = ${builderUtil.serialVersionUid};
  private String name;
  private String info;

}
