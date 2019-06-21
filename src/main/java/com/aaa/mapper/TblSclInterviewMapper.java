package com.aaa.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.ResultType;
import org.apache.ibatis.annotations.Select;

import com.aaa.model.TblSclInterview;
import com.aaa.model.TblSclRecord;
import com.baomidou.mybatisplus.mapper.BaseMapper;
import com.baomidou.mybatisplus.plugins.pagination.Pagination;

/**
  *@description 健康自评统计总页面的Mapper接口
 * @author sunxicai
 * @since 2017-11-29
 */
public interface TblSclInterviewMapper extends BaseMapper<TblSclInterview> {
	Map<String, Object> selectTblSclInterviewById(Long id);
}