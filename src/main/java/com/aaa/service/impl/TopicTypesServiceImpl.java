package com.aaa.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.aaa.commons.result.PageInfo;
import com.aaa.commons.utils.StringUtils;
import com.aaa.mapper.TopicInfoMapper;
import com.aaa.mapper.TopicTypesMapper;
import com.aaa.model.TopicInfo;
import com.aaa.model.TopicTypes;
import com.aaa.service.ITopicTypesService;
import com.baomidou.mybatisplus.plugins.Page;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
/**
 * 类名称：
 * 类描述： 
 * 创建人：sunshaoshan
 * 创建时间：2018-6-30 下午3:01:02
 * @version
 */
@Service
public class TopicTypesServiceImpl extends ServiceImpl<TopicTypesMapper,TopicTypes> implements ITopicTypesService{
	@Autowired
	private TopicTypesMapper topicTypesMapper;
	@Autowired
	private TopicInfoMapper topicInfoMapper; 
	@Override
	public void selectDataGrid(PageInfo pageInfo) {
		Page<Map<String, Object>> page = new Page<Map<String, Object>>(pageInfo.getNowpage(), pageInfo.getSize());
        page.setOrderByField(pageInfo.getSort());
        page.setAsc(pageInfo.getOrder().equalsIgnoreCase("asc"));
        List<Map<String, Object>> list = topicTypesMapper.selectTopicTypePage(page, pageInfo.getCondition());
        //获取试题类型
        pageInfo.setRows(list);
        pageInfo.setTotal(page.getTotal());
	}
	/**
	 * 获取科目以及科目下所有题目数量
	 */
	@Override
	public List<Map<String, Object>> selectTypeAndSum(String stage) {
		//获取科目状态为1 试题状态为1的信息
		if(StringUtils.isBlank(stage)){
			stage = "S3";
		}
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("stage", stage);
		List<Map<String, Object>> list = topicTypesMapper.selectTypeAndSum(stage);
		return list;
	}
	/**
	 * 删除科目时,把typestate改为0,并且把下属的试题状态也修改为0
	 */
	@Override
	public void updateTypeAndInfo(Long id) {
		//更新下属的试题信息
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("topictype", id);
		List<TopicInfo> infoList = topicInfoMapper.selectByMap(map);
		for (TopicInfo topicInfo : infoList) {
			topicInfo.setTopicstate(0);//删除状态
			topicInfoMapper.updateById(topicInfo);
		}
		//更新科目信息
		TopicTypes type = new TopicTypes();
		type.setTypestate(0);
		type.setId(id);
		topicTypesMapper.updateById(type);
	}
	
}
