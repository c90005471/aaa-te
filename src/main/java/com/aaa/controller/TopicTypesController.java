package com.aaa.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
import com.aaa.model.TopicTypes;
import com.aaa.service.ITopicTypesService;
/**
 * 类名称：TopicTypes
 * 类描述： 题目类型管理
 * 创建人：sunshaoshan
 * 创建时间：2018-7-10 下午2:24:21
 * @version
 */
@Controller
@RequestMapping("/topicTypes")
public class TopicTypesController extends BaseController {
	@Autowired
	private ITopicTypesService topicTypesService;
	/**
     * 题目类型列表页面
     */
    @GetMapping("/manager")
    public String manager(Model model) {
        return "admin/topicType/topicType";
    }
    
    /**
     * 题目类型管理列表
     * @return
     */
    @PostMapping("/dataGrid")
    @ResponseBody
    public Object dataGrid(Integer page, Integer rows, String sort, String order,TopicTypes topicTypes) {
        PageInfo pageInfo = new PageInfo(page, rows, sort, order);
        Map<String, Object> condition = new HashMap<String, Object>();
        if(StringUtils.isNotBlank(topicTypes.getStage())){
        	condition.put("stage", topicTypes.getStage());
        }else{
        	condition.put("stage", "S3");
        }
        if (StringUtils.isNotBlank(topicTypes.getTypename())) {
            condition.put("typename", topicTypes.getTypename());
        }
        condition.put("typestate", 1);
        pageInfo.setCondition(condition);
        topicTypesService.selectDataGrid(pageInfo);
        return pageInfo;
    }
    
    /**
     * 添加题目类型
     */
    @GetMapping("/addPage")
    public String addPage(Model model) {
        return "admin/topicType/topicTypesAdd";
    }
    /**
     * 添加题目类型
     */
    @PostMapping("/add")
    @ResponseBody
    public Object add(TopicTypes topicTypes) {
    	topicTypes.setTypestate(1);
    	topicTypesService.insert(topicTypes);
        return renderSuccess("添加成功");
    }
    /**
     * 修改题目类型页
     */
    @GetMapping("/editPage")
    public String editPage(Model model, Long id) {
    	TopicTypes topicTypes = topicTypesService.selectById(id);
    	model.addAttribute("topicTypes",topicTypes);
        return "admin/topicType/topicTypesEdit";
    }
    
    /**
     * 编辑题目类型
     */
    @PostMapping("/edit")
    @ResponseBody
    public Object edit(TopicTypes topicTypes) {
    	topicTypesService.updateById(topicTypes);
        return renderSuccess("修改成功！");
    }
    /**
     * 删除题目类型
     * @param id
     */
    @PostMapping("/delete")
    @ResponseBody
    public Object delete(Long id) {
    	//topicTypesService.deleteById(id);
    	topicTypesService.updateTypeAndInfo(id);
        return renderSuccess("删除成功！");
    }
    
    
    /**
     * 科目类型管理列表(未分页)
     * @return
     */
    @PostMapping("/data")
    @ResponseBody
    public Object data(String stage) {
    	List<Map<String, Object>> list = topicTypesService.selectTypeAndSum(stage);
        return list;
    }
}
