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
	void selectDataGrid1(PageInfo pageInfo);


	void duplicateExamPaper(Long pid, Long eid);

	void selectPaperInfoPage(PageInfo pageInfo);

	void deletePaperInfoById(Long id);

	void deleteExamPaperAndInfoById(Long id);

	List<DataVo> selectExamPaperList(String stage, String type);

	List<Map<String,Object>> findAllPaper();

	Map<String, Object> findExamPaperByMap(Long examPaperId, String stuno,String stuphone);

	Map<String, Object> selectQuestionMap(Long paperId,Long paperinfoid);

	boolean checkExamLogin(Long examPaperId, String stuno, String stuphone);

	void selectQuestionInfoPage(PageInfo pageInfo);

	/**
	 * 手动组卷添加试题
	 * @param paperid
	 * @param infoid
	 * @return
	 */
	int addPaperByManual(Integer paperid,Integer infoid);

	/**
	 * 新 判断学生是否可以登陆
	 * @param examPaperId
	 * @param stuno
	 * @param stuphone
	 * @return
	 */
	boolean newCheckExamLogin(Long examPaperId, String stuno, String stuphone);

	/**
	 * 添加paperclass表数据
	 * @param paperid
	 * @param classid
	 */
	void addPaperClass(int paperid,int classid);
}
