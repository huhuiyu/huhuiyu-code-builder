package top.huhuiyu.api.fileutil;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.FilterInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;

/**
 * 自定义的http解码器，用于加密
 *
 * @author 胡辉煜
 */
public class Base64Decoder extends FilterInputStream {
  private static final char[] CHARS = { 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', 'a', 'b', 'c', 'd', 'e', 'f',
      'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z', '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '+', '/' };

  private static final int[] INTS = new int[128];
  static {
    int base64 = 64;
    for (int i = 0; i < base64; i++) {
      INTS[CHARS[i]] = i;
    }
  }
  private int charCount;
  private int carryOver;

  public Base64Decoder(InputStream in) {
    super(in);
  }

  @Override
  public int read() throws IOException {

    int x;
    do {
      x = in.read();
      if (x == -1) {
        return -1;
      }
    } while (Character.isWhitespace((char) x));
    charCount++;

    char eq = '=';
    if (x == eq) {
      return -1;
    }
    x = INTS[x];
    int mode0 = 0;
    int mode1 = 1;
    int mode2 = 2;
    int mode3 = 3;
    int mode = (charCount - 1) % 4;
    if (mode == mode0) {
      carryOver = x & 63;
      return read();
    } else if (mode == mode1) {
      int decoded = ((carryOver << 2) + (x >> 4)) & 255;
      carryOver = x & 15;
      return decoded;
    } else if (mode == mode2) {
      int decoded = ((carryOver << 4) + (x >> 2)) & 255;
      carryOver = x & 3;
      return decoded;
    } else if (mode == mode3) {
      int decoded = ((carryOver << 6) + x) & 255;
      return decoded;
    }
    return -1;
  }

  @Override
  public int read(byte[] buf, int off, int len) throws IOException {
    if (buf.length < ((len + off) - 1)) {
      throw new IOException("The input buffer is too small: " + len + " bytes requested starting at offset " + off + " while the buffer " + " is only " + buf.length + " bytes long.");
    }

    int i;
    for (i = 0; i < len; i++) {
      int x = read();
      if ((x == -1) && (i == 0)) {
        return -1;
      } else if (x == -1) {
        break;
      }
      buf[off + i] = (byte) x;
    }
    return i;
  }

  /**
   * 解码字符串
   *
   * @param encoded 编码过的字符串
   * 
   * @return 解码后字符串
   */
  public static String decode(String encoded) {
    return new String(decodeToBytes(encoded));
  }

  /**
   * 解码字符串到byte数组
   *
   * @param encoded 编码过的字符串
   * 
   * @return 解码后的byte数组
   */
  public static byte[] decodeToBytes(String encoded) {
    byte[] bytes = null;
    try {
      bytes = encoded.getBytes("8859_1");
    } catch (UnsupportedEncodingException ignored) {
    }

    Base64Decoder in = new Base64Decoder(new ByteArrayInputStream(bytes));

    ByteArrayOutputStream out = new ByteArrayOutputStream((int) (bytes.length * 0.67));

    try {
      byte[] buf = new byte[4 * 1024];
      int bytesRead;
      while ((bytesRead = in.read(buf)) != -1) {
        out.write(buf, 0, bytesRead);
      }
      out.close();
      in.close();
      return out.toByteArray();
    } catch (IOException ignored) {
      return null;
    }
  }

}
