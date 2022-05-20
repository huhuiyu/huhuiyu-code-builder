package top.huhuiyu.api.fileutil;

import java.io.ByteArrayOutputStream;
import java.io.FilterOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;

/**
 * 自定义的http编码器，用于加密
 *
 * @author 胡辉煜
 */
public class Base64Encoder extends FilterOutputStream {

  private static final char[] CHARS = { 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', 'a', 'b', 'c', 'd', 'e', 'f',
      'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z', '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '+', '/' };

  private int charCount;
  private int carryOver;

  public Base64Encoder(OutputStream out) {
    super(out);
  }

  @Override
  public void write(int b) throws IOException {
    int lift = 3;
    int lift57 = 57;
    int lift0 = 0;
    int lift1 = 1;
    int lift2 = 2;
    if (b < 0) {
      b += 256;
    }

    if ((charCount % lift) == lift0) {
      int lookup = b >> 2;
      carryOver = b & 3;
      out.write(CHARS[lookup]);
    } else if ((charCount % lift) == lift1) {
      int lookup = ((carryOver << 4) + (b >> 4)) & 63;
      carryOver = b & 15;
      out.write(CHARS[lookup]);
    } else if ((charCount % lift) == lift2) {
      int lookup = ((carryOver << 2) + (b >> 6)) & 63;
      out.write(CHARS[lookup]);
      lookup = b & 63;
      out.write(CHARS[lookup]);
      carryOver = 0;
    }
    charCount++;

    if ((charCount % lift57) == 0) {
      out.write('\n');
    }
  }

  @Override
  public void write(byte[] buf, int off, int len) throws IOException {
    for (int i = 0; i < len; i++) {
      write(buf[off + i]);
    }
  }

  @Override
  public void close() throws IOException {
    int lift3 = 3;
    int mode1 = 1;
    int mode2 = 2;
    if ((charCount % lift3) == mode1) {
      int lookup = (carryOver << 4) & 63;
      out.write(CHARS[lookup]);
      out.write('=');
      out.write('=');
    } else if ((charCount % lift3) == mode2) {
      int lookup = (carryOver << 2) & 63;
      out.write(CHARS[lookup]);
      out.write('=');
    }
    super.close();
  }

  /**
   * base64编码字符
   *
   * @param unencoded 原始字符
   * 
   * @return base64编码后字符
   */
  public static String encode(String unencoded) {
    byte[] bytes = null;
    try {
      bytes = unencoded.getBytes("8859_1");
    } catch (UnsupportedEncodingException ignored) {
    }
    return encode(bytes);
  }

  /**
   * base64编码字符
   *
   * @param bytes 原始字符的自己数组
   * 
   * @return base64编码后字符
   */
  public static String encode(byte[] bytes) {
    ByteArrayOutputStream out = new ByteArrayOutputStream((int) (bytes.length * 1.37));
    Base64Encoder encodedOut = new Base64Encoder(out);

    try {
      encodedOut.write(bytes);
      encodedOut.close();

      return out.toString("8859_1");
    } catch (IOException ignored) {
      return null;
    }
  }

}