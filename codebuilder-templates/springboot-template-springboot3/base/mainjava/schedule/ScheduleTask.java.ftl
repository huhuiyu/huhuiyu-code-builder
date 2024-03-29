package ${builderUtil.getSubPackage("schedule")};

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
import lombok.RequiredArgsConstructor;
import ${builderUtil.getSubPackage("dao")}.UtilDAO;
import ${builderUtil.getSubPackage("service")}.WebSocketService;
import ${builderUtil.getSubPackage("ws")}.WebSocket;
import ${builderUtil.getSubPackage("ws")}.base.BaseWebSocketResult;

/**
 * 定时任务
 * 
 * @author ${baseInfo.author}
 */
@Component
@RequiredArgsConstructor
public class ScheduleTask {
  private static final Logger log = LoggerFactory.getLogger(ScheduleTask.class);
  private final WebSocketService webSocketService;
  private final UtilDAO utilDAO;

  @Scheduled(initialDelay = 5 * 1000, fixedDelay = 5 * 60 * 1000)
  public void timestamp() {
    try {
      log.debug("正在广播时间戳");
      BaseWebSocketResult baseWsInfo = BaseWebSocketResult.getSuccessInfo(utilDAO.queryTimestamp());
      baseWsInfo.setType(WebSocket.TYPE_TIMESTAMP);
      webSocketService.broadcast(baseWsInfo);
    } catch (Exception ex) {
      log.error("广播时间戳", ex);
    }
  }
}