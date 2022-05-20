package top.huhuiyu.api.xml;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Date;
import com.thoughtworks.xstream.converters.SingleValueConverter;

/**
 * 时间日期转换
 *
 * @author 胡辉煜
 */
public class XmlDateTimeConverter implements SingleValueConverter {
  public static final String DATEIME_FORMAT = "yyyy-MM-dd hh:mm:ss";
  private SimpleDateFormat sdf = new SimpleDateFormat(DATEIME_FORMAT);
  private Class<?> dateClass;

  public XmlDateTimeConverter() {
  }

  @Override
  public Object fromString(String date) {
    try {
      Date d = sdf.parse(date);
      if (Timestamp.class.equals(dateClass)) {
        return new Timestamp(d.getTime());
      }
      return d;
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
    dateClass = date;
    return (Date.class.equals(dateClass) || Timestamp.class.equals(dateClass));
  }
}
