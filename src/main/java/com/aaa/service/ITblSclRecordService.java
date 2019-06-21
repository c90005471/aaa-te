package com.aaa.service;

import com.aaa.commons.result.PageInfo;
import com.aaa.model.TblSclRecord;
import com.baomidou.mybatisplus.service.IService;

/**
 * 健康自评统计总页面服务类
 * @author sunxicai
 * @since 2017-11-29
 */
public interface ITblSclRecordService extends IService<TblSclRecord> {
	void selectDataGrid(PageInfo pageInfo);//查看健康自评统计总页面
}
