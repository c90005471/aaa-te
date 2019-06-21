package com.aaa.mapper;

import java.util.List;
import java.util.Map;

import com.aaa.model.TopicTypes;
import com.baomidou.mybatisplus.mapper.BaseMapper;
import com.baomidou.mybatisplus.plugins.Page;

/**
 * 类名称：TopicTypesMapper
 * 类描述： 
 * 创建人：sunshaoshan
 * 创建时间：2018-6-30 下午4:42:18
 * @version
 */
public interface TopicTypesMapper extends BaseMapper<TopicTypes> {

	List<Map<String, Object>> selectTopicTypePage(Page<Map<String, Object>> page, Map<String, Object> condition);

	List<Map<String, Object>> selectTypeAndSum(String stage);
}