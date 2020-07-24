package com.aaa.service.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Random;
import java.util.Set;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.aaa.commons.result.PageInfo;
import com.aaa.commons.result.Tree;
import com.aaa.mapper.ExamPaperMapper;
import com.aaa.mapper.ExamRecordMapper;
import com.aaa.mapper.PaperInfoMapper;
import com.aaa.mapper.StudentMapper;
import com.aaa.mapper.TopicInfoMapper;
import com.aaa.mapper.TopicOptionMapper;
import com.aaa.mapper.TopicTypesMapper;
import com.aaa.model.ExamPaper;
import com.aaa.model.ExamRecord;
import com.aaa.model.PaperInfo;
import com.aaa.model.Question;
import com.aaa.model.Student;
import com.aaa.model.TestQuestion;
import com.aaa.model.TestQuestionAnswer;
import com.aaa.model.TopicInfo;
import com.aaa.model.TopicOption;
import com.aaa.model.TopicTypes;
import com.aaa.model.vo.DataVo;
import com.aaa.model.vo.TopicInfoExcelVo;
import com.aaa.model.vo.TopicInfoVo;
import com.aaa.service.IExamPaperService;
import com.aaa.service.ITopicInfoService;
import com.baomidou.mybatisplus.mapper.Wrapper;
import com.baomidou.mybatisplus.plugins.Page;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
/**
 * 类名称：ExamPaperServiceImpl
 * 类描述： 
 * 创建人：sunshaoshan
 * 创建时间：2018-7-10 下午4:43:54
 * @version
 */
