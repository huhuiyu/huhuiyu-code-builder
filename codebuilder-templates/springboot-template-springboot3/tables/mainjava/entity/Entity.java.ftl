package ${builderUtil.getSubPackage("entity")};

import com.mybatisflex.annotation.Id;
import com.mybatisflex.annotation.KeyType;
import com.mybatisflex.annotation.Table;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

import java.io.Serial;
import java.io.Serializable;

/**
 * ${tableInfo.name}表
 * 
 * @author ${baseInfo.author}
 */
@Table(value = "${tableInfo.name}")
@Data
@Schema(name = "${builderUtil.getClassName(tableInfo)}", description = "${builderUtil.getClassName(tableInfo)}")
public class ${builderUtil.getClassName(tableInfo)} implements Serializable {

  @Serial
  private static final long serialVersionUID = 1L;
  
<#list tableInfo.columnInfos as column>
  <#if column.primaryKey>
  @Id(keyType = KeyType.Auto)
  </#if>
  @Schema(description = "${builderUtil.getColFieldName(column)}", example = "")
  private ${builderUtil.getColType(column)} ${builderUtil.getColFieldName(column)};
</#list>

}