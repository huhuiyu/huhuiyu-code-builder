package ${builderUtil.getSubPackage("")};

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.scheduling.annotation.EnableScheduling;

import springfox.documentation.oas.annotations.EnableOpenApi;
import ${builderUtil.getSubPackage("listener")}.AppReadyListener;

/**
 * SpringBoot启动类
 * 
 * @author ${baseInfo.author}
 */
@SpringBootApplication
@ComponentScan(basePackageClasses = { Application.class })
@EnableOpenApi
@EnableScheduling
public class Application extends SpringBootServletInitializer {

  public static void main(String[] args) {
    SpringApplication application = new SpringApplication(Application.class);
    application.addListeners(new AppReadyListener());
    application.run(args);
  }

  @Override
  protected SpringApplicationBuilder configure(SpringApplicationBuilder builder) {
    return builder.sources(Application.class);
  }

}