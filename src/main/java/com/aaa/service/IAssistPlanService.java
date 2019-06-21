package com.aaa.service;

import java.util.List;
import java.util.Map;

import com.aaa.commons.result.PageInfo;
import com.aaa.model.AssistPlan;
import com.baomidou.mybatisplus.service.IService;

public interface IAssistPlanService extends IService<AssistPlan> {
	void selectDataGrid(PageInfo pageInfo);
	Long insertAssistPlan(AssistPlan assistPlan,String stunos);
	int updateAssistPlan(AssistPlan assistPlan, String students);
	boolean deleteAssistPlan(Long id);
	List<Map<String, Object>> selectClassInfoById(Long valueOf);
}
