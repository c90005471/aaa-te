package com.aaa.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.aaa.commons.result.PageInfo;
import com.aaa.commons.utils.ConstantUtils;
import com.aaa.mapper.TestQuestionRecordMapper;
import com.aaa.model.TestQuestionRecord;
import com.aaa.service.ITestQuestionRecordService;
import com.baomidou.mybatisplus.plugins.Page;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
@Service
public class TestQuestionRecordServiceImpl extends ServiceImpl<TestQuestionRecordMapper, TestQuestionRecord> implements ITestQuestionRecordService {
	@Autowired
	private TestQuestionRecordMapper testQuestionRecordMapper;

	@Override
	public void selectDataGrid(PageInfo pageInfo) {
		Page<Map<String, Object>> page = new Page<Map<String, Object>>(pageInfo.getNowpage(), pageInfo.getSize());
        page.setOrderByField(pageInfo.getSort());
        page.setAsc(pageInfo.getOrder().equalsIgnoreCase("asc"));
        List<Map<String, Object>> list = testQuestionRecordMapper.selectTestQuestionRecordPage(page, pageInfo.getCondition());
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

}
