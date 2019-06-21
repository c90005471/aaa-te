package com.aaa.controller;

import java.io.InputStream;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedHashMap;
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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.aaa.commons.base.BaseController;
import com.aaa.commons.shiro.ShiroUser;
import com.aaa.commons.utils.ConstantUtils;
import com.aaa.commons.utils.ExcelUitl;
import com.aaa.model.Course;
import com.aaa.model.Resource;
import com.aaa.model.Student;
import com.aaa.model.StudentCompany;
import com.aaa.model.vo.CourseVo;
import com.aaa.model.vo.StudentCompanyVo;
import com.aaa.service.ICourseService;
import com.aaa.service.IResourceService;
import com.baomidou.mybatisplus.mapper.EntityWrapper;

/**
 * @description：课程管理
 * @author：aaa.teacher
 * @date：2017/10/1 14:51
 */
@Controller
@RequestMapping("/course")
public class CourseController extends BaseController {

    @Autowired
    private ICourseService courseService;

    /**
     * 菜单树
     *
     * @return
     */
    @PostMapping("/tree")
    @ResponseBody
    public Object tree(Long orgid) {
        ShiroUser shiroUser = getShiroUser();
        return courseService.selectTree(shiroUser,orgid,"");
    }

    /**
     * 课程管理页
     *
     * @return
     */
    @GetMapping("/manager")
    public String manager(Model model) {
    	//获取课程分组
    	List<Map> list = courseService.selectListByGroup();
    	model.addAttribute("map", list);
        return "admin/course/course";
    }

    /**
     * 资源管理列表
     *
     * @return
     */
    @RequestMapping("/treeGrid")
    @ResponseBody
    public Object treeGrid(Integer organizationId,String name,String version) {
    	EntityWrapper<Course> wrapper = new EntityWrapper<Course>();
		Course course = new Course();
		wrapper.setEntity(course);
		wrapper.in("course_type",ConstantUtils.ZZDLX);//知识点类型
		if(StringUtils.isNotBlank(name)){
			wrapper.like("course_name", name);// 添加过滤条件
		}
    	//如果组织id不为空，则按照id进行查询，否则查询所有
		if (organizationId != null) {
			wrapper.addFilter("orgId = {0}", organizationId);// 添加过滤条件
		} else {
			wrapper.addFilter("orgId = {0}", ConstantUtils.YJ_ORGID);// 默认显示杨金路校区的信息
			wrapper.addFilter("course_version = {0}", version);// 显示最新的课程体系
		}
		//若选择的是杨金路校区
		if(organizationId==Integer.valueOf(ConstantUtils.YJ_ORGID)){
			wrapper.addFilter("course_version = {0}", version);// 显示最新的课程体系
		}
		wrapper.orderBy("seq");//默认按照页面排序的编号排序
		return courseService.selectList(wrapper);
    }

    /**
     * 添加资源页
     *
     * @return
     */
    @GetMapping("/addPage")
    public String addPage() {
        return "admin/course/courseAdd";
    }

    /**
     * 添加资源
     *
     * @param resource
     * @return
     */
    @RequestMapping("/add")
    @ResponseBody
    public Object add(@Valid Course course) {
    	course.setCreateTime(new Date());
        courseService.insert(course);
        return renderSuccess("添加成功！");
    }

    /**
     * 查询所有的菜单
     */
    @RequestMapping("/allTree")
    @ResponseBody
    public Object allMenu(Long orgid,Integer coursetype) {
        return courseService.selectAllMenu(orgid,coursetype);
    }

    /**
     * 查询所有的资源tree
     */
    @RequestMapping("/allTrees")
    @ResponseBody
    public Object allTree() {
        return courseService.selectAllTree();
    }

    /**
     * 编辑资源页
     *
     * @param model
     * @param id
     * @return
     */
    @RequestMapping("/editPage")
    public String editPage(Model model, Long id) {
        Course course = courseService.selectById(id);
        model.addAttribute("course", course);
        return "admin/course/courseEdit";
    }

    /**
     * 编辑资源
     *
     * @param resource
     * @return
     */
    @RequestMapping("/edit")
    @ResponseBody
    public Object edit(@Valid Course course) {
    	courseService.updateById(course);
        return renderSuccess("编辑成功！");
    }

    /**
     * 删除资源
     *
     * @param id
     * @return
     */
    @RequestMapping("/delete")
    @ResponseBody
    public Object delete(Long id) {
    	courseService.deleteCourseById(id);
        return renderSuccess("删除成功！");
    }
    @GetMapping("/addManyCourse")
    public String addManyPage(Long orgId,Model model) {
    	//flag为标识导入毕业信息
    	model.addAttribute("orgId",orgId);
    	return "admin/course/courseAddMany";
    }
    
    /**
     * 批量导入学生
     * flag 标识导入的是学生毕业信息
     * @throws Exception 
     */
    @SuppressWarnings("unused")
	@RequestMapping("/importExcelcourseByOrgId")
    @ResponseBody
    public Object  importExcelcourseByOrgId(Integer orgId,@RequestParam MultipartFile mf) throws Exception{
    	/*System.out.println(stuList);
    	System.out.println(mf.getName());*/
    	LinkedHashMap<String,String> map = new LinkedHashMap<String,String>();
    	InputStream in = mf.getInputStream();
    	
    	map.put("weeks", "周次");
    	map.put("coursecode", "课程代码");
    	map.put("coursename", "课程名称");
    	map.put("zcoursecode", "授课内容");
    	map.put("stage","所属阶段");
    	map.put("zcoursecotent", "内容");
    	map.put("coursepoints", "知识点");
    	List<CourseVo> excelToList = ExcelUitl.excelToList(in, "JavaEE专业课表", CourseVo.class, map, null);
    	boolean b = courseService.batchAddCource(excelToList,orgId);
    	if (b) {
            return renderSuccess("批量添加成功！");
        } else {
            return renderError("课表格式有误,添加失败！");
        }
    }
}
