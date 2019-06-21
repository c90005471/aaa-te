package com.aaa.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import com.aaa.commons.result.PageInfo;
import com.aaa.model.Examquestion;
import com.aaa.mapper.ExamquestionMapper;
import com.aaa.service.IExamquestionService;
import com.baomidou.mybatisplus.plugins.Page;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author xuhui
 * @since 2017-12-05
 */
@Service
public class ExamquestionServiceImpl extends ServiceImpl<ExamquestionMapper, Examquestion> implements IExamquestionService {
	
	@Resource(name="examquestionMapper")
	private ExamquestionMapper examquestionMapper;
	/**
	 * 考试题库
	 * 进行查询和分页
	 * 将总条数和每页的数据集合放入pageInfo
	 * @param pageInfo
	 */
	@Override
	public void selectDataGird(PageInfo pageInfo) {
		Page<Map<String, Object>> page = new Page<Map<String, Object>>(pageInfo.getNowpage(), pageInfo.getSize());
        page.setOrderByField(pageInfo.getSort());
        page.setAsc(pageInfo.getOrder().equalsIgnoreCase("asc"));
        List<Map<String, Object>> list = examquestionMapper.selectExamquestionPage(page, pageInfo.getCondition());
        pageInfo.setRows(list);
        pageInfo.setTotal(page.getTotal());
        
	}
	
}
