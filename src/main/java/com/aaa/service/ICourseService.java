package com.aaa.service;

import java.util.List;
import java.util.Map;

import com.aaa.commons.result.Tree;
import com.aaa.commons.shiro.ShiroUser;
import com.aaa.model.Course;
import com.aaa.model.vo.CourseVo;
import com.baomidou.mybatisplus.service.IService;

/**
 *
 * course 科目 表数据服务层接口
 *
 */
public interface ICourseService extends IService<Course> {

    List<Course> selectAll();

    List<Tree> selectAllMenu(Long orgid,Integer coursetype);

    List<Tree> selectAllTree();

    List<Tree> selectTree(ShiroUser shiroUser,Long orgid,String flag);
   
	void deleteCourseById(Long id);//一次删除多行数据

	boolean batchAddCource(List<CourseVo> excelToList,Integer orgId);

	List<Map> selectListByGroup();

}