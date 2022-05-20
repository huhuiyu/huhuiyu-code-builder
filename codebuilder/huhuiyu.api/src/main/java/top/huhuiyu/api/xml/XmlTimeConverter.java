package top.huhuiyu.api.xml;

import java.sql.Time;
import java.text.SimpleDateFormat;
import com.thoughtworks.xstream.converters.SingleValueConverter;

/**
 * 时间转换
 *
 * @author 胡辉煜
 */
public class XmlTimeConverter implements SingleValueConverter {
  public static final String TIME_FORMAT = "hh:mm:ss";
  private SimpleDateFormat sdf = new SimpleDateFormat(TIME_FORMAT);

  public XmlTimeConverter() {
  }

  @Override
  public Object fromString(String date) {
    try {
      return new Time(sdf.parse(date).getTime());
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
    return Time.class.equals(date);
  }
}
