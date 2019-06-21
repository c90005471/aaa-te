package com.aaa.test.mail;

import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.aaa.commons.mail.MailBiz;
import com.aaa.commons.mail.MailParam;


public class MailTest {
	public static void main(String[] args) {
		ClassPathXmlApplicationContext context = new ClassPathXmlApplicationContext("classpath:spring-config.xml");
		MailBiz mb =(MailBiz) context.getBean("mailBiz");
		MailParam mail=new MailParam();
		mail.setTo("chenjian3822515@163.com");
		mail.setSubject("ActiveMQ测试123");
		mail.setContent("通过ActiveMQ异步发送邮件333！");

		mb.mailSend(mail);

	}
}
