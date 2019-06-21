package com.aaa.mapper;

import java.util.List;
import java.util.Map;

import com.aaa.model.StudentRecord;
import com.aaa.model.TblClassRecord;
import com.baomidou.mybatisplus.mapper.BaseMapper;
import com.baomidou.mybatisplus.plugins.pagination.Pagination;

/**
 * <p>
  *  Mapper 接口
 * </p>
 *
 * @author sunshaoshan
 * @since 2017-10-18
 */
public interface StudentRecordMapper extends BaseMapper<StudentRecord> {
	List<Map<String, Object>> selectStudentRecordPage(Pagination page, Map<String, Object> params);
	Long insertStudentRecord(StudentRecord studentRecord);
}