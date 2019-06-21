package com.aaa.service;

import java.util.List;
import java.util.Map;

import com.aaa.commons.result.PageInfo;
import com.aaa.model.Answer;
import com.aaa.model.ExamRecord;
import com.aaa.model.vo.ExamRecordVo;
import com.baomidou.mybatisplus.service.IService;
/**
 * 类名称：IExamRecordService
 * 类描述： 
 * 创建人：sunshaoshan
 * 创建时间：2018-7-26 下午3:36:33
 * @version
 */
public interface IExamRecordService extends  IService<ExamRecord>{
	void selectDataGrid(PageInfo pageInfo);

	void saveExamRecord(List<Answer> answerList, Long stuid);

	List<ExamRecordVo> selectExamRecordVoList(Map<String, Object> condition);

}
