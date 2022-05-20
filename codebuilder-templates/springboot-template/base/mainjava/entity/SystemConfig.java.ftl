package ${builderUtil.getSubPackage("entity")};

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import ${builderUtil.getSubPackage("base")}.BaseEntity;

/**
 * 系统配置信息
 * 
 * @author ${baseInfo.author}
 *
 */
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class SystemConfig extends BaseEntity {

  private static final long serialVersionUID = ${builderUtil.serialVersionUid};

  /**
   * token超时时间（秒）
   */
  private Integer tokenTimeout = 7 * 24 * 60 * 60;
  /**
   * 图片校验码干扰线数量
   */
  private Integer imageCodeAmount = 10;
  /**
   * 图片校验码长度
   */
  private Integer imageCodeLength = 5;
  /**
   * 同一个ip最大新token数量限制
   */
  private Integer ipMaxTokenCount = 10;
  /**
   * ip锁定时间（秒）
   */
  private Integer ipBanTimeout = 60;
  /**
   * 文件上传路径
   */
  private String uploadDir = "files/";
  /**
   * 登录密码最大错误次数
   */
  private Integer loginPasswordErrorLimit = 10;
  /**
   * 密码错误锁定时间（秒）
   */
  private Integer loginPasswordErrorTimeout = 60;
}
