package com.aaa.service.impl;

import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.aaa.commons.result.PageInfo;
import com.aaa.mapper.AssistPlanMapper;
import com.aaa.mapper.AssplanStudentMapper;
import com.aaa.mapper.StudentMapper;
import com.aaa.model.AssistPlan;
import com.aaa.model.AssplanStudent;
import com.aaa.model.Student;
import com.aaa.service.IAssistPlanService;
import com.baomidou.mybatisplus.plugins.Page;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
@Service
public class AssistPlanServiceImpl extends ServiceImpl<AssistPlanMapper, AssistPlan> implements IAssistPlanService {
	@Autowired
	private AssistPlanMapper assistPlanMapper;
	@Autowired
	private AssplanStudentMapper assplanStudentMapper;
	@Autowired
	private StudentMapper studentMapper;
	/**
	 * 获取列表
	 */
	@Override
	public void selectDataGrid(PageInfo pageInfo) {
		 Page<Map<String, Object>> page = new Page<Map<String, Object>>(pageInfo.getNowpage(), pageInfo.getSize());
	        page.setOrderByField(pageInfo.getSort());
	        page.setAsc(pageInfo.getOrder().equalsIgnoreCase("asc"));
	        List<Map<String, Object>> list = assistPlanMapper.selectAssistPlanPage(page, pageInfo.getCondition());
	        pageInfo.setRows(list);
	        pageInfo.setTotal(page.getTotal());
	}
	/**
	 * 插入数据
	 */
	public Long insertAssistPlan(AssistPlan assistPlan,String stunos){
		assistPlanMapper.insertAssistPlan(assistPlan);
		Long id = assistPlan.getId();
		//插入帮扶学生信息
    	Set<Long> idSet = returnIdSet(stunos);
    	for (Long studentId : idSet) {
    		AssplanStudent assplanStudent = new AssplanStudent();
    		assplanStudent.setAssid(id);
    		assplanStudent.setStuid(studentId);
    		assplanStudentMapper.insert(assplanStudent);
		}
		return id;
	}
	/**
	 * 编辑帮扶计划数据
	 */
	@Override
	public int updateAssistPlan(AssistPlan assistPlan, String stunos) {
		//更新帮扶计划基本信息
		int row =  assistPlanMapper.updateById(assistPlan);
		//更新帮扶计划学生信息
		//先删除原来的学生信息
		Map<String,Object> columnMap = new HashMap<String,Object>();
		columnMap.put("assid", assistPlan.getId());
		assplanStudentMapper.deleteByMap(columnMap);
		//保存修改的学生信息
		//插入帮扶学生信息
    	Set<Long> idSet = returnIdSet(stunos);
    	for (Long studentId : idSet) {
    		AssplanStudent assplanStudent = new AssplanStudent();
    		assplanStudent.setAssid(assistPlan.getId());
    		assplanStudent.setStuid(studentId);
    		assplanStudentMapper.insert(assplanStudent);
		}
		return row;
	}
	/**
     * 删除帮扶计划信息和帮扶学生信息
     */
	@Override
	public boolean deleteAssistPlan(Long id) {
		boolean flag = false;
		//先删除原来的学生信息
		Map<String,Object> columnMap = new HashMap<String,Object>();
		columnMap.put("assid", id);
		assplanStudentMapper.deleteByMap(columnMap);
		//删除计划信息
		int b = assistPlanMapper.deleteById(id);
		if(b>0){
			flag = true;
		}
		return flag;
	}
	/**
     * 根据学号字符串返回 id set集合
     * @param stunos
     * @return
     */
    @SuppressWarnings("unused")
	private Set<Long> returnIdSet(String stunos){
    	Set<Long> idSet = new HashSet<Long>();
    	Set<String> set = new HashSet<String>();
    	if(StringUtils.isNotBlank(stunos)){//学号
    		String[] studentArr = stunos.split(",");
    		for (String string : studentArr) {
    			set.add(string);
			}
    		//查询出id  保存到关系表中
    		for (String stuno : set) {
    			Map<String,Object> columnMap = new HashMap<String,Object>();
    			columnMap.put("stuno", stuno);
    			List<Student> studentList = studentMapper.selectByMap(columnMap);
    			if(studentList!=null&&studentList.size()>0){
    				idSet.add(studentList.get(0).getId());
    			}
			}
    	}
    	return idSet;
    }
    /**
     * 根据计划id获取班级信息
     */
	@Override
	public List<Map<String, Object>> selectClassInfoById(Long id) {
		return assistPlanMapper.selectClassInfoById(id);
	}
}
