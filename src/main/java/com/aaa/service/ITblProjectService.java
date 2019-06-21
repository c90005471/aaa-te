package com.aaa.service;

import com.aaa.commons.result.PageInfo;
import com.aaa.model.TblProject;
import com.baomidou.mybatisplus.service.IService;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author sunxicai
 * @since 2017-12-04
 */
public interface ITblProjectService extends IService<TblProject> {
	void selectDataGrid(PageInfo pageInfo);//查看项目管理页面
}
