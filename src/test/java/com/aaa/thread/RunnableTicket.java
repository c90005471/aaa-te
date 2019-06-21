package com.aaa.thread;

/**
 * @author TeacherChen
 * @description 多线程卖票
 * @company AAA软件
 * 2017-9-30上午9:44:44
 */
public class RunnableTicket implements Runnable {
	private int ticketNum=5;
	
	


	@Override
	public void run() {
		for (int i = 1; i <=5 ; i++) {
	
			saleTicket();
		}
		
	}
	
	public synchronized void saleTicket(){
		if(ticketNum>0){
			try {
				Thread.sleep(500);//线程睡眠500毫秒
			} catch (InterruptedException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			System.out.println(Thread.currentThread().getName()+"卖票"+ticketNum--);
		}
	}
	
}
