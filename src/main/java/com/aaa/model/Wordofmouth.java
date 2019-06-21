package com.aaa.model;

import com.aaa.commons.utils.JsonUtils;

import java.io.Serializable;
import java.util.Date;

/**
 * 
 * 类名称：Wordofmouth
 * 类描述： 口碑信息
 * 创建人：sunshaoshan
 * 创建时间：2018-1-11 下午1:34:49
 * @version
 */
public class Wordofmouth implements Serializable {

	private static final long serialVersionUID = 1L;

	/** 主键id */
	private Long id;

	/**学生姓名**/
	private String stuname;
	/**学生电话**/
	private String stuphone;
	/**报备人姓名**/
	private String teaname;
	/**报备人电话**/
	private String teaphone;
	/**备注信息**/
	private String remark;
	/**口碑状态**/
	private String status;
	/** 创建时间 */
	private Date createtime;

	public Long getId() {
		return this.id;
	}

	public void setId(Long id) {
		this.id = id;
	}
	

	public String getStuname() {
		return stuname;
	}

	public void setStuname(String stuname) {
		this.stuname = stuname;
	}

	public String getStuphone() {
		return stuphone;
	}

	public void setStuphone(String stuphone) {
		this.stuphone = stuphone;
	}

	public String getTeaname() {
		return teaname;
	}

	public void setTeaname(String teaname) {
		this.teaname = teaname;
	}

	public String getTeaphone() {
		return teaphone;
	}

	public void setTeaphone(String teaphone) {
		this.teaphone = teaphone;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}
	
	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public Date getCreatetime() {
		return createtime;
	}

	public void setCreatetime(Date createtime) {
		this.createtime = createtime;
	}

	@Override
	public String toString() {
		return JsonUtils.toJson(this);
	}
}
