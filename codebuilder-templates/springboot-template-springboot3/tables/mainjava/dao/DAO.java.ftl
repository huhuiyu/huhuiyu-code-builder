package ${builderUtil.getSubPackage("dao")};

import com.mybatisflex.core.BaseMapper;
import org.apache.ibatis.annotations.Mapper;
import ${builderUtil.getSubPackage("entity")}.${builderUtil.getClassName(tableInfo)};

/**
 * ${tableInfo.name}表的dao
 * 
 * @author ${baseInfo.author}
 */
@Mapper
public interface ${builderUtil.getClassName(tableInfo)}DAO extends BaseMapper<${builderUtil.getClassName(tableInfo)}> {
}