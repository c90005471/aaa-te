package com.aaa.mapper;

import java.util.List;
import java.util.Map;

import com.aaa.model.ExamPaper;
import com.aaa.model.ExamRecord;
import com.aaa.model.vo.ExamRecordVo;
import com.baomidou.mybatisplus.mapper.BaseMapper;
import com.baomidou.mybatisplus.plugins.Page;
/**
 * 类名称：ExamRecordMapper
 * 类描述： 
 * 创建人：sunshaoshan
 * 创建时间：2018-7-26 下午3:01:49
 * @version
 */
public interface ExamRecordMapper extends BaseMapper<ExamRecord> {
	List<Map<String, Object>> selectExamRecordPage(Page<Map<String, Object>> page, Map<String, Object> condition);

	void insertExamRecord(ExamRecord examRecord);

	List<ExamRecordVo> selectExamRecordVoList(Map<String, Object> condition);
}
