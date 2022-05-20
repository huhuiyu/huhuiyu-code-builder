package ${builderUtil.getSubPackage("service")};

import ${builderUtil.getSubPackage("entity")}.TbUser;
import ${builderUtil.getSubPackage("message")}.UserAuthMessage;

/**
 * 用户信息服务
 * 
 * @author ${baseInfo.author}
 *
 */
public interface UserAuthService {

  /**
   * 用户登录
   * 
   * @param user 用登录信息
   * 
   * @return 用户登录结果
   * 
   * @throws Exception 处理发生异常
   */
  UserAuthMessage login(TbUser user) throws Exception;

  /**
   * 用户登出
   * 
   * @return 用户登出结果
   * 
   * @throws Exception 处理发生异常
   */
  UserAuthMessage logout() throws Exception;

  /**
   * 获取登录用户信息
   * 
   * @return 登录用户信息
   * 
   * @throws Exception 处理发生异常
   */
  UserAuthMessage getUserInfo() throws Exception;

  /**
   * 修改用户启用状态
   * 
   * @param user   用户信息
   * @param enable 是否启用
   * 
   * @return 修改用户启用状态的结果
   * 
   * @throws Exception 处理发生异常
   */
  UserAuthMessage updateEnable(TbUser user, boolean enable) throws Exception;

  /**
   * 用户注册
   * 
   * @param user 用户信息
   * 
   * @return 用户注册的结果
   * 
   * @throws Exception 处理发生异常
   */
  UserAuthMessage reg(TbUser user) throws Exception;

  /**
   * 修改密码
   * 
   * @param user 用户信息
   * 
   * @return 修改密码的结果
   * 
   * @throws Exception 处理发生异常
   */
  UserAuthMessage updatePwd(TbUser user) throws Exception;

}
