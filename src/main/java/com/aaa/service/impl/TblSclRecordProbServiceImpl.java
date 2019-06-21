package com.aaa.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.aaa.commons.result.PageInfo;
import com.aaa.mapper.TblSclRecordProbMapper;
import com.aaa.model.TblSclRecord;
import com.aaa.model.vo.TblSclRecordVo;
import com.aaa.service.ITblSclRecordProbService;
import com.baomidou.mybatisplus.plugins.Page;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
	/**
 *@className:TblSclRecordProbServiceImpl.java
 *@discriptions:
 *@author:徐辉
 *@createTime:2017-11-30下午4:29:30
 *@version:1.0.0
 *
 *<p>
 *	服务实现类
 *</p>
 */
@Service
public class TblSclRecordProbServiceImpl extends ServiceImpl<TblSclRecordProbMapper, TblSclRecord> implements ITblSclRecordProbService {
	
	@Autowired
	private TblSclRecordProbMapper tblSclRecordProbMapper;
	@Override
	public void selectProbDataGrid(PageInfo pageInfo) {
		Page<Map<String, Object>> page = new Page<Map<String, Object>>(pageInfo.getNowpage(), pageInfo.getSize());
		page.setOrderByField(pageInfo.getSort());
		page.setAsc(pageInfo.getOrder().equalsIgnoreCase("asc"));
		List<Map<String, Object>> list = tblSclRecordProbMapper.selectTblSclRecordProbPage(page, pageInfo.getCondition());
		pageInfo.setRows(list);
		pageInfo.setTotal(page.getTotal());
	}
	/*
	 * 查询异常学生信息
	 */
	@Override
	public List<TblSclRecordVo> selectExportTblSclRecord() {
		return tblSclRecordProbMapper.selectExportTblSclRecord();
	}
	
}
