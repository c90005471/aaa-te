package com.aaa.service;

import com.baomidou.mybatisplus.service.IService;
import com.aaa.commons.result.PageInfo;
import com.aaa.model.SysLog;

/**
 *
 * SysLog 表数据服务层接口
 *
 */
public interface ISysLogService extends IService<SysLog> {

    void selectDataGrid(PageInfo pageInfo);

}