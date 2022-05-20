package top.huhuiyu.codebuilder.ui;

import top.huhuiyu.api.frame.FrameUtil;
import top.huhuiyu.api.utils.JsonUtils;
import top.huhuiyu.codebuilder.entity.Config;

import java.awt.event.ActionListener;
import java.io.File;
import java.util.Scanner;

/**
 * MySpringBoot项目生成工具
 *
 * @author 胡辉煜
 */
public class MySpringBootProjectFrame extends BaseSpringBootProjectFrame implements ActionListener {

  private static final long serialVersionUID = -8951698808764167634L;
  private static final String APP_CONFIG = "config.json";
  private static final String TEMPLATE_CONFIG;

  static {
    try {
      Scanner scanner = new Scanner(new File(APP_CONFIG));
      String strConfig = "";
      while (scanner.hasNextLine()) {
        strConfig += scanner.nextLine().trim();
      }
      scanner.close();
      Config config = JsonUtils.parse(strConfig, Config.class);
      TEMPLATE_CONFIG = config.getTemplateConfigFile();
    } catch (Exception ex) {
      throw new RuntimeException(ex);
    }
  }

  public MySpringBootProjectFrame() {
    super(TEMPLATE_CONFIG);
  }

  public static void main(String[] args) {
    FrameUtil.setDefaultLookAndFeelDecorated();
    FrameUtil.showSwingFrame(MySpringBootProjectFrame.class);
  }
}
