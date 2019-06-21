package com.aaa.model.vo;

import java.io.Serializable;
import java.util.Date;

import com.baomidou.mybatisplus.activerecord.Model;
import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;
import com.baomidou.mybatisplus.enums.IdType;
/**
 * 类名称：AssistPlanVo
 * 类描述： 帮扶计划实体类
 * 创建人：sunshaoshan
 * 创建时间：2018-2-1 上午9:03:31
 */
public class AssistPlanVo extends Model<AssistPlanVo> {
	/**
     * 主键，计划Id
     */
	private Long id;
	/**
	 * 班级名称
	 */
	private String classname;
	private String teacher;
	private String stuname;
	/**
	 * 学习内容
	 */
	private String stucontent;
	/**
	 * 帮扶结果
	 */
	private String comflan;
	/**
	 * 计划措施
	 */
	private String plancontent;
	/**
	 * 备注
	 */
	private String remark;
	/**
	 * 开始时间
	 */
	private String starttime;
	/**
	 * 结束时间
	 */
	private String endtime;
	
	/**
	 * 创建人
	 */
	private String createname;
	/**
	 * 创建时间
	 */
	private String createtime;
	
	private String isstatus;

	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}

	public String getClassname() {
		return classname;
	}



	public void setClassname(String classname) {
		this.classname = classname;
	}



	public String getStucontent() {
		return stucontent;
	}



	public void setStucontent(String stucontent) {
		this.stucontent = stucontent;
	}



	public String getStarttime() {
		return starttime;
	}



	public void setStarttime(String starttime) {
		this.starttime = starttime;
	}



	public String getEndtime() {
		return endtime;
	}



	public void setEndtime(String endtime) {
		this.endtime = endtime;
	}



	public String getCreatename() {
		return createname;
	}



	public void setCreatename(String createname) {
		this.createname = createname;
	}



	public String getCreatetime() {
		return createtime;
	}



	public void setCreatetime(String createtime) {
		this.createtime = createtime;
	}
	public String getIsstatus() {
		return isstatus;
	}
	public void setIsstatus(String isstatus) {
		this.isstatus = isstatus;
	}
	public String getTeacher() {
		return teacher;
	}
	public void setTeacher(String teacher) {
		this.teacher = teacher;
	}
	
	public String getComflan() {
		return comflan;
	}
	public void setComflan(String comflan) {
		this.comflan = comflan;
	}
	public String getPlancontent() {
		return plancontent;
	}
	public void setPlancontent(String plancontent) {
		this.plancontent = plancontent;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	
	public String getStuname() {
		return stuname;
	}
	public void setStuname(String stuname) {
		this.stuname = stuname;
	}
	@Override
	protected Serializable pkVal() {
		return this.id;
	}

}
