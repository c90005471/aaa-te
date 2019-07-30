package com.aaa.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.aaa.commons.result.PageInfo;
import com.aaa.mapper.TeacherDetailMapper;
import com.aaa.model.TeacherDetail;
import com.aaa.service.ITeacherDetailService;
import com.baomidou.mybatisplus.plugins.Page;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author 张德鑫
 * @since 2017-09-21
 */
@Service
public class TeacherDetailServiceImpl extends ServiceImpl<TeacherDetailMapper, TeacherDetail> implements ITeacherDetailService {

	@Autowired
	private TeacherDetailMapper teacherDetailMapper;
	
	@SuppressWarnings("rawtypes")
	@Override
	public List<Map> selectAvgscoreByplanid(Map map) {
		List<Map> resMap = teacherDetailMapper.selectAvgscoreByplanid(map);
		return resMap;
	}
	@Override
	public Map selectByplanidAndclassid(Long id) {
		return teacherDetailMapper.selectByplanidAndclassid(id);
	}
	@Override
	public void selectByplanid(PageInfo pageInfo) {
		//添加分页信息
		Page<Map<String, Object>> page = new Page<Map<String, Object>>(pageInfo.getNowpage(), pageInfo.getSize());
        page.setOrderByField(pageInfo.getSort());
        page.setAsc(pageInfo.getOrder().equalsIgnoreCase("asc"));
        List<Map> list = teacherDetailMapper.selectByplanid(page, pageInfo.getCondition());
        pageInfo.setRows(list);
        pageInfo.setTotal(page.getTotal());
		/*return  teacherDetailMapper.selectByplanid( map);*/
	}
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	public Map selectByTeacher(Long id) {
		Map radeMap=teacherDetailMapper.selectByteacherSum(id);
		Map map =new HashMap();
		Float radecount;
		int rade = 0;
		String radestString;
		Float radea = 0f;
		String classname="无班级";
		if(radeMap!=null){
			radestString = radeMap.get("sum").toString();
			rade=Integer.parseInt(radestString);
			radea=(float) rade;
			classname=radeMap.get("classname").toString();
		}
//		String radestString=radeMap.get("sum").toString();
//		int rade=Integer.parseInt(radestString);
//		Float radea=(float) rade;
//		String classname=radeMap.get("classname").toString();
		String countString;
		int count=0;
		String teaname="未开始";
		Map<String,Object> paramMap = new HashMap<String,Object>();
		paramMap.put("id", id);
		paramMap.put("rade", rade);
		Map countMap =teacherDetailMapper.selectByStuSum(paramMap);//添加条件 班级总人数
		if(countMap!=null){
			 countString=countMap.get("count").toString();
			 count=Integer.parseInt(countString);
			 teaname=countMap.get("name").toString();
		}
	/*	String countString=countMap.get("count").toString();
		int count=Integer.parseInt(countString);
		String teaname=countMap.get("name").toString();*/
		if (radea==0) {
			radecount=(float) 0;
			map.put("radecount", radecount);
		}else {
			radecount= count/radea*100;
			map.put("radecount", radecount);
		}
		map.put("sum", rade);
		map.put("count",count);
		map.put("classname", classname);
		map.put("teaname", teaname);
		return map;
	}
	
}
