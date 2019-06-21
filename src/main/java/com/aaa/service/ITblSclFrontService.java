package com.aaa.service;

import java.util.List;

import com.aaa.model.TblScl;
import com.baomidou.mybatisplus.service.IService;
	/**
 *@className:ITblSclFrontService.java
 *@discriptions:
 *@author:徐辉
 *@createTime:2017-11-30下午9:32:18
 *@version:1.0.0
 *
 */
public interface ITblSclFrontService extends IService<TblScl> {
	/**
	 * 查询心理测试题的内容
	 */
	List<TblScl> selecAllTblScls();
}
