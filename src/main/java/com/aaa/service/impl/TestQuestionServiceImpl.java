package com.aaa.service.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.aaa.commons.result.PageInfo;
import com.aaa.commons.utils.ConstantUtils;
import com.aaa.commons.utils.StringUtils;
import com.aaa.mapper.TestQuestionAnswerMapper;
import com.aaa.mapper.TestQuestionMapper;
import com.aaa.model.Question;
import com.aaa.model.TestQuestion;
import com.aaa.model.TestQuestionAnswer;
import com.aaa.service.ITestQuestionService;
import com.baomidou.mybatisplus.plugins.Page;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
@Service
public class TestQuestionServiceImpl extends ServiceImpl<TestQuestionMapper, TestQuestion> implements ITestQuestionService {
	@Autowired
	private TestQuestionMapper testQuestionMapper;
	@Autowired
	private TestQuestionAnswerMapper testQuestionAnswerMapper;
	/**
	 * 查询列表
	 */
	@Override
    public void selectDataGrid(PageInfo pageInfo) {
        Page<Map<String, Object>> page = new Page<Map<String, Object>>(pageInfo.getNowpage(), pageInfo.getSize());
        page.setOrderByField(pageInfo.getSort());
        page.setAsc(pageInfo.getOrder().equalsIgnoreCase("asc"));
        List<Map<String, Object>> list = testQuestionMapper.selectTestQuestionPage(page, pageInfo.getCondition());
        //获取试题类型
        Map<Integer,String> typeMap = ConstantUtils.QUESTIONTYPEMAP;
        for (Map<String, Object> map : list) {
        	String quetype = map.get("questype").toString();
        	for (Map.Entry<Integer,String> entry : typeMap.entrySet()) {
				if(quetype.equals(entry.getKey()+"")){
					map.put("questype",entry.getValue());
					break;
				}
			}
		}
        pageInfo.setRows(list);
        pageInfo.setTotal(page.getTotal());
    }
	/**
	 * 保存试题信息和选项信息
	 */
	@Override
	public void insertQuestionAndOption(TestQuestion ques, String[] options,String scores) {
		ques.setCreatetime(new Date());
		//保存试题信息
		testQuestionMapper.insertTestQues(ques);
		Long quesid = ques.getId();
		String[] scoreArrStrings={}; 
		if(scores!=null&&scores.length()>0){
			scoreArrStrings = scores.split(",");
		}
		//保存选项信息
		for (int i = 0; i < options.length; i++) {
			TestQuestionAnswer answer = new TestQuestionAnswer();
			answer.setQuesid(quesid);
			answer.setOption(options[i]);
			if(scoreArrStrings!=null&&scoreArrStrings.length>0){
				try {
					answer.setScore(Integer.valueOf(scoreArrStrings[i]));
				} catch (Exception e) {
				}
			}else{
				answer.setScore(1);
			}
			//如果选项为空就不保存选项
			if(StringUtils.isNotBlank(options[i])){
				testQuestionAnswerMapper.insert(answer);
			}
		}
	}
	/**
	 * 删除试题信息和选项信息
	 */
	@Override
	public void deleteQuestionAndOption(Long id) {
		testQuestionMapper.deleteById(id);
		Map<String,Object> columnMap = new HashMap<String,Object>();
		columnMap.put("quesid", id);
		testQuestionAnswerMapper.deleteByMap(columnMap);
		
	}
	/**
	 * 查询试题信息和选项信息
	 */
	@Override
	public Map<String, Object> selectTestQuesAndOption(Long id) {
		Map<String, Object> map = new HashMap<String, Object>();
		//获取试题信息
		TestQuestion testQuestion = testQuestionMapper.selectById(id);
		map.put("testQuestion", testQuestion);
		//获取选项信息
		Map<String,Object> columnMap = new HashMap<String,Object>();
		columnMap.put("quesid",id);
		List<TestQuestionAnswer>  optionList = testQuestionAnswerMapper.selectByMap(columnMap);
		map.put("optionList", optionList);
		String scores = "";
		if(optionList!=null&&optionList.size()>0){
			for (TestQuestionAnswer testQuestionAnswer : optionList) {
				if(testQuestionAnswer.getScore()!=null){
					scores+=testQuestionAnswer.getScore()+",";
				}
			}
			if(scores!=null&&scores.length()>0){
				scores = scores.substring(0,scores.length()-1);
			}
		}
		//获取选项得分
		map.put("scores", scores);
		return map;
	}
	/**
	 * 更新试题信息和选项信息
	 */
	@Override
	public void updateQuestionAndOption(TestQuestion ques, String[] options,String scores) {
		ques.setCreatetime(new Date());
		//更新试题信息
		testQuestionMapper.updateById(ques);
		//删除对应的选项信息
		Map<String,Object> columnMap = new HashMap<String,Object>();
		columnMap.put("quesid", ques.getId());
		testQuestionAnswerMapper.deleteByMap(columnMap);
		
		String[] scoreArrStrings={}; 
		if(scores!=null&&scores.length()>0){
			scoreArrStrings = scores.split(",");
		}
		//添加新修改的信息
		for (int i = 0; i < options.length; i++) {
			TestQuestionAnswer answer = new TestQuestionAnswer();
			answer.setQuesid(ques.getId());
			answer.setOption(options[i]);
			if(scoreArrStrings!=null&&scoreArrStrings.length>0){
				try {
					answer.setScore(Integer.valueOf(scoreArrStrings[i]));
				} catch (Exception e){}
			}else{
				answer.setScore(1);
			}
			testQuestionAnswerMapper.insert(answer);
		}
	}
	@Override
	public Map<String, Object> selectQuestionMap(String  quesType) {
		List<Question> questionList= new ArrayList<Question>();
		Map<Integer,Integer> questionIdTopicIdMap = new HashMap<Integer,Integer>();
		//获取试题内容
		Map<String,Object> columnMap = new HashMap<String,Object>();
		columnMap.put("questype", quesType);
		List<TestQuestion> testQuestionList = testQuestionMapper.selectByMap(columnMap);
		//将所有的知识点封装到试题列表中
		for (int i = 0; i < testQuestionList.size(); i++) {
			//获取对应的试题选项
			Map<String,Object> columnMap1 = new HashMap<String,Object>();
			columnMap1.put("quesid", testQuestionList.get(i).getId());
			List<TestQuestionAnswer> testQuestionAnswerList = testQuestionAnswerMapper.selectByMap(columnMap1);
			String itmes = "";
			String[] itemList = new String[testQuestionAnswerList.size()];
			if(testQuestionAnswerList!=null&&testQuestionAnswerList.size()>0){
				for (int j=0;j<testQuestionAnswerList.size();j++) {
					TestQuestionAnswer testQuestionAnswer = testQuestionAnswerList.get(j);
					itmes += testQuestionAnswer.getOption()+"~";
					String answerStr  = testQuestionList.get(i).getQuesanswer();
					//获取正确答案的得分 (正确答案有分,错误答案为空)
					if(StringUtils.isNotBlank(answerStr)){
						String str  =  testQuestionAnswer.getOption().substring(0,1);
						if(str.equals(answerStr)){
							itemList[j] = testQuestionAnswer.getScore().toString();
						}else{
							itemList[j] = "";
						}
					}else{
						//如果没有答案
						itemList[j] = testQuestionAnswer.getScore().toString();
					}
				}
				if(StringUtils.isNotBlank(itmes)){
					itmes = itmes.substring(0,itmes.length()-1);
				}
			}
			
			Question q= new Question();
			 q.setQuestionId(testQuestionList.get(i).getId());
			//将topicId作为value放到map中，key是0，1，2，3，4，下标
			 questionIdTopicIdMap.put(i, Integer.valueOf(testQuestionList.get(i).getId().toString()));
			 q.setQuestionTitle(testQuestionList.get(i).getQuesname());
			 q.setQuestionItems(itmes);
			 q.setQuestionAnswer(itmes);
			 q.setItems(itemList);
			 q.setQuestionType(testQuestionList.get(i).getType());
			 questionList.add(q);
		}
		Map<String, Object> map = new HashMap<String,Object>();
		map.put("questionList", questionList);
		map.put("questionIdTopicIdMap", questionIdTopicIdMap);
		return map;
	}

}
