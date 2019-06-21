package com.aaa.mapper;

import java.util.List;
import java.util.Map;

import com.aaa.model.TblSclRecord;
import com.baomidou.mybatisplus.mapper.BaseMapper;
import com.baomidou.mybatisplus.plugins.pagination.Pagination;

/**
  *@description 健康自评统计总页面的Mapper接口
 * @author sunxicai
 * @since 2017-11-29
 */
public interface TblSclRecordMapper extends BaseMapper<TblSclRecord> {
	//查看健康自评统计总页面
	List<Map<String, Object>> selectTblSclRecordPage(Pagination page, Map<String, Object> params);
}