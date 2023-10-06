package ${builderUtil.getSubPackage("utils")};

import java.net.InetAddress;
import java.net.UnknownHostException;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

/**
 * ip工具
 * 
 * @author ${baseInfo.author}
 */
public class IpUtil {

  /**
   * 获取客户端ip地址
   * 
   * @return 客户端ip地址
   * 
   * @throws Exception 处理发生异常
   */
  public static String getIpAddress() throws Exception {
    ServletRequestAttributes servletRequestAttributes = (ServletRequestAttributes) RequestContextHolder.getRequestAttributes();
    if (servletRequestAttributes == null) {
      return getLocalIp();
    }
    HttpServletRequest request = servletRequestAttributes.getRequest();
    return getIpAddr(request);
  }

  /**
   * 获取客户端ip地址
   * 
   * @param request 客户端请求
   * 
   * @return 客户端ip地址
   * 
   * @throws Exception 处理发生异常
   */
  public static String getIpAddr(HttpServletRequest request) throws Exception {
    if (request == null) {
      return getLocalIp();
    }
    String ipAddress = null;
    try {
      ipAddress = request.getHeader("x-forwarded-for");
      if ((ipAddress == null) || (ipAddress.length() == 0) || SystemConstants.UNKNOWN_IP.equalsIgnoreCase(ipAddress)) {
        ipAddress = request.getHeader("Proxy-Client-IP");
      }
      if ((ipAddress == null) || (ipAddress.length() == 0) || SystemConstants.UNKNOWN_IP.equalsIgnoreCase(ipAddress)) {
        ipAddress = request.getHeader("WL-Proxy-Client-IP");
      }
      if ((ipAddress == null) || (ipAddress.length() == 0) || SystemConstants.UNKNOWN_IP.equalsIgnoreCase(ipAddress)) {
        ipAddress = request.getRemoteAddr();
        if (SystemConstants.LOCAL_IP.equals(ipAddress)) {
          // 根据网卡取本机配置的IP
          InetAddress inet = null;
          try {
            inet = InetAddress.getLocalHost();
          } catch (UnknownHostException e) {
            e.printStackTrace();
          }
          ipAddress = inet.getHostAddress();
        }
      }
      // 对于通过多个代理的情况，第一个IP为客户端真实IP,多个IP按照','分割,
      if ((ipAddress != null) && (ipAddress.length() > SystemConstants.IP_MIN_LENGTH)) {
        if (ipAddress.indexOf(SystemConstants.IP_SPLIT) > 0) {
          ipAddress = ipAddress.substring(0, ipAddress.indexOf(SystemConstants.IP_SPLIT));
        }
      }
    } catch (Exception e) {
      ipAddress = "";
    }
    return ipAddress;
  }

  /**
   * 获取本地ip地址
   * 
   * @return 本地ip地址
   */
  public static String getLocalIp() {
    InetAddress inet = null;
    try {
      inet = InetAddress.getLocalHost();
    } catch (UnknownHostException e) {
      e.printStackTrace();
    }
    return inet.getHostAddress();
  }
}