package com.aaa.controller;


import java.io.File;
import java.io.InputStream;
import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.aaa.commons.base.BaseController;
import com.aaa.commons.result.PageInfo;
import com.aaa.commons.utils.ConstantUtils;
import com.aaa.commons.utils.ExcelUitl;
import com.aaa.commons.utils.StringUtils;
import com.aaa.model.TopicInfo;
import com.aaa.model.TopicOption;
import com.aaa.model.vo.TopicInfoExcelVo;
import com.aaa.model.vo.TopicInfoVo;
import com.aaa.service.ITopicInfoService;


/**
 * 类名称：TopicManageController
 * 类描述： 试题管理
 * 创建人：sunshaoshan
 * 创建时间：2018-6-22 上午11:10:00
 * @version
 */
@Controller
@RequestMapping("/topicInfo")
public class TopicInfoController extends BaseController{

	@Autowired
	private ITopicInfoService topicInfoService;
	/**
     * 试题列表页面
     * @return
     */
    @GetMapping("/manager")
    public String manager(Model model) {
    	//题目类型
    	Map<Integer,String> typeMap = topicInfoService.selectTopicTypes();
    	model.addAttribute("typeMap", typeMap);
        return "admin/topic/topicInfo";
    }
    /**
     * 试题管理列表
     * @return
     */
    @PostMapping("/dataGrid")
    @ResponseBody
    public Object dataGrid(Integer page, Integer rows, String sort, String order,TopicInfo topicInfo) {
        PageInfo pageInfo = new PageInfo(page, rows, sort, order);
        Map<String, Object> condition = new HashMap<String, Object>();
        if (StringUtils.isNotBlank(topicInfo.getTopicname())) {
            condition.put("topicname", topicInfo.getTopicname());
        }
        if (topicInfo.getTopictype()!=null) {
            condition.put("topictype", topicInfo.getTopictype());
        }
        condition.put("topicstate", 1);
        pageInfo.setCondition(condition);
        topicInfoService.selectDataGrid(pageInfo);
        return pageInfo;
    }
    
    /**
     * 添加试题页
     */
    @GetMapping("/addPage")
    public String addPage(Model model) {
    	//题目类型
    	Map<Integer,String> typeMap = topicInfoService.selectTopicTypes();
    	model.addAttribute("typeMap", typeMap);
    	//试题类型
    	Map<Integer,String> types = ConstantUtils.TYPEMAP;
    	model.addAttribute("types", types);
        return "admin/topic/topicInfoAdd";
    }
    /**
     * 添加试题内容和选项
     */
    @PostMapping("/add")
    @ResponseBody
    public Object add(TopicInfo info,String[] optionnum, String[] option,String score) {
    	info.setTopicstate(1);
    	topicInfoService.insertQuestionAndOption(info,optionnum,option,score,getUserId());
        return renderSuccess("添加成功");
    }
    
