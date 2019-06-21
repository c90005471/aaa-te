package com.aaa.thread;

/**
 * @author TeacherChen
 * @description 多线程卖票
 * @company AAA软件
 * 2017-9-30上午9:44:44
 */
public class ThreadTicket extends Thread {
	private int ticketNum=5;
	private String name;
	public ThreadTicket(String name) {
		super();
		this.name = name;
	}

	@Override
	public void run() {
		for (int i = 1; i <=5 ; i++) {
			System.out.println(name+"卖票"+ticketNum--);
			
		}
	}
}
