package com.aaa.service.impl;

import java.util.List;
import java.util.Map;

import com.aaa.commons.result.PageInfo;
import com.aaa.model.TblSclRecorddetail;
import com.aaa.mapper.TblSclRecorddetailMapper;
import com.aaa.service.ITblSclRecorddetailService;
import com.baomidou.mybatisplus.plugins.Page;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 *  健康自评统计详情服务实现类
 * @author sunxicai
 * @since 2017-11-30
 */
@Service
public class TblSclRecorddetailServiceImpl extends ServiceImpl<TblSclRecorddetailMapper, TblSclRecorddetail> implements ITblSclRecorddetailService {
	//自动注入健康自评统计详情的dao层接口
	@Autowired
	private TblSclRecorddetailMapper tblSclRecorddetailMapper;
	
	//查看健康自评统计详情
	@Override
	public void selectDataGrid(PageInfo pageInfo) {
		// TODO Auto-generated method stub
		//新建baomidou分页实体类
		Page<Map<String, Object>> page = new Page<Map<String, Object>>(pageInfo.getNowpage(), pageInfo.getSize());
		//给baomidou分页实体类添加排序参数
        page.setOrderByField(pageInfo.getSort());
        page.setAsc(pageInfo.getOrder().equalsIgnoreCase("asc"));
        //调用方法查询健康自评统计详情
        List<Map<String, Object>> list = tblSclRecorddetailMapper.selectTblSclRecordDetailPage(page, pageInfo.getCondition());
        //将查询到的信息添加到分页信息实体类中
        pageInfo.setRows(list);
        pageInfo.setTotal(page.getTotal());
	}
	
	//查看健康自评统计分析图
	@Override
	public List<Map> selectAvgscoreBystudentid(Map map) {
		// TODO Auto-generated method stub
		return tblSclRecorddetailMapper.selectAvgscoreBystudentid(map);
	}
	
}
