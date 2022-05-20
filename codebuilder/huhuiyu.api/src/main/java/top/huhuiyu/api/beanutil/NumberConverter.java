package top.huhuiyu.api.beanutil;

import org.apache.commons.beanutils.Converter;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.math.BigDecimal;

/**
 * 自定义时间格式转换器
 *
 * @author 胡辉煜
 */
@SuppressWarnings({ "rawtypes", "unchecked" })
public class NumberConverter implements Converter {

  private static final Logger log = LoggerFactory.getLogger(NumberConverter.class);

  public NumberConverter() {
  }

  @Override
  public Object convert(Class c, Object value) {
    // 空值和空字符串处理
    if ((value == null) || value.toString().trim().equals("")) {
      // 对象类型直接返回null
      if (Double.class.equals(c) || Float.class.equals(c) || Long.class.equals(c) || Integer.class.equals(c) || Short.class.equals(c) || BigDecimal.class.equals(c)) {
        return null;
      } else if (double.class.equals(c)) {
        return 0.0;
      } else if (float.class.equals(c)) {
        return 0.0F;
      } else if (long.class.equals(c)) {
        return 0L;
      } else if (int.class.equals(c) || short.class.equals(c)) {
        return 0;
      } else {
        return null;
      }
    }
    // 类型匹配将不执行转换
    if (c.equals(value.getClass())) {
      return value;
    }
    log.debug(String.format("数字数据转换：%s(%s)", value, c));
    if ((c == java.lang.Double.class) || (c == double.class)) {
      return Double.parseDouble(value.toString());
    } else if ((c == java.lang.Float.class) || (c == float.class)) {
      return Float.parseFloat(value.toString());
    } else if ((c == java.lang.Long.class) || (c == long.class)) {
      return Long.parseLong(value.toString());
    } else if ((c == java.lang.Integer.class) || (c == int.class)) {
      return Integer.parseInt(value.toString());
    } else if ((c == java.lang.Short.class) || (c == short.class)) {
      return Short.parseShort(value.toString());
    } else if (c == java.math.BigDecimal.class) {
      return new BigDecimal(value.toString());
    }
    return value;
  }
}
