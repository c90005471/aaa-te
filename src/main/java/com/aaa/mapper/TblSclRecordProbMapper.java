package com.aaa.mapper;

import java.util.List;
import java.util.Map;

import com.aaa.model.TblSclRecord;
import com.aaa.model.vo.TblSclRecordVo;
import com.baomidou.mybatisplus.mapper.BaseMapper;
import com.baomidou.mybatisplus.plugins.pagination.Pagination;
	/**
 *@className:TblSclRecordProbMapper.java
 *@discriptions:
 *@author:徐辉
 *@createTime:2017-11-30下午4:24:17
 *@version:1.0.0
 *
 * <p>
 *  Mapper 接口
 * </p>
 */
public interface TblSclRecordProbMapper extends BaseMapper<TblSclRecord> {
	List<Map<String, Object>> selectTblSclRecordProbPage(Pagination page, Map<String, Object> params);
	//查询异常学生信息
	List<TblSclRecordVo> selectExportTblSclRecord();
}
