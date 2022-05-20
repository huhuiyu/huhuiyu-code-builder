package ${builderUtil.getSubPackage("service.impl")};

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;

import ${builderUtil.getSubPackage("base")}.BaseDataResult;
import ${builderUtil.getSubPackage("base")}.BaseResult;
import ${builderUtil.getSubPackage("dao")}.${builderUtil.getClassName(tableInfo)}DAO;
import ${builderUtil.getSubPackage("entity")}.PageBean;
import ${builderUtil.getSubPackage("entity")}.${builderUtil.getClassName(tableInfo)};
import ${builderUtil.getSubPackage("message")}.${builderUtil.getClassName(tableInfo)}Message;
import ${builderUtil.getSubPackage("service")}.${builderUtil.getClassName(tableInfo)}Service;

/**
 * ${builderUtil.getClassName(tableInfo)}的实现层
 * 
 * @author ${baseInfo.author}
 */
@Service
@Transactional(rollbackFor = Exception.class)
public class ${builderUtil.getClassName(tableInfo)}ServiceImpl implements ${builderUtil.getClassName(tableInfo)}Service {
  @Autowired
  private ${builderUtil.getClassName(tableInfo)}DAO ${builderUtil.getTableFieldName(tableInfo)}DAO;

  @Override
  public ${builderUtil.getClassName(tableInfo)}Message queryAll(PageBean pageBean, ${builderUtil.getClassName(tableInfo)} ${builderUtil.getTableFieldName(tableInfo)}) throws Exception {
    // 处理分页信息
    if (pageBean == null) {
      pageBean = new PageBean();
    }
    IPage<${builderUtil.getClassName(tableInfo)}> page = new Page<${builderUtil.getClassName(tableInfo)}>();
    pageBean.toIPage(page);
    // 分页查询
    QueryWrapper<${builderUtil.getClassName(tableInfo)}> wrapper = new QueryWrapper<${builderUtil.getClassName(tableInfo)}>();
    page = ${builderUtil.getTableFieldName(tableInfo)}DAO.selectPage(page, wrapper);
    // 应答消息
    ${builderUtil.getClassName(tableInfo)}Message message = new ${builderUtil.getClassName(tableInfo)}Message();
    message.setPage(pageBean.fromIPage(page));
    message.setList(page.getRecords());
    message.setSuccessInfo("");
    return message;
  }

  @Override
  public BaseDataResult<${builderUtil.getClassName(tableInfo)}> queryByKey(${builderUtil.getClassName(tableInfo)} ${builderUtil.getTableFieldName(tableInfo)}) throws Exception {
    BaseDataResult<${builderUtil.getClassName(tableInfo)}> message = new BaseDataResult<${builderUtil.getClassName(tableInfo)}>();
    ${builderUtil.getTableFieldName(tableInfo)} = ${builderUtil.getTableFieldName(tableInfo)}DAO.selectById(${builderUtil.getTableFieldName(tableInfo)});
    if (${builderUtil.getTableFieldName(tableInfo)} == null) {
      message.setFailInfo("查无记录");
    } else {
      message.setSuccessInfo("");
      message.setData(${builderUtil.getTableFieldName(tableInfo)});
    }
    return message;
  }

  @Override
  public BaseResult add(${builderUtil.getClassName(tableInfo)} ${builderUtil.getTableFieldName(tableInfo)}) throws Exception {
    BaseResult message = new BaseResult();
    int result = ${builderUtil.getTableFieldName(tableInfo)}DAO.insert(${builderUtil.getTableFieldName(tableInfo)});
    if (result == 1) {
      message.setSuccessInfo("添加数据成功");
    } else {
      message.setFailInfo("添加数据失败");
    }
    return message;
  }

  @Override
  public BaseResult delete(${builderUtil.getClassName(tableInfo)} ${builderUtil.getTableFieldName(tableInfo)}) throws Exception {
    BaseResult message = new BaseResult();
    int result = ${builderUtil.getTableFieldName(tableInfo)}DAO.deleteById(${builderUtil.getTableFieldName(tableInfo)});
    if (result == 1) {
      message.setSuccessInfo("删除数据成功");
    } else {
      message.setFailInfo("删除数据失败");
    }
    return message;
  }

  @Override
  public BaseResult update(${builderUtil.getClassName(tableInfo)} ${builderUtil.getTableFieldName(tableInfo)}) throws Exception {
    BaseResult message = new BaseResult();
    int result = ${builderUtil.getTableFieldName(tableInfo)}DAO.updateById(${builderUtil.getTableFieldName(tableInfo)});
    if (result == 1) {
      message.setSuccessInfo("修改数据成功");
    } else {
      message.setFailInfo("修改数据失败");
    }
    return message;
  }
}