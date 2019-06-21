package com.aaa.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.aaa.model.TeaQuestion;
import com.aaa.model.vo.TeaQuestionVo;
import com.baomidou.mybatisplus.mapper.BaseMapper;
import com.baomidou.mybatisplus.plugins.pagination.Pagination;

/**
 * @title: TeaQuestionMApper
 * @Description:
 * @Company:AAA
 * @Date 2017-9-20 上午11:48:05
 * @author 万舒萌
 */
public interface TeaQuestionMapper extends BaseMapper<TeaQuestion>{

	TeaQuestionVo selectQuestionVoById(@Param("id") Long id);

    List<Map<String, Object>> selectQuestionPage(Pagination page, Map<String, Object> params);

	List<TeaQuestion> selectListByRoleId(@Param("roleId")Long roleId);

//分模块教评
	List<TeaQuestion> selecFentListByRoleId(@Param("roleId")Long roleId);
}
