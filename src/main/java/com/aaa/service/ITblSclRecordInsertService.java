package com.aaa.service;

import java.util.List;
import java.util.Map;

import com.aaa.model.TblSclRecord;
/**
 *@className:ITblSclRecordInsertService.java
 *@discriptions:向心理健康自评表tblsclRecord中插入计算过的数据
 *@author:徐辉
 *@createTime:2017-12-1下午9:10:46
 *@version:1.0.0
 *
 *<p>
 *	服务层
 *</p>
 */
public interface ITblSclRecordInsertService {
	/**
	 * 向tblsclRecord表中插入数据，心理健康测试记录
	 * @return
	 */
	boolean insertTblSclRecord(TblSclRecord tblSclRecord);
	/**
	 * 求当前学生的心理测试总分
	 */
	List<Map<String, Object>> selectTblSclScore(Long studentid,String createtime);
	
	/**
	 * 求当前学生的心理测试阳性项目个数
	 */
	List<Map<String, Object>> selectTblSclCount(Long studentid,String createtime);
}
