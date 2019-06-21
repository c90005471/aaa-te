package com.aaa.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.aaa.commons.result.PageInfo;
import com.aaa.mapper.TblSclRecordProbdetailMapper;
import com.aaa.model.TblSclRecorddetail;
import com.aaa.service.ITblSclRecordProbdetailService;
import com.baomidou.mybatisplus.plugins.Page;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;


	/**
 *@className:TblSclRecordProbdetailServiceImpl.java
 *@discriptions:
 *@author:徐辉
 *@createTime:2017-11-30下午8:18:43
 *@version:1.0.0
 *
 */
@Service
public class TblSclRecordProbdetailServiceImpl extends ServiceImpl<TblSclRecordProbdetailMapper, TblSclRecorddetail> implements ITblSclRecordProbdetailService{
	@Autowired
	private TblSclRecordProbdetailMapper tblSclRecordProbdetailMapper;
	@Override
	public void selectProbDataGrid(PageInfo pageInfo) {
		Page<Map<String, Object>> page = new Page<Map<String, Object>>(pageInfo.getNowpage(), pageInfo.getSize());
        page.setOrderByField(pageInfo.getSort());
        page.setAsc(pageInfo.getOrder().equalsIgnoreCase("asc"));
        List<Map<String, Object>> list = tblSclRecordProbdetailMapper.selectTblSclRecordProbDetailPage(page, pageInfo.getCondition());
        pageInfo.setRows(list);
        pageInfo.setTotal(page.getTotal());
	}
	@Override
	public void selectProbInterview(PageInfo pageInfo) {
		// TODO Auto-generated method stub
		Page<Map<String, Object>> page = new Page<Map<String, Object>>(pageInfo.getNowpage(), pageInfo.getSize());
        page.setOrderByField(pageInfo.getSort());
        page.setAsc(pageInfo.getOrder().equalsIgnoreCase("asc"));
        List<Map<String, Object>> list = tblSclRecordProbdetailMapper.selectTblSclRecordProbInterview(page, pageInfo.getCondition());
        pageInfo.setRows(list);
        pageInfo.setTotal(page.getTotal());
	}
}