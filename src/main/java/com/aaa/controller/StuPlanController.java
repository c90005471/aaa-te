package com.aaa.controller;

import java.io.File;
import java.lang.reflect.Field;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;

import net.sf.json.JSONArray;

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
import com.aaa.commons.shiro.ShiroUser;
import com.aaa.commons.utils.ConstantUtils;
import com.aaa.commons.utils.DateUtil;
import com.aaa.commons.utils.ExcelUitl;
import com.aaa.commons.utils.StringUtils;
import com.aaa.model.Organization;
import com.aaa.model.StuPlan;
import com.aaa.model.vo.StuPlanExcelVo;
import com.aaa.model.vo.StuPlanVo;
import com.aaa.model.vo.TeacherPlanExcelVo;
import com.aaa.service.IOrganizationService;
import com.aaa.service.IStuPlanService;

/**
 * <p>
 * 学生自评计划表 前端控制器
 * </p>
 *
 * @author chenjian
 * @since 2017-09-17
 */
@Controller
@RequestMapping("/stuPlan")
public class StuPlanController extends BaseController {

    @Autowired private IStuPlanService stuPlanService;
    @Autowired
    private IOrganizationService organizationService;
    @GetMapping("/manager")
    public String manager() {
        return "admin/stuPlan/stuPlanList";
    }
    
    @PostMapping("/dataGrid")
    @ResponseBody
    public PageInfo dataGrid(StuPlan stuPlan, Integer page, Integer rows, String sort,String order,String beginTime,String endTime,String courseType,Long orgid) {
        PageInfo pageInfo = new PageInfo(page, rows, sort, order);
        Map<String, Object> condition = new HashMap<String, Object>();
        if(orgid!=null){//校区或专业的id 
    		String idstr = findOrgList(orgid+"","");//获取校区或专业下所有的子类
    		if(StringUtils.isNotBlank(idstr)&&idstr.length()>1){
    			idstr = idstr.substring(0,idstr.length()-1);
    			condition.put("orgids", idstr);
    		}
    	}
        //班级id
        if(stuPlan!=null&& stuPlan.getClassid()!=null){
        	condition.remove("orgids");
            condition.put("classid", stuPlan.getClassid());
       }
        //查询结束时间在时间段的结果
        if (StringUtils.isNotBlank(endTime)) {
        	condition.put("begintime", beginTime);
            condition.put("endtime", endTime);
        }else{
        	//不输入时间查询时，默认当前月份
        	condition.put("flag", "1");
        }
        //阶段/章节
        if(StringUtils.isNotBlank(courseType)){
        	condition.put("courseType", courseType);
        }
        pageInfo.setCondition(condition);
        stuPlanService.selectDataGrid(pageInfo);
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
        return "admin/stuPlan/stuPlanAdd";
    }
    
    /**
     * 添加
     * @param 
     * @return
     */
    @PostMapping("/add")
    @ResponseBody
    public Object add(@Valid StuPlan stuPlan,Integer hourNum) {
        ShiroUser shiroUser = getShiroUser();
        stuPlan.setCreateuserid(shiroUser.getId());//添加指定人的ID
        stuPlan.setDostatus(0);
        //计算结束时间
        Date endTime=DateUtil.getEndTime(stuPlan.getBegintime(), hourNum);
        stuPlan.setEndtime(endTime);
        stuPlan.setCreatetime(new Date());
        boolean b = stuPlanService.insert(stuPlan);
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
    	/* StuPlan stuPlan = new StuPlan();
        stuPlan.setId(id);
        stuPlan.setUpdateTime(new Date());
        stuPlan.setDeleteFlag(1);*/
        boolean b = stuPlanService.deleteById(id);
        if (b) {
            return renderSuccess("删除成功！");
        } else {
            return renderError("删除失败！");
        }
    }
    
    /**
	 * 计算两个时间的小时差
	 * @param endDate结束时间
	 * @param nowDate开始时间
	 * @return
	 */
	public static Integer getDatePoor(Date endDate, Date nowDate) {
		 
	    long nd = 1000 * 24 * 60 * 60;
	    long nh = 1000 * 60 * 60;
	    long nm = 1000 * 60;
	    // long ns = 1000;
	    // 获得两个时间的毫秒时间差异
	    long diff = endDate.getTime() - nowDate.getTime();
	    System.out.println(diff);
	    // 计算差多少天
	    // 计算差多少小时
	    Integer hour = (int) (diff / nh) ;
	    return hour;
	}
    
