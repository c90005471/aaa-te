package com.aaa.mapper;

import java.util.List;
import java.util.Map;

import com.aaa.model.TblProject;
import com.baomidou.mybatisplus.mapper.BaseMapper;
import com.baomidou.mybatisplus.plugins.pagination.Pagination;

/**
  *@description  项目管理Mapper 接口
 * @author 孙喜才
 * @since 2017-12-04
 */
public interface TblProjectMapper extends BaseMapper<TblProject> {
	//查看项目管理信息
	List<Map<String, Object>> selectTblProjectPage(Pagination page, Map<String, Object> params);
}