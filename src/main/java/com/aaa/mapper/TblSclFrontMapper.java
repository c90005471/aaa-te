package com.aaa.mapper;

import java.util.List;

import com.aaa.model.TblScl;
import com.baomidou.mybatisplus.mapper.BaseMapper;
	/**
 *@className:TblSclFrontMapper.java
 *@discriptions:
 *@author:徐辉
 *@createTime:2017-11-30下午9:44:46
 *@version:1.0.0
 *
 */
public interface TblSclFrontMapper extends BaseMapper<TblScl> {
	/**
	 * 查询所有心理试题
	 */
	List<TblScl> selecAllTblScls();
}
