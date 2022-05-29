package ${builderUtil.getSubPackage("ws")};

import java.util.HashMap;
import java.util.Map;

import javax.websocket.OnClose;
import javax.websocket.OnError;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.PathParam;
import javax.websocket.server.ServerEndpoint;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

import ${builderUtil.getSubPackage("service")}.WebSocketService;
import ${builderUtil.getSubPackage("utils")}.ApplicationUtil;
import ${builderUtil.getSubPackage("utils")}.JsonUtil;
import ${builderUtil.getSubPackage("ws")}.base.BaseParameter;
import ${builderUtil.getSubPackage("ws")}.base.BaseProcessor;
import ${builderUtil.getSubPackage("ws")}.base.BaseWebSocketResult;
import ${builderUtil.getSubPackage("ws")}.processor.ChatProcessor;
import ${builderUtil.getSubPackage("ws")}.processor.EchoProcessor;

/**
 * WebSocket监听
 * 
 * @author ${baseInfo.author}
 */
@ServerEndpoint(value = "/ws/{app}")
@Component
public class WebSocket {

  private static final Logger log = LoggerFactory.getLogger(WebSocket.class);
  // app类型
  public static final String APP_ECHO = "echo";
  public static final String APP_CHAT = "chat";
  /**
   * 消息类型echo
   */
  public static final String TYPE_ECHO = "echo";
  /**
   * 消息类型chat
   */
  public static final String TYPE_CHAT = "chat";
  /**
   * 消息类型timestamp
   */
  public static final String TYPE_TIMESTAMP = "timestamp";
  /**
   * 订阅channel类型
   */
  public static final String CHANNEL_CHAT = "chat";

  /**
   * 时间戳回应标识特别字符串
   */
  public static final String TIMESTAMP_RESPONSE = "teach_project_service_timestamp";

  private static final Map<String, BaseProcessor> PROCESSORM_MAP = new HashMap<>();

  public WebSocket() {
    PROCESSORM_MAP.put(APP_CHAT, new ChatProcessor());
    PROCESSORM_MAP.put(APP_ECHO, new EchoProcessor());
  }

  /**
   * 连接建立成功调用的方法
   * 
   * @throws Exception
   */
  @OnOpen
  public void onOpen(Session session, @PathParam("app") String app) throws Exception {
    WebSocketService webSocketService = ApplicationUtil.getBean(WebSocketService.class);
    log.debug("open app is:" + app);
    // 校验app参数
    if (!PROCESSORM_MAP.containsKey(app)) {
      webSocketService.sendMessage(session, JsonUtil.stringify(BaseWebSocketResult.getFailInfo("无效的请求路径")));
      return;
    }
    // 调用处理器处理open事件
    PROCESSORM_MAP.get(app).onOpen(session);
    log.debug("onOpen：" + session.getId());
  }

  /**
   * 连接关闭调用的方法
   */
  @OnClose
  public void onClose(Session session, @PathParam("app") String app) {
    WebSocketService webSocketService = ApplicationUtil.getBean(WebSocketService.class);
    log.debug("close app is:" + app);
    webSocketService.removeSession(session);
    log.debug("onClose：" + session.getId());
  }

  /**
   * 收到客户端消息后调用的方法
   */
  @OnMessage
  public void onMessage(String message, Session session, @PathParam("app") String app) throws Exception {
    WebSocketService webSocketService = ApplicationUtil.getBean(WebSocketService.class);
    log.debug("message app is:{}", app);
    log.debug("onMessage：{}", message);
    // 不存的app路径信息
    if (!PROCESSORM_MAP.containsKey(app)) {
      webSocketService.sendMessage(session, JsonUtil.stringify(BaseWebSocketResult.getFailInfo("无效的请求路径")));
      return;
    }
    // 时间戳回应消息
    if (TIMESTAMP_RESPONSE.equals(message)) {
      log.debug("收到时间戳回应消息，无需处理");
      return;
    }
    // 继续流程
    PROCESSORM_MAP.get(app).onMessage(message, session);
  }

  /**
   * 发生错误时调用
   */
  @OnError
  public void onError(Session session, Throwable error) {
    log.error("onError:", error);
  }
}

