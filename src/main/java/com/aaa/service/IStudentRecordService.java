package com.aaa.service;

import com.aaa.commons.result.PageInfo;
import com.aaa.model.StudentRecord;
import com.baomidou.mybatisplus.service.IService;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author sunshaoshan
 * @since 2017-10-18
 */
public interface IStudentRecordService extends IService<StudentRecord> {
	 void selectDataGrid(PageInfo pageInfo);
	 
}
