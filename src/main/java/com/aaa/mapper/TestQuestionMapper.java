package com.aaa.mapper;

import java.util.List;
import java.util.Map;

import com.aaa.model.TestQuestion;
import com.baomidou.mybatisplus.mapper.BaseMapper;
import com.baomidou.mybatisplus.plugins.pagination.Pagination;

/**
 *
 * testquestion 表数据库控制层接口
 *
 */
public interface TestQuestionMapper extends BaseMapper<TestQuestion> {

    List<Map<String, Object>> selectTestQuestionPage(Pagination page, Map<String, Object> params);

	Long insertTestQues(TestQuestion ques);

}