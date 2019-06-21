package com.aaa.service;

import java.util.List;

import com.aaa.commons.result.PageInfo;
import com.aaa.model.TblSclRecord;
import com.aaa.model.vo.TblSclRecordVo;
import com.baomidou.mybatisplus.service.IService;
	/**
 *@className:ITblSclRecordProbService.java
 *@discriptions:
 *@author:徐辉
 *@createTime:2017-11-30下午4:27:40
 *@version:1.0.0
 *
 *<p>
 *	服务类
 *</p>
 */
public interface ITblSclRecordProbService extends IService<TblSclRecord> {
	void selectProbDataGrid(PageInfo pageInfo);
	//查询异常学生信息
	List<TblSclRecordVo> selectExportTblSclRecord();
}
