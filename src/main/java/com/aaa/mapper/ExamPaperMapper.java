package com.aaa.mapper;

import java.util.List;
import java.util.Map;

import com.aaa.model.ExamPaper;
import com.baomidou.mybatisplus.mapper.BaseMapper;
import com.baomidou.mybatisplus.plugins.Page;
/**
 * 类名称：ExamPaperMapper
 * 类描述： 
 * 创建人：sunshaoshan
 * 创建时间：2018-7-10 下午4:50:00
 * @version
 */
public interface ExamPaperMapper extends BaseMapper<ExamPaper> {
	List<Map<String, Object>> selectExamPaperPage(Page<Map<String, Object>> page, Map<String, Object> condition);

	List<ExamPaper> findExamPaperByMap(Map<String, Object> map);

	List<ExamPaper> selectExamPaperByMap(Map<String, Object> columnMap);

}
