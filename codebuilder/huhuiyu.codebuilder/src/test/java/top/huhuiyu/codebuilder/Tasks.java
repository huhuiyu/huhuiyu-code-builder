package top.huhuiyu.codebuilder;

import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.util.Date;

/**
 * 需要完成的任务列表
 *
 * @author 胡辉煜
 */
public class Tasks {

  public static void main(String[] args) {
    // 需要springbootbase项目界面
    // 类型映射
    // 模板扩展多个，添加模板下拉选择项
    DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
    Date time = Date.from(LocalDateTime.parse("2018-09-10 10:11:12", dtf).atZone(ZoneId.systemDefault()).toInstant());
    System.out.println(time);
  }
}
