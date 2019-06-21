package com.aaa.mapper;

import java.util.List;
import java.util.Map;

import com.aaa.model.TeacherPlan;
import com.aaa.model.User;
import com.baomidou.mybatisplus.mapper.BaseMapper;
import com.baomidou.mybatisplus.plugins.pagination.Pagination;

/**
 * <p>
  * 老师评价计划表 Mapper 接口
 * </p>
 *
 * @author 张德鑫
 * @since 2017-09-18
 */
public interface TeacherPlanMapper extends BaseMapper<TeacherPlan> {
	List<Map<String, Object>> selectPlanTeacherPage(Pagination page, Map<String, Object> params);
	List<User> selectUsers();
	//分模块
	List<Map<String, Object>> selectFenPlanTeacherPage(Pagination page, Map<String, Object> params);
	//分模块
	Boolean updateTeacherPlan(TeacherPlan teacherPlan);
	//非分模块
	List<Map<String, Object>> selectTeaPlanTeacherPage(Pagination page, Map<String, Object> params);
}