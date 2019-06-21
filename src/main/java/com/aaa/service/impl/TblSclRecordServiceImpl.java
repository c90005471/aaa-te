package com.aaa.service.impl;

import java.util.List;
import java.util.Map;

import com.aaa.commons.result.PageInfo;
import com.aaa.model.TblSclRecord;
import com.aaa.mapper.TblSclRecordMapper;
import com.aaa.service.ITblSclRecordService;
import com.baomidou.mybatisplus.plugins.Page;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 *  健康自评统计总页面服务实现类
 * @author sunxicai
 * @since 2017-11-29
 */
@Service
public class TblSclRecordServiceImpl extends ServiceImpl<TblSclRecordMapper, TblSclRecord> implements ITblSclRecordService {
	//自动注入健康自评统计的dao层接口
	@Autowired
	private TblSclRecordMapper tblSclRecordMapper;
	
	/**
	 * 查看健康自评统计总页面
	 */
	@Override
	public void selectDataGrid(PageInfo pageInfo) {
		// TODO Auto-generated method stub
		//新建baomidou分页实体类
		Page<Map<String, Object>> page = new Page<Map<String, Object>>(pageInfo.getNowpage(), pageInfo.getSize());
		//将排序参数放入到baomidou分页信息实体类
        page.setOrderByField(pageInfo.getSort());
        //将正序排序参数放入到baomidou分页信息实体类
        page.setAsc(pageInfo.getOrder().equalsIgnoreCase("asc"));
        //调用方法查询健康自评统计信息
        List<Map<String, Object>> list = tblSclRecordMapper.selectTblSclRecordPage(page, pageInfo.getCondition());
        //将查询到的分页信息和记录总条数传送到分页信息实体类中
        pageInfo.setRows(list);
        pageInfo.setTotal(page.getTotal());
	}
	
}
