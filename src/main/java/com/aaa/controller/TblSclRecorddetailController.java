package com.aaa.controller;

import java.util.ArrayList;
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
import com.aaa.model.TblSclRecorddetail;
import com.aaa.service.ITblSclRecorddetailService;

/**
 *@desprition:健康自评统计详情控制器
 * @author sunxicai
 * @since 2017-11-30
 */
@Controller
@RequestMapping("/tblSclRecorddetail")
public class TblSclRecorddetailController extends BaseController {
	//自动装填健康自评详情服务类接口
    @Autowired private ITblSclRecorddetailService tblSclRecorddetailService;
    
    //跳转到学生健康自评详情页面
    @GetMapping("/manager")
    public String manager(Model model,String studentid,String createtime) {
    	//传参
    	model.addAttribute("studentid", studentid);//传送学生id
    	model.addAttribute("createtime",createtime);//传送创建时间
    	//返回健康自评统计详情页面
        return "admin/tblSclRecorddetail/tblSclRecorddetailList";
    }
    
    //向健康自评统计详情页面进行数据传输
    @PostMapping("/dataGrid")
    @ResponseBody
    public PageInfo dataGrid(TblSclRecorddetail tblSclRecorddetail, Integer page, Integer rows, String sort,String order,String studentid,String createtime) {
        PageInfo pageInfo = new PageInfo(page, rows, sort, order);//映入分页信息实体类
        Map<String, Object> condition = new HashMap<String, Object>();//新建查询条件存放map
        //将查询条件传入map中
        if (tblSclRecorddetail != null) {//判断scl-90健康自评详情表是否为空
			if (studentid != null) {
				condition.put("studentid", studentid);//并且将学生id传入map
			}
		}
        if (tblSclRecorddetail != null) {
			if (createtime != null) {
				condition.put("createtime", createtime);
			}
		}
        pageInfo.setCondition(condition);//将查询条件存入分页信息实体类中
        tblSclRecorddetailService.selectDataGrid(pageInfo);//调用方法查询健康自评总评数据
        return pageInfo;//将分页信息返回到jsp页面
    }
    
    //跳转到健康自评的统计分析页面
    @GetMapping("/showCountPage")
    public String showCountPage(Model model,String studentid,String createtime) {
    	model.addAttribute("studentid", studentid);
    	model.addAttribute("createtime", createtime);
        return "admin/tblSclRecorddetail/tblSclRecordDetailCount";
    }
    
    //向健康自评统计分析传送数据
    @RequestMapping("/getCountData")
    @ResponseBody
    public Map getCountData(String studentid,String createtime) {
    	Map dataMap = new HashMap();//建立获取到的数据的map空间
    	Map map = new HashMap();//建立查询条件的map空间
    	map.put("studentid", studentid);
    	map.put("createtime", createtime);
    	List<Map> avgscoreList = tblSclRecorddetailService.selectAvgscoreBystudentid(map);//查询十大项的数据
    	List<Map> indicatorList= new ArrayList<Map>();
    	List<String> real= new ArrayList<String>();
    	List<Integer> dream= new ArrayList<Integer>();
    	for (Map avgscoreMap : avgscoreList) {//循环遍历，把数据库的数据存储到前台数据存储空间中
    		Map indicatorMap = new HashMap();
    		indicatorMap.put("text", avgscoreMap.get("typename"));//将十大项的名称放入
    		indicatorMap.put("max", 3);//设置雷达图范围，5表示各数据的最大范围
    		indicatorList.add(indicatorMap);
    		dream.add(1);
    		real.add(avgscoreMap.get("avgscore")+"");//放入实际的十大项测试平均值
    		
		}
    	dataMap.put("indicator", indicatorList);//十大项的名称和最大值
    	dataMap.put("dream", dream);//理想值
    	dataMap.put("real", real);//实际值
    	
    	return dataMap;
    }
    
}
