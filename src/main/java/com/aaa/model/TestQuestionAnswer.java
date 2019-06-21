package com.aaa.model;

import java.io.Serializable;

import com.baomidou.mybatisplus.activerecord.Model;
import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;
import com.baomidou.mybatisplus.enums.IdType;
@TableName("testquestion_answer")
public class TestQuestionAnswer extends Model<TestQuestionAnswer> {
	/**
	 * 主键 自增
	 */
	@TableId(value="id",type=IdType.AUTO)
	private Long id;
	/**
	 * 选项
	 */
	private String option;
	/**
	 * 得分
	 */
	private Integer score;
	/**
	 * 外键
	 * @return
	 */
	private Long quesid;
	
	public Long getId() {
		return id;
	}
	

	public Long getQuesid() {
		return quesid;
	}


	public void setQuesid(Long quesid) {
		this.quesid = quesid;
	}


	public void setId(Long id) {
		this.id = id;
	}


	public String getOption() {
		return option;
	}


	public void setOption(String option) {
		this.option = option;
	}


	public Integer getScore() {
		return score;
	}


	public void setScore(Integer score) {
		this.score = score;
	}


	@Override
	protected Serializable pkVal() {
		return this.id;
	}

}
