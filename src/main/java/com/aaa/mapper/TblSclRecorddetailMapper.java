package com.aaa.mapper;

import java.util.List;
import java.util.Map;

import com.aaa.model.TblSclRecorddetail;
import com.baomidou.mybatisplus.mapper.BaseMapper;
import com.baomidou.mybatisplus.plugins.pagination.Pagination;

/**
  *  健康自评统计详情 Mapper 接口
 *
 * @author sunxicai
 * @since 2017-11-30
 */
public interface TblSclRecorddetailMapper extends BaseMapper<TblSclRecorddetail> {
	//查看健康自评统计详情
	List<Map<String, Object>> selectTblSclRecordDetailPage(Pagination page, Map<String, Object> params);
	//查看健康统计分析雷达图
	List<Map> selectAvgscoreBystudentid(Map map);
}