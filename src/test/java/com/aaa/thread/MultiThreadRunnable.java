package com.aaa.thread;

import java.io.IOException;

/**
 * @author TeacherChen
 * @description 这辈子第二次写多线程代码
 * @company AAA软件
 * 2017-9-30上午9:39:04
 */
public class MultiThreadRunnable implements Runnable {

	private String ip;
	
	
	public MultiThreadRunnable(String ip) {
		super();
		this.ip = ip;
	}
	@Override
	public void run() {
		try {
			PingHost.ping(ip);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

}
