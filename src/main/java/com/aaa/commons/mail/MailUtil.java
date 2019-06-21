package com.aaa.commons.mail;

import com.aaa.commons.utils.DateUtil;
import com.aaa.model.TeacherPlan;
import com.aaa.model.User;

/**
 * @author TeacherChen
 * @description 邮件相关工具类
 * @company AAA软件
 * 2017-9-30下午3:05:28
 */
public class MailUtil {
	
	/**
	 * 教评计划制定成功的时候给对应的老师发送邮件
	 * @param emailAddress 邮件地址
	 * @param teacherPlan 教评计划信息
	 * @param String className 班级名称
	 * @return
	 */
	public static MailParam sendMail(User teacher,TeacherPlan teacherPlan,String className){
		MailParam mail=new MailParam();
		mail.setTo(teacher.getEmail());
		mail.setSubject("教评通知【重要】");
		mail.setContent(teacher.getName()+"老师：你好！请于"+DateUtil.fromDateToString(teacherPlan.getBegintime())+"到"+DateUtil.fromDateToString(teacherPlan.getStoptime())+"时间段内安排"+className+"学生进行教评测试！验证码："+teacherPlan.getCode());
		return mail;
	}

}
