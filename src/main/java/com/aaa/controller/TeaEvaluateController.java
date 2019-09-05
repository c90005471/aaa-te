package com.aaa.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.aaa.commons.base.BaseController;
import com.aaa.commons.result.PageInfo;
import com.aaa.model.StuEvaluate;
import com.aaa.model.vo.TeacherPlanExcelVo;
import com.aaa.service.IStuEvaluateService;
import com.aaa.service.ITeacherDetailService;
import com.aaa.service.ITeacherPlanService;

/**                                                                             
 * <p>                                                                          
 *  教师评价统计模块控制器                                                      
 * </p>                                                                         
 *                                                                              
 * @author chenjian                                                             
 * @since 2017-09-22                                                            
 */                                                                             
@Controller                                                                     
@RequestMapping("/teaEvaluate")                                                 
public class TeaEvaluateController extends BaseController {                     
                                                                                
    @Autowired private ITeacherDetailService teacherDetailService;              
    @Autowired 
    private ITeacherPlanService teacherPlanService;
    @GetMapping("/manager")                                                     
    public String manager() {                                                   
        return "admin/teaEvaluate/teaEvaluateList";                             
    }

/**
     * 分模块  查询教评结果
     * @return
     */
    @GetMapping("/fenManager")                                                     
    public String fenManager() {                                                   
        return "admin/teaEvaluate/teaFenEvaluateList";                             
    }
                                                                           
                                                                                
                                                                                
    /**                                                                         
     * 编辑                                                                     
     * @param model                                                             
     * @param id                                                                
     * @return                                                                  
     */                                                                         
    @GetMapping("/showDetailPage")                                              
    public String editPage(Model model, Long planid,Long classid) {             
    	model.addAttribute("planid", planid);                                     
    	model.addAttribute("classid", classid);                              
        return "admin/teaEvaluate/showDetail";                                  
    }                                                                           
    /**                                                                         
     * 编辑                                                                     
     * @param model                                                             
     * @param id                                                                
     * @return                                                                  
     */                                                                         
    @GetMapping("/showCountPage")                                               
    public String showCountPage(Model model, Long planid) {
    	model.addAttribute("planid", planid);                                     
    	return "admin/teaEvaluate/showCount";                                     
    }                                                                           
                                                                                
    /**                                                                         
     * 显示详情页面                                                             
     * @param                                                                   
     * @return                                                                  
     */                                                                         
    @PostMapping("/detailPage")                                                 
    @ResponseBody                                                               
    public PageInfo detailPage(String planid,Integer page, Integer rows, String sort,String order) { 
    	 PageInfo pageInfo = new PageInfo(page, rows, sort, order);
    	 Map<String, Object> condition = new HashMap<String, Object>();
         condition.put("planid", planid);
         pageInfo.setCondition(condition);
    	/*Map map = new HashMap();                                                  
    	map.put("planid", planid);     */                                           
    	teacherDetailService.selectByplanid( pageInfo);    
    	return pageInfo;                                                   
    }                                                                           
                                                                                
    /**                                                                         
     * 显示统计图页面                                                           
     * @param                                                                   
     * @return                                                                  
     */                                                                         
    @SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping("/getCountData")                                            
    @ResponseBody                                                               
    public Map getCountData(String planid) {                                    
    	Map dataMap = new HashMap();                                              
    	Map map = new HashMap();                                                  
    	map.put("planid", planid);                                                
    	                                                                          
    	List<Map> avgscoreList = teacherDetailService.selectAvgscoreByplanid(map);
    	/*List<Map> indicatorList= new ArrayList<Map>();*/                        
    	List<Double> avgScore= new ArrayList<Double>();                           
    	List<String> xList= new ArrayList<String>();                              
    	for (Map avgscoreMap : avgscoreList) {                                    
    		/*Map indicatorMap = new HashMap();                                     
    		indicatorMap.put("text", avgscoreMap.get("course_name"));               
    		indicatorMap.put("max", 5);*/                                           
    		avgScore.add(Double.parseDouble(avgscoreMap.get("avgscore")+""));       
    		xList.add(avgscoreMap.get("questionname").toString().split("：")[0]);   
    		                                                                        
		}                                                                           
    	//dataMap.put("indicator", indicatorList);                                
    	dataMap.put("avgScore", avgScore);                                        
    	dataMap.put("xList", xList);                                              
    	                                                                          
    	return dataMap;                                                           
    }                                                                           
    /*                                                                          
   //自评率页面                                                                 
    @GetMapping("/showRade")                                                    
    public String evaluation(Model model,Long planid) {                         
		model.addAttribute("planid", planid);                                       
		Map count=stuEvaluateService.selctgetDetailByRade(planid);                  
		model.addAttribute("countt",count);                                         
		System.out.println(count);                                                  
		return "admin/stuEvaluate/showRate";                                        
    }                                                                           
    @ResponseBody                                                               
	@RequestMapping(value="/countRade",method=RequestMethod.POST)                 
	public Object countRade(Long planid){                                         
		Map count=stuEvaluateService.selctgetDetailByRade(planid);                  
		                                                                            
		return Math.round((float) count.get("radecount"));                          
	}*/                                                                                           
   //自评率页面 
    @GetMapping("/showRade")
    public String evaluation(Model model,Long planid) {
		model.addAttribute("planid", planid);
		Map count=teacherDetailService.selectByTeacher(planid);
		model.addAttribute("countt",count);
		//System.out.println(count);
		return "admin/teaEvaluate/showRate";
    }
    //填充前台的仪表盘的数据
    @SuppressWarnings("rawtypes")
	@ResponseBody
	@RequestMapping(value="/countRade",method=RequestMethod.POST)
	public Object countRade(Long planid){
    	Map count=teacherDetailService.selectByTeacher(planid);
		
		return Math.round((float) count.get("radecount"));
	}
}
