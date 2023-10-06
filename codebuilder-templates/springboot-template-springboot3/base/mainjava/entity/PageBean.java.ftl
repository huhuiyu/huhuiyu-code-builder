package ${builderUtil.getSubPackage("entity")};

import javax.validation.constraints.Max;
import javax.validation.constraints.Min;

import com.baomidou.mybatisplus.core.metadata.IPage;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import io.swagger.annotations.ApiParam;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import ${builderUtil.getSubPackage("base")}.BaseEntity;
import ${builderUtil.getSubPackage("utils")}.SystemConstants;

/**
 * 分页信息
 * 
 * @author ${baseInfo.author}
 */
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ApiModel(value = "分页信息")
public class PageBean extends BaseEntity {

  private static final long serialVersionUID = ${builderUtil.serialVersionUid};
  @Max(value = SystemConstants.PAGE_SIZE_MAX, message = "分页大小不能超过：" + SystemConstants.PAGE_SIZE_MAX)
  @Min(value = SystemConstants.PAGE_SIZE_MIN, message = "分页大小不能低于：" + SystemConstants.PAGE_SIZE_MIN)
  @ApiModelProperty(value = "分页大小", example = "10")
  @ApiParam(hidden = true)
  private Long pageSize = SystemConstants.PAGE_SIZE;
  @Min(value = SystemConstants.PAGE_NUMBER_MIN, message = "页码不能低于：" + SystemConstants.PAGE_NUMBER_MIN)
  @ApiModelProperty(value = "当前页码", example = "1")
  @ApiParam(hidden = true)
  private Long pageNumber = SystemConstants.PAGE_NUMBER_MIN;
  @ApiModelProperty(value = "分页总数")
  @ApiParam(hidden = true)
  private Long pageCount;
  @ApiModelProperty(value = "记录总数")
  @ApiParam(hidden = true)
  private long total;

  /**
   * 获取IPage的信息
   * 
   * @param pageInfo IPage的信息
   * 
   * @return 当前实例更新后的信息
   */
  public PageBean fromIPage(IPage<?> pageInfo) {
    if (pageInfo == null) {
      return this;
    }
    this.setTotal(pageInfo.getTotal());
    this.setPageCount(pageInfo.getPages());
    this.setPageNumber(pageInfo.getCurrent());
    this.setPageSize(pageInfo.getSize());
    return this;
  }

  /**
   * 将当前实例的信息传递给IPage对象
   * 
   * @param pageInfo 要更新信息的IPage对象
   */
  public void toIPage(IPage<?> pageInfo) {
    if (pageInfo == null) {
      return;
    }
    pageInfo.setCurrent(this.getPageNumber() == null ? SystemConstants.PAGE_NUMBER_MIN : this.getPageNumber());
    pageInfo.setSize(this.getPageSize() == null ? SystemConstants.PAGE_SIZE : this.getPageSize());
  }

}
