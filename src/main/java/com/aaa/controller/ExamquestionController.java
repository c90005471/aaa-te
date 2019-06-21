package com.aaa.controller;

import javax.validation.Valid;

import java.util.HashMap;
import java.util.List;
import java.util.Date;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.plugins.Page;
import com.aaa.commons.result.PageInfo;
import com.aaa.commons.utils.StringUtils;
import com.aaa.model.Examquestion;
import com.aaa.service.IExamquestionService;
import com.aaa.commons.base.BaseController;

/**
 * 考试题库管理 控制层
 * <p>
 *  前端控制器
 * </p>
 *
 * @author xuhui
 * @since 2017-12-05
 */
@Controller
@RequestMapping("/examquestion")
public class ExamquestionController extends BaseController {

    @Autowired private IExamquestionService examquestionService;
    
    @GetMapping("/manager")
    public String manager() {
        return "admin/examquestion/examquestionList";
    }
    
    @PostMapping("/dataGrid")
    @ResponseBody
    public PageInfo dataGrid(Examquestion examquestion, Integer page, Integer rows, String sort,String order) {
    	PageInfo pageInfo = new PageInfo(page, rows, sort, order);
        Map<String, Object> condition = new HashMap<String, Object>();
        //将查询条件放入condition集合
        /*if (StringUtils.isNotBlank(examquestion.getCourseid()+"")) {
            condition.put("typeId", examquestion.getCourseid());
        }*/
        /*if(StringUtils.isNotBlank(examquestion.getItem())){
        	condition.put("item", examquestion.getItem());
        }*/
        pageInfo.setCondition(condition);
        examquestionService.selectDataGird(pageInfo);
        return pageInfo;
    }
    
    /**
     * 添加页面
     * @return
     */
    @GetMapping("/addPage")
    public String addPage() {
        return "admin/examquestion/examquestionAdd";
    }
    
    /**
     * 添加
     * @param 
     * @return
     */
    /*@PostMapping("/add")
    @ResponseBody
    public Object add(@Valid Examquestion examquestion) {
        examquestion.setCreateTime(new Date());
        examquestion.setUpdateTime(new Date());
        examquestion.setDeleteFlag(0);
        boolean b = examquestionService.insert(examquestion);
        if (b) {
            return renderSuccess("添加成功！");
        } else {
            return renderError("添加失败！");
        }
    }*/
    
    /**
     * 删除
     * @param id
     * @return
     */
    /*@PostMapping("/delete")
    @ResponseBody
    public Object delete(Long id) {
        Examquestion examquestion = new Examquestion();
        examquestion.setId(id);
        examquestion.setUpdateTime(new Date());
        examquestion.setDeleteFlag(1);
        boolean b = examquestionService.updateById(examquestion);
        if (b) {
            return renderSuccess("删除成功！");
        } else {
            return renderError("删除失败！");
        }
    }*/
    
    /**
     * 编辑
     * @param model
     * @param id
     * @return
     */
    @GetMapping("/editPage")
    public String editPage(Model model, Long id) {
        Examquestion examquestion = examquestionService.selectById(id);
        model.addAttribute("examquestion", examquestion);
        return "admin/examquestion/examquestionEdit";
    }
    
    /**
     * 编辑
     * @param 
     * @return
     */
    /*@PostMapping("/edit")
    @ResponseBody
    public Object edit(@Valid Examquestion examquestion) {
        examquestion.setUpdateTime(new Date());
        boolean b = examquestionService.updateById(examquestion);
        if (b) {
            return renderSuccess("编辑成功！");
        } else {
            return renderError("编辑失败！");
        }
    }*/
}
