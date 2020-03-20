package com.aaa.controller;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
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
import org.springframework.web.servlet.ModelAndView;

import com.aaa.commons.base.BaseController;
import com.aaa.commons.result.PageInfo;
import com.aaa.model.TblClass;
import com.aaa.service.IStudentCompanyService;
import com.aaa.service.ITblClassService;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author chenjian
 * @since 2017-09-13
 */
@Controller
@RequestMapping("/tblClass")
public class TblClassController extends BaseController {

    @Autowired private ITblClassService tblClassService;
    @Autowired private IStudentCompanyService studentCompanyService;
    @GetMapping("/manager")
    public ModelAndView manager(String flag) {
    	ModelAndView mv = new ModelAndView();
    	if(StringUtils.isNotBlank(flag)){
    		mv.setViewName("admin/tblClass/tblClassByList");
    		mv.addObject("flag", flag);
    	}else{
    		mv.setViewName("admin/tblClass/tblClassList");
    	}
        return mv;
    }
    
    
    /**
     * 班级列表
     *
     * @return
     */
    @RequestMapping("/treeGrid")
    @ResponseBody
    public Object treeGrid(String flag) {
        return tblClassService.selectTreeGrid(flag);
    }
    /**
     * 班级树
     *
     * @return
     */
    @RequestMapping("/tree")
    @ResponseBody
    public Object tree(String flag) {
    	return tblClassService.selectTree(flag);
    }


    @PostMapping("/dataGrid")
    @ResponseBody
    public PageInfo dataGrid(TblClass tblClass, Integer page, Integer rows, String sort,String order) {
        PageInfo pageInfo = new PageInfo(page, rows, sort, order);
        tblClassService.selectDataGrid(pageInfo);
        return pageInfo;
    }
    
    /**
     * 添加页面
     * @return
     */
    @GetMapping("/addPage")
    public String addPage() {
        return "admin/tblClass/tblClassAdd";
    }
    
    /**
     * 添加
     * @param 
     * @return
     */
    @PostMapping("/add")
    @ResponseBody
    public Object add(@Valid TblClass tblClass) {
        tblClass.setCreatetime(new Date());
        try {
        	  tblClassService.insertTblClass(tblClass);
        	  return renderSuccess("添加成功！");
		} catch (Exception e) {
			 return renderError("添加失败！"+e);
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
        try {
        	tblClassService.deleteById(id);
        	 return renderSuccess("删除成功！");
		} catch (Exception e) {
			return renderError("删除失败！"+e);
		}
    }
    
    /**
     * 编辑
     * @param model
     * @param id
     * @return
     */
    @GetMapping("/editPage")
    public String editPage(Model model, Long id,String flage) {
    	TblClass tblClass = tblClassService.selectClassById(id);
        model.addAttribute("tblClass", tblClass);
    	if(StringUtils.isNotBlank(flage)){
    		//获取毕业信息
    		List<Map<String,Object>> list = studentCompanyService.selectStudentComByClassId(id);
    		if(list!=null&&list.size()>0){
    			model.addAttribute("stucomMap", list.get(0));
    		}
    		  return "admin/tblClass/tblClassDetail";
    	}
        return "admin/tblClass/tblClassEdit";
    }
    
    /**
     * 编辑
     * @param 
     * @return
     */
    @PostMapping("/edit")
    @ResponseBody
    public Object edit(@Valid TblClass tblClass) {
        tblClass.setCreatetime(new Date());
        try {
        	tblClassService.updateClassById(tblClass,getUserId());
        	 return renderSuccess("编辑成功！");
		} catch (Exception e) {
			System.out.println(e);
			 return renderError("编辑失败！");
		}
    }
    /**
     * 检查班级名称是否重复
     * @param id 班级id
     * @param classname 输入的班级名称
     * @return
     */
    @RequestMapping("/chekcClassName")
    @ResponseBody
    public Object checkClassName(Long id,String classname){
    	boolean flag = false;
    	List<TblClass> list = tblClassService.selectByClassname(classname);
    	//判断班级名称是否在数据库中
		if(list==null||list.size()==0){
			return true;
		}
    	if(id!=null){
    		if(list!=null&&list.size()>0){
    			if(list.size()==1&&id.equals(list.get(0).getId())){
    				return true;
    			}else{
    				return flag;
    			}
    		}
    	}
    	return flag;
    }

    /**
     * 组织树
     * @return
     */
    @RequestMapping("/organizationTree")
    @ResponseBody
    public Object organizationTree(String flag) {
        return tblClassService.organizationTree(flag);
    }

    /**
     * 根据组织查询班级树
     *
     * @return
     */
    @RequestMapping("/getTree")
    @ResponseBody
    public Object getTree(int orgid) {
        return tblClassService.getTree(orgid);
    }
}
