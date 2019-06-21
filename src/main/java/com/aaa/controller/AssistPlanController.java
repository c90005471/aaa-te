package com.aaa.controller;

import java.io.File;
import java.lang.reflect.Field;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;

import net.sf.json.JSONArray;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.aaa.commons.base.BaseController;
import com.aaa.commons.result.PageInfo;
import com.aaa.commons.utils.ConstantUtils;
import com.aaa.commons.utils.ExcelUitl;
import com.aaa.model.AssistPlan;
import com.aaa.model.Organization;
import com.aaa.model.vo.AssistPlanVo;
import com.aaa.model.vo.StuPlanExcelVo;
import com.aaa.service.IAssistPlanService;
import com.aaa.service.IAssplanStudentService;
import com.aaa.service.IOrganizationService;
/**
 * 类名称：AssistPlanController
 * 类描述： 帮扶计划前台控制器
 * 创建人：sunshaoshan
 * 创建时间：2018-2-1 上午9:20:54
 * @version
 */
@Controller
@RequestMapping("/assistPlan")
public class AssistPlanController extends BaseController {
	@Autowired
	private IAssistPlanService assistPlanService;
	@Autowired
    private IOrganizationService organizationService;
	@Autowired
	private IAssplanStudentService assplanStudentService;
	/**
	 * 跳转列表页面
	 * @return
	 */
	@GetMapping("/manager")
    public String manager() {
        return "admin/assistPlan/assistPlanList";
    }
	/**
	 * 列表的回调方法
	 * @param assistPlan
	 * @return
	 */
	@PostMapping("/dataGrid")
    @ResponseBody
    public PageInfo dataGrid(AssistPlan assistPlan, Integer page, Integer rows, String sort,String order,Long orgid,String teacherName,String startTime,String endTime) {
        PageInfo pageInfo = new PageInfo(page, rows, sort, order);
        Map<String, Object> condition = new HashMap<String, Object>();
        if(orgid!=null){//校区或专业的id 
    		String idstr = findOrgList(orgid+"","");//获取校区或专业下所有的子类
    		if(StringUtils.isNotBlank(idstr)&&idstr.length()>1){
    			idstr = idstr.substring(0,idstr.length()-1);
    			condition.put("orgids", idstr);
    		}
    	}
        //过滤掉已毕业的班级
        if(assistPlan!=null&& assistPlan.getClassid()!=null){
            condition.put("classid", assistPlan.getClassid());
        }
        //添加模糊查询老师姓名
        if(StringUtils.isNotBlank(teacherName)){
        	condition.put("teachername", teacherName);
        }
        if(StringUtils.isNotBlank(startTime)){
        	condition.put("startTime", startTime);
        }
        if(StringUtils.isNotBlank(endTime)){
        	condition.put("endTime", endTime);
        }else{
        	condition.put("flag", "0");//标记当前年月
        }
        pageInfo.setCondition(condition);
        assistPlanService.selectDataGrid(pageInfo);
        return pageInfo;
    }
	/**
     * 递归调用获取该校区或专业下的所有专业
     * @param pid 父id 0    
     * @param idstr 专业id字符串
     * @return 
     */
    public String findOrgList(String pid,String idstr){
    	List<Organization> orgList = organizationService.selectListByPid(pid);
    	if(orgList!=null&&orgList.size()>0){//判断是否有子类
    		for (Organization org : orgList) {
    			List<Organization> zorgList = organizationService.selectListByPid(org.getId()+"");
    			if(zorgList!=null&&zorgList.size()>0){
    				//如果存在子类继续执行该方法
    				idstr = findOrgList(org.getId()+"",idstr);
    			}else{
    				idstr+=org.getId()+",";
    			}
			}
    	}else{
    		idstr = pid+",";
    	}
    	return idstr;
    }
    
    
    /**
     * 添加页面
     * @return
     */
    @GetMapping("/addPage")
    public String addPage() {
        return "admin/assistPlan/assistPlanAdd";
    }
    
