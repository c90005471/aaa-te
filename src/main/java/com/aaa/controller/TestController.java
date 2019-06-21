package com.aaa.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import org.apache.shiro.authz.annotation.RequiresRoles;
import org.springframework.core.io.Resource;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.aaa.commons.base.BaseController;
import com.aaa.model.Question;

/**
 * @description：测试Controller
 * @author：aaa.teacher
 * @date：2017/10/1 14:51
 */
@Controller
@RequestMapping("/test")
public class TestController extends BaseController {
	
	@RequestMapping("/question")
	public  String  toQuestionPage() {
		return "front/question";

	}
	@RequestMapping("/findQuestionByPlanId")
	@ResponseBody
	public  List<Question> findQuestionByPlanId() {
		 List<Question> questionList= new ArrayList<Question>();
		 Question q1= new Question(1L,"下丘脑与腺垂体之间主要通过下列哪条途径联系？","神经纤维;神经纤维和门脉系统;垂体门脉系统;垂体束;轴浆运输","c");
		 Question q2= new Question(1L,"aa下丘脑与腺垂体之间主要通过下列哪条途径联系？","cc神经纤维;神经纤维和门脉系统;垂体门脉系统;垂体束;轴浆运输","c");
		 questionList.add(q1);
		 questionList.add(q2);
		 return questionList;
	}

    /**
     * 图标测试
     * 
     * @RequiresRoles shiro 权限注解
     * 
     * @return
     */
    @RequiresRoles("test")
    @GetMapping("/dataGrid")
    public String dataGrid() {
        return "admin/test";
    }

    /**
     * 下载测试
     * @return
     */
    @GetMapping("/down")
    public ResponseEntity<Resource> down() {
        File file = new File("/Users/lcm/Downloads/归档.zip");
        return download(file);
    }
}
