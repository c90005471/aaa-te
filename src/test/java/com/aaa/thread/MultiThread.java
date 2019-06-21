package com.aaa.thread;

import java.io.IOException;

/**
 * @author TeacherChen
 * @description 这辈子第一个多线程代码
 * @company AAA软件
 * 2017-9-30上午9:07:33
 */
public class MultiThread extends Thread {
	private String ip;

	public MultiThread(String ip) {
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