@Service
public class ExamPaperServiceImpl extends ServiceImpl<ExamPaperMapper,ExamPaper> implements IExamPaperService{
	@Autowired
	private ExamPaperMapper examPaperMapper;
	@Autowired
	private TopicInfoMapper topicInfoMapper;
	@Autowired
	private PaperInfoMapper paperInfoMapper; 
	@Autowired
	private TopicOptionMapper topicOptionMapper; 
	@Autowired
	private StudentMapper studentMapper;
	@Autowired
	private ExamRecordMapper examRecordMapper;
	/**
	 * 查询列表信息
	 */
	@Override
	public void selectDataGrid(PageInfo pageInfo) {
		Page<Map<String, Object>> page = new Page<Map<String, Object>>(pageInfo.getNowpage(), pageInfo.getSize());
        page.setOrderByField(pageInfo.getSort());
        page.setAsc(pageInfo.getOrder().equalsIgnoreCase("asc"));
        List<Map<String, Object>> list = examPaperMapper.selectExamPaperPage(page, pageInfo.getCondition());
        //获取试题类型
        pageInfo.setRows(list);
        pageInfo.setTotal(page.getTotal());
	}
	@Override
	public void selectDataGrid1(PageInfo pageInfo) {
		Page<Map<String, Object>> page = new Page<Map<String, Object>>(pageInfo.getNowpage(), pageInfo.getSize());
        page.setOrderByField(pageInfo.getSort());
        page.setAsc(pageInfo.getOrder().equalsIgnoreCase("asc"));
        List<Map<String, Object>> list = examPaperMapper.selectExamPaperPage1(page, pageInfo.getCondition());
        //获取试题类型
        pageInfo.setRows(list);
        pageInfo.setTotal(page.getTotal());
	}
	/**
	 * 保存试卷和题目关系信息
	 */
	/* (non-Javadoc)
	 * @see com.aaa.service.IExamPaperService#addExamPaperAndTopicInfo(java.lang.Long, java.lang.String)
	 */
	@Override
	public void addExamPaperAndTopicInfo(Long id, String sumStr,String xin) {
		if(xin.equals("1")){
			//重新生成
			//首先先删除paperinfo表中的对应的试卷中的试题
			Map<String,Object> columnMap = new HashMap<String,Object>();
			columnMap.put("paperid", id);
			paperInfoMapper.deleteByMap(columnMap);
		}
		//保存试卷和试题信息
		savePaperInfo(id, sumStr,null);
	}
	/**
	 * 保存试卷和试题信息
	 * @param id
	 * @param sumStr
	 * @param infoIdSet 原来试卷中试题
	 */
	private void savePaperInfo(Long id,String sumStr,List<Long> infoIdList){
		//抽取试题
		if(StringUtils.isNotBlank(sumStr)){
			// 初始化随机数  
	        //Random rand = new Random();  
			//分割科目id#对应抽取的数量
			String [] typeIdAndSums = sumStr.split(";");
			for (String typeIdAndSum : typeIdAndSums) {
				String[] typeIds = typeIdAndSum.split("#");
				//分割科目id 并随机抽取(数量)的试题
				Map<String,Object> map = new HashMap<String,Object>();
				map.put("topictype", typeIds[0]);
				if(StringUtils.isNotBlank(typeIds[1])){
					map.put("sum", Integer.valueOf(typeIds[1]));
				}
				List<TopicInfo> infoList = topicInfoMapper.selectInfoByTypeIdAndSum(map);
				//获取该科目中待选取的试题
//				Map<String,Object> columnMap = new HashMap<String,Object>();
//				columnMap.put("topictype", typeIds[0]);
//				List<TopicInfo> list = topicInfoMapper.selectByMap(columnMap);
//				
//				List<Long> idList = new ArrayList<Long>();
//				for (TopicInfo topicInfo : list) {
//					if(infoIdList!=null){//去掉试卷中原有的试题
//						if(!infoIdList.contains(topicInfo.getId())){
//							idList.add(topicInfo.getId());
//						}
//					}else{
//						idList.add(topicInfo.getId());
//					}
//				}
//				if(StringUtils.isNotBlank(typeIds[1])){
//					int size = Integer.valueOf(typeIds[1]);
//					if(size>idList.size()){//如果抽取的数量大于剩余数量,使用该科目的总题数
//						idList = new ArrayList<Long>();
//						for (TopicInfo info : list) {
//							idList.add(info.getId());
//						}
//					}
//					//随机抽取sum道题
//					for(int i=0;i<size;i++){
//						int myRand = rand.nextInt(idList.size());
//						Long infoId = idList.get(myRand);
//						PaperInfo info = new PaperInfo();
//						info.setPaperid(id);
//						info.setInfoid(infoId);
//						paperInfoMapper.insert(info);
//					}
//				}
				//保存试题
				for (TopicInfo topicInfo : infoList) {
					PaperInfo info = new PaperInfo();
					info.setPaperid(id);
					info.setInfoid(topicInfo.getId());
					paperInfoMapper.insert(info);
				}
			}
		}
	}
	/**
	 * 智能组卷回调的datagrid方法
	 */
	@Override
	public void selectPaperInfoPage(PageInfo pageInfo) {
		Page<Map<String, Object>> page = new Page<Map<String, Object>>(pageInfo.getNowpage(), pageInfo.getSize());
        page.setOrderByField(pageInfo.getSort());
        page.setAsc(pageInfo.getOrder().equalsIgnoreCase("asc"));
        List<Map<String, Object>> list = paperInfoMapper.selectPaperInfoPage(page, pageInfo.getCondition());
        pageInfo.setRows(list);
        pageInfo.setTotal(page.getTotal());
	}
	/**
	 * 智能组卷删除试题方法
	 */
	@Override
	public void deletePaperInfoById(Long id) {
		paperInfoMapper.deleteById(id);
	}
	/**
	 * 删除试卷和所属试题
	 */
	@Override
	public void deleteExamPaperAndInfoById(Long id) {
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("paperid", id);
		paperInfoMapper.deleteByMap(map);
		//删除试卷信息
		examPaperMapper.deleteById(id);
	}
	/**
	 * 根据阶段和类型
	 */
	@Override
	public List<DataVo> selectExamPaperList(String stage, String type) {
		Map<String,Object> columnMap = new HashMap<String,Object>();
		columnMap.put("stage", stage);
		columnMap.put("type", type);
		columnMap.put("state", 1);
		List<ExamPaper> list = examPaperMapper.selectExamPaperByMap(columnMap);
		List<DataVo> dataList = new ArrayList<DataVo>();
		if(list!=null&&list.size()>0){
			dataList.add(new DataVo("请选择试卷",""));
			for (ExamPaper examPaper : list) {
				DataVo data = new DataVo(examPaper.getTitle(),examPaper.getId()+"");
				dataList.add(data);
			}
		}else{
			dataList.add(new DataVo("请选择试卷",""));
		}
		return dataList;
	}
	/**
	 * 查询试卷是否有该学生
	 */
	@Override
	public boolean checkExamLogin(Long examPaperId, String stuno, String stuphone) {
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("id", examPaperId);
		map.put("stuno", stuno);
		map.put("phone", stuphone);
		List<ExamPaper> list = examPaperMapper.findExamPaperByMap(map);
		if(list!=null&&list.size()>0){
			Long classid = list.get(0).getClassid();
			//获取学生的id
//			Student stu = new Student();
//			stu.setStuno(stuno);
//			stu = studentMapper.selectOne(stu);
			Map<String,Object> paraMap = new HashMap<String,Object>();
			paraMap.put("class_id", classid);
			paraMap.put("stuno", stuno);
			List<Student> stuList =  studentMapper.selectByMap(paraMap);
			if(stuList!=null && stuList.size()>0){
				//根据学生id 和  试卷id查询考试记录是否有信息
				Map<String,Object> cloumnMap = new HashMap<String,Object>();
				cloumnMap.put("stuid", stuList.get(0).getId());
				cloumnMap.put("paperid", examPaperId);
				List<ExamRecord> recordList = examRecordMapper.selectByMap(cloumnMap);
				if(recordList!=null&&recordList.size()!=0){
					//如果存在记录并且状态为0 允许登陆
					if(recordList.get(0).getState()==0){
						return true;
					}else{
						return false;
					}
				}
				return true;
			}
		}
		return false;
	}