    /**
     * 添加
     * @param 
     * @return
     */
    @PostMapping("/add")
    @ResponseBody
    public Object add(@Valid AssistPlan assistPlan,String students) {
    	//插入计划信息
    	assistPlan.setCreator(getUserId());
    	assistPlan.setCreatetime(new Date());
    	assistPlan.setIsstatus(0);//新增默认是未完成
    	Long id = assistPlanService.insertAssistPlan(assistPlan,students);
    	
        if (id!=null) {
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
    public String editPage(Model model, Long id,String classname) {
		//获取帮扶计划信息
		AssistPlan assistPlan = assistPlanService.selectById(id);
		//获取帮扶计划学生的学生信息
		String stunos = assplanStudentService.findStunosByAssistId(id);
        model.addAttribute("assistPlan", assistPlan);
        model.addAttribute("stunos", stunos);
        model.addAttribute("classid", assistPlan.getClassid());
        return "admin/assistPlan/assistPlanEdit";
    }
    
    /**
     * 编辑
     * @param 
     * @return
     */
    @PostMapping("/edit")
    @ResponseBody
    public Object edit(@Valid AssistPlan assistPlan,String students) {
    	if(getUserId().equals(assistPlan.getCreator())){
    		assistPlan.setCreatetime(new Date());
        	int row = assistPlanService.updateAssistPlan(assistPlan,students);
            if (row>0) {
                return renderSuccess("编辑成功！");
            } else {
                return renderError("编辑失败！");
            }
    	}else{
    		return renderError("您没有权限修改别人的帮扶计划信息!");
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
    	AssistPlan assistPlan = assistPlanService.selectById(id);
    	if(getUserId().equals(assistPlan.getCreator())){
    		//删除计划信息和计划的学生信息
            boolean b = assistPlanService.deleteAssistPlan(id);
            if (b) {
                return renderSuccess("删除成功！");
            } else {
                return renderError("删除失败！");
            }
    	}else{
    		return renderError("您没有权限删除别人的帮扶计划信息!");
    	}
    }
    
    
    /**
     * 按查询结果导出excel
     * @param columns
     * @param Rows
     * @throws Exception 
     */
    @PostMapping("/exportAssistPlanExcel")
    @ResponseBody
    public String exportAssistPlanExcel(HttpServletRequest req, HttpServletResponse resp,@RequestBody Map map) throws Exception{
    	LinkedHashMap<String,String> titleMap = new LinkedHashMap<String,String>(); 
    	//获取表头
    	JSONArray columnsJsonArray = JSONArray.fromObject(map.get("columns"));
    	List<Map<String,Object>> mapListJsonColumns = (List<Map<String,Object>>)columnsJsonArray;
    	//反射获取实体类中的字段名
//    	Field[] fs=AssistPlanVo.class.getDeclaredFields();
//    	for (Map<String,Object> columnMap : mapListJsonColumns) {
//    		String fieldName = columnMap.get("field").toString();
//    		String titleName = columnMap.get("title").toString();
//    		for (Field field : fs) {
//    			if(field.getName().equals(fieldName)){
//    				titleMap.put(fieldName, titleName);
//    			}
//    		}
//		}
    	titleMap.put("classname", "班级名称");
    	titleMap.put("teacher", "教员及班主任");
    	titleMap.put("stuname", "课前测三次未过");
    	titleMap.put("stucontent", "帮扶计划");
    	titleMap.put("comflan", "帮扶结果");
    	titleMap.put("plancontent", "计划措施");
    	titleMap.put("remark", "备注");
    	//获取行数据
    	JSONArray datagridRowsJsonArray = JSONArray.fromObject(map.get("datagridRows"));
    	List<Map<String,Object>> mapListJsonDatagridRows = (List<Map<String,Object>>)datagridRowsJsonArray;
    	List<AssistPlanVo> assistPlanVoList = new ArrayList<AssistPlanVo>();
    	for (Map<String, Object> dataMap : mapListJsonDatagridRows) {
    		AssistPlanVo plan = new AssistPlanVo(); 
//    		plan.setId(Long.valueOf(dataMap.get("id").toString()));
    		plan.setClassname(dataMap.get("classname").toString());
    		//教员及班主任  
    		List<Map<String,Object>> classInfoMapList = assistPlanService.selectClassInfoById(Long.valueOf(dataMap.get("id").toString()));
    		if(classInfoMapList!=null&&classInfoMapList.size()>0){
    			plan.setTeacher(classInfoMapList.get(0).get("teacher").toString());
    			//学生
    			plan.setStuname(classInfoMapList.get(0).get("stuname").toString());
    			//帮扶结果
        		plan.setComflan(classInfoMapList.get(0).get("comflan").toString());
        		//计划措施
        		plan.setPlancontent(classInfoMapList.get(0).get("plancontent").toString());
        		//备注
        		plan.setRemark(classInfoMapList.get(0).get("remark").toString());
    		}
    		plan.setStucontent(dataMap.get("stucontent").toString());
    		
//    		plan.setEndtime(dataMap.get("endtime").toString());
//    		plan.setStarttime(dataMap.get("starttime").toString());
//    		plan.setEndtime(dataMap.get("endtime").toString());
//    		plan.setCreatename(dataMap.get("createname").toString());
//    		plan.setCreatetime(dataMap.get("createtime").toString());
//    		if(StringUtils.isNotBlank(dataMap.get("isstatus").toString())){
//    			if(dataMap.get("isstatus").toString().equals("0")){
//    				plan.setIsstatus("未完成");
//    			}else{
//    				plan.setIsstatus("已完成");
//    			}
//    		}
    		assistPlanVoList.add(plan);
		}
    	String path = req.getSession().getServletContext().getRealPath("/")+ConstantUtils.UPLOAD_PATH+File.separator;
    	String fileName = ExcelUitl.listToExcelFile(assistPlanVoList, titleMap, "自评计划列表", 1000, resp,path);
    	return fileName;
    }
}
