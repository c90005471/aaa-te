package com.aaa.model;

import com.aaa.commons.utils.JsonUtils;
import com.baomidou.mybatisplus.annotations.TableName;

/**
 * @title: TeaQuestion
 * @Description:
 * @Company:AAA
 * @Date 2017-9-20 上午11:43:39
 * @author 万舒萌
 */
@TableName("teacherquestion")
public class TeaQuestion {
	
	/** 主键id */
	private Long id;
	
	/** 问题名称 */
	private String questionname;
	/**问题类型**/
	private String questiontype;
	private int type;
	private int status;
	
	
	public String getQuestiontype() {
		return questiontype;
	}

	public void setQuestiontype(String questiontype) {
		this.questiontype = questiontype;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getQuestionname() {
		return questionname;
	}

	public void setQuestionname(String questionname) {
		this.questionname = questionname;
	}

	public int getType() {
		return type;
	}

	public void setType(int type) {
		this.type = type;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	@Override
	public String toString() {
		return JsonUtils.toJson(this);
	}
	
}
