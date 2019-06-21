package com.aaa.model;

import java.io.Serializable;

public class Answer implements Serializable{

	/**
	 * 评价的答案
	 */
	private static final long serialVersionUID = 1L;
	
	private Long id;
	private String item;
	private String answer;
	private Long quesId;
	private String type;//0 单选  1多选
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public String getItem() {
		return item;
	}
	public void setItem(String item) {
		this.item = item;
	}
	public String getAnswer() {
		return answer;
	}
	public void setAnswer(String answer) {
		this.answer = answer;
	}
	
	public Long getQuesId() {
		return quesId;
	}
	public void setQuesId(Long quesId) {
		this.quesId = quesId;
	}	
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	@Override
	public String toString() {
		return "Answer [id=" + id + ", item=" + item + ", answer=" + answer
				+ ", quesId=" + quesId + ", type=" + type + "]";
	}
	
	

}
