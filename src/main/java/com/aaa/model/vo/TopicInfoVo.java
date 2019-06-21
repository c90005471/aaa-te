package com.aaa.model.vo;
/**
 * 类名称：TopicInfoVo
 * 类描述： 试题导出信息类
 * 创建人：sunshaoshan
 * 创建时间：2018-7-6 下午4:32:22
 * @version
 */
public class TopicInfoVo {
	private String id;//临时使用
	/**
	 * 题目内容
	 */
	private String topicname;
	/**
	 * 答案
	 */
	private String correct;
	/**
	 * 试题类型
	 */
	private String type;
	/**
	 * 选项A
	 */
	private String optionA;
	/**
	 * 选项B
	 */
	private String optionB;
	/**
	 * 选项C
	 */
	private String optionC;
	/**
	 * 选项D
	 */
	private String optionD;
	public String getTopicname() {
		return topicname;
	}
	public void setTopicname(String topicname) {
		this.topicname = topicname;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getOptionA() {
		return optionA;
	}
	public void setOptionA(String optionA) {
		this.optionA = optionA;
	}
	public String getOptionB() {
		return optionB;
	}
	public void setOptionB(String optionB) {
		this.optionB = optionB;
	}
	public String getOptionC() {
		return optionC;
	}
	public void setOptionC(String optionC) {
		this.optionC = optionC;
	}
	public String getOptionD() {
		return optionD;
	}
	public void setOptionD(String optionD) {
		this.optionD = optionD;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getCorrect() {
		return correct;
	}
	public void setCorrect(String correct) {
		this.correct = correct;
	}
	
	
}
