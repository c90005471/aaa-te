package com.aaa.mapper;

import java.util.List;
import java.util.Map;


import com.baomidou.mybatisplus.mapper.BaseMapper;
import com.baomidou.mybatisplus.plugins.pagination.Pagination;
import com.aaa.model.Wordofmouth;

/**
 * 
 * 类名称：WordofmouthMapper
 * 类描述：Wordofmouth 表数据库控制层接口
 * 创建人：sunshaoshan
 * 创建时间：2018-1-11 下午1:47:23
 * @version
 */
public interface WordofmouthMapper extends BaseMapper<Wordofmouth> {

    List<Map<String, Object>> selectWordofmouthPage(Pagination page, Map<String, Object> params);

	List<Map> selectWordStatusByHashMap(Map map);

	List<Map> selectWordStatusByMonHashMap(Map map);

}