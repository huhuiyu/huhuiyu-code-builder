package ${builderUtil.getSubPackage("controller")};

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiImplicitParams;
import io.swagger.annotations.ApiOperation;
import ${builderUtil.getSubPackage("base")}.BaseDataResult;
import ${builderUtil.getSubPackage("base")}.BaseResult;
import ${builderUtil.getSubPackage("entity")}.PageBean;
import ${builderUtil.getSubPackage("entity")}.${builderUtil.getClassName(tableInfo)};
import ${builderUtil.getSubPackage("message")}.${builderUtil.getClassName(tableInfo)}Message;
import ${builderUtil.getSubPackage("service")}.${builderUtil.getClassName(tableInfo)}Service;

/**
 * ${builderUtil.getClassName(tableInfo)}的控制器
 * 
 * @author ${baseInfo.author}
 */
 @Api(tags = { "${builderUtil.getClassName(tableInfo)}" })
@RestController
@RequestMapping("/${builderUtil.getClassName(tableInfo)}")
public class ${builderUtil.getClassName(tableInfo)}Controller {

  @Autowired
  private ${builderUtil.getClassName(tableInfo)}Service ${builderUtil.getTableFieldName(tableInfo)}Service;

  @ApiOperation(value = "查询全部")
  @ApiImplicitParams({ @ApiImplicitParam(name = "pageNumber", value = "分页页码", paramType = "query"), @ApiImplicitParam(name = "pageSize", value = "分页大小", paramType = "query") })
  @PostMapping("/queryAll")
  public ${builderUtil.getClassName(tableInfo)}Message queryAll(PageBean pageBean, ${builderUtil.getClassName(tableInfo)} ${builderUtil.getTableFieldName(tableInfo)}) throws Exception {
    return ${builderUtil.getTableFieldName(tableInfo)}Service.queryAll(pageBean, ${builderUtil.getTableFieldName(tableInfo)});
  }

  @ApiOperation(value = "添加")
  @ApiImplicitParams({ 
    <#list tableInfo.columnInfos as col>
    @ApiImplicitParam(name = "${builderUtil.getColFieldName(col)}", value = "${builderUtil.getColFieldName(col)}", paramType = "query")<#if col_has_next>,</#if>
    </#list>
  })
  @PostMapping("/add")
  public BaseResult add(${builderUtil.getClassName(tableInfo)} ${builderUtil.getTableFieldName(tableInfo)}) throws Exception {
    return ${builderUtil.getTableFieldName(tableInfo)}Service.add(${builderUtil.getTableFieldName(tableInfo)});
  }

  @ApiOperation(value = "修改")
  @ApiImplicitParams({ 
    <#list tableInfo.columnInfos as col>
    @ApiImplicitParam(name = "${builderUtil.getColFieldName(col)}", value = "${builderUtil.getColFieldName(col)}", paramType = "query")<#if col_has_next>,</#if>
    </#list>
  })
  @PostMapping("/update")
  public BaseResult update(${builderUtil.getClassName(tableInfo)} ${builderUtil.getTableFieldName(tableInfo)}) throws Exception {
    return ${builderUtil.getTableFieldName(tableInfo)}Service.update(${builderUtil.getTableFieldName(tableInfo)});
  }

  @ApiOperation(value = "删除")
  @ApiImplicitParams({ 
    <#list tableInfo.getPrimaryKeys() as col>
    @ApiImplicitParam(name = "${builderUtil.getColFieldName(col)}", value = "${builderUtil.getColFieldName(col)}", paramType = "query")<#if col_has_next>,</#if>
    </#list>
  })
  @PostMapping("/delete")
  public BaseResult delete(${builderUtil.getClassName(tableInfo)} ${builderUtil.getTableFieldName(tableInfo)}) throws Exception {
    return ${builderUtil.getTableFieldName(tableInfo)}Service.delete(${builderUtil.getTableFieldName(tableInfo)});
  }

  @ApiOperation(value = "主键查询")
  @ApiImplicitParams({ 
    <#list tableInfo.getPrimaryKeys() as col>
    @ApiImplicitParam(name = "${builderUtil.getColFieldName(col)}", value = "${builderUtil.getColFieldName(col)}", paramType = "query")<#if col_has_next>,</#if>
    </#list>
  })
  @PostMapping("/queryByKey")
  public BaseDataResult<${builderUtil.getClassName(tableInfo)}> queryByKey(${builderUtil.getClassName(tableInfo)} ${builderUtil.getTableFieldName(tableInfo)}) throws Exception {
    return ${builderUtil.getTableFieldName(tableInfo)}Service.queryByKey(${builderUtil.getTableFieldName(tableInfo)});
  }

}