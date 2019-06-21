package com.aaa.service;

import com.aaa.commons.result.PageInfo;
import com.aaa.model.TeacherPlan;
import com.baomidou.mybatisplus.service.IService;

/**
 * <p>
 * 老师评价计划表 服务类
 * </p>
 *
 * @author 张德鑫
 * @since 2017-09-18
 */
public interface ITeacherPlanService extends IService<TeacherPlan> {
	void selectDataGrid(PageInfo pageInfo);
	//分模块
	void selectFenDataGrid(PageInfo pageInfo);
	//分模块
	boolean updateTeacherPlan(TeacherPlan teacherPlan);
	
	void selectTeaDataGrid(PageInfo pageInfo);
}
