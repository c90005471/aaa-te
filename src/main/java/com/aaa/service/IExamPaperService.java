package com.aaa.service;

import java.util.List;
import java.util.Map;

import com.aaa.commons.result.PageInfo;
import com.aaa.model.ExamPaper;
import com.aaa.model.vo.DataVo;
import com.baomidou.mybatisplus.service.IService;

/**
 * 类名称：IExamPaperService
 * 类描述： 
 * 创建人：sunshaoshan
 * 创建时间：2018-7-10 下午4:43:02
 * @version
 */
public interface IExamPaperService extends  IService<ExamPaper>{
	void selectDataGrid(PageInfo pageInfo);

	void addExamPaperAndTopicInfo(Long id, String sumStr,String xin);

	void selectPaperInfoPage(PageInfo pageInfo);

	void deletePaperInfoById(Long id);

	void deleteExamPaperAndInfoById(Long id);

	List<DataVo> selectExamPaperList(String stage, String type);

	Map<String, Object> findExamPaperByMap(Long examPaperId, String stuno,String stuphone);

	Map<String, Object> selectQuestionMap(Long paperId);

	boolean checkExamLogin(Long examPaperId, String stuno, String stuphone);


}
