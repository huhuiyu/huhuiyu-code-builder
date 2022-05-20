package ${builderUtil.getSubPackage("aop")};

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import ${builderUtil.getSubPackage("service")}.RedisService;

/**
 * 自定义拦截器
 * 
 * @author ${baseInfo.author}
 *
 */
@Component
public class MyInterceptor implements HandlerInterceptor {

  private static final Logger log = LoggerFactory.getLogger(MyInterceptor.class);
  @Autowired
  private RedisService redisService;

  @Override
  public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
    log.debug("拦截器前置处理：{}，系统配置：{}", handler, redisService.readSystemConfig());
    return true;
  }

  @Override
  public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {
    log.debug("拦截器后置处理：{}，数据：{}", handler, modelAndView);
  }

  @Override
  public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) throws Exception {
    log.debug("拦截器完成：{}，异常：{}", handler, ex);
  }

}
