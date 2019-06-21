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
import com.aaa.commons.utils.ConstantUtils;
import com.aaa.commons.utils.StringUtils;
import com.aaa.model.Role;
import com.aaa.model.TestQuestion;
import com.aaa.model.User;
import com.aaa.model.vo.UserVo;
import com.aaa.service.ITestQuestionService;
/**
 * 类名称：TestQuestionController
 * 类描述： 入学考试前段控制器
 * 创建人：sunshaoshan
 * 创建时间：2018-5-11 下午2:46:37
 * @version
 */
@Controller
@RequestMapping("/testQues")
public class TestQuestionController extends BaseController{
	@Autowired
	private ITestQuestionService testQuestionService;
	/**
     * 试题列表页面
     * @return
     */
    @GetMapping("/manager")
    public String manager(Model model) {
    	//试题类型
        Map<Integer,String> typeMap = ConstantUtils.QUESTIONTYPEMAP;
    	model.addAttribute("typeMap", typeMap);
        return "admin/testques/testques";
    }
    
    /**
     * 试题管理列表
     * @return
     */
    @PostMapping("/dataGrid")
    @ResponseBody
    public Object dataGrid(Integer page, Integer rows, String sort, String order,String questype,String quesname) {
        PageInfo pageInfo = new PageInfo(page, rows, sort, order);
        Map<String, Object> condition = new HashMap<String, Object>();
        if (StringUtils.isNotBlank(quesname)) {
            condition.put("quesname", quesname);
        }
        if (StringUtils.isNotBlank(questype)) {
            condition.put("questype", questype);
        }
        pageInfo.setCondition(condition);
        testQuestionService.selectDataGrid(pageInfo);
        return pageInfo;
    }
    /**
     * 添加试题页
     *
     */
    @GetMapping("/addPage")
    public String addPage(Model model) {
    	//题目类型
    	Map<Integer,String> typeMap = ConstantUtils.QUESTIONTYPEMAP;
    	model.addAttribute("typeMap", typeMap);
    	//试题类型
    	Map<Integer,String> types = ConstantUtils.TYPEMAP;
    	model.addAttribute("types", types);
        return "admin/testques/testQuesAdd";
    }
    
    /**
     * 添加试题内容和选项
     * @return
     */
    @PostMapping("/add")
    @ResponseBody
    public Object add(TestQuestion ques,String[] option,String score) {
        testQuestionService.insertQuestionAndOption(ques,option,score);
        return renderSuccess("添加成功");
    }
    
    /**
     * 编辑试题信息页
     *
     * @param id
     * @return
     */
    @GetMapping("/editPage")
    public String editPage(Model model, Long id) {
        Map<String,Object> map = testQuestionService.selectTestQuesAndOption(id);
        model.addAttribute("testQuestion", map.get("testQuestion"));
        model.addAttribute("optionList", map.get("optionList"));
        model.addAttribute("scores", map.get("scores"));
        //题目类型
        Map<Integer,String> typeMap = ConstantUtils.QUESTIONTYPEMAP;
    	model.addAttribute("typeMap", typeMap);
    	//试题类型
    	Map<Integer,String> types = ConstantUtils.TYPEMAP;
    	model.addAttribute("types", types);
        return "admin/testques/testQuesEdit";
    }
    /**
     * 编辑试题信息页
     */
    @PostMapping("/edit")
    @ResponseBody
    public Object edit(TestQuestion ques,String[] option,String score) {
    	testQuestionService.updateQuestionAndOption(ques,option,score);
        return renderSuccess("修改成功！");
    }
    /**
     * 删除试题
     * @param id
     * @return
     */
    @PostMapping("/delete")
    @ResponseBody
    public Object delete(Long id) {
    	testQuestionService.deleteQuestionAndOption(id);
        return renderSuccess("删除成功！");
    }
}
