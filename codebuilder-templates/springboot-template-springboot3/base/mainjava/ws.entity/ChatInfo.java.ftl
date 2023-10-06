package ${builderUtil.getSubPackage("ws.entity")};

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import ${builderUtil.getSubPackage("base")}.BaseEntity;

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
public class ChatInfo extends BaseEntity {
  private static final long serialVersionUID = ${builderUtil.serialVersionUid};
  private String name;
  private String info;

}
