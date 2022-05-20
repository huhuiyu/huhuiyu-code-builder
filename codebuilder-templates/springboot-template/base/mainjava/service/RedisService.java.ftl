package ${builderUtil.getSubPackage("service")};

import ${builderUtil.getSubPackage("entity")}.RedisTokenInfo;
import ${builderUtil.getSubPackage("entity")}.SystemConfig;
import ${builderUtil.getSubPackage("entity")}.TbUser;

/**
 * redis服务
 * 
 * @author ${baseInfo.author}
 *
 */
public interface RedisService {

  /**
   * 保存ip信息
   * 
   * @param token token信息
   * @param ip    ip信息
   * 
   * @return 完整的token信息
   * 
   * @throws Exception 处理发生异常
   */
  RedisTokenInfo saveIp(String token, String ip) throws Exception;

  /**
   * 校验token信息，不存在就返回一个新的，否则就返回原值
   * 
   * @param token 要校验的token信息
   * 
   * @return token信息
   * 
   * @throws Exception 处理发生异常
   */
  String checkToken(String token) throws Exception;

  /**
   * 保存用户信息
   * 
   * @param token  token信息
   * @param tbUser 用户信息
   * 
   * @return 完整的token信息
   * 
   * @throws Exception 处理发生异常
   */
  RedisTokenInfo saveUser(String token, TbUser tbUser) throws Exception;

  /**
   * 读取token信息
   * 
   * @param token信息
   * 
   * @return token信息
   * 
   * @throws Exception 处理发生异常
   */
  RedisTokenInfo readTokenInfo(String token) throws Exception;

  /**
   * 获取系统配置
   * 
   * @return 系统配置
   * 
   * @throws Exception 处理发生异常
   */
  SystemConfig readSystemConfig() throws Exception;

  /**
   * 清除token中的用户信息
   * 
   * @param token token信息
   * 
   * @throws Exception 处理发生异常
   */
  void removeUser(String token) throws Exception;

  /**
   * 读取信息
   * 
   * @param <T>   泛型参数
   * @param key   信息的key
   * @param clazz 信息的类型
   * 
   * @return key对应的信息
   * 
   * @throws Exception 读取发生错误
   */
  <T> T loadInfo(String key, Class<T> clazz) throws Exception;

  /**
   * 保存信息
   * 
   * @param <T>   泛型参数
   * @param key   信息的key
   * @param value 信息的值
   * 
   * @throws Exception 保存发生错误
   */
  <T> void saveInfo(String key, T value) throws Exception;

  /**
   * 保存信息
   * 
   * @param <T>     泛型参数
   * @param key     信息的key
   * @param value   信息的值
   * @param timeout 信息超市秒数
   * 
   * @throws Exception 保存发生错误
   */
  <T> void saveInfo(String key, T value, Integer timeout) throws Exception;

}
