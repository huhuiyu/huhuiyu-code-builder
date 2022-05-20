# 服务器基本配置
server:
  # 服务端口
  port: 20000
  # 请求应答编码
  servlet:
    encoding:
      force: true
      charset: UTF-8
# 加密密码，线上可以通过--jasypt.encryptor.password=加密密码参数动态配置，避免密码泄露
jasypt:
  encryptor:
    password: 加密密码
# spring配置
spring:
  # redis连接配置
  redis:
    host: redis服务器地址
    port: redis服务端口
    password: redis密码
    # lettuce
    lettuce:
      pool:
        # 连接池中的最小空闲连接
        min-idle: 1
        # 连接池中的最大空闲连接
        max-idle: 6
        # 连接池最大连接数（使用负值表示没有限制,不要配置过大，否则可能会影响redis的性能）
        max-active: 10
        # 连接池最大阻塞等待时间（使用负值表示没有限制）；单位毫秒
        max-wait: 1000
      # 关闭超时时间；单位毫秒
      shutdown-timeout: 2000
  # 域配置，用于区分应用
  jmx:
    default-domain: ${baseInfo.projectName}
  # 是否允许静态资源映射，配置swagger文档必须开启
  web: 
    resources:
      add-mappings: true
  # 如果资源无法找到是否抛出异常，spring.web.resources.add-mappings配置为true则本配置无效
  mvc:
    throw-exception-if-no-handler-found: true
  # json配置
  jackson:
    # 不输出null值属性
    default-property-inclusion: non-null
    # 日期时间信息应答为时间戳
    serialization:
      write-dates-as-timestamps: true
  # 文件上传配置
  servlet:
    multipart:
      enabled: true
      file-size-threshold: 5MB
      max-file-size: 2MB
      max-request-size: 2MB
  # 数据源配置
  datasource:
    driver-class-name: ${dataSourceInfo.driver}
    url: ${dataSourceInfo.url}
    username: ${dataSourceInfo.username}
    password: ${dataSourceInfo.password}
    hikari:
      connection-test-query: select 1
      max-lifetime: 60000
mybatis-plus:
  config-location: classpath:mybatis-config.xml
springfox:
  documentation:
    swagger-ui:
      enabled: true
knife4j:
  enable: true