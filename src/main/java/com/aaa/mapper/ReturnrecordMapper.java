package com.aaa.mapper;

import java.util.List;
import java.util.Map;

import com.aaa.model.Returnrecord;
import com.baomidou.mybatisplus.mapper.BaseMapper;
import com.baomidou.mybatisplus.plugins.Page;

/**
 *
 * Returnrecord 表数据库控制层接口
 *
 */
public interface ReturnrecordMapper extends BaseMapper<Returnrecord> {

	List<Map<String, Object>> selectStudentReturnRecordPage(Page<Map<String, Object>> page,Map<String, Object> condition);

	List<Map> selectReturnRecordByMonHashMap(Map map);

}