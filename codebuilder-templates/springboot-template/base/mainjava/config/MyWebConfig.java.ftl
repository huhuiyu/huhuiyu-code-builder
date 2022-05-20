package ${builderUtil.getSubPackage("config")};

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.springframework.web.socket.server.standard.ServerEndpointExporter;

import ${builderUtil.getSubPackage("aop")}.MyInterceptor;

/**
 * mvc配置
 * 
 * @author ${baseInfo.author}
 *
 */
@Configuration
public class MyWebConfig implements WebMvcConfigurer {
  @Autowired
  private MyInterceptor myInterceptor;

  @Override
  public void addCorsMappings(CorsRegistry registry) {
    // 跨域配置
    WebMvcConfigurer.super.addCorsMappings(registry);
    // addMapping表示添加跨域的url映射，
    // /**表示所有的页面都支持跨域，一般会配置业务处理的url，而非全部
    // allowedMethods表示允许的http事件（POST，GET，DELETE...）
    // allowedOrigins表示允许跨域的域名，生产环境中一定会配置成限定的域名
    // 比如前端域名是huhuiyu.top，而springboot后端域名为api.huhuiyu.top
    // 那么应该允许的域名应该配置成huhuiyu.top，或者相对危险的*.huhuiyu.top
    // allowCredentials表示是否需要开启认证
    registry.addMapping("/**").allowedMethods("*").allowedOrigins("*").allowCredentials(false);
  }

  @Override
  public void addInterceptors(InterceptorRegistry registry) {
    // 添加自定义拦截器
    registry.addInterceptor(myInterceptor);
    WebMvcConfigurer.super.addInterceptors(registry);
  }

  @Bean
  public ServerEndpointExporter endpointExporter() {
    // 设置WebSocket节点
    return new ServerEndpointExporter();
  }

}