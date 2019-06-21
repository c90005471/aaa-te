package com.aaa.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.aaa.mapper.TblSclFrontMapper;
import com.aaa.model.TblScl;
import com.aaa.service.ITblSclFrontService;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;

	/**
 *@className:ITblSclFrontServiceImpl.java
 *@discriptions:
 *@author:徐辉
 *@createTime:2017-11-30下午9:36:16
 *@version:1.0.0
 *
 */
@Service
public class TblSclFrontServiceImpl extends ServiceImpl<TblSclFrontMapper, TblScl> implements ITblSclFrontService {
	
	@Resource(name="tblSclFrontMapper")
	private TblSclFrontMapper tblSclFrontMapper;
	
	@Override
	public List<TblScl> selecAllTblScls() {
		List<TblScl> selecAllTblScls = tblSclFrontMapper.selecAllTblScls();
		return null;
	}
	
}
