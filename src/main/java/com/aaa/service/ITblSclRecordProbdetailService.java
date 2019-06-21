package com.aaa.service;

import com.aaa.commons.result.PageInfo;
import com.aaa.model.TblSclRecorddetail;
import com.baomidou.mybatisplus.service.IService;
	/**
 *@className:ITblSclRecordProbdetailService.java
 *@discriptions:
 *@author:徐辉
 *@createTime:2017-11-30下午8:16:57
 *@version:1.0.0
 *
 */
public interface ITblSclRecordProbdetailService extends IService<TblSclRecorddetail> {
	void selectProbDataGrid(PageInfo pageInfo);
	void selectProbInterview(PageInfo pageInfo);
}
