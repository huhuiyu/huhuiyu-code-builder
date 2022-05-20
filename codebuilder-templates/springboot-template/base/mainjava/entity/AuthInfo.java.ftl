package ${builderUtil.getSubPackage("entity")};

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import ${builderUtil.getSubPackage("base")}.BaseEntity;

/**
 * 保存在请求中的认证信息
 * 
 * @author ${baseInfo.author}
 *
 */
@Component
@Scope("request")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class AuthInfo extends BaseEntity {

  private static final long serialVersionUID = ${builderUtil.serialVersionUid};
  private String token;
  private TbUser loginUser;
  private String ip;

}
