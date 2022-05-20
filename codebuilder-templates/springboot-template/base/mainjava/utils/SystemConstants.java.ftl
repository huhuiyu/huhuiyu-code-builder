package ${builderUtil.getSubPackage("utils")};

import java.util.Random;

/**
 * 系统常量定义
 * 
 * @author ${baseInfo.author}
 *
 */
public interface SystemConstants {

  /**
   * 权限错误代码
   */
  int NEED_AUTH_CODE = 1000;
  /**
   * 权限错误代码
   */
  String NEED_AUTH_MESSAGE = "需要相关角色登录";

  /**
   * 请求头中的token信息key
   */
  String TOKEN_KEY = "token";

  /**
   * 正常应答代码
   */
  int OK_CODE = 200;
  /**
   * 失败应答代码
   */
  int ERROR_CODE = 500;

  /**
   * ip信息最小长度
   */
  int IP_MIN_LENGTH = 15;
  /**
   * ip分隔字符
   */
  String IP_SPLIT = ",";
  /**
   * 未知ip
   */
  String UNKNOWN_IP = "unknown";
  /**
   * 本机ip
   */
  String LOCAL_IP = "127.0.0.1";

  /**
   * websocket成功应答代码
   */
  int WS_SUCCESS_CODE = 200;
  /**
   * websocket失败应答代码
   */
  int WS_FAIL_CODE = 500;
  /**
   * websocket类型（时间戳）
   */
  String WS_TYPE_TIME = "timestamp";
  /**
   * websocket类型（回声）
   */
  String WS_TYPE_ECHO = "echo";
  /**
   * websocket类型（聊天）
   */
  String WS_TYPE_CHAT = "chat";

  /**
   * 数据库最大分页配置
   */
  Long MAX_PAGE_SIZE = 1000l;

  /**
   * 应用错误代码
   */
  int APP_ERROR_CODE = 500;

  /**
   * 手机号码正则
   */
  String PHONE_CHECK = "^1[3-9]\\d{9}$";
  /**
   * 32位md5正则
   */
  String MD5_CHECK = "^[a-zA-Z0-9]{32}$";

  /**
   * 邮箱正则
   */
  String EMAIL_CHECK = "^\\w+@\\w+(\\.\\w{2,3})*\\.\\w{2,3}$";

  /**
   * 系统配置key;
   */
  String SYSTEM_CONFIG_KEY = "${baseInfo.projectName}_system_config";

  /**
   * 用户名正则
   */
  String USERNAME_CHECK = "^[a-zA-Z][a-zA-Z0-9_-]{3,15}$";

  /**
   * 默认分页大小
   */
  long PAGE_SIZE = 10l;
  /**
   * 最大分页限制
   */
  long PAGE_SIZE_MAX = 1000l;
  /**
   * 最小分页限制
   */
  long PAGE_SIZE_MIN = 1l;
  /**
   * 最小页面限制
   */
  long PAGE_NUMBER_MIN = 1l;

  /**
   * like查询模板
   */
  String LIKE_INFO = "%%%s%%";

  /**
   * 密码错误信息保存key模板
   */
  String PASSWORD_ERROR_KEY = "password_error_%s";
  /**
   * 密码错误限制信息
   */
  String PASSWORD_ERROR_INFO = "密码错误超过次数，登录将会被限制一段时间";
  /**
   * token错误信息保存key模板
   */
  String IP_TOKEN_ERROR_KEY = "ip_token_error_%s";
  /**
   * token错误限制信息
   */
  String IP_TOKEN_ERROR_INFO = "刷新token超过次数，请求将会被限制一段时间";

  /**
   * 启用状态
   */
  String ENABLE = "y";
  /**
   * 禁用状态
   */
  String DISABLE = "n";

  /**
   * 随机字符
   */
  String RANDOM_STRING = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890";
  /**
   * 随机对象
   */
  Random RANDOM = new Random();
  /**
   * 密码盐长度
   */
  int SALT_LENGTH = 5;

  /**
   * 产生指定长度的随机字符串
   * 
   * @param len 字符串长度
   * 
   * @return 指定长度的随机字符串
   */
  static String randomString(int len) {
    StringBuilder sb = new StringBuilder();
    for (int i = 0; i < len; i++) {
      int index = RANDOM.nextInt(RANDOM_STRING.length());
      sb.append(RANDOM_STRING.substring(index, index + 1));
    }
    return sb.toString();
  }

  /**
   * 用户角色
   */
  String ROLE_USER = "user";
  /**
   * 管理员角色
   */
  String ROLE_ADMIN = "admin";
  /**
   * 用户角色
   */
  String ROLE_APP_ADMIN = "app-admin";
}
