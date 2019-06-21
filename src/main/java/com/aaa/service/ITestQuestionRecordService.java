package com.aaa.service;

import com.aaa.commons.result.PageInfo;
import com.aaa.model.TestQuestionRecord;
import com.baomidou.mybatisplus.service.IService;

public interface ITestQuestionRecordService extends IService<TestQuestionRecord>{

	void selectDataGrid(PageInfo pageInfo);

}
