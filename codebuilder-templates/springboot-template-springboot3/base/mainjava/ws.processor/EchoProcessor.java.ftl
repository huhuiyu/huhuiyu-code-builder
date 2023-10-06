package ${builderUtil.getSubPackage("ws.processor")};

import javax.websocket.Session;

import ${builderUtil.getSubPackage("service")}.WebSocketService;
import ${builderUtil.getSubPackage("utils")}.ApplicationUtil;
import ${builderUtil.getSubPackage("utils")}.JsonUtil;
import ${builderUtil.getSubPackage("ws")}.WebSocket;
import ${builderUtil.getSubPackage("ws.base")}.BaseProcessor;
import ${builderUtil.getSubPackage("ws.base")}.BaseWebSocketResult;

/**
 * echo应答处理器
 * 
 * @author ${baseInfo.author}
 *
 */
public class EchoProcessor implements BaseProcessor {

  @Override
  public void onOpen(Session session) throws Exception {
    WebSocketService webSocketService = ApplicationUtil.getBean(WebSocketService.class);
    webSocketService.addSession(session);
  }

  @Override
  public void onMessage(String message, Session session) throws Exception {
    WebSocketService webSocketService = ApplicationUtil.getBean(WebSocketService.class);
    BaseWebSocketResult result = BaseWebSocketResult.getSuccessInfo("服务器应答:" + message);
    result.setType(WebSocket.TYPE_ECHO);
    webSocketService.sendMessage(session, JsonUtil.stringify(result));
  }

}
