package com.aaa.service;

import com.aaa.model.AssplanStudent;
import com.baomidou.mybatisplus.service.IService;

public interface IAssplanStudentService extends IService<AssplanStudent> {

	String findStunosByAssistId(Long id);
	String findStunameByAssistId(Long id);
	String findTeacherName(Long creator);
}
