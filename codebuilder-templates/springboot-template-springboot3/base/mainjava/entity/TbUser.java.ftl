package ${builderUtil.getSubPackage("entity")};

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Pattern;

import com.baomidou.mybatisplus.annotation.FieldStrategy;
import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import io.swagger.annotations.ApiParam;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import ${builderUtil.getSubPackage("base")}.BaseEntity;
import ${builderUtil.getSubPackage("utils")}.SystemConstants;
import ${builderUtil.getSubPackage("validate")}.UserAuthValidate;

/**
 * tb_user表
 * 
 * @author ${baseInfo.author}
 */
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ApiModel(value = "用户基本信息")
public class TbUser extends BaseEntity {

  private static final long serialVersionUID = ${builderUtil.serialVersionUid};

  @TableId(type = IdType.AUTO)
  @ApiModelProperty(value = "用户编号", example = "100")
  @ApiParam(hidden = true)
  private java.lang.Integer uid;
  @NotBlank(message = "登录名必须填写", groups = { UserAuthValidate.Auth.class, UserAuthValidate.Info.class })
  @Pattern(regexp = SystemConstants.USERNAME_CHECK, message = "登录名必须是4-16位长度的字母和数字以及_-的组合，必须是字母开头", groups = { UserAuthValidate.Auth.class, UserAuthValidate.Info.class })
  @ApiModelProperty(value = "登录名", example = "user")
  @ApiParam(hidden = true)
  private java.lang.String username;
  @NotBlank(message = "密码必须填写", groups = { UserAuthValidate.Auth.class, UserAuthValidate.Info.class, UserAuthValidate.Password.class })
  @Pattern(regexp = SystemConstants.MD5_CHECK, message = "密码必须md5加密", groups = { UserAuthValidate.Auth.class, UserAuthValidate.Info.class })
  @ApiModelProperty(value = "密码", example = "900150983cd24fb0d6963f7d28e17f72")
  @ApiParam(hidden = true)
  private java.lang.String password;
  @ApiModelProperty(hidden = true)
  @ApiParam(hidden = true)
  private java.lang.String salt;
  @NotBlank(message = "用户名必须填写", groups = { UserAuthValidate.Info.class })
  @ApiModelProperty(value = "用户名", example = "黑暗骑士")
  @ApiParam(hidden = true)
  private java.lang.String nickname;
  @ApiModelProperty(value = "二次开发key", example = "55172732-xxxx-yyyy-zzzz-ecb08d2cce66")
  @ApiParam(hidden = true)
  private java.lang.String accessKey;
  @ApiModelProperty(value = "用户角色", example = "user")
  @ApiParam(hidden = true)
  private java.lang.String role;
  @ApiModelProperty(value = "是否启用（y/n）", example = "y")
  @ApiParam(hidden = true)
  private java.lang.String enable;
  @TableField(updateStrategy = FieldStrategy.NEVER, insertStrategy = FieldStrategy.NEVER)
  @ApiModelProperty(value = "信息最后修改时间")
  @ApiParam(hidden = true)
  private java.util.Date lastupdate;

}