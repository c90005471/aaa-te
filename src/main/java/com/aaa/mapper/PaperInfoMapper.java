package com.aaa.mapper;

import java.util.List;
import java.util.Map;

import com.aaa.model.ExamPaper;
import com.aaa.model.PaperInfo;
import com.baomidou.mybatisplus.mapper.BaseMapper;
import com.baomidou.mybatisplus.plugins.Page;
/**
 * 类名称：PaperInfoMapper
 * 类描述： 
 * 创建人：sunshaoshan
 * 创建时间：2018-7-19 下午5:11:00
 * @version
 */
public interface PaperInfoMapper extends BaseMapper<PaperInfo> {
	List<Map<String, Object>> selectPaperInfoPage(Page<Map<String, Object>> page, Map<String, Object> condition);

	/**
	 * 查询科目下的所有的试题
	 * @param page
	 * @param condition
	 * @return
	 */
	List<Map<String, Object>> selectQuestionInfoPage(Page<Map<String, Object>> page, Map<String, Object> condition);

	/**
	 * 根据 paperid 和 infoid 查询 paper_info 信息
	 * @return
	 */
	Map<String,Object> selectPaperInfo(Map<String,Object> params);

}
