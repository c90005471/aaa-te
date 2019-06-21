package com.aaa.controller;

import javax.validation.Valid;

import java.util.HashMap;
import java.util.List;
import java.util.Date;
import java.util.Map;

import javax.validation.Valid;

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
import com.aaa.model.TblProject;
import com.aaa.service.ITblClassService;
import com.aaa.service.ITblProjectService;
import com.aaa.commons.base.BaseController;

/**
 *@description 项目评审信息控制器
 * @author 孙喜才
 * @since 2017-12-04
 */
@Controller
@RequestMapping("/tblProject")
public class TblProjectController extends BaseController {

    @Autowired private ITblProjectService tblProjectService;
    @Autowired private ITblClassService tblClassService;
    
    @GetMapping("/manager")
    public String manager() {
        return "admin/tblProject/tblProjectList";
    }
    
    @PostMapping("/dataGrid")
    @ResponseBody
    public PageInfo dataGrid(TblProject tblProject, Integer page, Integer rows, String sort,String order,String classid,String projectname,String stuname,String projectstage) {
    	PageInfo pageInfo = new PageInfo(page, rows, sort, order);//新建分页信息实体类
        Map<String, Object> condition = new HashMap<String, Object>();//新建存放查询条件的map
        if (tblProject != null) {//添加查询条件
			if (classid != null) {
				condition.put("classid", classid);//添加班级查询条件
			}
			if (stuname != null) {
				condition.put("stuname", stuname);//按照学生姓名查询
			}
			if (projectname != null) {
				condition.put("projectname", projectname);//按照项目名称查询的条件
			}
			if (projectstage != null) {
				condition.put("projectstage",projectstage);//按照项目期数查询的条件
			}
		}
        pageInfo.setCondition(condition);//将查询信息放入到分页信息实体类中
        tblProjectService.selectDataGrid(pageInfo);//调用页面查询健项目管理页面的数据
        return pageInfo;
    }
    
    /**
     * 添加页面
     * @return
     */
    @GetMapping("/addPage")
    public String addPage() {
        return "admin/tblProject/tblProjectAdd";
    }
    /*public String addPage(Model model,String graduateflag) {
    	Map<String,Object> graduateMap=new HashMap<String,Object>();
    	graduateMap.put("graduate", graduateflag);
    	Map<String, Object> classes = tblClassService.selectClass(graduateMap);
        model.addAttribute("classes", classes);
        return "admin/tblProject/tblProjectAdd";
    }*/
    
    /**
     * 添加
     * @param 
     * @return
     */
    @PostMapping("/add")
    @ResponseBody
    public Object add(@Valid TblProject tblProject) {
        /*tblProject.setCreateTime(new Date());
        tblProject.setUpdateTime(new Date());
        tblProject.setDeleteFlag(0);*/
        boolean b = tblProjectService.insert(tblProject);
        if (b) {
            return renderSuccess("添加成功！");
        } else {
            return renderError("添加失败！");
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
        TblProject tblProject = new TblProject();
        tblProject.setId(id);
        /*tblProject.setUpdateTime(new Date());
        tblProject.setDeleteFlag(1);*/
        boolean b = tblProjectService.updateById(tblProject);
        if (b) {
            return renderSuccess("删除成功！");
        } else {
            return renderError("删除失败！");
        }
    }
    
    /**
     * 编辑
     * @param model
     * @param id
     * @return
     */
    @GetMapping("/editPage")
    public String editPage(Model model, Long id) {
        TblProject tblProject = tblProjectService.selectById(id);
        model.addAttribute("tblProject", tblProject);
        return "admin/tblProject/tblProjectEdit";
    }
    
    /**
     * 编辑
     * @param 
     * @return
     */
    @PostMapping("/edit")
    @ResponseBody
    public Object edit(@Valid TblProject tblProject) {
        /*tblProject.setUpdateTime(new Date());*/
        boolean b = tblProjectService.updateById(tblProject);
        if (b) {
            return renderSuccess("编辑成功！");
        } else {
            return renderError("编辑失败！");
        }
    }
}
