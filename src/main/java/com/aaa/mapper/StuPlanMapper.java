package com.aaa.mapper;

import java.util.List;
import java.util.Map;

import com.aaa.model.StuPlan;
import com.baomidou.mybatisplus.mapper.BaseMapper;
import com.baomidou.mybatisplus.plugins.pagination.Pagination;

/**
 * <p>
  * 学生自评计划表 Mapper 接口
 * </p>
 *
 * @author chenjian
 * @since 2017-09-17
 */
public interface StuPlanMapper extends BaseMapper<StuPlan> {
	List<Map<String, Object>> selectPlanStuPage(Pagination page, Map<String, Object> params);

	List<Map> selectPlanStuList(Map<String, Object> condition);
}