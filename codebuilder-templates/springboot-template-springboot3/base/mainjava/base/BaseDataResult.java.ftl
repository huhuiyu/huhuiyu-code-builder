package ${builderUtil.getSubPackage("base")};

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

/**
 * 单数据基础应答对象
 * 
 * @author ${baseInfo.author}
 *
 */
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ApiModel(value = "单数据基础应答", description = "最基本的单数据应答信息")
public class BaseDataResult<T> extends BaseResult {

  private static final long serialVersionUID = ${builderUtil.serialVersionUid};

  /**
   * 应答数据
   */
  @ApiModelProperty(value = "应答数据信息 ")
  private T data;

}
