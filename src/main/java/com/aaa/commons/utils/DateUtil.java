package com.aaa.commons.utils;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

/**
 * @author TeacherChen
 * @description
 * @company AAA软件 2017-9-18上午11:01:49
 */
public class DateUtil {
	/**
	 * 根据开始时间和时长返回结束时间
	 * @param beginTime 开始时间
	 * @param hourNum 时长
	 * @return 结束时间
	 */

	public static Date getEndTime(Date beginTime, Integer hourNum) {
		if (hourNum == null) {
			hourNum = 0;
		}
		Calendar ca = Calendar.getInstance();
		ca.setTime(beginTime);
		ca.add(Calendar.HOUR_OF_DAY, hourNum);
		return ca.getTime();

	}
	public  static String fromDateToString(Date date){
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String format = sdf.format(date);
		return format;
	} 
	public  static String fromDateToStringN(Date date){
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		String format = sdf.format(date);
		return format;
	}
	public  static Date fromStringToDate(String str){
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date date = new Date();
		try {
			date = sdf.parse(str);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return date;
	} 
	/**
	 * @param args
	 */
	public static void main(String[] args) {
		System.out.println(getEndTime(new Date(), 25));

	}

}
