package com.aaa.model;

import java.io.Serializable;
import java.util.Date;

import com.aaa.commons.utils.JsonUtils;
import com.fasterxml.jackson.annotation.JsonProperty;

/**
 * 类名称：Returnrecord
 * 类描述： 毕业回访记录实体
 * 创建人：sunshaoshan
 * 创建时间：2018-3-2 上午11:21:23
 * @version
 */
public class Returnrecord implements Serializable {
	private static final long serialVersionUID = 1L;

	/** 主键 */
	private Long id;
	/** 学生id */
	private Long studentId;
	/** 回访人id */
	private Long userId;
	/** 回访内容 */
	private String returncontent;
	/** 回访时间 */
	private Date returntime;
	
	
	public Long getId() {
		return id;
	}


	public void setId(Long id) {
		this.id = id;
	}


	public Long getStudentId() {
		return studentId;
	}


	public void setStudentId(Long studentId) {
		this.studentId = studentId;
	}


	public Long getUserId() {
		return userId;
	}


	public void setUserId(Long userId) {
		this.userId = userId;
	}


	public String getReturncontent() {
		return returncontent;
	}


	public void setReturncontent(String returncontent) {
		this.returncontent = returncontent;
	}


	public Date getReturntime() {
		return returntime;
	}


	public void setReturntime(Date returntime) {
		this.returntime = returntime;
	}


	@Override
	public String toString() {
		return JsonUtils.toJson(this);
	}
}
