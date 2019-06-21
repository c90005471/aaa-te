package com.aaa.controller;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.validation.Valid;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
	
import com.aaa.commons.base.BaseController;
import com.aaa.commons.result.PageInfo;
import com.aaa.model.Student;
import com.aaa.model.StudentCompany;
import com.aaa.model.TblSclInterview;
import com.aaa.model.TblSclRecorddetail;
import com.aaa.service.IStudentService;
import com.aaa.service.ITblSclInterviewService;
import com.aaa.service.ITblSclRecordProbdetailService;
/**
 *@className:TblSclRecordProbdetailController.java
 *@discriptions:
 *@author:徐辉
 *@createTime:2017-11-30下午8:14:07
 *@version:1.0.0
 *
 *<p>
 *  前端控制器
 *</p>
 */
@Controller
@RequestMapping("/tblSclRecordProbdetail")
public class TblSclRecordProbdetailController extends BaseController{
	@Autowired ITblSclRecordProbdetailService tblSclRecordProbdetailService;
	
	@Autowired 
	ITblSclInterviewService tblSclInterviewService;
	@Autowired private IStudentService studentService;
	/**
	 * 跳转问题学生页面
	 * @param model
	 * @param studentid
	 * @param createtime
	 * @return
	 */
	@GetMapping("/manager")
    public String manager(Model model,String studentid,String createtime) {
    	model.addAttribute("studentid", studentid);
    	model.addAttribute("createtime", createtime);
        return "admin/tblSclRecordProbdetail/tblSclRecordProbdetailList";
    }
	/**
	 * 列表  回调方法获取列表信息
	 * @param tblSclRecorddetail
	 * @param page
	 * @param rows
	 * @param sort
	 * @param order
	 * @param studentid
	 * @param createtime
	 * @return
	 */
	@PostMapping("/dataGrid")
    @ResponseBody
    public PageInfo dataGrid(TblSclRecorddetail tblSclRecorddetail, Integer page, Integer rows, String sort,String order,String studentid,String createtime) {
        PageInfo pageInfo = new PageInfo(page, rows, sort, order);
        Map<String, Object> condition = new HashMap<String, Object>();
        if (tblSclRecorddetail != null) {
			if (studentid != null) {
				condition.put("studentid", studentid);
				condition.put("createtime", createtime);
			}
		}
        pageInfo.setCondition(condition);
        tblSclRecordProbdetailService.selectProbDataGrid(pageInfo);
        return pageInfo;
    }
	/**
	 * 跳转访谈记录页面
	 * @param model
	 * @param studentid
	 * @param createtime
	 * @return
	 */
	@GetMapping("/showCountPage")
    public String showCountPage(Model model,String studentid,String createtime,String classid) {
    	model.addAttribute("studentid", studentid);
    	model.addAttribute("createtime", createtime);
    	model.addAttribute("classid", classid);
        return "admin/tblSclRecordProbdetail/tblSclRecordProbdetailHistory";
    }
	/**
	 * 访谈记录页面列表回调方法
	 * @param tblSclRecorddetail
	 * @param page
	 * @param rows
	 * @param sort
	 * @param order
	 * @param studentid
	 * @param createtime
	 * @return
	 */
	@PostMapping("/tblSclRecordProlemHistory")
    @ResponseBody
    public PageInfo tblSclRecordProlemHistory(TblSclRecorddetail tblSclRecorddetail, Integer page, Integer rows, String sort,String order,String studentid,String createtime) {
        PageInfo pageInfo = new PageInfo(page, rows, sort, order);
        Map<String, Object> condition = new HashMap<String, Object>();
        if (tblSclRecorddetail != null) {
			if (studentid != null) {
				condition.put("studentid", studentid);
				condition.put("createtime", createtime);
			}
		}
        pageInfo.setCondition(condition);
        tblSclRecordProbdetailService.selectProbInterview(pageInfo);
        return pageInfo;
	}
	/**
	 * 访谈记录列表跳转添加页面
	 */
    @GetMapping("/addPage")
    public String addPage(Model model,String classid,String studentid) {
    	model.addAttribute("classid", classid);
    	model.addAttribute("studentid", studentid);
    	//获取学生姓名
    	if(StringUtils.isNotEmpty(studentid)){
    		Long id = Long.valueOf(studentid);
    		Map<String, Object> selectStuById = studentService.selectStuById(id);
    		
    		model.addAttribute("stuname", selectStuById.get("stuname"));
    	}
        return "admin/tblSclRecordProbdetail/tblSclRecordProbdetailHistoryAdd";
    }
    
    /**
     * 添加
     * @param 
     * @return
     */
    @PostMapping("/add")
    @ResponseBody
    public Object add(@Valid TblSclInterview tblSclInterview) {
    	tblSclInterview.setCreatetime(new Date());
        boolean b = tblSclInterviewService.insert(tblSclInterview);
        if (b) {
            return renderSuccess("添加成功！");
        } else {
            return renderError("添加失败！");
        }
    }
    
    /**
     * 编辑
     * @param model
     * @param id
     * @return
     */
    @GetMapping("/editPage")
    public String editPage(Model model, Long id,String classid) {
        Map<String, Object> selectTblSclInterviewById = tblSclInterviewService.selectTblSclInterviewById(id);
        model.addAttribute("tblSclInterview", selectTblSclInterviewById);
        model.addAttribute("classid", classid);
        return "admin/tblSclRecordProbdetail/tblSclRecordProbdetailHistoryEdit";
    }
    
    /**
     * 编辑
     * @param 
     * @return
     */
    @PostMapping("/edit")
    @ResponseBody
    public Object edit(@Valid TblSclInterview tblSclInterview) {
    	tblSclInterview.setCreatetime(new Date());
        boolean b = tblSclInterviewService.updateTblSclInterviewById(tblSclInterview);
        if (b) {
            return renderSuccess("编辑成功！");
        } else {
            return renderError("编辑失败！");
        }
    }
    
    /**
     * 删除
     * @param id
     * @return
     */
    @PostMapping("/delete")
    @ResponseBody
    public Object delete(Long id) {
        boolean b = tblSclInterviewService.deleteById(id);
        if (b) {
            return renderSuccess("删除成功！");
        } else {
            return renderError("删除失败！");
        }
    }
}
