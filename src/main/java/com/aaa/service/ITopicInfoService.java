package com.aaa.service;

import java.util.List;
import java.util.Map;

import com.aaa.commons.result.PageInfo;
import com.aaa.model.TopicInfo;
import com.aaa.model.TopicOption;
import com.aaa.model.vo.TopicInfoExcelVo;
import com.aaa.model.vo.TopicInfoVo;
import com.baomidou.mybatisplus.service.IService;

/**
 * 类名称：TopicManageService
 * 类描述： 添加试题的接口
 * 创建人：sunshaoshan
 * 创建时间：2018-6-22 上午11:13:24
 * @version
 */
public interface ITopicInfoService extends  IService<TopicInfo>{

	void selectDataGrid(PageInfo pageInfo);

	Map<Integer, String> selectTopicTypes();

	void insertQuestionAndOption(TopicInfo info, String[] optionnum,
			String[] option, String score,Long userId);

	List<TopicOption> selectTopicOptionListByInfoId(Long id);

	void updateTopInfoAndOption(TopicInfo info, String[] optionnum,
			String[] option, String[] option2);

	void deleteTopInfoAndOption(Long id);

	List<TopicInfoVo> selectTopicInfoVoList(List<TopicInfoVo> topicInfoList);

	Object selectTree(String stage);

	boolean addTopicInfoAndOption(List<TopicInfoExcelVo> excelToList,
			Long topictype,Long userId);

}
