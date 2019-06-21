package com.aaa.service.impl;

import java.util.List;
import java.util.Map;

import com.aaa.commons.result.PageInfo;
import com.aaa.model.Student;
import com.aaa.model.StudentRecord;
import com.aaa.mapper.StudentMapper;
import com.aaa.mapper.StudentRecordMapper;
import com.aaa.service.IStudentRecordService;
import com.aaa.service.IStudentService;
import com.baomidou.mybatisplus.plugins.Page;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author chenjian
 * @since 2017-09-14
 */
@Service
public class StudentRecordServiceImpl extends ServiceImpl<StudentRecordMapper, StudentRecord> implements IStudentRecordService {

	@Autowired
	private StudentRecordMapper studentRecordMapper;
	@Override
	public void selectDataGrid(PageInfo pageInfo) {
		 Page<Map<String, Object>> page = new Page<Map<String, Object>>(pageInfo.getNowpage(), pageInfo.getSize());
	        page.setOrderByField(pageInfo.getSort());
	        page.setAsc(pageInfo.getOrder().equalsIgnoreCase("asc"));
	        List<Map<String, Object>> list = studentRecordMapper.selectStudentRecordPage(page, pageInfo.getCondition());
	        pageInfo.setRows(list);
	        pageInfo.setTotal(page.getTotal());
	}
	
}
