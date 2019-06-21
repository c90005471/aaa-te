package com.aaa.controller;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.aaa.commons.base.BaseController;
import com.aaa.commons.result.PageInfo;
import com.aaa.commons.utils.ConstantUtils;
import com.aaa.commons.utils.DateUtil;
import com.aaa.commons.utils.StringUtils;
import com.aaa.service.IStudentService;
/**
 * 类名称：ReturnRecordController
 * 类描述： 
 * 创建人：sunshaoshan
 * 创建时间：2018-3-19 下午2:07:55
 * @version
 */
@Controller
@RequestMapping("/returnRecordEva")
public class ReturnRecordEvaController extends BaseController{
	@Autowired
	private IStudentService studentService;
	/**
	 * 跳转统计显示页面
	 * @return
	 */
	@GetMapping("/manager")
    public String manager() {
        return "admin/returnRecordEva/showCount";
    }
	
	
	/**                                                                         
     * 显示统计图页面                                                           
     * @param                                                                   
     * @return                                                                  
     */                                                                         
    @SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping("/getCountData")                                            
    @ResponseBody                                                               
    public Map getCountData(String teaname,String begintime,String endtime,String flag) {                                    
    	Map dataMap = new HashMap();                                              
    	Map map = new HashMap();   
    	if(StringUtils.isNotBlank(teaname)){
    		map.put("teaname", teaname);
    	}
    	if (StringUtils.isNotBlank(begintime)) {
    		map.put("begintime", begintime); 
    		if (StringUtils.isNotBlank(endtime)) {
        		map.put("endtime", endtime);
            }
        }else{
        	map.put("flag", "1");
        }
    	//获取该时间段内回访记录的数量
    	List<Map> countStatusList = studentService.selectReturnRecordByMonHashMap(map); 
    	
    	List<Integer> countStatus= new ArrayList<Integer>();                           
    	List<String> xList= new ArrayList<String>();                              
    	for (Map countStatusMap : countStatusList) {
    		countStatus.add(Integer.valueOf(countStatusMap.get("stunamecount").toString()));
    		xList.add(countStatusMap.get("returntime").toString());  
		}                                                                           
    	dataMap.put("avgScore", countStatus);                                        
    	dataMap.put("xList", xList);                                              
    	return dataMap;                                                           
    }
    /**
     * 跳转回访记录页面
     */
    @RequestMapping("/showReturnReCordPage")
    public String showReturnReCordPage(Model model, String dateTime){
    	model.addAttribute("dateTime",dateTime);
    	return "admin/returnRecordEva/showReturnReCordPage";
    }
    /**
     * 回访记录列表
     */
    @ResponseBody
    @RequestMapping("/returnRecordDataGrid")
    public PageInfo returnRecordDataGrid(Integer page, Integer rows, String sort,String order,String dateTime,String stuname,String username){
    	PageInfo pageInfo = new PageInfo(page, rows, sort, order);
    	Map<String, Object> condition = new HashMap<String, Object>();
    	condition.put("dateTime", dateTime);
    	condition.put("stuname", stuname);
    	condition.put("username", username);
    	pageInfo.setCondition(condition);
        studentService.selectRerturnCordDataGrid(pageInfo);
        return pageInfo;
    }
}
