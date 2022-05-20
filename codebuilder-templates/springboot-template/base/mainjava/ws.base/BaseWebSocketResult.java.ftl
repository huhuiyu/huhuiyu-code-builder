package ${builderUtil.getSubPackage("ws.base")};

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import ${builderUtil.getSubPackage("base")}.BaseEntity;

/**
 * WebSocket统一应答对象
 * 
 * @author ${baseInfo.author}
 *
 */
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class BaseWebSocketResult extends BaseEntity {
  private static final long serialVersionUID = ${builderUtil.serialVersionUid};
  public static final int SUCCESS_CODE = 200;
  public static final int FAIL_CODE = 500;

  /**
   * 应答是否成功
   */
  private boolean success;
  /**
   * 应答代码
   */
  private int code;
  /**
   * 应答数据
   */
  private Object message;

  /**
   * 消息类型
   */
  private String type;

  public static BaseWebSocketResult getBaseWsInfo(Boolean success, int code, Object message) {
    BaseWebSocketResult baseWsInfo = new BaseWebSocketResult();
    baseWsInfo.setCode(code);
    baseWsInfo.setSuccess(success);
    baseWsInfo.setMessage(message);
    return baseWsInfo;
  }

  public static BaseWebSocketResult getSuccessInfo(int code, Object message) {
    return getBaseWsInfo(true, code, message);
  }

  public static BaseWebSocketResult getSuccessInfo(Object message) {
    return getBaseWsInfo(true, SUCCESS_CODE, message);
  }

  public static BaseWebSocketResult getFailInfo(int code, Object message) {
    return getBaseWsInfo(false, code, message);
  }

  public static BaseWebSocketResult getFailInfo(Object message) {
    return getBaseWsInfo(false, FAIL_CODE, message);
  }

}
