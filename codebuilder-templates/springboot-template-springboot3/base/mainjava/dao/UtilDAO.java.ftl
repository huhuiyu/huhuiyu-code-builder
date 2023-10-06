package ${builderUtil.getSubPackage("dao")};

import java.util.Date;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

/**
 * 工具dao
 * 
 * @author ${baseInfo.author}
 *
 */
@Mapper
public interface UtilDAO {
  /**
   * 获取数据库当前时间
   * 
   * @return 数据库当前时间
   * 
   * @throws Exception
   */
  @Select("select now()")
  Date queryTime() throws Exception;

  /**
   * 获取数据库当前时间戳
   * 
   * @return 数据库当前时间戳
   * 
   * @throws Exception
   */
  @Select("select unix_timestamp()")
  Long queryTimestamp() throws Exception;
}
