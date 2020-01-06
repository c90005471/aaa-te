package com.aaa.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.validation.Valid;

import com.aaa.service.ITblClassService;
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
import com.aaa.model.Role;
import com.aaa.model.vo.TeaQuestionVo;
import com.aaa.service.ITeaQuestionService;

/**
 * @title: TeaQuestionController
 * @Description:
 * @Company:AAA
 * @Date 2017-9-20 下午4:05:37
 * @author 万舒萌
 */
@Controller
@RequestMapping("/teacherQuestion")
public class TeaQuestionController extends BaseController{
	@Autowired
	private ITeaQuestionService teaQuestionService;
	@Autowired
    private ITblClassService tblClassService;
	
	/**
	 * 教师考核点管理页面
	 * @return
	 */
	@GetMapping("/manager")
    public String manager() {
        return "admin/TeaQuestion/teaQuestion";
    }
	
	@GetMapping("/TeacherQuestion")
    public String TeacherQuestion() {
        return "front/tealogin";
    }
	/**
	 * 教师考核点管理列表
	 * @param page
	 * @param rows
	 * @param sort
	 * @param order
	 * @return
	 */
	@PostMapping("/dataGrid")
    @ResponseBody
    public Object dataGrid(Integer page, Integer rows, String sort, String order) {
        PageInfo pageInfo = new PageInfo(page, rows, sort, order);
        Map<String, Object> condition = new HashMap<String, Object>();
        pageInfo.setCondition(condition);
        teaQuestionService.selectDataGrid(pageInfo);
        return pageInfo;
    }

    /**
     * 添加教师考核点页面
     * @return
     */
    @GetMapping("/addPage")
    public String addPage() {
        return "admin/TeaQuestion/teaQuestionAdd";
    }

    /**
     * 添加教师考核点
     * @param teaQuestionVo
     * @return
     */
    @PostMapping("/add")
    @ResponseBody
    public Object add(@Valid TeaQuestionVo teaQuestionVo) {
        teaQuestionService.insertQuestionByVo(teaQuestionVo);
        return renderSuccess("添加成功");
    }

    /**
     * 编辑教师考核点页面
     * @param model
     * @param id
     * @return
     */
    @GetMapping("/editPage")
    public String editPage(Model model, Long id) {
        TeaQuestionVo questionVo = teaQuestionService.selectQuestionVoById(id);
        //查询出教师考评点所属的角色信息
        List<Role> rolesList = questionVo.getRolesList();
        List<Long> ids = new ArrayList<Long>();
        for (Role role : rolesList) {
            ids.add(role.getId());
        }
        //查询出考评点所属的校区信息
        List<Map<String, Object>> mapList = tblClassService.questionAndOrganTree(id);
        List<Long> oids = new ArrayList<Long>();
        if (mapList != null && mapList.size() > 0){
            for (int i = 0; i < mapList.size(); i++) {
                oids.add(Long.parseLong(mapList.get(i).get("oid") + ""));
            }
        }
        model.addAttribute("roleIds", ids);
        model.addAttribute("organIds", oids);
        model.addAttribute("QuestionVo", questionVo);
        return "admin/TeaQuestion/teaQuestionEdit";
    }

    /**
     * 编辑教师考核点
     * @param teaQuestionVo
     * @return
     */
    @RequiresRoles("admin")
    @PostMapping("/edit")
    @ResponseBody
    public Object edit(@Valid TeaQuestionVo teaQuestionVo) {
        teaQuestionService.updateQuestionByVo(teaQuestionVo);
        return renderSuccess("修改成功！");
    }

    /**
     * 删除教师考核点
     * @param id
     * @return
     */
    @RequiresRoles("admin")
    @PostMapping("/delete")
    @ResponseBody
    public Object delete(Long id) {
        Long currentUserId = getUserId();
        if (id == currentUserId) {
            return renderError("不可以删除自己！");
        }
        teaQuestionService.deleteById(id);
        return renderSuccess("删除成功！");
    }
}
