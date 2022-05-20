package ${builderUtil.getSubPackage("aop")};

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.reflect.MethodSignature;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;
import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;

import ${builderUtil.getSubPackage("base")}.BaseResult;
import ${builderUtil.getSubPackage("dao")}.TbActionsDAO;
import ${builderUtil.getSubPackage("entity")}.AuthInfo;
import ${builderUtil.getSubPackage("entity")}.RedisTokenInfo;
import ${builderUtil.getSubPackage("entity")}.TbActions;
import ${builderUtil.getSubPackage("entity")}.TbUser;
import ${builderUtil.getSubPackage("service")}.RedisService;
import ${builderUtil.getSubPackage("utils")}.ApplicationUtil;
import ${builderUtil.getSubPackage("utils")}.IpUtil;
import ${builderUtil.getSubPackage("utils")}.SystemConstants;

/**
 * 控制器token切面
 *
 * @author ${baseInfo.author}
 */
@Aspect
@Component
public class ControllerToken implements BaseControllerAop {

  private static final Logger log = LoggerFactory.getLogger(ControllerToken.class);
  @Autowired
  private RedisService redisService;
  @Autowired
  private TbActionsDAO tbActionsDAO;

  @Around("controller()")
  public Object around(ProceedingJoinPoint pjp) throws Throwable {
    log.debug("控制器切面token处理");
    // 处理token信息 =====================================================
    String token = processToken(pjp);
    // token存在就保存ip地址信息并更新token相关信息
    if (StringUtils.hasText(token)) {
      processAuthInfo(token);
    }
    // 处理接口权限信息 =====================================================
    boolean checkResult = checkActionInfo();
    // 有返回值表示校验没用通过
    if (!checkResult) {
      throw new AppException(SystemConstants.NEED_AUTH_CODE, SystemConstants.NEED_AUTH_MESSAGE, token);
    }
    // 执行控制器方法 =======================================================
    Object result = pjp.proceed();
    // 处理应答结果 =========================================================
    // 如果控制器返回的是标准应答结果就添加token信息
    if ((StringUtils.hasText(token)) && (result instanceof BaseResult)) {
      BaseResult message = (BaseResult) result;
      message.setToken(token);
    }
    return result;
  }

  /**
   * 处理token信息
   * 
   * @param pjp 切面信息
   * 
   * @return token信息
   * 
   * @throws Exception 处理发生错误
   */
  private String processToken(ProceedingJoinPoint pjp) throws Exception {
    // 通过注解获取是否需要token信息
    AnnoNoToken annoNoToken = pjp.getTarget().getClass().getAnnotation(AnnoNoToken.class);
    if (annoNoToken != null) {
      log.debug("获取到AnnoNoToken信息的对象:{}", pjp.getTarget().getClass().getName());
      return "";
    }
    MethodSignature methodSignature = (MethodSignature) pjp.getSignature();
    annoNoToken = methodSignature.getMethod().getAnnotation(AnnoNoToken.class);
    if (annoNoToken != null) {
      log.debug("获取到AnnoNoToken信息的方法:{}", methodSignature.getMethod().getName());
      return "";
    }
    // 获取请求中的token信息
    RequestAttributes ra = RequestContextHolder.getRequestAttributes();
    ServletRequestAttributes sra = (ServletRequestAttributes) ra;
    HttpServletRequest request = sra.getRequest();
    String token = request.getHeader(SystemConstants.TOKEN_KEY);
    // 校验token信息
    token = redisService.checkToken(token);
    return token;
  }

  /**
   * 处理token中的认证信息和ip信息
   * 
   * @param token token值
   * 
   * @throws Exception 处理发生错误
   */
  private void processAuthInfo(String token) throws Exception {
    redisService.saveIp(token, IpUtil.getIpAddress());
    RedisTokenInfo redisTokenInfo = redisService.readTokenInfo(token);
    AuthInfo authInfo = ApplicationUtil.getBean(AuthInfo.class);
    authInfo.setToken(token);
    authInfo.setLoginUser(redisTokenInfo.getTbUser());
    authInfo.setIp(redisTokenInfo.getIp());
    log.debug("用户认证信息：{}", authInfo);
  }

  /**
   * 检查url的访问权限
   * 
   * @return 是否通过了权限检测
   * 
   * @throws Exception 处理发生错误
   */
  private boolean checkActionInfo() throws Exception {
    // 处理路径信息 =======================================================
    RequestAttributes ra = RequestContextHolder.getRequestAttributes();
    ServletRequestAttributes sra = (ServletRequestAttributes) ra;
    HttpServletRequest request = sra.getRequest();
    TbActions tbActions = new TbActions();
    tbActions.setUrl(request.getRequestURI().replaceFirst(request.getContextPath(), ""));
    log.debug("应用路径：{}，请求action：{}", request.getContextPath(), tbActions.getUrl());
    // 查询数据库中的信息
    QueryWrapper<TbActions> wrapper = new QueryWrapper<TbActions>();
    wrapper.eq("url", tbActions.getUrl());
    tbActions = tbActionsDAO.selectOne(wrapper);
    // 地址信息不存在就表示不受权限管理
    if (tbActions == null) {
      return true;
    }
    // url的权限列表
    List<String> roles = getRoles(tbActions.getRole());
    List<String> check = new ArrayList<>();
    check.addAll(roles);
    log.debug("接口详细信息：{},权限集合：{}", tbActions, check);
    // 获取当前用户权限信息
    AuthInfo authInfo = ApplicationUtil.getBean(AuthInfo.class);
    // 登陆用户的权限列表
    List<String> userRoles = new ArrayList<>();
    TbUser user = authInfo.getLoginUser();
    if (user != null && StringUtils.hasText(user.getRole())) {
      userRoles = getRoles(user.getRole());
    }
    check.retainAll(userRoles);
    log.debug("用户信息：{},权限集合：{}，结果权限集合：{}", user, userRoles, check);
    // 不为空就表示权限吻合
    if (!check.isEmpty()) {
      return true;
    }
    return false;
  }

  /**
   * 转换角色信息为集合
   * 
   * @param role 角色信息
   * 
   * @return 角色集合
   */
  private List<String> getRoles(String role) {
    List<String> roles = new ArrayList<>(Arrays.asList(role.split(",")));
    return roles;
  }

}