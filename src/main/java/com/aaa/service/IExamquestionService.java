package com.aaa.service;

import com.aaa.commons.result.PageInfo;
import com.aaa.model.Examquestion;
import com.baomidou.mybatisplus.service.IService;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author xuhui
 * @since 2017-12-05
 */
public interface IExamquestionService extends IService<Examquestion> {
	/**
	 * 考试题库
	 * 进行查询和分页
	 * @param pageInfo
	 */
	void selectDataGird(PageInfo pageInfo);
}
