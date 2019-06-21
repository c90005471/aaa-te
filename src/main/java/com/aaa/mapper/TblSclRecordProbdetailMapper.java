package com.aaa.mapper;

import java.util.List;
import java.util.Map;

import com.aaa.model.TblSclRecorddetail;
import com.baomidou.mybatisplus.mapper.BaseMapper;
import com.baomidou.mybatisplus.plugins.pagination.Pagination;
	/**
 *@className:TblSclRecordProbdetailMapper.java
 *@discriptions:
 *@author:徐辉
 *@createTime:2017-11-30下午8:21:28
 *@version:1.0.0
 *
 *<p>
 *  Mapper 接口
 * </p>
 */
public interface TblSclRecordProbdetailMapper extends BaseMapper<TblSclRecorddetail> {
	List<Map<String, Object>> selectTblSclRecordProbDetailPage(Pagination page, Map<String, Object> params);
	List<Map<String, Object>> selectTblSclRecordProbInterview(Pagination page, Map<String, Object> params);
}
