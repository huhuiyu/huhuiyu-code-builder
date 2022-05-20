package ${builderUtil.getSubPackage("service.impl")};

import java.util.UUID;
import java.util.concurrent.TimeUnit;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.data.redis.core.ValueOperations;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import ${builderUtil.getSubPackage("aop")}.AppException;
import ${builderUtil.getSubPackage("entity")}.RedisTokenInfo;
import ${builderUtil.getSubPackage("entity")}.SystemConfig;
import ${builderUtil.getSubPackage("entity")}.TbUser;
import ${builderUtil.getSubPackage("service")}.RedisService;
import ${builderUtil.getSubPackage("utils")}.IpUtil;
import ${builderUtil.getSubPackage("utils")}.JsonUtil;
import ${builderUtil.getSubPackage("utils")}.SystemConstants;

/**
 * redis服务实现
 * 
 * @author ${baseInfo.author}
 *
 */
@Service
public class RedisServiceImpl implements RedisService {

  @Autowired
  private StringRedisTemplate stringRedisTemplate;

  @Override
  public <T> void saveInfo(String key, T value, Integer timeout) throws Exception {
    ValueOperations<String, String> valueOperations = stringRedisTemplate.opsForValue();
    valueOperations.set(key, JsonUtil.stringify(value), timeout, TimeUnit.SECONDS);
  }

  @Override
  public <T> void saveInfo(String key, T value) throws Exception {
    ValueOperations<String, String> valueOperations = stringRedisTemplate.opsForValue();
    valueOperations.set(key, JsonUtil.stringify(value));
  }

  @Override
  public <T> T loadInfo(String key, Class<T> clazz) throws Exception {
    ValueOperations<String, String> valueOperations = stringRedisTemplate.opsForValue();
    String info = valueOperations.get(key);
    return info == null ? null : JsonUtil.parse(info, clazz);
  }

  @Override
  public SystemConfig readSystemConfig() throws Exception {
    ValueOperations<String, String> valueOperations = stringRedisTemplate.opsForValue();
    String info = valueOperations.get(SystemConstants.SYSTEM_CONFIG_KEY);
    if (StringUtils.hasText(info)) {
      return JsonUtil.parse(info, SystemConfig.class);
    }
    SystemConfig config = new SystemConfig();
    valueOperations.set(SystemConstants.SYSTEM_CONFIG_KEY, JsonUtil.stringify(config));
    return config;
  }

  @Override
  public RedisTokenInfo readTokenInfo(String token) throws Exception {
    token = checkToken(token);
    ValueOperations<String, String> valueOperations = stringRedisTemplate.opsForValue();
    RedisTokenInfo redisTokenInfo = JsonUtil.parse(valueOperations.get(token), RedisTokenInfo.class);
    return redisTokenInfo;
  }

  @Override
  public RedisTokenInfo saveIp(String token, String ip) throws Exception {
    ValueOperations<String, String> valueOperations = stringRedisTemplate.opsForValue();
    RedisTokenInfo redisTokenInfo;
    if (stringRedisTemplate.hasKey(token)) {
      // token存在就直接获取
      redisTokenInfo = JsonUtil.parse(valueOperations.get(token), RedisTokenInfo.class);
    } else {
      // token不存在就新建
      token = UUID.randomUUID().toString();
      redisTokenInfo = new RedisTokenInfo();
    }
    // 更新ip信息
    redisTokenInfo.setIp(ip);
    return saveTokenInfo(token, redisTokenInfo);
  }

  @Override
  public RedisTokenInfo saveUser(String token, TbUser tbUser) throws Exception {
    ValueOperations<String, String> valueOperations = stringRedisTemplate.opsForValue();
    RedisTokenInfo redisTokenInfo;
    if (stringRedisTemplate.hasKey(token)) {
      // token存在就直接获取
      redisTokenInfo = JsonUtil.parse(valueOperations.get(token), RedisTokenInfo.class);
    } else {
      // token不存在就新建
      token = UUID.randomUUID().toString();
      redisTokenInfo = new RedisTokenInfo();
    }
    // 更新用户信息
    redisTokenInfo.setTbUser(tbUser);
    return saveTokenInfo(token, redisTokenInfo);
  }

  @Override
  public void removeUser(String token) throws Exception {
    ValueOperations<String, String> valueOperations = stringRedisTemplate.opsForValue();
    RedisTokenInfo redisTokenInfo;
    if (stringRedisTemplate.hasKey(token)) {
      // token存在就直接获取
      redisTokenInfo = JsonUtil.parse(valueOperations.get(token), RedisTokenInfo.class);
      // 清除用户信息
      redisTokenInfo.setTbUser(null);
      saveTokenInfo(token, redisTokenInfo);
    }
  }

  /**
   * 保存token信息
   * 
   * @param token          token值
   * @param redisTokenInfo token信息
   * 
   * @return 保存的token值
   * 
   * @throws Exception 处理发生异常
   */
  private RedisTokenInfo saveTokenInfo(String token, RedisTokenInfo redisTokenInfo) throws Exception {
    SystemConfig config = readSystemConfig();
    ValueOperations<String, String> valueOperations = stringRedisTemplate.opsForValue();
    valueOperations.set(token, JsonUtil.stringify(redisTokenInfo), config.getTokenTimeout(), TimeUnit.SECONDS);
    return redisTokenInfo;
  }

  @Override
  public String checkToken(String token) throws Exception {
    SystemConfig config = readSystemConfig();
    token = StringUtils.hasText(token) ? token : "";
    ValueOperations<String, String> valueOperations = stringRedisTemplate.opsForValue();
    if (stringRedisTemplate.hasKey(token)) {
      return token;
    }
    // 同一个ip新建token次数限制
    String ipTokenKey = String.format(SystemConstants.IP_TOKEN_ERROR_KEY, IpUtil.getIpAddress());
    Integer ipTokenCount = this.loadInfo(ipTokenKey, Integer.class);
    ipTokenCount = ipTokenCount == null ? 0 : ipTokenCount;
    if (ipTokenCount >= config.getIpMaxTokenCount()) {
      throw new AppException(SystemConstants.IP_TOKEN_ERROR_INFO);
    }
    this.saveInfo(ipTokenKey, ipTokenCount + 1, config.getIpBanTimeout());
    // token不存在就新建
    token = UUID.randomUUID().toString();
    RedisTokenInfo redisTokenInfo = new RedisTokenInfo();
    valueOperations.set(token, JsonUtil.stringify(redisTokenInfo));
    return token;
  }
}
