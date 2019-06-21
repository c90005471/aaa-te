package com.aaa.commons.utils;

/**
 * 类名称：IdnoUtil 类描述： 创建人：sunshaoshan 创建时间：2018-6-2 下午4:02:49
 * 
 * @version
 */
public class IdnoUtil {
	/**
	 * 根据身份证号获取性别
	 * @param idno
	 * @return
	 */
	public static String getSexByIdno(String idno) {
		String sex = "";
		String sexnoStr = "";
		if (idno.length() == 18) {
			sexnoStr = idno.substring(16, 17);
		} else if (idno.length() == 15) {
			sexnoStr = idno.substring(14, 15);
		} else {
			// alert("错误的身份证号码，请核对！");
			sexnoStr = "3";
		}
		int sexno = Integer.valueOf(sexnoStr);
		int tempid = sexno % 2;
		if (tempid == 0) {
			sex = "女";
		} else {
			sex = "男";
		}
		return sex;
	}
}
