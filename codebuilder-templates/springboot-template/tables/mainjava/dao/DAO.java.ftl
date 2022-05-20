package ${builderUtil.getSubPackage("dao")};

import org.apache.ibatis.annotations.Mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;

import ${builderUtil.getSubPackage("entity")}.${builderUtil.getClassName(tableInfo)};

/**
 * ${tableInfo.name}表的dao
 * 
 * @author ${baseInfo.author}
 */
@Mapper
public interface ${builderUtil.getClassName(tableInfo)}DAO extends BaseMapper<${builderUtil.getClassName(tableInfo)}> {
}