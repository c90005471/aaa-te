package com.aaa.mapper;

import java.util.List;
import java.util.Map;

import com.aaa.model.AssistPlan;
import com.aaa.model.TeacherPlan;
import com.aaa.model.User;
import com.baomidou.mybatisplus.mapper.BaseMapper;
import com.baomidou.mybatisplus.plugins.pagination.Pagination;

/**
 * 类名称：AssistPlanMapper
 * 类描述： 帮扶计划 Mapper 接口
 * 创建人：sunshaoshan
 * 创建时间：2018-2-1 上午10:36:55
 * @version
 */
public interface AssistPlanMapper extends BaseMapper<AssistPlan> {
	List<Map<String, Object>> selectAssistPlanPage(Pagination page, Map<String, Object> params);
	
	Long insertAssistPlan(AssistPlan assistPlan);

	List<Map<String, Object>> selectClassInfoById(Long id);
}