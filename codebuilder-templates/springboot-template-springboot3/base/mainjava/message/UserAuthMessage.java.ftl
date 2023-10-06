package ${builderUtil.getSubPackage("message")};

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import ${builderUtil.getSubPackage("base")}.BaseResult;
import ${builderUtil.getSubPackage("entity")}.TbUser;

/**
 * 用户信息应答消息
 * 
 * @author ${baseInfo.author}
 *
 */
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ApiModel(value = "用户信息应答", description = "用户信息应答")
public class UserAuthMessage extends BaseResult {
  private static final long serialVersionUID = ${builderUtil.serialVersionUid};

  @ApiModelProperty(value = "用户信息")
  private TbUser tbUser;

}
