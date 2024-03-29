package com.aaa.commons.mail;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.MailException;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.scheduling.concurrent.ThreadPoolTaskExecutor;
import org.springframework.stereotype.Component;




/**
 * @author TeacherChen
 * @description 邮件发送业务类
 * @company AAA软件
 * 2017-9-24下午10:10:43
 */
@Component("mailBiz")
public class MailBiz {

	@Autowired
	private JavaMailSender mailSender;// spring配置中定义
	@Autowired
	private SimpleMailMessage simpleMailMessage;// spring配置中定义
	@Autowired
	private ThreadPoolTaskExecutor threadPool;//线程池，spring中配置

	/**
	 * 发送模板邮件
	 * 
	 * @param mailParamTemp需要设置四个参数
	 *            templateName,toMail,subject,mapModel
	 * @throws Exception
	 * 
	 */
	public void mailSend(final MailParam mailParam) {
		threadPool.execute(new Runnable() {
			public void run() {
				try {
					simpleMailMessage.setFrom(simpleMailMessage.getFrom()); // 发送人,从配置文件中取得
					simpleMailMessage.setTo(mailParam.getTo()); // 接收人
					simpleMailMessage.setSubject(mailParam.getSubject());
					simpleMailMessage.setText(mailParam.getContent());
					mailSender.send(simpleMailMessage);
					//mailSender.send(simpleMailMessage);
				} catch (MailException e) {
					System.out.println(e);
					throw e;
				}
			}
		});
	}
}
