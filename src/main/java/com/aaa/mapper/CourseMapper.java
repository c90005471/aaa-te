package com.aaa.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Select;

import com.aaa.model.Course;
import com.baomidou.mybatisplus.mapper.BaseMapper;

/**
 *
 * Course 表数据库控制层接口
 *
 */
public interface CourseMapper extends BaseMapper<Course> {
	List<Long> selectChildById(Long id);//根据id查询所有子节点
	void deleteCourseById(Map map);//一次删除多行数据
	List<Course> selectCourceList(Map<String, Object> condition);
	Integer insertCourse(Course v);
	@Select("select course_version from course where course_version is not null group by course_version order by course_version desc")
	List<Map> selectListByGroup();

}