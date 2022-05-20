package top.huhuiyu.api.xml;

import java.sql.Date;
import java.text.SimpleDateFormat;
import com.thoughtworks.xstream.converters.SingleValueConverter;

/**
 * 日期转换
 *
 * @author 胡辉煜
 */
public class XmlDateConverter implements SingleValueConverter {
  public static final String DATE_FORMAT = "yyyy-MM-dd";
  private SimpleDateFormat sdf = new SimpleDateFormat(DATE_FORMAT);

  public XmlDateConverter() {
  }

  @Override
  public Object fromString(String date) {
    try {
      return new Date(sdf.parse(date).getTime());
    } catch (Exception e) {
      return null;
    }
  }

  @Override
  public String toString(Object date) {
    synchronized (sdf) {
      return sdf.format(date);
    }
  }

  @Override
  @SuppressWarnings("rawtypes")
  public boolean canConvert(Class date) {
    return Date.class.equals(date);
  }
}
