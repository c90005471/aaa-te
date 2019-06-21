package com.aaa.mapper;

import java.util.List;
import java.util.Map;

import com.aaa.model.TblScl;
import com.baomidou.mybatisplus.mapper.BaseMapper;
import com.baomidou.mybatisplus.plugins.pagination.Pagination;

/**
 * <p>
  *  Mapper 接口
 * </p>
 *
 * @author fangjunwei
 * @since 2017-11-29
 */
public interface TblSclMapper extends BaseMapper<TblScl> {

	/**
	 * 查询当前页的数据
	 * @return
	 */
	List<Map<String,Object>> selectTblSclPage(Pagination page, Map<String, Object> params);
	/**
	 * 查询tbl_scl_type表的数据，关联tbl_scl
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