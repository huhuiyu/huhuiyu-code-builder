package top.huhuiyu.api.utils;

import java.awt.Color;
import java.awt.Font;
import java.awt.FontMetrics;
import java.awt.Graphics;
import java.awt.image.BufferedImage;
import java.util.Random;

/**
 * 图片校验码工具
 *
 * @author 胡辉煜
 */
public class ImageCode {
  /**
   * 默认字符集
   */
  public static final String CODES = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
  /**
   * 绘图字体
   */
  private static final Font FONT = new Font(null, Font.BOLD | Font.ITALIC, 28);
  /**
   * 随机数
   */
  public static final Random RANDOM = new Random();
  /**
   * 最小长度
   */
  public static final int MIN_LENGTH = 5;
  /**
   * 最大长度
   */
  public static final int MAX_LENGTH = 10;
  /**
   * 最大干扰线数量
   */
  public static final int MAX_AMOUNT = 30;
  /**
   * 最小干扰线数量
   */
  public static final int MIN_AMOUNT = 10;
  /**
   * 字体上下文
   */
  private static final FontMetrics FONT_METRICS;
  /**
   * 字符数量
   */
  private static int length = MIN_LENGTH;
  /**
   * 干扰线数量
   */
  private static int amount = MIN_AMOUNT;
  /**
   * 随机字符集
   */
  private static String code = CODES;

  static {
    // 初始化绘图
    BufferedImage image = new BufferedImage(1, 1, BufferedImage.TYPE_INT_ARGB);
    Graphics graphics = image.getGraphics();
    graphics.setFont(FONT);
    FONT_METRICS = graphics.getFontMetrics();
  }

  public int getLength() {
    return length;
  }

  public static void setLength(int length) {
    length = length > MAX_LENGTH ? MAX_LENGTH : length;
    length = length < MIN_LENGTH ? MIN_LENGTH : length;
    ImageCode.length = length;
  }

  public static int getAmount() {
    return amount;
  }

  public static void setAmount(int amount) {
    amount = amount > MAX_AMOUNT ? MAX_AMOUNT : amount;
    amount = amount < MIN_AMOUNT ? MIN_AMOUNT : amount;
    ImageCode.amount = amount;
  }

  public static String getCode() {
    return code;
  }

  public static void setCode(String code) {
    ImageCode.code = StringUtils.isEmpty(code) ? CODES : StringUtils.trim(code);
  }

  public static void reset() {
    ImageCode.amount = MIN_AMOUNT;
    ImageCode.length = MIN_AMOUNT;
    ImageCode.code = CODES;
  }

  /**
   * 生成默认长度的随机字符
   *
   * @return 默认长度的随机字符
   */
  public static String makeCode() {
    return makeCode(length);
  }

  /**
   * 生成指定长度的随机字符
   *
   * @param length 随机字符长度
   * 
   * @return 指定长度的随机字符
   */
  public static String makeCode(int length) {
    setLength(length);
    StringBuilder sb = new StringBuilder();
    for (int i = 0; i < ImageCode.length; i++) {
      sb.append(code.charAt(RANDOM.nextInt(code.length())));
    }
    return sb.toString();
  }

  /**
   * 绘制code对应的图片
   *
   * @param code 图片code
   * 
   * @return code对应的图片
   */
  public static BufferedImage makeImage(String code) {
    // 绘图高度
    int height = FONT_METRICS.getHeight();
    // 绘图宽度
    int width = FONT_METRICS.stringWidth(code);
    int ascent = FONT_METRICS.getMaxAscent();

    // 创建内存图片
    BufferedImage image = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);
    Graphics graphics = image.getGraphics();
    graphics.setFont(FONT);
    // 绘制背景颜色
    graphics.setColor(Color.YELLOW);
    graphics.fillRect(0, 0, width, height);
    // 绘制文字
    graphics.setColor(Color.BLUE);
    graphics.drawString(code, 0, (((FONT_METRICS.getHeight() / 2) + (ascent / 2)) - 2));
    // 绘制干扰线
    graphics.setColor(Color.BLACK);
    for (int i = 0; i < ImageCode.amount; i++) {
      int startx = RANDOM.nextInt(width);
      int starty = RANDOM.nextInt(height);
      int endx = RANDOM.nextInt(width);
      int endy = RANDOM.nextInt(height);
      graphics.drawLine(startx, starty, endx, endy);
    }
    return image;
  }

}
