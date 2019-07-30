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

import org.apache.commons.lang.StringUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.aaa.commons.base.BaseController;
import com.aaa.commons.mail.MailBiz;
import com.aaa.commons.mail.MailParam;
import com.aaa.commons.mail.MailUtil;
import com.aaa.commons.result.PageInfo;
import com.aaa.commons.utils.ConstantUtils;
import com.aaa.commons.utils.ExcelUitl;
import com.aaa.model.Organization;
import com.aaa.model.TeacherPlan;
import com.aaa.model.User;
import com.aaa.model.vo.TeacherPlanExcelVo;
import com.aaa.model.vo.TeacherPlanVo;
import com.aaa.service.IOrganizationService;
import com.aaa.service.ITeacherPlanService;
import com.aaa.service.IUserService;

/**
 * <p>
 * 老师评价计划表 前端控制器  --- 分模块
 * </p>
 *
 * @author 张德鑫
 * @since 2017-09-18
 */
@Controller
@RequestMapping("/teacherPlanFen")
public class TeacherPlanFenController extends BaseController {
	protected Logger logger = LogManager.getLogger(getClass());
    @Autowired 
    private ITeacherPlanService teacherPlanService;
    @Autowired
    private IUserService userService;
    @Autowired
    MailBiz mailBiz;
    @Autowired
    private IOrganizationService organizationService;
    @GetMapping("/manager")
    public String manager() {
        return "admin/teaEvaluate/teaEvaluateList";
    }
    
    /*根据班级id查询所有该班级的老师*/
    @PostMapping("/teacher")
    @ResponseBody
    public Object teacher(Long classid) {
        return userService.selectAllTeacher(classid);
    }
    
    @PostMapping("/dataFenGrid")
    @ResponseBody
    public PageInfo dataFenGrid(TeacherPlan teacherPlan, Integer page, Integer rows, String sort,String order,Long orgid,String teacherName,String beginTime,String stopTime) {
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
        if(teacherPlan!=null&& teacherPlan.getClassid()!=null){
            condition.put("classid", teacherPlan.getClassid());
        }
        //添加模糊查询老师姓名
        if(StringUtils.isNotBlank(teacherName)){
        	condition.put("teachername", teacherName);
        }
        if(StringUtils.isNotBlank(beginTime)){
        	condition.put("begintime", beginTime);
        }
        if(StringUtils.isNotBlank(stopTime)){
        	condition.put("stoptime", stopTime);
        }else{
        	condition.put("flag", "0");//标记当前年月
        }
        pageInfo.setCondition(condition);
        teacherPlanService.selectFenDataGrid(pageInfo);
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
        return "admin/teaEvaluate/teacherFenPlanAdd";
    }
    
