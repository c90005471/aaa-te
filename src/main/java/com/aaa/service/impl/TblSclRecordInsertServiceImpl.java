package com.aaa.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.aaa.mapper.TblSclRecordInsertMapper;
import com.aaa.model.TblSclRecord;
import com.aaa.service.ITblSclRecordInsertService;
	/**
 *@className:ITblSclRecordInsertServiceImpl.java
 *@discriptions:向心理健康自评表tblsclRecord中插入计算过的数据
 *@author:徐辉
 *@createTime:2017-12-1下午9:11:15
 *@version:1.0.0
 *
 *<p>
 *	服务实现类
 *</p>
 */
@Service
public class TblSclRecordInsertServiceImpl implements ITblSclRecordInsertService {
	
	@Resource(name="tblSclRecordInsertMapper")
	private TblSclRecordInsertMapper tblSclRecordInsertMapper;
	
	/**
	 * 向tblsclRecord表中插入数据，心理健康测试记录
	 * @return
	 */
	@Override
	public boolean insertTblSclRecord(TblSclRecord tblSclRecord) {
		return tblSclRecordInsertMapper.insertTblSclRecord(tblSclRecord);
	}
	
	/**
	 * 求当前学生的心理测试总分
	 */
	@Override
	public List<Map<String, Object>> selectTblSclScore(Long studentid,String createtime) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("studentid", studentid);
		map.put("createtime", createtime);
		return tblSclRecordInsertMapper.selectTblSclScore(map);
	}
	
	/**
	 * 求当前学生的心理测试阳性项目个数
	 */
	@Override
	public List<Map<String, Object>> selectTblSclCount(Long studentid,String createtime) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("studentid", studentid);
		map.put("createtime", createtime);
		return tblSclRecordInsertMapper.selectTblSclCount(map);
	}
	
}
