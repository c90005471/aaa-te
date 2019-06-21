package com.aaa.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import com.aaa.commons.result.PageInfo;
import com.aaa.model.TblScl;
import com.aaa.mapper.TblSclMapper;
import com.aaa.service.ITblSclService;
import com.baomidou.mybatisplus.plugins.Page;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author fangjunwei
 * @since 2017-11-29
 */
@Service
public class TblSclServiceImpl extends ServiceImpl<TblSclMapper, TblScl> implements ITblSclService {

	@Resource(name="tblSclMapper")
	private TblSclMapper tblSclMapper;
	/**
	 * 将总条数和每页的数据集合放入pageInfo 
	 */
	@Override
	public void selectDataGird(PageInfo pageInfo) {
		 	Page<Map<String, Object>> page = new Page<Map<String, Object>>(pageInfo.getNowpage(), pageInfo.getSize());
	        page.setOrderByField(pageInfo.getSort());
	        page.setAsc(pageInfo.getOrder().equalsIgnoreCase("asc"));
	        List<Map<String, Object>> list = tblSclMapper.selectTblSclPage(page, pageInfo.getCondition());
	        pageInfo.setRows(list);
	        pageInfo.setTotal(page.getTotal());
	}
	/**
	 * 测试题类型表
	 */
	@Override
	public List<Map<String, Object>> selectTblSclType() {
		return tblSclMapper.selectTblSclType();
	}
	/**
	 * 通过id查询当前添加的题目id是否已经存在
	 */
	@Override
	public List<Map<String,Object>> selectItemId(Long id) {
		return tblSclMapper.selectItemId(id);
	}
	/**
	 * 查询tbl_scl表的最后一个id（jsp页面提示使用）
	 * @return
	 */
	@Override
	public Integer selectLastId() {
		return tblSclMapper.selectLastId();
	}

	
	
	
	
}
