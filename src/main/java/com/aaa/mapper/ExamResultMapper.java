package com.aaa.mapper;

import com.aaa.model.ExamResult;
import com.baomidou.mybatisplus.mapper.BaseMapper;
import com.baomidou.mybatisplus.plugins.Page;

import java.util.List;
import java.util.Map;


/** 
 * @author ky
 * @date 2020/2/13   
 * 记录错题信息
**/ 
public interface ExamResultMapper extends BaseMapper<ExamResult> {

	/**
	 * 添加数据
	 * @param examResult
	 */
	void insertExamResult(ExamResult examResult);

	/**
	 * 查询数据
	 * @param page
	 * @param condition
	 * @return
	 */
	List<Map<String, Object>> selectExamResultPage(Page<Map<String, Object>> page, Map<String, Object> condition);

	/**
	 * 查询每一项的详细
	 * @param tid
	 * @return
	 */
	Map<String, Object> selectExamResultInfo(int tid);

	/**
	 * 获取信息
	 * @param map
	 * @return
	 */
	List<Map<String, Object>> getQuestionsList(Map<String,Object> map);

	/**
	 * 获取条数
	 * @param map
	 * @return
	 */
	int getQuestionsCount(Map<String,Object> map);

	/**
	 * 获取最后一次考试信息
	 * @param stuid
	 * @return
	 */
	Map<String,Object> getLastPaper(int stuid);
}
