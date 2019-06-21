package com.aaa.mapper;

import java.util.List;
import java.util.Map;

import com.aaa.model.TeacherDetail;
import com.baomidou.mybatisplus.mapper.BaseMapper;
import com.baomidou.mybatisplus.plugins.pagination.Pagination;

/**
 * <p>
  *  Mapper 接口
 * </p>
 *
 * @author 张德鑫
 * @since 2017-09-21
 */
public interface TeacherDetailMapper extends BaseMapper<TeacherDetail> {
	Map selectByplanidAndclassid(Long id) ;
	List<Map> selectAvgscoreByplanid(Map map);
	List<Map> selectByplanid(Pagination page, Map<String, Object> params);
	Map selectByteacherSum(Long id);
	Map selectByStuSum(Map<String,Object> paramMap);
}