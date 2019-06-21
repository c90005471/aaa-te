package com.aaa.commons.utils;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;
import java.util.Set;

/**
 * @author TeacherChen
 * @description 项目常量
 * @company AAA软件
 * 2017-9-19下午4:44:37
 */
public class ConstantUtils {
	
	public static final String Question_Items="很好;好;一般;较差;差";
	
	public static final String TblScl_Items="严重;相当重;中度;轻度;无";
	/**
	 * 杨金路校区id
	 */
	public static final String YJ_ORGID = "6";
	/**
	 * 下载文件的路径
	 */
	public static final String UPLOAD_PATH = "download";
	/**
	 * 所有知识点的类型
	 */
	public static final String ZZDLX = "0,1";
	/**
	 * 所有阶段教评类型
	 */
	public static final String JDLX = "2,3";
	
	/**
	 * 口碑状态
	 */
	public static final Map<String,String> WORDSTATUSMAP = new LinkedHashMap<String,String>();
	static{
		WORDSTATUSMAP.put("0", "未咨询");
		WORDSTATUSMAP.put("1", "已咨询");
		WORDSTATUSMAP.put("2", "未入学");
		WORDSTATUSMAP.put("3", "已入学");
	}
	/**
	 * 月份
	 */
	public static final Map<String,String> MONTHMAP = new LinkedHashMap<String,String>();
	static{
		MONTHMAP.put("01", "一月");
		MONTHMAP.put("02", "二月");
		MONTHMAP.put("03", "三月");
		MONTHMAP.put("04", "四月");
		MONTHMAP.put("05", "五月");
		MONTHMAP.put("06", "六月");
		MONTHMAP.put("07", "七月");
		MONTHMAP.put("08", "八月");
		MONTHMAP.put("09", "九月");
		MONTHMAP.put("10", "十月");
		MONTHMAP.put("11", "十一月");
		MONTHMAP.put("12", "十二月");
		
	}
	/**
	 * 题目类型
	 */
	public static final Map<Integer,String> QUESTIONTYPEMAP= new HashMap<Integer,String>();
	static{
		QUESTIONTYPEMAP.put(1, "逻辑思维");
		QUESTIONTYPEMAP.put(2, "意志力1");
		QUESTIONTYPEMAP.put(3, "意志力2");
		QUESTIONTYPEMAP.put(4, "意志力3");
	}
	/**
	 * 试题类型
	 */
	public static final Map<Integer,String> TYPEMAP = new HashMap<Integer,String>();
	static{
		TYPEMAP.put(0,"单选题");
		TYPEMAP.put(1,"多选题");
	}
	/**
	 * 意志力不同的试卷
	 */
	public static final List<String> TYPELIST = new ArrayList<String>();
	static{
		TYPELIST.add("2");
		TYPELIST.add("3");
		TYPELIST.add("4");
	}
	public static final String ZIZHUJIUYE="自主就业";
	
}
