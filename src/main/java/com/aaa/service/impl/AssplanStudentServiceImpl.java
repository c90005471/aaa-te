package com.aaa.service.impl;

import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.aaa.mapper.AssplanStudentMapper;
import com.aaa.mapper.UserMapper;
import com.aaa.model.AssplanStudent;
import com.aaa.model.User;
import com.aaa.service.IAssplanStudentService;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
@Service
public class AssplanStudentServiceImpl extends ServiceImpl<AssplanStudentMapper, AssplanStudent> implements IAssplanStudentService {
	@Autowired
	private AssplanStudentMapper assplanStudentMapper;
	@Autowired
	private UserMapper userMapper;
	/**
	 * 获取该计划下所有学生并把学生的学号拼接成一个字符串
	 */
	@Override
	public String findStunosByAssistId(Long id) {
		String stunos = "";
		List<Map<String, Object>> list = assplanStudentMapper.findStudentListByAssistId(id);
		for (Map<String, Object> map : list) {
			stunos += map.get("stuno")+",";
		}
		if(StringUtils.isNotBlank(stunos)){
			stunos = stunos.substring(0,stunos.length()-1);
		}
		return stunos;
	}
	
	
	/**
	 * 获取该计划下所有学生并把学生姓名拼接成一个字符串
	 */
	@Override
	public String findStunameByAssistId(Long id) {
		String stunames = "";
		List<Map<String, Object>> list = assplanStudentMapper.findStudentListByAssistId(id);
		for (Map<String, Object> map : list) {
			stunames += map.get("stuname")+",";
		}
		if(StringUtils.isNotBlank(stunames)){
			stunames = stunames.substring(0,stunames.length()-1);
		}
		return stunames;
	}


	@Override
	public String findTeacherName(Long id) {
		User user = userMapper.selectById(id);
		return user.getName();
	}
}
