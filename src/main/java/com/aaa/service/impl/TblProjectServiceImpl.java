package com.aaa.service.impl;

import java.util.List;
import java.util.Map;

import com.aaa.commons.result.PageInfo;
import com.aaa.model.TblProject;
import com.aaa.mapper.TblProjectMapper;
import com.aaa.service.ITblProjectService;
import com.baomidou.mybatisplus.plugins.Page;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 *@description 项目管理控制器
 * @author 孙喜才
 * @since 2017-12-04
 */
@Service
public class TblProjectServiceImpl extends ServiceImpl<TblProjectMapper, TblProject> implements ITblProjectService {
	//自动注入业务实现dao层接口
	@Autowired
	private TblProjectMapper tblProjectMapper;
	/**
	 * 分页查看项目管理数据
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
        //调用方法查询项目管理信息
        List<Map<String, Object>> list =tblProjectMapper.selectTblProjectPage(page, pageInfo.getCondition());
        //将查询到的分页信息和记录总条数传送到分页信息实体类中
        pageInfo.setRows(list);
        pageInfo.setTotal(page.getTotal());
		
	}
	
}
