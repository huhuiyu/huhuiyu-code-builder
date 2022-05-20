package ${builderUtil.getSubPackage("message")};

import java.util.List;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import ${builderUtil.getSubPackage("base")}.BaseResult;
import ${builderUtil.getSubPackage("entity")}.PageBean;
import ${builderUtil.getSubPackage("entity")}.${builderUtil.getClassName(tableInfo)};

/**
 * ${builderUtil.getClassName(tableInfo)}应答对象
 * 
 * @author ${baseInfo.author}
 */
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ApiModel(value = "${builderUtil.getClassName(tableInfo)}Message", description = "${builderUtil.getClassName(tableInfo)}Message")
public class ${builderUtil.getClassName(tableInfo)}Message extends BaseResult {

  private static final long serialVersionUID = ${builderUtil.serialVersionUid};

  @ApiModelProperty(value = "分页信息")
  private PageBean page;
  @ApiModelProperty(value = "查询结果")
  private List<${builderUtil.getClassName(tableInfo)}> list;

}