    /**
     * 添加
     * @param 
     * @return
     */
    @PostMapping("/add")
    @ResponseBody
    public Object add(@Valid TeacherPlanVo teacherPlanVo,Long classid,String classname) {
    	TeacherPlan teacherPlan=new TeacherPlan();
    	teacherPlan.setBegintime(teacherPlanVo.getBegintime());
    	teacherPlan.setClassid(classid);
    	Long  i=(long) ((Math.random()*9+1)*100000);    	
    	teacherPlan.setCode(i);
    	teacherPlan.setMakerid(getUserId());
    	teacherPlan.setMaketime(new Date());
		teacherPlan.setStoptime(getEndTime(teacherPlanVo.getBegintime(), teacherPlanVo.getHournum()));
		teacherPlan.setDostatus(0);
		teacherPlan.setTeacherno(teacherPlanVo.getTeacherno());
		//新增设置为分模块(null  不是       1  是)
		teacherPlan.setIsFen(1);
    	boolean b = teacherPlanService.insert(teacherPlan);
        if (b) {
        	User teacher = userService.selectById(teacherPlan.getTeacherno());
        	//TblClass classInfo = tblClassService.selectById(classid);
        	//成功的时候给对应的老师发送邮件
        	/*if(teacher!=null&&teacher.getEmail()!=null){
        		//MailParam mail=MailUtil.sendMail(teacher, teacherPlan,classInfo.getClassname());
        		MailParam mail=MailUtil.sendMail(teacher, teacherPlan,classname);
            	mailBiz.mailSend(mail);
            	logger.debug("发送邮件给"+teacher.getName()+"成功！收件人地址："+teacher.getEmail());
        	}*/
        	
            return renderSuccess("添加成功！");
        } else {
            return renderError("添加失败！");
        }
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
     * 删除
     * @param id
     * @return
     */
    @PostMapping("/delete")
    @ResponseBody
    public Object delete(Long id) {
        /*TeacherPlan teacherPlan = new TeacherPlan();
       stuPlan.setId(id);
        stuPlan.setUpdateTime(new Date());
        stuPlan.setDeleteFlag(1);*/
    	
        boolean b = teacherPlanService.deleteById(id);
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
    public String editPage(Model model, Long id,String classname,Long classid) {
        TeacherPlan teacherPlan = teacherPlanService.selectById(id);
        TeacherPlanVo teacherPlanVo =new TeacherPlanVo();
        teacherPlanVo.setId(teacherPlan.getId());
        teacherPlanVo.setBegintime(teacherPlan.getBegintime());
        teacherPlanVo.setCode(teacherPlan.getCode());
        teacherPlanVo.setHournum(getDatePoor(teacherPlan.getStoptime(),teacherPlan.getBegintime()));
        teacherPlanVo.setTeacherno(teacherPlan.getTeacherno());
        teacherPlanVo.setDostatus(teacherPlan.getDostatus());
        teacherPlanVo.setClassid(classid);
        model.addAttribute("teacherPlan", teacherPlanVo);
        model.addAttribute("classname", classname);
        return "admin/teacherPlan/teacherPlanEdit";
    }
    
    /**
     * 编辑
     * @param 
     * @return
     */
    @PostMapping("/edit")
    @ResponseBody
    public Object edit(@Valid TeacherPlanVo teacherPlanVo,String classname) {
       // stuPlan.setUpdateTime(new Date());
    	TeacherPlan teacherPlan=new TeacherPlan();
    	teacherPlan.setId(teacherPlanVo.getId());
    	teacherPlan.setBegintime(teacherPlanVo.getBegintime());
    	teacherPlan.setTeacherno(teacherPlanVo.getTeacherno());
    	teacherPlan.setStoptime(getEndTime(teacherPlanVo.getBegintime(),(Integer)teacherPlanVo.getHournum()));
    	teacherPlan.setDostatus(teacherPlanVo.getDostatus());
        boolean b = teacherPlanService.updateById(teacherPlan);
        if (b) {
        	 User teacher = userService.selectById(teacherPlan.getTeacherno());
        	//成功的时候给对应的老师发送邮件
        	/*if(teacher!=null&&teacher.getEmail()!=null){
        		MailParam mail=MailUtil.sendMail(teacher, teacherPlan,classname);
            	mailBiz.mailSend(mail);
            	logger.debug("发送邮件给"+teacher.getName()+"成功！收件人地址："+teacher.getEmail());
        	}*/
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
    @PostMapping("/exportTeaEvaluateExcel")
    @ResponseBody
    public String exportTeaEvaluateExcel(HttpServletRequest req, HttpServletResponse resp,@RequestBody Map map) throws Exception{
    	LinkedHashMap<String,String> titleMap = new LinkedHashMap<String,String>(); 
    	//获取表头
    	JSONArray columnsJsonArray = JSONArray.fromObject(map.get("columns"));
    	List<Map<String,Object>> mapListJsonColumns = (List<Map<String,Object>>)columnsJsonArray;
    	//反射获取实体类中的字段名
    	Field[] fs=TeacherPlanExcelVo.class.getDeclaredFields();
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
    	List<TeacherPlanExcelVo> teacherPlanExcelVoList = new ArrayList<TeacherPlanExcelVo>();
    	for (Map<String, Object> dataMap : mapListJsonDatagridRows) {
    		TeacherPlanExcelVo plan = new TeacherPlanExcelVo(); 
    		plan.setId(Long.valueOf(dataMap.get("id").toString()));
    		plan.setTeachername(dataMap.get("teachername").toString());
    		plan.setRolename(dataMap.get("rolename").toString());
    		plan.setBegintime(dataMap.get("begintime").toString());
    		plan.setStoptime(dataMap.get("stoptime").toString());
    		plan.setName(dataMap.get("name").toString());
    		plan.setClassname(dataMap.get("classname").toString());
    		if(dataMap.get("score")!=null){
    			plan.setScore(dataMap.get("score").toString());
    		}
    		teacherPlanExcelVoList.add(plan);
		}
    	String path = req.getSession().getServletContext().getRealPath("/")+ConstantUtils.UPLOAD_PATH+File.separator;
    	String fileName = ExcelUitl.listToExcelFile(teacherPlanExcelVoList, titleMap, "教评计划列表", 1000, resp,path);
    	return fileName;
    }
}
