package com.aaa.service;

import java.util.List;
import java.util.Map;

import com.aaa.commons.result.PageInfo;
import com.aaa.model.*;
import com.aaa.model.vo.StudentCompanyVo;
import com.aaa.model.vo.StudentVo;
import com.baomidou.mybatisplus.service.IService;

/**
 * <p>
 * 服务类
 * </p>
 *
 * @author chenjian
 * @since 2017-09-14
 */
public interface IStudentService extends IService<Student> {
    void selectDataGrid(PageInfo pageInfo);

    Map selectCapterByStuId(Long id);//根据学生id查询出所在班级的自评信息

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

    boolean updateStudentById(Student student, Long userId);

    Map<String, Object> selectStudentCompanyById(Long id);

    List<StudentVo> selectStudentVoList(Long classid);

    /**
     * 大学生校区学生
     *
     * @param orgid
     * @return
     */
    List<Map> fillAllColStu(String orgid);

    /**
     * 高中生校区学生
     *
     * @return
     */
    List<Map> fillAllHighStu(String yjOrgid);

    void selectRerturnCordDataGrid(PageInfo pageInfo);

    boolean deleteReturnRecordById(Long id);

    boolean insertReturnrecord(Returnrecord returnrecord);

    Returnrecord selectReturnRecordById(Long id);

    boolean updateReturnrecordById(Returnrecord returnrecord);

    List<Map> selectReturnRecordByMonHashMap(Map map);

    boolean updateByStudentById(Student student, StudentCompany studentCompany,
                                Long userId);

    List<StudentCompany> selectStudentCompanyByExcel(List<StudentCompanyVo> excelToList, Long userId);

    /**
     * 判断学生是否可以登陆
     * @param stuno
     * @param stuphone
     * @return
     */
    boolean checkStudentLogin(String stuno, String stuphone);

    List<TreeMenu> getStudentMenu(String stuid);

    /**
     * 通过手机号和学号查找学生信息
     * @param stuno
     * @param stuphont
     * @return
     */
    Student getStudentInfo(String stuno,String stuphont);
}
