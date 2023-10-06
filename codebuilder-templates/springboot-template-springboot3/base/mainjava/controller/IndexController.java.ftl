package ${builderUtil.getSubPackage("controller")};

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiImplicitParams;
import io.swagger.annotations.ApiOperation;
import ${builderUtil.getSubPackage("aop")}.AnnoNoToken;
import ${builderUtil.getSubPackage("base")}.BaseResult;

/**
 * 首页控制器
 * 
 * @author ${baseInfo.author}
 *
 */
@RestController
@Api(tags = "首页")
public class IndexController {

  private static final Logger log = LoggerFactory.getLogger(IndexController.class);

  @AnnoNoToken
  @ApiOperation(value = "回声测试", notes = "参数通过应答message返回")
  @ApiImplicitParams({ @ApiImplicitParam(name = "echo", value = "回声参数") })
  @GetMapping("")
  public BaseResult index(String echo) throws Exception {
    echo = StringUtils.hasText(echo) ? echo.trim() : "";
    log.debug("姓名参数：{}", echo);
    BaseResult result = new BaseResult();
    result.setSuccessInfo("hello " + echo);
    return result;
  }

  @AnnoNoToken
  @ApiOperation(value = "WebSocket说明", notes = "本接口是websocket说明文档，无需调用")
  @GetMapping("/websocket")
  public BaseResult websocket() throws Exception {
    BaseResult result = new BaseResult();
    result.setFailInfo("本接口是websocket说明文档，无需调用");
    return result;
  }
}
