package ${builderUtil.getSubPackage("entity")};

<#if tableInfo.getPrimaryKeys()?size &gt; 0>
import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
</#if>
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import io.swagger.annotations.ApiParam;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import ${builderUtil.getSubPackage("base")}.BaseEntity;

/**
 * ${tableInfo.name}表
 * 
 * @author ${baseInfo.author}
 */
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ApiModel(value = "${builderUtil.getClassName(tableInfo)}", description = "${builderUtil.getClassName(tableInfo)}")
public class ${builderUtil.getClassName(tableInfo)} extends BaseEntity {

  private static final long serialVersionUID = ${builderUtil.serialVersionUid};
  
<#list tableInfo.columnInfos as column>
  <#if column.primaryKey>
  @TableId(type = IdType.AUTO)
  </#if>
  @ApiModelProperty(value = "${builderUtil.getColFieldName(column)}")
  @ApiParam(hidden = true)
  private ${builderUtil.getColType(column)} ${builderUtil.getColFieldName(column)};
</#list>

}