package com.aaa.mapper;

import java.util.List;
import java.util.Map;

import com.aaa.model.Student;
import com.aaa.model.StudentCompany;
import com.baomidou.mybatisplus.mapper.BaseMapper;
import com.baomidou.mybatisplus.plugins.Page;
import com.baomidou.mybatisplus.plugins.pagination.Pagination;

/**
 * <p>
  *  Mapper 接口
 * </p>
 *
 * @author chenjian
 * @since 2017-09-14
 */
public interface StudentCompanyMapper extends BaseMapper<StudentCompany> {
	void insertStudentCompany(StudentCompany studentCompany);

	Map<String, Object> selectStudentCompanyById(Long stuid);

	List<Map<String, Object>> selectStudentCompanyPage(Page<Map<String, Object>> page, Map<String, Object> condition);

	List<Map<String, Object>> selectStudentComByClassId(Long id);
}