// buildscript是项目和项目子项目的公共配置
buildscript {
  repositories {
    // 使用本地仓库
    mavenLocal()
    //使用阿里的maven仓库（避免去国外的地址下载，可以加快下载速度）
    maven {url 'https://maven.aliyun.com/nexus/content/groups/public/'}
    // 使用官方maven仓库
    mavenCentral()
  }
}

// 插件配置
plugins {
  // springboot插件
  id 'org.springframework.boot' version '2.5.2'
  // springboot依赖管理插件
  id 'io.spring.dependency-management' version '1.0.11.RELEASE'
  // java开发插件
  id 'java'
  id 'java-library'
  // war打包依赖
  id 'war'
  // eclipse开发插件（会自动配置eclipse）
  id 'eclipse'
  // idea开发插件（会自动配置idea）
  id 'idea'
}

// 代码编译等级
sourceCompatibility = '1.8'
targetCompatibility = '1.8'

// 源码和javadoc编码设置
[compileJava, compileTestJava, javadoc]*.options*.encoding = 'UTF-8'

//项目版本号
version = '1.0.0.0'

//项目的maven仓库
repositories {
  // 使用本地仓库
  mavenLocal()
  //使用阿里的maven仓库（避免去国外的地址下载，可以加快下载速度）
  maven {url 'https://maven.aliyun.com/nexus/content/groups/public/'}
  // 使用官方maven仓库
  mavenCentral()
}

//项目依赖的第三方库配置
dependencies {
  // springboot网页项目依赖
  implementation group: 'org.springframework.boot', name: 'spring-boot-starter-web'
  // springboot校验框架依赖
  implementation group: 'org.springframework.boot', name: 'spring-boot-starter-validation'
  // email
  implementation group: 'org.springframework.boot', name: 'spring-boot-starter-mail'
  // redis
  implementation group: 'org.springframework.boot', name: 'spring-boot-starter-data-redis'
  // aop切面
  implementation group: 'org.springframework.boot', name: 'spring-boot-starter-aop'
  // websocket
  implementation group: 'org.springframework.boot', name: 'spring-boot-starter-websocket'
  
  // redis连接池
  implementation group: 'org.apache.commons', name: 'commons-pool2', version: '2.11.1'
  
  // 配置文件加密
  implementation group: 'com.github.ulisesbocchio', name: 'jasypt-spring-boot-starter', version: '3.0.4'
  // mybatis整合
  implementation group: 'org.mybatis.spring.boot', name: 'mybatis-spring-boot-starter', version: '2.2.1'
  // mybatis-plus插件
  implementation group: 'com.baomidou', name: 'mybatis-plus-boot-starter', version: '3.5.0'

  // mysql驱动
  implementation group: 'mysql', name: 'mysql-connector-java', version: '8.0.27'
  // swagger3依赖
  implementation group: 'io.springfox', name: 'springfox-boot-starter', version: '3.0.0'
  // knife4j界面
  implementation group: 'com.github.xiaoymin', name: 'knife4j-spring-boot-starter', version: '3.0.3'
  
  // springboot开发工具，可以热部署代码（部署时可以去掉）
  developmentOnly group: 'org.springframework.boot', name: 'spring-boot-devtools'
  
  // lombok工具
  compileOnly 'org.projectlombok:lombok:1.18.22'
  annotationProcessor 'org.projectlombok:lombok:1.18.22'
  testCompileOnly 'org.projectlombok:lombok:1.18.22'
  testAnnotationProcessor 'org.projectlombok:lombok:1.18.22'
  
  // springboot测试依赖
  testImplementation group: 'org.springframework.boot', name: 'spring-boot-starter-test'

}

configurations.implementation {
  // 排除log4j，因为项目使用的是logback
  exclude group: 'org.apache.logging.log4j', module: 'log4j-to-slf4j'
  exclude group: 'org.apache.logging.log4j', module: 'log4j-api'
}

bootRun {
  // 热部署监听目录
  sourceResources sourceSets.main
}

jar {
  // 打包jar不要添加版本号
  project.version ''
}

war {
  // 打包war不要添加版本号
  project.version ''
}