package com.aaa.mapper;

import java.util.List;
import java.util.Map;

import com.aaa.model.Examquestion;
import com.baomidou.mybatisplus.mapper.BaseMapper;
import com.baomidou.mybatisplus.plugins.pagination.Pagination;

/**
 * <p>
  *  Mapper 接口
 * </p>
 *
 * @author xuhui
 * @since 2017-12-05
 */
public interface ExamquestionMapper extends BaseMapper<Examquestion> {
	/**
	 * 查询当前页的数据
	 * @return
	 */
	List<Map<String,Object>> selectExamquestionPage(Pagination page, Map<String, Object> params);
}