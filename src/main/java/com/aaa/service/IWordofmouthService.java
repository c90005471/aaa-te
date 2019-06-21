package com.aaa.service;

import java.util.List;
import java.util.Map;

import com.aaa.commons.result.PageInfo;
import com.aaa.model.Wordofmouth;
import com.baomidou.mybatisplus.service.IService;

/**
 *
 * User 表数据服务层接口
 *
 */
public interface IWordofmouthService extends IService<Wordofmouth> {
    void selectDataGrid(PageInfo pageInfo);

	List<Map> selectWordStatusByHashMap(Map map);

	List<Map> selectWordStatusByMonHashMap(Map map);
}