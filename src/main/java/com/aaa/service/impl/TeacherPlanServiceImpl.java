package com.aaa.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.aaa.commons.result.PageInfo;
import com.aaa.mapper.TeacherPlanMapper;
import com.aaa.model.TeacherPlan;
import com.aaa.service.ITeacherPlanService;
import com.baomidou.mybatisplus.plugins.Page;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;

/**
 * <p>
 * 老师评价计划表 服务实现类
 * </p>
 *
 * @author 张德鑫
 * @since 2017-09-18
 */
@Service
public class TeacherPlanServiceImpl extends ServiceImpl<TeacherPlanMapper, TeacherPlan> implements ITeacherPlanService {
	@Autowired
	private TeacherPlanMapper teacherPlanMapper;
	
	@Override
	public void selectDataGrid(PageInfo pageInfo) {
		 Page<Map<String, Object>> page = new Page<Map<String, Object>>(pageInfo.getNowpage(), pageInfo.getSize());
	        page.setOrderByField(pageInfo.getSort());
	        page.setAsc(pageInfo.getOrder().equalsIgnoreCase("asc"));
	        List<Map<String, Object>> list = teacherPlanMapper.selectPlanTeacherPage(page, pageInfo.getCondition());
	        pageInfo.setRows(list);
	        pageInfo.setTotal(page.getTotal());
		
	}
	
	//非分模块  教评统计
		@Override
		public void selectTeaDataGrid(PageInfo pageInfo) {
			 Page<Map<String, Object>> page = new Page<Map<String, Object>>(pageInfo.getNowpage(), pageInfo.getSize());
		        page.setOrderByField(pageInfo.getSort());
		        page.setAsc(pageInfo.getOrder().equalsIgnoreCase("asc"));
		        List<Map<String, Object>> list = teacherPlanMapper.selectTeaPlanTeacherPage(page, pageInfo.getCondition());
		        pageInfo.setRows(list);
		        pageInfo.setTotal(page.getTotal());
			
		}
		
	//分模块
	@Override
	public void selectFenDataGrid(PageInfo pageInfo) {
		 Page<Map<String, Object>> page = new Page<Map<String, Object>>(pageInfo.getNowpage(), pageInfo.getSize());
	        page.setOrderByField(pageInfo.getSort());
	        page.setAsc(pageInfo.getOrder().equalsIgnoreCase("asc"));
	        List<Map<String, Object>> list = teacherPlanMapper.selectFenPlanTeacherPage(page, pageInfo.getCondition());
	        pageInfo.setRows(list);
	        pageInfo.setTotal(page.getTotal());
		
	}

	//分模块
	@Override
	public boolean updateTeacherPlan(TeacherPlan teacherPlan) {
		return teacherPlanMapper.updateTeacherPlan(teacherPlan);
	}
}
