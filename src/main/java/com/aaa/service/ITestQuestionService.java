package com.aaa.service;

import java.util.Map;

import com.aaa.commons.result.PageInfo;
import com.aaa.model.TestQuestion;
import com.baomidou.mybatisplus.service.IService;

public interface ITestQuestionService extends IService<TestQuestion>{

	void selectDataGrid(PageInfo pageInfo);

	void insertQuestionAndOption(TestQuestion ques, String[] option,String score);

	void deleteQuestionAndOption(Long id);

	Map<String, Object> selectTestQuesAndOption(Long id);

	void updateQuestionAndOption(TestQuestion ques, String[] option,String score);

	Map<String,Object> selectQuestionMap(String  quesType);
	
}
