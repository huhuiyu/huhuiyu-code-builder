package top.huhuiyu.api.frame;

import javax.swing.JFrame;

/**
 * 窗口回调
 *
 * @author 胡辉煜
 * 
 * @param <T> 泛型参数
 */
public interface RunCallBack<T extends JFrame> {
  /**
   * 回调窗口
   *
   * @param frame 窗口
   */
  void back(T frame);
}
