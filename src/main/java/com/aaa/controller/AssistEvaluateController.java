package com.aaa.controller;

import java.io.UnsupportedEncodingException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.aaa.commons.base.BaseController;
import com.aaa.model.AssistPlan;
import com.aaa.service.IAssistPlanService;
import com.aaa.service.IAssplanStudentService;

/**
 * 类名称：RssistEvaluateController
 * 类描述： 帮扶计划统计
 * 创建人：sunshaoshan
 * 创建时间：2018-2-2 下午2:11:17
 * @version
 */
@Controller                                                                     
@RequestMapping("/assistEvaluate") 
public class AssistEvaluateController extends BaseController{
	@Autowired 
    private IAssistPlanService assistPlanService;
	@Autowired
	private IAssplanStudentService assplanStudentService;
	/**
	 * 跳转统计页面
	 * @return
	 */
	@GetMapping("/manager")                                                     
    public String manager() {                                                   
        return "admin/assistEvaluate/assistEvaluateList";                             
    }
	
	
	/**                                                                         
     * 查看详情                                                                  
     * @param model                                                             
     * @param id                                                                
     * @return                                                                  
     */                                                                         
    @GetMapping("/showDetailPage")                                              
    public String editPage(Model model, Long id,String classname,String createname) {             
    	//获取帮扶计划信息
		AssistPlan assistPlan = assistPlanService.selectById(id);
		//获取帮扶计划学生的学生信息
		String stunames = assplanStudentService.findStunameByAssistId(id);
		String teacherName = assplanStudentService.findTeacherName(assistPlan.getCreator());
	    model.addAttribute("assistPlan", assistPlan);
	    model.addAttribute("stunames", stunames);
	    model.addAttribute("classname", classname);    
	    model.addAttribute("createname", teacherName);   
        return "admin/assistEvaluate/showDetail";                                  
    }
	
}