    /**
     * 编辑
     * @param model
     * @param id
     * @return
     */
    @GetMapping("/editPage")
    public String editPage(Model model, Long id,Long classid) {
        StuPlan stuPlan= stuPlanService.selectById(id);
        StuPlanVo stuPlanVo= new StuPlanVo();
        stuPlanVo.setId(stuPlan.getId());
        stuPlanVo.setBegintime(stuPlan.getBegintime());
        stuPlanVo.setChapterid(stuPlan.getChapterid());
        stuPlanVo.setClassid(stuPlan.getClassid());
        stuPlanVo.setTeacherno(stuPlan.getTeacherno());
        stuPlanVo.setHourNum(getDatePoor(stuPlan.getEndtime(),stuPlan.getBegintime()));
        stuPlanVo.setCreateuserid(stuPlan.getCreateuserid());
        stuPlanVo.setDostatus(stuPlan.getDostatus());
        //获取阶段/章节的类型
        Map<String, Object> condition = new HashMap<String, Object>();
        condition.put("id", id);
        List<Map> list = stuPlanService.selectPlanStuList(condition);
        String flag = "0";//默认是章节类型,1是知识点，2是阶段，3是阶段重点
        if(list!=null&&list.size()>0){
        	if(StringUtils.isNotBlank(list.get(0).get("coursetype").toString())){
        		flag = list.get(0).get("coursetype").toString();
        		/*if(coursetype>1){
        			flag="1";//阶段类型
        		}*/
        	}
        }
        stuPlanVo.setCoursetype(flag);
        model.addAttribute("stuPlan", stuPlanVo);
        return "admin/stuPlan/stuPlanEdit"; 
    }
    
    /**
	 * 传入开始date时间，和时长小时数，返回结束的date时间
	 * @param beginTime 开始时间
	 * @param hourNum 时长
	 * @return 返回结束时间
	 */

	public static Date getEndTime(Date beginTime, Integer hourNum) {
		if (hourNum == null) {
			hourNum = 0;
		}
		Calendar ca = Calendar.getInstance();
		ca.setTime(beginTime);
		ca.add(Calendar.HOUR_OF_DAY, hourNum);
		return ca.getTime();

	}
    
    /**
     * 编辑
     * @param 
     * @return
     */
    @PostMapping("/edit")
    @ResponseBody
    public Object edit(@Valid StuPlanVo stuPlanvo) {
    	StuPlan stuPlan=new StuPlan();
    	stuPlan.setId(stuPlanvo.getId());
    	stuPlan.setChapterid(stuPlanvo.getChapterid());
    	stuPlan.setBegintime(stuPlanvo.getBegintime());
    	stuPlan.setEndtime(getEndTime(stuPlanvo.getBegintime(),stuPlanvo.getHourNum()));
    	stuPlan.setDostatus(stuPlanvo.getDostatus());    
    	stuPlan.setTeacherno(stuPlanvo.getTeacherno());
        boolean b = stuPlanService.updateById(stuPlan);
        if (b) {
            return renderSuccess("编辑成功！");
        } else {
            return renderError("编辑失败！");
        }
    }
    /**
     * 按查询结果导出excel
     * @param columns
     * @param Rows
     * @throws Exception 
     */
    @PostMapping("/exportStuEvaluateExcel")
    @ResponseBody
    public String exportStuEvaluateExcel(HttpServletRequest req, HttpServletResponse resp,@RequestBody Map map) throws Exception{
    	LinkedHashMap<String,String> titleMap = new LinkedHashMap<String,String>(); 
    	//获取表头
    	JSONArray columnsJsonArray = JSONArray.fromObject(map.get("columns"));
    	List<Map<String,Object>> mapListJsonColumns = (List<Map<String,Object>>)columnsJsonArray;
    	//反射获取实体类中的字段名
    	Field[] fs=StuPlanExcelVo.class.getDeclaredFields();
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
    	List<StuPlanExcelVo> stuPlanExcelVoList = new ArrayList<StuPlanExcelVo>();
    	for (Map<String, Object> dataMap : mapListJsonDatagridRows) {
    		StuPlanExcelVo plan = new StuPlanExcelVo(); 
    		plan.setId(Long.valueOf(dataMap.get("id").toString()));
    		plan.setCoursename(dataMap.get("coursename").toString());
    		plan.setBegintime(dataMap.get("begintime").toString());
    		plan.setEndtime(dataMap.get("endtime").toString());
    		plan.setName(dataMap.get("name").toString());
    		plan.setClassname(dataMap.get("classname").toString());
    		if(dataMap.get("teachername")!=null){
    			plan.setTeachername(dataMap.get("teachername").toString());
    		}
    		if(dataMap.get("score")!=null){
    			plan.setScore(dataMap.get("score").toString());
    		}
    		stuPlanExcelVoList.add(plan);
		}
    	String path = req.getSession().getServletContext().getRealPath("/")+ConstantUtils.UPLOAD_PATH+File.separator;
    	String fileName = ExcelUitl.listToExcelFile(stuPlanExcelVoList, titleMap, "自评计划列表", 1000, resp,path);
    	return fileName;
    }
}
