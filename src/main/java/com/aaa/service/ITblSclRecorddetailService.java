package com.aaa.service;

import java.util.List;
import java.util.Map;

import com.aaa.commons.result.PageInfo;
import com.aaa.model.TblSclRecorddetail;
import com.baomidou.mybatisplus.service.IService;

/**
 *健康自评统计详情页面服务类
 * @author sunxicai
 * @since 2017-11-30
 */
public interface ITblSclRecorddetailService extends IService<TblSclRecorddetail> {
	void selectDataGrid(PageInfo pageInfo);//查看健康自评统计详情
	List<Map> selectAvgscoreBystudentid(Map map);//查看健康自评统计分析图
}
