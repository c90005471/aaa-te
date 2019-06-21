package com.aaa.mapper;

import java.util.List;
import java.util.Map;

import com.aaa.model.TestQuestion;
import com.aaa.model.TopicInfo;
import com.baomidou.mybatisplus.mapper.BaseMapper;
import com.baomidou.mybatisplus.plugins.Page;

/**
 * 类名称：TopicInfoMapper
 * 类描述： 
 * 创建人：sunshaoshan
 * 创建时间：2018-6-30 下午3:01:08
 * @version
 */
public interface TopicInfoMapper extends BaseMapper<TopicInfo> {

	List<Map<String, Object>> selectTopicInfoPage(Page<Map<String, Object>> page, Map<String, Object> condition);
	Long insertTopicInfo(TopicInfo topicInfo);
	List<TopicInfo> selectInfoByTypeIdAndSum(Map<String, Object> map);
	List<TopicInfo> selectInfoByMap(Map<String, Object> columnMap);
}