    /**
     * 修改试题页
     */
    @GetMapping("/editPage")
    public String editPage(Model model, Long id) {
    	//题目类型
    	Map<Integer,String> typeMap = topicInfoService.selectTopicTypes();
    	model.addAttribute("typeMap", typeMap);
    	//试题类型
    	Map<Integer,String> types = ConstantUtils.TYPEMAP;
    	model.addAttribute("types", types);
    	//获取试题主干信息
    	TopicInfo topicInfo = topicInfoService.selectById(id);
    	model.addAttribute("topicInfo", topicInfo);
    	//获取试题选项信息
    	List<TopicOption> optionList = topicInfoService.selectTopicOptionListByInfoId(id);
    	model.addAttribute("optionList",optionList);
        return "admin/topic/topicInfoEdit";
    }
    /**
     * 编辑试题信息页
     */
    @PostMapping("/edit")
    @ResponseBody
    public Object edit(TopicInfo info,String[] optionnum, String[] option,String score) {
    	topicInfoService.updateTopInfoAndOption(info,optionnum,option,option);
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
    	topicInfoService.deleteTopInfoAndOption(id);
        return renderSuccess("删除成功！");
    }
    /**
     * 按查询结果导出excel
     * @param columns
     * @param Rows
     * @throws Exception 
     */
    @PostMapping("/exportTopicInfoExcel")
    @ResponseBody
    public String exportTopicInfoExcel(HttpServletRequest req, HttpServletResponse resp,@RequestBody Map map) throws Exception{
    	LinkedHashMap<String,String> titleMap = new LinkedHashMap<String,String>(); 
    	//获取表头
    	JSONArray columnsJsonArray = JSONArray.fromObject(map.get("columns"));
    	List<Map<String,Object>> mapListJsonColumns = (List<Map<String,Object>>)columnsJsonArray;
    	//反射获取实体类中的字段名
    	Field[] fs=TopicInfoVo.class.getDeclaredFields();
    	for (Map<String,Object> columnMap : mapListJsonColumns) {
    		String fieldName = columnMap.get("field").toString();
    		String titleName = columnMap.get("title").toString();
    		for (Field field : fs) {
    			if(field.getName().equals(fieldName)){
    				titleMap.put(fieldName, titleName);
    			}
    		}
		}
    	//获取行数据
    	JSONArray datagridRowsJsonArray = JSONArray.fromObject(map.get("datagridRows"));
    	List<Map<String,Object>> mapListJsonDatagridRows = (List<Map<String,Object>>)datagridRowsJsonArray;
    	List<TopicInfoVo> topicInfoList = new ArrayList<TopicInfoVo>();
    	for (Map<String, Object> dataMap : mapListJsonDatagridRows) {
    		TopicInfoVo vo = new TopicInfoVo();
    		//获取字段名
    		for (String columnStr : titleMap.keySet()) {
    			// 将属性首字母大写，并获取getter方法名
    			String firstLetter = columnStr.substring(0, 1).toUpperCase();
    			String setter = "set" + firstLetter + columnStr.substring(1);
    			// getMethod第一个参数是方法名，第二个参数是该方法的参数类型，
    			Method setMethod = vo.getClass().getMethod(setter, String.class);
    			// invoke第一个参数是具体调用该方法的对象,第二个参数是执行该方法的具体参数
    			setMethod.invoke(vo, dataMap.get(columnStr)+"");//把得到的值放到实体中
    		}
    		topicInfoList.add(vo);
		}
    	//处理题目类型等信息
    	topicInfoList = topicInfoService.selectTopicInfoVoList(topicInfoList);
    	String path = req.getSession().getServletContext().getRealPath("/")+ConstantUtils.UPLOAD_PATH+File.separator;
    	titleMap.put("optionA", "选项A");
    	titleMap.put("optionB", "选项B");
    	titleMap.put("optionC", "选项C");
    	titleMap.put("optionD", "选项D");
    	String fileName = ExcelUitl.listToExcelFile(topicInfoList, titleMap, "试题列表", 1000, resp,path);
    	return fileName;
    }
    
    /**
     * 题目类型树
     *
     * @return
     */
    @RequestMapping("/tree")
    @ResponseBody
    public Object tree(String stage) {
    	return topicInfoService.selectTree(stage);
    }
    /**
     * 跳转导入页面
     */
    @GetMapping("/addManyPage")
    public String addManyPage(Model model) {
    	return "admin/topic/topicInfoAddMany";
    }
    
    /**
     * 批量导入学生
     * flag 标识导入的是学生毕业信息
     * @throws Exception 
     */
    @RequestMapping("/importExceltopicInfo")
    @ResponseBody
    public Object  importExceltopicInfo(Long topictype,@RequestParam MultipartFile mf) throws Exception{
    	LinkedHashMap<String,String> map = new LinkedHashMap<String,String>();
    	InputStream in = mf.getInputStream();
    	map.put("topicname", "题目内容");
    	map.put("type", "试题类型");
    	map.put("correct", "题目答案");
    	map.put("optionA", "选项A");
    	map.put("optionB", "选项B");
    	map.put("optionC", "选项C");
    	map.put("optionD", "选项D");
    	List<TopicInfoExcelVo> excelToList = ExcelUitl.excelToList(in, "题目列表", TopicInfoExcelVo.class, map, null);
    	boolean b = topicInfoService.addTopicInfoAndOption(excelToList,topictype,getUserId());
    	if (b) {
            return renderSuccess("批量添加成功！");
        } else {
            return renderError("添加失败！");
        }
    }
}
