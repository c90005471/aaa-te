package com.aaa.service;

import java.util.List;
import java.util.Map;

import com.aaa.commons.result.PageInfo;
import com.aaa.model.Returnrecord;
import com.aaa.model.Student;
import com.aaa.model.StudentCompany;
import com.aaa.model.vo.StudentCompanyVo;
import com.aaa.model.vo.StudentVo;
import com.baomidou.mybatisplus.service.IService;

/**
 * 类名称：IStudentCompanyService
 * 类描述： 
 * 创建人：sunshaoshan
 * 创建时间：2018-5-31 下午2:51:27
 * @version
 */
public interface IStudentCompanyService extends IService<StudentCompany> {

	String calBonus(StudentCompany com);

	boolean addOrUpdStudentCompany(List<StudentCompany> excelToListNew);

	List<Map<String, Object>> selectStudentComByClassId(Long id);

	
}