	@Override
	public void selectQuestionInfoPage(PageInfo pageInfo) {
		Page<Map<String, Object>> page = new Page<Map<String, Object>>(pageInfo.getNowpage(), pageInfo.getSize());
		page.setOrderByField(pageInfo.getSort());
		page.setAsc(pageInfo.getOrder().equalsIgnoreCase("asc"));
		List<Map<String, Object>> list = paperInfoMapper.selectQuestionInfoPage(page, pageInfo.getCondition());
		pageInfo.setRows(list);
		pageInfo.setTotal(page.getTotal());
	}

	@Override
	public int addPaperByManual(Integer paperid, Integer infoid) {
		int len = 0;
		/**
		 * 查询是否在试卷中存在如果不存在则添加
		 */
		Map<String,Object> params = new HashMap<>();
		params.put("paperid",paperid);
		params.put("infoid",infoid);
		Map<String, Object> map = paperInfoMapper.selectPaperInfo(params);
		if (map != null){
			len = -1;
		}else {
			PaperInfo info = new PaperInfo();
			info.setPaperid(Long.parseLong(paperid+""));
			info.setInfoid(Long.parseLong(infoid+""));
			len = paperInfoMapper.insert(info);
		}
		return len;
	}

	@Override
	public boolean newCheckExamLogin(Long examPaperId, String stuno, String stuphone) {

		return true;
	}

	@Override
	public void addPaperClass(int paperid, int classid) {
		Map<String,Object> map = new HashMap<>();
		map.put("paperid",paperid);
		map.put("classid",classid);
		examPaperMapper.insertPaperClass(map);
	}

