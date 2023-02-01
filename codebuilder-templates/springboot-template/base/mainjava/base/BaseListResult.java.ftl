package ${builderUtil.getSubPackage("base")};

import java.util.List;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import ${builderUtil.getSubPackage("entity")}.PageBean;

/**
 * 分页查询基础应答
 * 
 * @author ${baseInfo.author}
 *
 * @param <T> 查询结果类
 *
 */
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ApiModel(value = "分页查询基础应答", description = "分页查询基础应答")
public class BaseListResult<T> extends BaseResult {

  private static final long serialVersionUID = ${builderUtil.serialVersionUid};

  @ApiModelProperty(value = "分页信息")
  private PageBean page;
  @ApiModelProperty(value = "查询结果")
  private List<T> list;

}
