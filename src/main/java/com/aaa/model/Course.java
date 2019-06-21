package com.aaa.model;

import java.io.Serializable;
import java.util.Date;

import com.aaa.commons.utils.JsonUtils;
import com.fasterxml.jackson.annotation.JsonProperty;

/**
 * 
 * 科目实体类jpa规范
 * 
 */
public class Course implements Serializable {

	private static final long serialVersionUID = 1L;

	/** 主键 */
	private Long id;
	/** 科目代码 */
	private String courseCode;
	/** 科目名称 */
	private String courseName;
	/** 排序 */
	private Long pid;
	private Integer seq;

	/** 状态 */
	private Integer status;

	/** 知识点图标 */
	@JsonProperty("iconCls")
	private String icon;

	/*知识点为1，其他为0，知识点为tree的叶子节点*/
	private Integer courseType;
	/** 创建时间 */
	private Date createTime;

	/** 所属专业 */
	private Integer orgid;
	private String courseVersion;
	

	
	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getCourseCode() {
		return courseCode;
	}

	public void setCourseCode(String courseCode) {
		this.courseCode = courseCode;
	}

	public String getCourseName() {
		return courseName;
	}

	public void setCourseName(String courseName) {
		this.courseName = courseName;
	}

	public Integer getSeq() {
		return seq;
	}

	public void setSeq(Integer seq) {
		this.seq = seq;
	}

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	public String getIcon() {
		return icon;
	}

	public void setIcon(String icon) {
		this.icon = icon;
	}

	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}



	public Integer getOrgid() {
		return orgid;
	}

	public void setOrgid(Integer orgid) {
		this.orgid = orgid;
	}
	
	
	

	public Long getPid() {
		return pid;
	}

	public void setPid(Long pid) {
		this.pid = pid;
	}

	
	
	public Integer getCourseType() {
		return courseType;
	}

	public void setCourseType(Integer courseType) {
		this.courseType = courseType;
	}
	

	public String getCourseVersion() {
		return courseVersion;
	}

	public void setCourseVersion(String courseVersion) {
		this.courseVersion = courseVersion;
	}


	@Override
	public String toString() {
		return JsonUtils.toJson(this);
	}
}
