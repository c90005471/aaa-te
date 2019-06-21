package com.aaa.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.aaa.commons.base.BaseController;
import com.aaa.commons.result.PageInfo;
import com.aaa.model.Organization;
import com.aaa.model.StudentRecord;
import com.aaa.service.IOrganizationService;
import com.aaa.service.IStudentRecordService;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author sunshaoshan
 * @since 2017-10-18
 */
@Controller
@RequestMapping("/studentRecord")
public class StudentRecordController extends BaseController {

    @Autowired private IStudentRecordService studentRecordService;
    
    @Autowired
    private IOrganizationService organizationService;
    
    @GetMapping("/manager")
    public String manager() {
        return "admin/studentRecord/studentRecordList";
    }
    
    @PostMapping("/dataGrid")
    @ResponseBody
    public PageInfo dataGrid(StudentRecord studentRecord, Integer page, Integer rows, String sort,String order ,Long orgid,String beginTime,String stopTime) {
        PageInfo pageInfo = new PageInfo(page, rows, sort, order);
        Map<String, Object> condition = new HashMap<String, Object>();
        if(studentRecord!=null){
        	//拼接过滤条件
        	if(studentRecord.getId()!=null){
        		condition.put("id", studentRecord.getId());//班级id
        	}
        	if(StringUtils.isNotBlank(studentRecord.getStudentname())){
        		condition.put("studentname", studentRecord.getStudentname());//学生姓名
        	}
        }
        if(orgid!=null){//校区或专业的id 
    		String idstr = findOrgList(orgid+"","");//获取校区或专业下所有的子类
    		if(StringUtils.isNotBlank(idstr)&&idstr.length()>1){
    			idstr = idstr.substring(0,idstr.length()-1);
    			condition.put("orgids", idstr);
    		}
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
        studentRecordService.selectDataGrid(pageInfo);
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
    
}
