package com.aaa.model;

import java.io.Serializable;
import java.util.Date;

import com.baomidou.mybatisplus.activerecord.Model;
import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;
import com.baomidou.mybatisplus.enums.IdType;
/**
 * 类名称：AssistPlan
 * 类描述： 帮扶计划实体类
 * 创建人：sunshaoshan
 * 创建时间：2018-2-1 上午9:03:31
 * @version
 */
@TableName("assistplan")
public class AssistPlan extends Model<AssistPlan> {
	/**
     * 主键，计划Id
     */
	@TableId(value="id", type= IdType.AUTO)
	private Long id;
	/**
	 * 班级id
	 */
	private Long classid;
	/**
	 * 学习内容
	 */
	private String stucontent;
	/**
	 * 开始时间
	 */
	private Date starttime;
	/**
	 * 结束时间
	 */
	private Date endtime;
	/**
	 * 计划内容
	 */
	private String plancontent;
	/**
	 * 计划完成情况
	 */
	private String comflan;
	/**
	 * 备注
	 */
	private String remark;
	/**
	 * 是否完成  0 未完成  1已完成
	 */
	private Integer isstatus;
	/**
	 * 创建人
	 */
	private Long creator;
	/**
	 * 创建时间
	 */
	private Date createtime;
	
	
	public Long getId() {
		return id;
	}


	public void setId(Long id) {
		this.id = id;
	}


	public Long getClassid() {
		return classid;
	}


	public void setClassid(Long classid) {
		this.classid = classid;
	}


	public String getStucontent() {
		return stucontent;
	}


	public void setStucontent(String stucontent) {
		this.stucontent = stucontent;
	}


	public Date getStarttime() {
		return starttime;
	}


	public void setStarttime(Date starttime) {
		this.starttime = starttime;
	}


	public Date getEndtime() {
		return endtime;
	}


	public void setEndtime(Date endtime) {
		this.endtime = endtime;
	}


	public String getPlancontent() {
		return plancontent;
	}


	public void setPlancontent(String plancontent) {
		this.plancontent = plancontent;
	}


	public String getComflan() {
		return comflan;
	}


	public void setComflan(String comflan) {
		this.comflan = comflan;
	}
	
	public Integer getIsstatus() {
		return isstatus;
	}

	public void setIsstatus(Integer isstatus) {
		this.isstatus = isstatus;
	}

	public Long getCreator() {
		return creator;
	}

	public void setCreator(Long creator) {
		this.creator = creator;
	}


	public Date getCreatetime() {
		return createtime;
	}


	public void setCreatetime(Date createtime) {
		this.createtime = createtime;
	}
	

	public String getRemark() {
		return remark;
	}


	public void setRemark(String remark) {
		this.remark = remark;
	}


	@Override
	protected Serializable pkVal() {
		return this.id;
	}

}
