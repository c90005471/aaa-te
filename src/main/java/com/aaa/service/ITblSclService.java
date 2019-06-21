package com.aaa.service;

import java.util.List;
import java.util.Map;

import com.aaa.commons.result.PageInfo;
import com.aaa.model.TblScl;
import com.baomidou.mybatisplus.service.IService;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author fangjunwei
 * @since 2017-11-29
 */
public interface ITblSclService extends IService<TblScl> {
	/**
	 * 进行查询和分页
	 * @param pageInfo
	 */
	void selectDataGird(PageInfo pageInfo);
	/**
	 * 查询tbl_scl_type,为tbl_scl做关联
	 * @return
	 */
	List<Map<String,Object>> selectTblSclType();
	/**
	 * 添加题目时，查询当前添加的id是否已经存在
	 * @param id
	 * @return
	 */
	List<Map<String,Object>> selectItemId(Long id);
	/**
	 * 查询tbl_scl表的最后一个id
	 * @return
	 */
	Integer selectLastId();
	
	
}
