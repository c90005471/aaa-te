package com.aaa.service;

import java.util.List;
import java.util.Map;

import com.aaa.commons.result.PageInfo;
import com.aaa.model.TeacherDetail;
import com.baomidou.mybatisplus.service.IService;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author 张德鑫
 * @since 2017-09-21
 */
public interface ITeacherDetailService extends IService<TeacherDetail> {
	Map selectByplanidAndclassid(Long id);
	List<Map> selectAvgscoreByplanid(Map map);
	void selectByplanid(PageInfo pageInfo);//按照计划id查询评价详情，分页显示
	Map selectByTeacher(Long id);
}
