package com.aaa.service.impl;

import java.util.List;
import java.util.Map;

import com.aaa.commons.result.PageInfo;
import com.aaa.model.StuPlan;
import com.aaa.mapper.StuPlanMapper;
import com.aaa.service.IStuPlanService;
import com.baomidou.mybatisplus.plugins.Page;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * <p>
 * 学生自评计划表 服务实现类
 * </p>
 *
 * @author chenjian
 * @since 2017-09-17
 */
@Service
public class StuPlanServiceImpl extends ServiceImpl<StuPlanMapper, StuPlan> implements IStuPlanService {
	@Autowired
	private StuPlanMapper stuPlanMapper;
	@Override
	public void selectDataGrid(PageInfo pageInfo) {
		 Page<Map<String, Object>> page = new Page<Map<String, Object>>(pageInfo.getNowpage(), pageInfo.getSize());
	        page.setOrderByField(pageInfo.getSort());
	        page.setAsc(pageInfo.getOrder().equalsIgnoreCase("asc"));
	        List<Map<String, Object>> list = stuPlanMapper.selectPlanStuPage(page, pageInfo.getCondition());
	        pageInfo.setRows(list);
	        pageInfo.setTotal(page.getTotal());
		
	}
	@Override
	public List<Map> selectPlanStuList(Map<String, Object> condition) {
		return stuPlanMapper.selectPlanStuList(condition);
		
	}
	
}
