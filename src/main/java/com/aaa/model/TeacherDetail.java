package com.aaa.model;

import java.io.Serializable;
import java.util.Date;

import com.aaa.commons.utils.JsonUtils;
import com.baomidou.mybatisplus.annotations.TableName;
/**
*
* 教师评价明细表实体
*
*/
@TableName("teacherdetail")
public class TeacherDetail implements Serializable{
	private static final long serialVersionUID = 1L;
	/** 主键id */
	private Long id;
	/** session id */
	private String sessionid;
	/** 题目id */
	private Long questionid;
	/** 得分 */
	private Integer score;
	/** 提交时间 */
	private Date submitime;
	/** 教师评价计划表编号 */
	private Long teatestid;
	/** 老师编号 */
	private Long teacherid;
	/** 意见 */
	private String idea;
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

	public Integer getScore() {
		return score;
	}

	public void setScore(Integer score) {
		this.score = score;
	}

	public Date getSubmitime() {
		return submitime;
	}

	public void setSubmitime(Date submitime) {
		this.submitime = submitime;
	}

	public Long getTeatestid() {
		return teatestid;
	}

	public void setTeatestid(Long teatestid) {
		this.teatestid = teatestid;
	}

	public String getSessionid() {
		return sessionid;
	}

	public void setSessionid(String sessionid) {
		this.sessionid = sessionid;
	}
	

	public Long getTeacherid() {
		return teacherid;
	}

	public void setTeacherid(Long teacherid) {
		this.teacherid = teacherid;
	}
	public String getIdea() {
		return idea;
	}

	public void setIdea(String idea) {
		this.idea = idea;
	}

	@Override
	public String toString() {
		return JsonUtils.toJson(this);
	}
}
