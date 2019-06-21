package com.aaa.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;

import com.aaa.commons.result.PageInfo;
import com.aaa.model.TopicTypes;
import com.baomidou.mybatisplus.service.IService;

/**
 * 类名称：TopicManageService
 * 类描述： 添加题目类型的接口
 * 创建人：sunshaoshan
 * 创建时间：2018-6-22 上午11:13:24
 * @version
 */
public interface ITopicTypesService extends  IService<TopicTypes>{

	void selectDataGrid(PageInfo pageInfo);

	List<Map<String, Object>> selectTypeAndSum(String stage);

	void updateTypeAndInfo(Long id);
}