	/**
	 * 查询试卷是否有该学生
	 */
	@Override
	public Map<String,Object> findExamPaperByMap(Long examPaperId, String stuno,String stuphone) {
		Map<String,Object> returnMap = new HashMap<String,Object>();
		returnMap.put("flag", false);
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("id", examPaperId);
		map.put("stuno", stuno);
		map.put("phone", stuphone);
		List<ExamPaper> list = examPaperMapper.findExamPaperByMap(map);
		if(list!=null && list.size()>0){
			Long classid = list.get(0).getClassid();
			//获取学生的id
//			Student stu = new Student();
//			stu.setStuno(stuno);
//			stu = studentMapper.selectOne(stu);
			Map<String,Object> paraMap = new HashMap<String,Object>();
			paraMap.put("class_id", classid);
			paraMap.put("stuno", stuno);
			List<Student> stuList =  studentMapper.selectByMap(paraMap);
			if(stuList!=null && stuList.size()>0){
				//根据学生id 和  试卷id查询考试记录是否有信息
				Map<String,Object> cloumnMap = new HashMap<String,Object>();
				cloumnMap.put("stuid", stuList.get(0).getId());
				cloumnMap.put("paperid", examPaperId);
				List<ExamRecord> recordList = examRecordMapper.selectByMap(cloumnMap);
				if(recordList!=null&&recordList.size()!=0){
					//如果存在记录并且状态为0 允许登陆
					if(recordList.get(0).getState()==0){
						returnMap.put("flag", true);
						returnMap.put("id", recordList.get(0).getId());
					}
				}else{
					//注:在考试记录插入一条数据,防止重复登录
					ExamRecord examRecord = new ExamRecord();
					examRecord.setStuid(stuList.get(0).getId());
					examRecord.setPaperid(examPaperId);
					examRecord.setScore(0);
					examRecord.setState(0);
					examRecord.setCreatetime(new Date());
					examRecordMapper.insertExamRecord(examRecord);//插入
					returnMap.put("flag", true);
					returnMap.put("id", examRecord.getId());
				}
			}
		}
		return returnMap;
	}
	/**
	 * 获取试卷的试题
	 * @return
	 */
	@Override
	public Map<String, Object> selectQuestionMap(Long paperId) {
		List<Question> questionList= new ArrayList<Question>();
		Map<Integer,Integer> questionIdTopicIdMap = new HashMap<Integer,Integer>();
		//根据试卷id获取试题内容
		Map<String,Object> columnMap = new HashMap<String,Object>();
		columnMap.put("paperId", paperId);
		List<TopicInfo> topicInfoList = topicInfoMapper.selectInfoByMap(columnMap);
		//将所有的知识点封装到试题列表中
		for (int i = 0; i < topicInfoList.size(); i++) {
			//获取对应的试题选项
			Map<String,Object> columnMap1 = new HashMap<String,Object>();
			columnMap1.put("infoid", topicInfoList.get(i).getId());
			List<TopicOption> topicOptionList = topicOptionMapper.selectByMap(columnMap1);
			String itmes = "";
			String[] itemList = new String[topicOptionList.size()];
			if(topicOptionList!=null&&topicOptionList.size()>0){
				for (int j=0;j<topicOptionList.size();j++) {
					TopicOption topicOption = topicOptionList.get(j);
					itmes += topicOption.getOptionnum()+":"+topicOption.getOption()+"~";
					String answerStr  = topicInfoList.get(i).getCorrect();
					//获取正确答案的得分 (正确答案有分,错误答案为空)单选题有用
					if(StringUtils.isNotBlank(answerStr)){
						String str  =  topicOption.getOptionnum();
						if(str.equals(answerStr)){
							itemList[j] = topicInfoList.get(i).getScore().toString();
						}else{
							itemList[j] = "";
						}
					}else{
						//如果没有答案
						itemList[j] = topicInfoList.get(i).getScore().toString();
					}
				}
				if(StringUtils.isNotBlank(itmes)){
					itmes = itmes.substring(0,itmes.length()-1);
				}
			}
			
			Question q= new Question();
			 q.setQuestionId(topicInfoList.get(i).getId());
			//将topicId作为value放到map中，key是0，1，2，3，4，下标
			 questionIdTopicIdMap.put(i, Integer.valueOf(topicInfoList.get(i).getId().toString()));
			 if(topicInfoList.get(i).getType()==1){
				 q.setQuestionTitle(topicInfoList.get(i).getTopicname()+"(多选题)");
			 }else{
				 q.setQuestionTitle(topicInfoList.get(i).getTopicname());
			 }
			 q.setQuestionItems(itmes);
			 q.setQuestionAnswer(itmes);
			 q.setItems(itemList);
			 q.setQuestionType(topicInfoList.get(i).getType());
			 questionList.add(q);
		}
		Map<String, Object> map = new HashMap<String,Object>();
		map.put("questionList", questionList);
		map.put("questionIdTopicIdMap", questionIdTopicIdMap);
		return map;
	}

}
