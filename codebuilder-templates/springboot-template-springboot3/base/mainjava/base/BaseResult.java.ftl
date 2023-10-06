package ${builderUtil.getSubPackage("base")};

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import ${builderUtil.getSubPackage("utils")}.SystemConstants;

/**
 * 基础应答对象
 * 
 * @author ${baseInfo.author}
 *
 */
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ApiModel(value = "基础应答", description = "最基本的应答信息")
public class BaseResult extends BaseEntity {

  private static final long serialVersionUID = ${builderUtil.serialVersionUid};

  /**
   * code:服务器应答代码
   */
  @ApiModelProperty(value = "应答代码")
  private int code = SystemConstants.ERROR_CODE;
  /**
   * message：服务器应答信息，默认为空
   */
  @ApiModelProperty(value = "应答消息")
  private String message = "";

  /**
   * success：服务器是否正确应答，默认为false
   */
  @ApiModelProperty(value = "成功应答")
  private boolean success = false;

  /**
   * 服务器token信息
   */
  @ApiModelProperty(value = "token令牌")
  private String token;

  /**
   * 设置标准的应答信息
   * 
   * @param success 是否成功应答
   * @param code    服务器应答code
   * @param message 服务器应答信息
   * 
   */
  public void setInfo(boolean success, int code, String message) {
    this.setCode(code);
    this.setSuccess(success);
    this.setMessage(message);
  }

  /**
   * 设置成功的应答信息
   * 
   * @param message 服务器应答信息
   * 
   */
  public void setSuccessInfo(String message) {
    this.setInfo(true, SystemConstants.OK_CODE, message);
  }

  /**
   * 设置失败的应答信息
   * 
   * @param message 服务器应答信息
   * 
   */
  public void setFailInfo(String message) {
    this.setInfo(false, SystemConstants.ERROR_CODE, message);
  }

  /**
   * 设置指定code的失败应答信息
   * 
   * @param code    服务器应答code
   * @param message 服务器应答信息
   * 
   */
  public void setFailInfo(int code, String message) {
    this.setInfo(false, code, message);
  }

  /**
   * 静态工厂方法，获取一个基础无应答数据的BaseResult的实例
   * 
   * @param success 是否成功应答
   * @param code    服务器应答code
   * @param message 服务器应答信息
   * 
   * @return 基础无应答数据的BaseResult的实例
   */
  public static BaseResult getBaseResult(boolean success, int code, String message) {
    BaseResult result = new BaseResult();
    result.setInfo(success, code, message);
    return result;
  }

  /**
   * 委托方法，获取成功的应答
   * 
   * @param message 成功的消息
   * 
   * @return BaseMessage的实例
   */
  public static BaseResult getSuccess(String message) {
    return BaseResult.getBaseResult(true, SystemConstants.OK_CODE, message);
  }

  /**
   * 委托方法，获取指定错误code的失败应答
   * 
   * @param code    错误代码
   * @param message 错误消息
   * 
   * @return 基础无应答数据的BaseResult的实例
   */
  public static BaseResult getFail(int code, String message) {
    return BaseResult.getBaseResult(false, code, message);
  }

  /**
   * 错误应答的委托方法
   * 
   * @param message 错误消息
   * 
   * @return 基础无应答数据的BaseResult的实例
   */
  public static BaseResult getFail(String message) {
    return BaseResult.getBaseResult(false, SystemConstants.ERROR_CODE, message);
  }

}
