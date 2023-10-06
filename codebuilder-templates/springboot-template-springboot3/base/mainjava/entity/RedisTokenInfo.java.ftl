package ${builderUtil.getSubPackage("entity")};

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import ${builderUtil.getSubPackage("base")}.BaseEntity;

/**
 * redis中的关联token的信息
 * 
 * @author ${baseInfo.author}
 *
 */
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class RedisTokenInfo extends BaseEntity {
  private static final long serialVersionUID = ${builderUtil.serialVersionUid};
  private String ip;
  private TbUser tbUser;
}
