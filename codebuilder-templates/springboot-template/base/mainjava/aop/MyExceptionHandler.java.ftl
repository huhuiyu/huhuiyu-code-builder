package ${builderUtil.getSubPackage("aop")};

import java.sql.SQLException;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.converter.HttpMessageNotReadableException;
import org.springframework.validation.BindException;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.NoHandlerFoundException;

import ${builderUtil.getSubPackage("base")}.BaseResult;

/**
 * 控制器全局错误处理器，ControllerAdvice注解表示是控制器层拦截处理，ExceptionHandler注解表示方法为错误处理器，参数是错误的类型
 * 
 * @author ${baseInfo.author}
 *
 */
@ControllerAdvice
@ResponseBody
public class MyExceptionHandler {

  private static final Logger log = LoggerFactory.getLogger(MyExceptionHandler.class);

  @ExceptionHandler(AppException.class)
  public BaseResult handleAppException(AppException ex) {
    // 自定义异常处理，一般用于服务层需要回滚事务的情况
    BaseResult result = BaseResult.getFail(ex.getCode(), ex.getMessage());
    result.setToken(ex.getToken());
    log.debug("自定义异常：{}，token：{}", ex.getMessage(), ex.getToken());
    return result;
  }

  @ExceptionHandler(MethodArgumentNotValidException.class)
  public BaseResult handleMethodArgumentNotValidException(MethodArgumentNotValidException ex) {
    // 获取JSON（@RequestBody）校验错误信息
    List<ObjectError> errors = ex.getBindingResult().getAllErrors();
    // 拼接错误信息
    StringBuilder sb = new StringBuilder();
    for (ObjectError oe : errors) {
      sb.append(oe.getDefaultMessage()).append(",");
    }
    if (sb.length() > 0) {
      sb.deleteCharAt(sb.length() - 1);
    }
    BaseResult result = BaseResult.getFail(sb.toString());
    log.debug("校验异常：{}", ex.getMessage());
    return result;
  }

  @ExceptionHandler(BindException.class)
  public BaseResult handleBindException(BindException ex) {
    // 获取表单校验错误信息
    List<ObjectError> errors = ex.getBindingResult().getAllErrors();
    // 拼接错误信息
    StringBuilder sb = new StringBuilder();
    for (ObjectError oe : errors) {
      sb.append(oe.getDefaultMessage()).append(",");
    }
    if (sb.length() > 0) {
      sb.deleteCharAt(sb.length() - 1);
    }
    BaseResult result = BaseResult.getFail(sb.toString());
    log.debug("校验异常：{}", ex.getMessage());
    return result;

  }

  @ExceptionHandler(NoHandlerFoundException.class)
  public BaseResult handleNoHandlerFoundException(NoHandlerFoundException ex) {
    // 配置spring.mvc.throw-exception-if-no-handler-found: true
    // 且spring.web.resources.add-mappings: false
    // 在控制器路径无法访问时会抛出本异常信息
    return BaseResult.getFail(404, "资源不存在");
  }

  @ExceptionHandler(HttpMessageNotReadableException.class)
  public BaseResult handleHttpMessageNotReadableException(HttpMessageNotReadableException ex) {
    // 请求参数异常，一般是格式错误
    log.error("请求参数错误", ex);
    return BaseResult.getFail("请检查提交数据格式");
  }

  @ExceptionHandler(SQLException.class)
  public BaseResult handleSQLException(SQLException ex) {
    log.error("服务器发生数据错误", ex);
    return BaseResult.getFail("数据处理发生，请稍后重试！");
  }

  @ExceptionHandler(Exception.class)
  public BaseResult handleException(Exception ex) {
    log.error("服务器发生错误", ex);
    return BaseResult.getFail("服务器忙，请稍后重试！");
  }

}
