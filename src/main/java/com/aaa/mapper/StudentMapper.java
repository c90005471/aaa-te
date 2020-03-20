package com.aaa.mapper;

import java.util.List;
import java.util.Map;

import com.aaa.model.TreeMenu;
import org.apache.ibatis.annotations.Param;

import com.aaa.model.Student;
import com.aaa.model.vo.StudentVo;
import com.baomidou.mybatisplus.mapper.BaseMapper;
import com.baomidou.mybatisplus.plugins.pagination.Pagination;

/**
 * <p>
 * Mapper 接口
 * </p>
 *
 * @author chenjian
 * @since 2017-09-14
 */
public interface StudentMapper extends BaseMapper<Student> {
    List<Map<String, Object>> selectStudentPage(Pagination page, Map<String, Object> params);

    Map selectCapterByStuId(Long id);

    /**
     * 描述:得到所有教育程度
     * 作者:林增辉
     * 时间:2017-9-21
     *
     * @return
     */
    List<Map<String, Object>> getDegree();

    /**
     * 描述:得到所有大学专业
     * 作者:林增辉
     * 时间:2017-9-21
     *
     * @return
     */
    List<Map<String, Object>> getMajor();

    /**
     * 描述:得到这个学生可以转的班
     * 作者:林增辉
     * 时间:2017-9-21
     *
     * @return
     */
    List<Map<String, Object>> getClassById(Long id);

    /**
     * 描述:得到这个学生的信息
     * 作者:林增辉
     * 时间:2017-9-21
     *
     * @return
     */
    Map<String, Object> selectStuById(Long id);

    /**
     * 根据班级id获取下属所有学生的基本信息和就业信息
     *
     * @param classid
     * @return
     */
    List<StudentVo> selectStudentVoList(@Param("id") Long classid);

    /**
     * 获取大学生学员
     *
     * @return
     */
    List<Map> fillAllColStu(String orgid);

    /**
     * 获取高中生学员
     *
     * @return
     */
    List<Map> fillAllHighStu(String orgid);

    /**
     * 判断学生是否可以登陆
     * @return
     */
    Map<String, Object> checkStudentLogin(Map<String, Object> map);

    /**
     * 获取学生考试记录
     * @param map
     * @return
     */
    List<TreeMenu> getStudentExam(Map<String, Object> map);

    /**
     * 查找学生信息
     * @param map
     * @return
     */
    Student getStudentInfo(Map<String, Object> map);
}