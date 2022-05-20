package ${builderUtil.getSubPackage("ws.base")};

import javax.websocket.Session;

/**
 * websocket处理器
 * 
 * @author ${baseInfo.author}
 *
 */
public interface BaseProcessor {

  default void onOpen(Session session) throws Exception {
  }

  default void onMessage(String message, Session session) throws Exception {
  }

  default void onClose(Session session) throws Exception {
  }

  default void onError(Session session, Throwable error) throws Exception {
  }

}
