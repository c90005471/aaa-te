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
import org.springframework.web.bind.annotation.ResponseBody;

import com.aaa.commons.base.BaseController;
import com.aaa.commons.result.PageInfo;
import com.aaa.model.StuEvaluate;
import com.aaa.service.IStuEvaluateService;

/**
 * <p>
 *  学生自评统计模块控制器
 * </p>
 *
 * @author chenjian
 * @since 2017-09-19
 */
@Controller
@RequestMapping("/stuEvaluate")
public class StuEvaluateController extends BaseController {

    @Autowired private IStuEvaluateService stuEvaluateService;
    
    @GetMapping("/manager")
    public String manager() {
        return "admin/stuEvaluate/stuEvaluateList";
    }
    
    @PostMapping("/dataGrid")
    @ResponseBody
    public PageInfo dataGrid(StuEvaluate stuEvaluate, Integer page, Integer rows, String sort,String order) {
        PageInfo pageInfo = new PageInfo(page, rows, sort, order);
       /* EntityWrapper<StuEvaluate> ew = new EntityWrapper<StuEvaluate>(stuEvaluate);
        Page<StuEvaluate> pages = getPage(pageInfo);
        pages = stuEvaluateService.selectPage(pages, ew);
        pageInfo.setRows(pages.getRecords());
        pageInfo.setTotal(pages.getTotal());*/
        return pageInfo;
    }
    
    /**
     * 添加页面
     * @return
     */
    @GetMapping("/addPage")
    public String addPage() {
        return "admin/stuEvaluate/stuEvaluateAdd";
    }
    
    /**
     * 添加
     * @param 
     * @return
     */
    @PostMapping("/add")
    @ResponseBody
    public Object add(@Valid StuEvaluate stuEvaluate) {
       /* stuEvaluate.setCreateTime(new Date());
        stuEvaluate.setUpdateTime(new Date());
        stuEvaluate.setDeleteFlag(0);*/
        boolean b = stuEvaluateService.insert(stuEvaluate);
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
      StuEvaluate stuEvaluate = new StuEvaluate();
      /*stuEvaluate.setId(id);
        stuEvaluate.setUpdateTime(new Date());
        stuEvaluate.setDeleteFlag(1);*/
        boolean b = stuEvaluateService.updateById(stuEvaluate);
        if (b) {
            return renderSuccess("删除成功！");
        } else {
            return renderError("删除失败！");
        }
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
        return "admin/stuEvaluate/showDetail";
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
    	return "admin/stuEvaluate/showCount";
    }
    
    /**
     * 显示详情页面
     * @param 
     * @return
     */
    @PostMapping("/detailPage")
    @ResponseBody
    public List<Map> detailPage(String planid,String classid) {
    	Map map = new HashMap();
    	map.put("planid", planid);
    	map.put("classid", classid);
    	
    	List<Map> stuEvaluateList = stuEvaluateService.selectByplanidAndclassid( map);
    	return stuEvaluateList;
    }
    /**
     * 显示统计图页面
     * @param 
     * @return
     */
    @SuppressWarnings("rawtypes")
	@RequestMapping("/getCountData")
    @ResponseBody
    public Map getCountData(String planid) {
    	Map dataMap = new HashMap();
    	Map map = new HashMap();
    	map.put("planid", planid);
    	
    	List<Map> avgscoreList = stuEvaluateService.selectAvgscoreByplanid(map);
    	List<Map> indicatorList= new ArrayList<Map>();
    	List<Integer> dream= new ArrayList<Integer>();
    	List<String> real= new ArrayList<String>();
    	for (Map avgscoreMap : avgscoreList) {
    		Map indicatorMap = new HashMap();
    		indicatorMap.put("text", avgscoreMap.get("course_name"));
    		indicatorMap.put("max", 5);
    		indicatorList.add(indicatorMap);
    		dream.add(4);
    		real.add(avgscoreMap.get("avgscore")+"");
    		
		}
    	//
    	dataMap.put("indicator", indicatorList);
    	dataMap.put("dream", dream);
    	dataMap.put("real", real);
    	
    	return dataMap;
    }
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
	}
}
