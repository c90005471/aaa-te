package com.aaa.mapper;

import java.util.List;
import java.util.Map;

import com.aaa.model.TestQuestion;
import com.aaa.model.TestQuestionRecord;
import com.baomidou.mybatisplus.mapper.BaseMapper;
import com.baomidou.mybatisplus.plugins.Page;
import com.baomidou.mybatisplus.plugins.pagination.Pagination;

/**
 *
 * testquestionRecord 表数据库控制层接口
 *
 */
public interface TestQuestionRecordMapper extends BaseMapper<TestQuestionRecord> {

	List<Map<String, Object>> selectTestQuestionRecordPage(Page<Map<String, Object>> page, Map<String, Object> condition);

  

}