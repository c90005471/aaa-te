package com.aaa.thread;

import java.io.BufferedInputStream;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.Date;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.scheduling.concurrent.ThreadPoolTaskExecutor;

import com.aaa.commons.mail.MailBiz;
import com.aaa.commons.mail.MailParam;

public class PingHost {
	
	public static boolean ping(String ipadress) throws IOException{
		Process exec = Runtime.getRuntime().exec("ping "+ipadress);
		BufferedReader buf = new BufferedReader(new InputStreamReader(exec.getInputStream()));
		String line;
		while ((line=buf.readLine())!=null) {
			if(line.contains("TTL")){
				System.out.println(ipadress+" 可到达！");
				return true;
			}
			
		}
		System.out.println(ipadress+" 不可到达！");
		return false;
		
	}

	/**
	 * @param args
	 * @throws IOException 
	 */
	public static void main(String[] args) throws IOException {
		/*System.out.println("开始时间："+new Date());
		for (int i = 22; i < 33; i++) {
			ping("172.16.22."+i);
		}
		System.out.println("结束时间："+new Date());*/
		
		
/*		System.out.println("开始时间："+new Date());
		for (int i = 22; i < 33; i++) {
			MultiThread mt = new MultiThread("172.16.22."+i);
			mt.start();
		}
		System.out.println("结束时间："+new Date());*/
		
		/*System.out.println("开始时间："+new Date());
		for (int i = 22; i < 33; i++) {
			MultiThread mt = new MultiThread("172.16.22."+i);
			mt.start();
			MultiThreadRunnable mr = new MultiThreadRunnable("172.16.22."+i);
			new Thread(mr).start();
		}
		System.out.println("结束时间："+new Date());*/
		
		/*new ThreadTicket("小昭").start();
		new ThreadTicket("赵敏").start();*/
	/*	RunnableTicket rt = new RunnableTicket();
		new Thread(rt,"小昭").start();
		new Thread(rt,"赵敏").start();*/

		ApplicationContext ac = new ClassPathXmlApplicationContext("classpath:spring-task.xml");
		ThreadPoolTaskExecutor tt=(ThreadPoolTaskExecutor) ac.getBean("taskExecutor");
		for (int i = 22; i < 33; i++) {
			MultiThreadRunnable mr = new MultiThreadRunnable("172.16.22."+i);
			tt.execute(mr);
		}
		
	
	}

}
