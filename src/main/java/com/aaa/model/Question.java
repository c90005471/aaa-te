package com.aaa.model;

import java.io.Serializable;

public class Question implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	public Question() {
		super();
		// TODO Auto-generated constructor stub
	}
	public Question(Long questionId, String questionTitle,
			String questionItems, String questionAnswer) {
		super();
		this.questionId = questionId;
		this.questionTitle = questionTitle;
		this.questionItems = questionItems;
		this.questionAnswer = questionAnswer;
	}
	private Long questionId;
	private String questionTitle;
	private String questionItems;
	private String questionAnswer;
	private String[] items;//选项
	private Integer questionType;
	public Long getQuestionId() {
		return questionId;
	}
	public void setQuestionId(Long questionId) {
		this.questionId = questionId;
	}
	public String getQuestionTitle() {
		return questionTitle;
	}
	public void setQuestionTitle(String questionTitle) {
		this.questionTitle = questionTitle;
	}
	public String getQuestionItems() {
		return questionItems;
	}
	public void setQuestionItems(String questionItems) {
		this.questionItems = questionItems;
	}
	public String getQuestionAnswer() {
		return questionAnswer;
	}
	public void setQuestionAnswer(String questionAnswer) {
		this.questionAnswer = questionAnswer;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	public String[] getItems() {
		return items;
	}
	public void setItems(String[] items) {
		this.items = items;
	}
	public Integer getQuestionType() {
		return questionType;
	}
	public void setQuestionType(Integer questionType) {
		this.questionType = questionType;
	}
	

}
