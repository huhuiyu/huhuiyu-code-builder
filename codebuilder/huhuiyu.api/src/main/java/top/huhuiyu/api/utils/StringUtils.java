package top.huhuiyu.api.utils;

import java.util.regex.Pattern;

/**
 * 字符串工具集
 *
 * @author 胡辉煜
 */
public class StringUtils {
  /**
   * 回车换行符
   */
  public static final String CRLF = String.format("%n");
  /**
   * 电话号码检查
   */
  public static final String PHONE_CHECK = "^[1]\\d{10}$";
  /**
   * like查询格式化字符串
   */
  public static final String LIKE_FORMAT = "%%%s%%";

  private StringUtils() {
  }

  /**
   * 去掉字符串头尾空格后转换首字母为大写
   *
   * @param s 要转换的字符串
   * 
   * @return 去掉头尾空格后转换首字母为大写的字符串
   */
  public static String firstToUpper(String s) {
    s = trim(s);
    if ("".equals(s)) {
      return s;
    }
    if (s.toUpperCase().equals(s)) {
      s = s.toLowerCase();
    }
    return s.substring(0, 1).toUpperCase() + s.substring(1);
  }

  /**
   * 把数组中的元素转换成字符串后用指定的字符串拼接成一个字符 例如：数组是[1,2,3]，连接字符串是：##，拼接的结果是1##2##3
   *
   * @param datas 要拼接成字符串的数组
   * @param join  连接字符
   * 
   * @return 拼接后的字符串
   */
  public static String join(Object[] datas, String join) {
    StringBuilder sb = new StringBuilder();
    if (datas != null) {
      for (Object v : datas) {
        sb.append(v).append(join);
      }
      if (sb.indexOf(join) > -1) {
        sb.deleteCharAt(sb.length() - 1);
      }
    }
    return sb.toString();
  }

  /**
   * 把数组中的元素转换成字符串后用,拼接成一个字符 例如：数组是[1,2,3]，拼接的结果是1,2,3
   *
   * @param datas 要拼接成字符串的数组
   * 
   * @return 拼接后的字符串
   */
  public static String join(Object[] datas) {
    return join(datas, ",");
  }

  /**
   * 去掉头尾空白字符，null值也會返回成空字符串
   * 
   * @param value 字符串
   * 
   * @return 去掉头尾空白字符的结果
   */
  public static String trim(String value) {
    if (isEmpty(value)) {
      return "";
    }
    return value.trim();
  }

  /**
   * 转换包名称成对应的路径名称
   *
   * @param packageName 要转换的包名称
   * 
   * @return 包名称成对应的路径名称
   */
  public static String packageToDir(String packageName) {
    packageName = packageName.replaceAll("[.]", "/");
    return packageName;
  }

  /**
   * 判断是否是null或者是全部都是空白字符
   * 
   * @param value 字符串
   * 
   * @return 是否是null或者是全部都是空白字符
   */
  public static boolean isEmpty(String value) {
    return (value == null) || "".equals(value.trim());
  }

  /**
   * 获取like查询字符
   * 
   * @param info 信息字符
   * 
   * @return like查询字符
   */
  public static String getLikeStr(String info) {
    return String.format(LIKE_FORMAT, info);
  }

  /**
   * 检查电话号码格式
   * 
   * @param phone 电话号码
   * 
   * @return 是否是电话号码格式
   */
  public static boolean isPhone(String phone) {
    return isEmpty(phone) ? false : Pattern.matches(PHONE_CHECK, phone);
  }

}
