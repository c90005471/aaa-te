package com.aaa.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.aaa.model.AssplanStudent;
import com.baomidou.mybatisplus.mapper.BaseMapper;

/**
 * 类名称：AssplanStudentMapper
 * 类描述： 帮扶计划 Mapper 接口
 * 创建人：sunshaoshan
 * 创建时间：2018-2-1 上午10:36:55
 * @version
 */
public interface AssplanStudentMapper extends BaseMapper<AssplanStudent> {

	List<Map<String, Object>> findStudentListByAssistId(@Param(value="id")Long id);
	
}