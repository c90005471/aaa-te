package com.aaa.service;

import java.util.List;
import java.util.Map;

import com.aaa.commons.result.PageInfo;
import com.aaa.model.StuPlan;
import com.baomidou.mybatisplus.service.IService;

/**
 * <p>
 * 学生自评计划表 服务类
 * </p>
 *
 * @author chenjian
 * @since 2017-09-17
 */
public interface IStuPlanService extends IService<StuPlan> {
	void selectDataGrid(PageInfo pageInfo);

	List<Map> selectPlanStuList(Map<String, Object> condition);
	
	//根据班级id和教师no去查stu_plan
	StuPlan selectPlanInfoByClassIdAndTeaNo(Long classId,Long teacherno);
	
}
