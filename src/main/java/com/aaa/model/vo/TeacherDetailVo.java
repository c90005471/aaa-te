package com.aaa.model.vo;

import java.io.Serializable;

import com.aaa.commons.utils.JsonUtils;
/**
*
* 教师评价明细表实体
*
*/
public class TeacherDetailVo implements Serializable{
	private static final long serialVersionUID = 1L;
	/** 主键id */
	private Long id;
	/** 题目id */
	private Long questionid;
	/** 得分 */
	private Long score;
	/** 提交时间 */
	private Long submittime;
	/** 教师评价计划编号 */
	private Long teatestid;
	
	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public Long getQuestionid() {
		return questionid;
	}

	public void setQuestionid(Long questionid) {
		this.questionid = questionid;
	}

	public Long getScore() {
		return score;
	}

	public void setScore(Long score) {
		this.score = score;
	}

	public Long getSubmittime() {
		return submittime;
	}

	public void setSubmittime(Long submittime) {
		this.submittime = submittime;
	}

	public Long getTeatestid() {
		return teatestid;
	}

	public void setTeatestid(Long teatestid) {
		this.teatestid = teatestid;
	}

	@Override
	public String toString() {
		return JsonUtils.toJson(this);
	}
}
