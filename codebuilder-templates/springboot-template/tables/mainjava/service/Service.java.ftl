package ${builderUtil.getSubPackage("service")};

import ${builderUtil.getSubPackage("base")}.BaseDataResult;
import ${builderUtil.getSubPackage("base")}.BaseResult;
import ${builderUtil.getSubPackage("entity")}.PageBean;
import ${builderUtil.getSubPackage("entity")}.${builderUtil.getClassName(tableInfo)};
import ${builderUtil.getSubPackage("message")}.${builderUtil.getClassName(tableInfo)}Message;

/**
 * ${builderUtil.getClassName(tableInfo)}的Service
 * 
 * @author ${baseInfo.author}
 */
public interface ${builderUtil.getClassName(tableInfo)}Service {

  /**
   * 修改${builderUtil.getClassName(tableInfo)}信息
   * 
   * @param ${builderUtil.getTableFieldName(tableInfo)} 页面提交数据
   * @return 修改${builderUtil.getClassName(tableInfo)}信息的结果
   * @throws Exception 处理发生错误
   */
  BaseResult update(${builderUtil.getClassName(tableInfo)} ${builderUtil.getTableFieldName(tableInfo)}) throws Exception;

  /**
   * 删除${builderUtil.getClassName(tableInfo)}信息
   * 
   * @param ${builderUtil.getTableFieldName(tableInfo)} 页面提交数据
   * @return 删除${builderUtil.getClassName(tableInfo)}信息的结果
   * @throws Exception 处理发生错误
   */
  BaseResult delete(${builderUtil.getClassName(tableInfo)} ${builderUtil.getTableFieldName(tableInfo)}) throws Exception;

  /**
   * 添加${builderUtil.getClassName(tableInfo)}信息
   * 
   * @param ${builderUtil.getTableFieldName(tableInfo)} 页面提交数据
   * @return 添加${builderUtil.getClassName(tableInfo)}信息的结果
   * @throws Exception 处理发生错误
   */
  BaseResult add(${builderUtil.getClassName(tableInfo)} ${builderUtil.getTableFieldName(tableInfo)}) throws Exception;

  /**
   * 按照主键查询${builderUtil.getClassName(tableInfo)}信息
   * 
   * @param ${builderUtil.getTableFieldName(tableInfo)} 页面提交数据
   * @return 主键查询${builderUtil.getClassName(tableInfo)}信息的结果
   * @throws Exception 处理发生错误
   */
  BaseDataResult<${builderUtil.getClassName(tableInfo)}> queryByKey(${builderUtil.getClassName(tableInfo)} ${builderUtil.getTableFieldName(tableInfo)}) throws Exception;

  /**
   * 分页查询${builderUtil.getClassName(tableInfo)}信息
   * 
   * @param pageBean 分页信息
   * @param ${builderUtil.getTableFieldName(tableInfo)} 页面提交数据
   * @return 分页查询${builderUtil.getClassName(tableInfo)}信息的结果
   * @throws Exception 处理发生错误
   */
  ${builderUtil.getClassName(tableInfo)}Message queryAll(PageBean pageBean, ${builderUtil.getClassName(tableInfo)} ${builderUtil.getTableFieldName(tableInfo)}) throws Exception;

}