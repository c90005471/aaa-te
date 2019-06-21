package com.aaa.commons.mail;


/**
 * @author TeacherChen
 * @description 邮件信息封装类
 * @company AAA软件
 * 2017-9-24下午10:30:34
 */
public class MailParam {

	/** 发件人 **/
	private String from;
	/** 收件人 **/
	private String to;
	/** 主题 **/
	private String subject;
	/** 邮件内容 **/
	private String content;

	public MailParam() {
	}

	public MailParam(String to, String subject, String content) {
		this.to = to;
		this.subject = subject;
		this.content = content;
	}

	public String getFrom() {
		return from;
	}

	public void setFrom(String from) {
		this.from = from;
	}

	public String getTo() {
		return to;
	}

	public void setTo(String to) {
		this.to = to;
	}

	public String getSubject() {
		return subject;
	}

	public void setSubject(String subject) {
		this.subject = subject;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}
}
