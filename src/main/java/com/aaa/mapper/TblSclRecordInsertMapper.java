package com.aaa.mapper;

import java.util.List;
import java.util.Map;

import com.aaa.model.TblSclRecord;
	/**
 *@className:TblSclRecordInsertMapper.java
 *@discriptions:向tblsclRecord表中插入数据，心理健康测试记录
 *@author:徐辉
 *@createTime:2017-12-1下午9:15:43
 *@version:1.0.0
 *
 *<p>
 *  Mapper 接口
 * </p>
 */
public interface TblSclRecordInsertMapper {
	/**
	 * 向tblsclRecord表中插入数据，心理健康测试记录
	 * @return
	 */
	boolean insertTblSclRecord(TblSclRecord tblSclRecord);
	
	/**
	 * 求当前学生的心理测试总分
	 */
	List<Map<String, Object>> selectTblSclScore(Map map);
	
	/**
	 * 求当前学生的心理测试阳性项目个数
	 */
	List<Map<String, Object>> selectTblSclCount(Map map);
	
}
