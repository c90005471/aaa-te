package com.aaa.service.impl;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.aaa.commons.result.PageInfo;
import com.aaa.commons.utils.StringUtils;
import com.aaa.mapper.ExamRecordMapper;
import com.aaa.mapper.TopicInfoMapper;
import com.aaa.mapper.TopicOptionMapper;
import com.aaa.model.Answer;
import com.aaa.model.ExamRecord;
import com.aaa.model.TestQuestion;
import com.aaa.model.TestQuestionAnswer;
import com.aaa.model.TestQuestionRecord;
import com.aaa.model.TopicInfo;
import com.aaa.model.TopicOption;
import com.aaa.model.vo.ExamRecordVo;
import com.aaa.service.IExamRecordService;
import com.baomidou.mybatisplus.plugins.Page;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
/**
 * 类名称：ExamRecordServiceImpl
 * 类描述： 
 * 创建人：sunshaoshan
 * 创建时间：2018-7-26 下午3:37:16
 * @version
 */
@Service
public class ExamRecordServiceImpl extends ServiceImpl<ExamRecordMapper,ExamRecord> implements IExamRecordService{
	@Autowired
	private ExamRecordMapper examRecordMapper;
	@Autowired
	private TopicInfoMapper topicInfoMapper;
	@Autowired
	private TopicOptionMapper topicOptionMapper;
	/**
	 * 查询列表信息
	 */
	@Override
	public void selectDataGrid(PageInfo pageInfo) {
		Page<Map<String, Object>> page = new Page<Map<String, Object>>(pageInfo.getNowpage(), pageInfo.getSize());
        page.setOrderByField(pageInfo.getSort());
        page.setAsc(pageInfo.getOrder().equalsIgnoreCase("asc"));
        List<Map<String, Object>> list = examRecordMapper.selectExamRecordPage(page, pageInfo.getCondition());
        //获取试题类型
        pageInfo.setRows(list);
        pageInfo.setTotal(page.getTotal());
	}
	/**
	 * 提交试卷计算总成绩
	 */
	@Override
	public void saveExamRecord(List<Answer> answerList,Long recordId) {
		int sum = 0;
		//计算总分数
		for (Answer answer : answerList) {
			//如果选项不为空并且是多选题
			if("1".equals(answer.getType())){
				if(answer.getItem().indexOf(",")==0){
					answer.setItem(answer.getItem().substring(1,answer.getItem().length()));
				}
				String[] items =  answer.getItem().replaceAll("item","").split(",");
				
				//获取题目答案    获取题目选项   选项得分
				
				TopicInfo topicInfo = topicInfoMapper.selectById(answer.getQuesId());
				
				Map<String, Object> columnMap = new HashMap<String,Object>();
				columnMap.put("infoid", answer.getQuesId());
				List<TopicOption>  optionList = topicOptionMapper.selectByMap(columnMap);
				//取出选中的选项
				String answerItem = "";
				for (String index : items) {
					String option = optionList.get(Integer.valueOf(index)).getOptionnum().substring(0,1);
					answerItem+=option;
				}
				int score = topicInfo.getScore();//题的得分
				String correct = topicInfo.getCorrect().replace(",", "");
				if(answerItem.equals(correct)){
					sum += score;
				}
			}else{
				if(StringUtils.isNotBlank(answer.getAnswer())){
	      			sum += Integer.valueOf(answer.getAnswer());
	      		}
			}
		}
		//更新考试记录的成绩
		ExamRecord examRecord = new ExamRecord();
		examRecord.setId(recordId);
		examRecord.setScore(sum);
		examRecord.setState(1);//考试完成
		examRecord.setCreatetime(new Date());
		examRecordMapper.updateById(examRecord);
	}
	@Override
	public List<ExamRecordVo> selectExamRecordVoList(Map<String, Object> condition) {
		return examRecordMapper.selectExamRecordVoList(condition);
	}
}
