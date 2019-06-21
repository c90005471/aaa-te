package com.aaa.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.validation.Valid;

import org.apache.shiro.authz.annotation.RequiresRoles;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.aaa.commons.base.BaseController;
import com.aaa.commons.result.PageInfo;
import com.aaa.commons.utils.StringUtils;
import com.aaa.model.Role;
import com.aaa.model.TestQuestion;
import com.aaa.model.TestQuestionRecord;
import com.aaa.model.User;
import com.aaa.model.vo.UserVo;
import com.aaa.service.ITestQuestionRecordService;
import com.aaa.service.ITestQuestionService;
/**
 * 类名称：TestQuestionController
 * 类描述： 入学考试记录前段控制器
 * 创建人：sunshaoshan
 * 创建时间：2018-5-14 下午2:46:37
 * @version
 */
@Controller
@RequestMapping("/testQuesRecord")
public class TestQuestionRecordController extends BaseController{
	@Autowired
	private ITestQuestionRecordService testQuestionRecordService;
	/**
     * 试题列表页面
     * @return
     */
    @GetMapping("/manager")
    public String manager() {
        return "admin/testquesRecord/testquesRecord";
    }
    
    /**
     * 试题管理列表
     * @return
     */
    @PostMapping("/dataGrid")
    @ResponseBody
    public Object dataGrid(Integer page, Integer rows, String sort, String order,TestQuestionRecord testQuestionRecord) {
        PageInfo pageInfo = new PageInfo(page, rows, sort, order);
        Map<String, Object> condition = new HashMap<String, Object>();
        if (StringUtils.isNotBlank(testQuestionRecord.getStuname())) {
            condition.put("stuname", testQuestionRecord.getStuname());
        }
        if(StringUtils.isNotBlank(testQuestionRecord.getStuphone())){
        	condition.put("stuphone", testQuestionRecord.getStuphone());
        }
        pageInfo.setCondition(condition);
        testQuestionRecordService.selectDataGrid(pageInfo);
        return pageInfo;
    }
}
