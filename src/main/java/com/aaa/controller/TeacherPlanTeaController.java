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
 * 教师评价结果
 * </p>
 *
 * @author 张德鑫
 * @since 2017-09-18
 */
@Controller
@RequestMapping("/teacherPlanTea")
public class TeacherPlanTeaController extends BaseController {
	protected Logger logger = LogManager.getLogger(getClass());
    @Autowired 
    private ITeacherPlanService teacherPlanService;
    @Autowired
    MailBiz mailBiz;
    @Autowired
    private IOrganizationService organizationService;
    
    
    @PostMapping("/dataGrid")
    @ResponseBody
    public PageInfo dataGrid(TeacherPlan teacherPlan, Integer page, Integer rows, String sort,String order,Long orgid,String teacherName,String beginTime,String stopTime) {
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
        teacherPlanService.selectTeaDataGrid(pageInfo);
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
}
