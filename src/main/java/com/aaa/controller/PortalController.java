package com.aaa.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.aaa.commons.base.BaseController;
import com.aaa.commons.utils.ConstantUtils;
import com.aaa.commons.utils.JuHeUtil;
import com.aaa.service.IStudentService;

/**
 * @author TeacherChen sunshaoshan
 * @description 
 * @company AAA软件
 * 2017-9-18下午11:23:50 2017-11-09
 */
@Controller
@RequestMapping("/portal")
public class PortalController extends BaseController{
	
	@Autowired 
	private IStudentService studentService;
	
	@RequestMapping("/portal")
	public  String  portal() {
		return "portal/portal";
	}
	/**
	 * 全国学生分布
	 * @return
	 */
	@RequestMapping("/about")
	public  String  about() {
		return "portal/colStu";
	}
	
	/**
	 * 高中学生分布
	 * @return
	 */
	@RequestMapping("/aboutHn")
	public  String  aboutHn() {
		return "portal/henan";
	}
	/**
	 * 获取大学生学员地区分布，返回一个json字符串
	 * 该地区主要包括省级
	 */
	@RequestMapping("/getColStu")
	public void getColStu(HttpServletResponse resp) throws Exception{
		List<Map> list= studentService.fillAllColStu(ConstantUtils.YJ_ORGID);
		
		Map areaMap=new HashMap();
		for(Map map:list){
			String province=JuHeUtil.getProvince(map.get("area")+"");
			areaMap.put(province, map.get("count")+"");
		}
		StringBuffer sb=new StringBuffer();
		sb.append("[");
		for(Object object:areaMap.keySet()){
			sb.append("{name: '"+object+"',value:"+areaMap.get(object)+"},");
		}
		sb.delete( sb.length()-1,sb.length());
		sb.append("]");
		resp.setCharacterEncoding("utf-8");
		resp.getWriter().print(sb.toString());
	}
	
	/**
	 * 获取高中生学员地区分布，返回一个json字符串
	 * 该地区主要包括市级
	 */
	@RequestMapping("/getHighStu")
	public void getHighStu(HttpServletResponse resp) throws Exception{
		List<Map> list=studentService.fillAllHighStu(ConstantUtils.YJ_ORGID);
		Map areaMap=new HashMap();
		for(Map map:list){
			String province=JuHeUtil.getCity(map.get("city")+"");
			if(areaMap.get(province)==null){
				areaMap.put(province, map.get("count")+"");
			}else{
				Integer count=Integer.valueOf(areaMap.get(province)+"")+Integer.valueOf(map.get("count")+"");
				areaMap.put(province,count);
			}
		}
		StringBuffer sb=new StringBuffer();
		sb.append("[");
		for(Object object:areaMap.keySet()){
			sb.append("{name: '"+object+"',value:"+areaMap.get(object)+"},");
		}
		sb.delete( sb.length()-1,sb.length());
		sb.append("]");
		resp.setCharacterEncoding("utf-8");
		resp.getWriter().print(sb.toString());
	}
}
