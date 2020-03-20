package com.aaa.service.impl;

import java.util.*;

import com.aaa.mapper.*;
import com.aaa.model.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.aaa.commons.result.PageInfo;
import com.aaa.commons.utils.StringUtils;
import com.aaa.model.vo.ExamRecordVo;
import com.aaa.service.IExamRecordService;
import com.baomidou.mybatisplus.plugins.Page;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;

/**
 * 类名称：ExamRecordServiceImpl
 * 类描述：
 * 创建人：sunshaoshan
 * 创建时间：2018-7-26 下午3:37:16
 */
@Service
public class ExamRecordServiceImpl extends ServiceImpl<ExamRecordMapper, ExamRecord> implements IExamRecordService {
    @Autowired
    private ExamRecordMapper examRecordMapper;
    @Autowired
    private TopicInfoMapper topicInfoMapper;
    @Autowired
    private TopicOptionMapper topicOptionMapper;
    @Autowired
    private ExamResultMapper examResultMapper;
    @Autowired
    private StudentMapper studentMapper;

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
    public void saveExamRecord(List<Answer> answerList, Long recordId) {
        //通过 recordId 查询stuId 和 paperId
        ExamRecord record = examRecordMapper.selectById(recordId);
        int paperId = record.getPaperid().intValue();
        int stuId = record.getStuid().intValue();
        //记录错题的信息
        ExamResult examResult = new ExamResult();
        int sum = 0;
        //计算总分数
        for (Answer answer : answerList) {
            //如果选项不为空并且是多选题
            if ("1".equals(answer.getType())) {
                if (answer.getItem().indexOf(",") == 0) {
                    answer.setItem(answer.getItem().substring(1, answer.getItem().length()));
                }
                String[] items = answer.getItem().replaceAll("item", "").split(",");
                //获取题目答案    获取题目选项   选项得分
                TopicInfo topicInfo = topicInfoMapper.selectById(answer.getQuesId());
                Map<String, Object> columnMap = new HashMap<String, Object>();
                columnMap.put("infoid", answer.getQuesId());
                List<TopicOption> optionList = topicOptionMapper.selectByMap(columnMap);
                //取出选中的选项
                String answerItem = "";
                for (String index : items) {
                    String option = optionList.get(Integer.valueOf(index)).getOptionnum().substring(0, 1);
                    answerItem += option;
                }
                //题的得分
                int score = topicInfo.getScore();
                int s1 = 0;
                String correct = topicInfo.getCorrect().replace(",", "");
                answerItem = sortChar(answerItem);
                if (answerItem.equals(correct)) {
                    sum += score;
                    s1 = score;
                }
                examResult.setInfoid(answer.getQuesId().intValue());
                examResult.setStuid(record.getStuid().intValue());
                examResult.setPaperid(record.getPaperid().intValue());
                examResult.setType(1);
                examResult.setRightAnswer(topicInfo.getCorrect());
                examResult.setAnswer(answerItem);
                examResult.setSum(s1);
                examResultMapper.insertExamResult(examResult);
            } else {
                int ss = 0;
                if (StringUtils.isNotBlank(answer.getAnswer())) {
                    sum += Integer.valueOf(answer.getAnswer());
                    ss = Integer.valueOf(answer.getAnswer());
                }
                //获取题目答案    获取题目选项   选项得分
                TopicInfo topicInfo = topicInfoMapper.selectById(answer.getQuesId());
                String item = answer.getItem();
                //取出选中的选项
                examResult.setInfoid(answer.getQuesId().intValue());
                examResult.setStuid(record.getStuid().intValue());
                examResult.setPaperid(record.getPaperid().intValue());
                examResult.setType(0);
                examResult.setRightAnswer(topicInfo.getCorrect());
                switch (item) {
                    case "item0":
                        examResult.setAnswer("A");
                        break;
                    case "item1":
                        examResult.setAnswer("B");
                        break;
                    case "item2":
                        examResult.setAnswer("C");
                        break;
                    case "item3":
                        examResult.setAnswer("D");
                        break;
                    default:
                        examResult.setAnswer("A");
                }
                examResult.setSum(ss);
                examResultMapper.insertExamResult(examResult);
            }
        }
        //更新考试记录的成绩
        ExamRecord examRecord = new ExamRecord();
        examRecord.setId(recordId);
        examRecord.setScore(sum);
        //考试完成
        examRecord.setState(1);
        examRecord.setCreatetime(new Date());
        examRecordMapper.updateById(examRecord);
    }

    @Override
    public List<ExamRecordVo> selectExamRecordVoList(Map<String, Object> condition) {
        return examRecordMapper.selectExamRecordVoList(condition);
    }

    @Override
    public void selectResultDataGrid(PageInfo pageInfo) {
        Page<Map<String, Object>> page = new Page<Map<String, Object>>(pageInfo.getNowpage(), pageInfo.getSize());
        page.setOrderByField(pageInfo.getSort());
        page.setAsc(pageInfo.getOrder().equalsIgnoreCase("asc"));
        List<Map<String, Object>> list = examResultMapper.selectExamResultPage(page, pageInfo.getCondition());
        //查询每一项信息
        for (int i = 0; i < list.size(); i++) {
            Map<String, Object> map = list.get(i);
            int tid = Integer.parseInt(map.get("tid") + "");
            Map<String, Object> info = examResultMapper.selectExamResultInfo(tid);
            map.put("a", info.get("A"));
            map.put("b", info.get("B"));
            map.put("c", info.get("C"));
            map.put("d", info.get("D"));
        }
        //获取试题类型
        pageInfo.setRows(list);
        pageInfo.setTotal(page.getTotal());
    }

    @Override
    public Map<String, Object> getQuestionsList(int pageSize, int pageNumber, String stuno, int paperId) {
        Map<String, Object> map = new HashMap<>();
        map.put("pageSize", pageSize);
        map.put("pageNumber", (pageNumber - 1) * pageSize);
        Map params = new HashMap();
        params.put("stuno", stuno);
        Student student = studentMapper.getStudentInfo(params);
        map.put("stuno", student.getId());
        map.put("paperid", paperId);
        List<Map<String, Object>> examResults = examResultMapper.getQuestionsList(map);
        //查询每一项信息
        for (int i = 0; i < examResults.size(); i++) {
            Map<String, Object> map1 = examResults.get(i);
            int tid = Integer.parseInt(map1.get("tid") + "");
            Map<String, Object> info = examResultMapper.selectExamResultInfo(tid);
            map1.put("a", info.get("A"));
            map1.put("b", info.get("B"));
            map1.put("c", info.get("C"));
            map1.put("d", info.get("D"));
        }
        int len = examResultMapper.getQuestionsCount(map);
        Map<String, Object> result = new HashMap<>();
        result.put("list", examResults);
        result.put("len", len);
        return result;
    }

    @Override
    public Map<String, Object> getLastPaperBystuno(String stuno) {
        Map<String, Object> params = new HashMap<>();
        params.put("stuno", stuno);
        Student student = studentMapper.getStudentInfo(params);
        Map<String, Object> map = examResultMapper.getLastPaper(Integer.parseInt(student.getId()+""));
        return map;
    }

    private String sortChar(String str) {
        // 1.将字符串转化成数组
        char[] chs = str.toCharArray();
        // 2.对数组进行排序
        Arrays.sort(chs);
        // 3.将数组转成字符串
        return new String(chs);
    }

}
