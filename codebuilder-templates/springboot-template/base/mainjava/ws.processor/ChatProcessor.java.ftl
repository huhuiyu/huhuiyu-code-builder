package ${builderUtil.getSubPackage("ws.processor")};

import javax.websocket.Session;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import ${builderUtil.getSubPackage("service")}.WebSocketService;
import ${builderUtil.getSubPackage("utils")}.ApplicationUtil;
import ${builderUtil.getSubPackage("utils")}.JsonUtil;
import ${builderUtil.getSubPackage("ws")}.WebSocket;
import ${builderUtil.getSubPackage("ws.base")}.BaseProcessor;
import ${builderUtil.getSubPackage("ws.base")}.BaseWebSocketResult;
import ${builderUtil.getSubPackage("ws.entity")}.ChatInfo;

/**
 * 聊天室处理器
 * 
 * @author ${baseInfo.author}
 *
 */
public class ChatProcessor implements BaseProcessor {

  private static final Logger log = LoggerFactory.getLogger(ChatProcessor.class);

  @Override
  public void onOpen(Session session) throws Exception {
    WebSocketService webSocketService = ApplicationUtil.getBean(WebSocketService.class);
    webSocketService.addSession(session);
    // 添加到聊天
    webSocketService.subscription(WebSocket.CHANNEL_CHAT, session);
  }

  @Override
  public void onMessage(String message, Session session) throws Exception {
    WebSocketService webSocketService = ApplicationUtil.getBean(WebSocketService.class);
    webSocketService.addSession(session);
    BaseWebSocketResult result;
    try {
      ChatInfo chatInfo = JsonUtil.parse(message, ChatInfo.class);
      log.debug("聊天信息：", chatInfo);
      // 广播到聊天频道
      result = BaseWebSocketResult.getSuccessInfo(chatInfo);
    } catch (Exception ex) {
      // 格式错误应答
      result = BaseWebSocketResult.getFailInfo(String.format("错误的信息格式：%s", ex.getMessage()));
      result.setType(WebSocket.TYPE_CHAT);
    }
    result.setType(WebSocket.TYPE_CHAT);
    webSocketService.publish(WebSocket.APP_CHAT, result);
  }

}
