package com.aaa.mapper;

import java.util.List;
import java.util.Map;

import com.aaa.model.StuEvaluate;
import com.baomidou.mybatisplus.mapper.BaseMapper;

/**
 * <p>
  *  Mapper 接口
 * </p>
 *
 * @author chenjian
 * @since 2017-09-19
 */
public interface StuEvaluateMapper extends BaseMapper<StuEvaluate> {
	List<Map> selectByplanidAndclassid(Map map) ;
	List<Map> selectAvgscoreByplanid(Map map);
	Map getDetailByRade(Long id);
	Float getDetailByCount(Long id);
}