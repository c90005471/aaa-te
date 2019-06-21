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

import org.apache.shiro.authz.annotation.RequiresRoles;
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
import com.aaa.commons.shiro.PasswordHash;
import com.aaa.commons.utils.ConstantUtils;
import com.aaa.commons.utils.DateUtil;
import com.aaa.commons.utils.ExcelUitl;
import com.aaa.commons.utils.StringUtils;
import com.aaa.model.Role;
import com.aaa.model.Student;
import com.aaa.model.StudentCompany;
import com.aaa.model.User;
import com.aaa.model.Wordofmouth;
import com.aaa.model.vo.TeacherPlanExcelVo;
import com.aaa.model.vo.UserVo;
import com.aaa.model.vo.WordofmouthVo;
import com.aaa.service.IUserService;
import com.aaa.service.IWordofmouthService;

/**
 * 
 * 类名称：WordofmouthController
 * 类描述： 口碑控制器
 * 创建人：sunshaoshan
 * 创建时间：2018-1-11 下午2:24:22
 * @version
 */
@Controller
@RequestMapping("/wordofmouth")
public class WordofmouthController extends BaseController {
    @Autowired
    private IWordofmouthService wordofmouthService;

    /**
     * 口碑管理页
     *
     * @return
     */
    @GetMapping("/manager")
    public String manager(Model model) {
    	//获取口碑状态
    	Map<String, String> wordstatusmap = ConstantUtils.WORDSTATUSMAP;
    	model.addAttribute("wordstatusmap", wordstatusmap);
        return "admin/wordofmouth/wordofmouthList";
    }

    /**
     * 口碑管理列表
     *
     * @param userVo
     * @param page
     * @param rows
     * @param sort
     * @param order
     * @return
     */
    @PostMapping("/dataGrid")
    @ResponseBody
    public Object dataGrid(Wordofmouth wordofmouth, Integer page, Integer rows, String sort, String order,String begintime,String stoptime) {
        PageInfo pageInfo = new PageInfo(page, rows, sort, order);
        Map<String, Object> condition = new HashMap<String, Object>();
        /**
         * 口碑姓名
         */
        if (StringUtils.isNotBlank(wordofmouth.getStuname())) {
            condition.put("stuname", wordofmouth.getStuname());
        }
        /**
         * 报备人姓名
         */
        if (StringUtils.isNotBlank(wordofmouth.getTeaname())) {
            condition.put("teaname", wordofmouth.getTeaname());
        }
        /**
         * 开始时间
         */
        if (StringUtils.isNotBlank(begintime)) {
            condition.put("begintime", begintime);
        }
        /**
         * 结束时间
         */
        if (StringUtils.isNotBlank(stoptime)) {
            condition.put("stoptime", stoptime);
        }else{
        	condition.put("flag", "1");
        }
        pageInfo.setCondition(condition);
        wordofmouthService.selectDataGrid(pageInfo);
        return pageInfo;
    }
    /**
     * 添加页面
     * @return
     */
    @GetMapping("/addPage")
    public String addPage(Model model) {
    	Map<String, String> wordstatusmap = ConstantUtils.WORDSTATUSMAP;
    	model.addAttribute("wordstatusmap", wordstatusmap);
        return "admin/wordofmouth/wordofmouthAdd";
    }
    /**
     * 添加
     * @param 
     * @return
     */
    @PostMapping("/add")
    @ResponseBody
    public Object add(@Valid Wordofmouth word) {
    	//检查口碑姓名和口碑手机号是否已经存在
		Map<String,Object> columnMap = new HashMap<String,Object>();
		columnMap.put("stuname", word.getStuname());
		columnMap.put("stuphone", word.getStuphone());
		List<Wordofmouth> wordList = wordofmouthService.selectByMap(columnMap);
		if(wordList!=null&&wordList.size()>0){
			return renderError("该口碑信息已录入,请重新输入！");
		}else{
			word.setCreatetime(new Date());
			boolean b = wordofmouthService.insert(word);
			if (b) {
	            return renderSuccess("添加成功！");
	        } else {
	            return renderError("添加失败！");
	        }
		}
    }
    /**
     * 编辑页面
     * @return
     */
    @GetMapping("/editPage")
    public String editPage(Model model, Long id) {
    	//查询口碑信息
    	Wordofmouth word = wordofmouthService.selectById(id);
    	model.addAttribute("word", word);
    	//获取口碑状态
    	Map<String, String> wordstatusmap = ConstantUtils.WORDSTATUSMAP;
    	model.addAttribute("wordstatusmap", wordstatusmap);
        return "admin/wordofmouth/wordofmouthEdit";
    }
    /**
     * 编辑
     * @param 
     * @return
     */
    @PostMapping("/edit")
    @ResponseBody
    public Object edit(@Valid Wordofmouth word) {
    	boolean b = false;
		String msg = "编辑失败！";
    	Wordofmouth oldWord = wordofmouthService.selectById(word.getId());
    	//如果是原口碑信息不再验证口碑是否重复
    	if(oldWord.getStuname().equals(word.getStuname())&&oldWord.getStuphone().equals(word.getStuphone())){
    		b = wordofmouthService.updateById(word);
    	}else{
    		//检查口碑姓名和口碑手机号是否已经存在
    		Map<String,Object> columnMap = new HashMap<String,Object>();
    		columnMap.put("stuname", word.getStuname());
    		columnMap.put("stuphone", word.getStuphone());
    		List<Wordofmouth> wordList = wordofmouthService.selectByMap(columnMap);
    		if(wordList!=null&&wordList.size()>0){
    			msg = "该口碑信息已录入,请重新输入！";
    		}else{
    			b = wordofmouthService.updateById(word);
    			msg = "编辑成功！";
    		}
    	}
        if (b) {
            return renderSuccess(msg);
        } else {
            return renderError(msg);
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
        boolean b = wordofmouthService.deleteById(id);
        if (b) {
            return renderSuccess("删除成功！");
        } else {
            return renderError("删除失败！");
        }
    }
    /**
     * 添加页面
     * @return
     */
    @GetMapping("/showCountPage")
    public String showCountPage() {
        return "admin/wordofmouth/showCount";
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
    	if (StringUtils.isNotBlank(begintime)) {
    		map.put("begintime", begintime); 
    		if (StringUtils.isNotBlank(endtime)) {
        		map.put("endtime", endtime);
            }
        }else{
        	endtime = DateUtil.fromDateToStringN(new Date());
        	map.put("flag", "1");
        }
    	//获取口碑状态
    	Map<String, String> wordstatusmap = ConstantUtils.WORDSTATUSMAP;
    	//获取分月对照表
    	Map<String, String> monthmap = ConstantUtils.MONTHMAP;
    	List<Map> countStatusList;
    	if(StringUtils.isBlank(flag)){
    		//获取每个口碑状态的数量                                                                          
        	countStatusList = wordofmouthService.selectWordStatusByHashMap(map);
    	}else{
    		//为sql添加拼接月份查询,如果该月份没有就设为0
    		int len = 1;
    		List<String> monList = new ArrayList<String>();
    		monList.add("01");
    		map.put("monList", monList);
        	if(StringUtils.isNotBlank(endtime)){
        		monList = new ArrayList<String>();
        		len = Integer.valueOf(endtime.substring(5,7));
        		for (int i = 1; i < len+1; i++) {
        			String mon = "";
					if(i<10){
						mon = "0"+i;
					}else{
						mon = String.valueOf(i);
					}
					monList.add(mon);
    			}
        		map.put("monList", monList);
        	}
    		//获取每个月份状态的数量                                                                          
        	countStatusList = wordofmouthService.selectWordStatusByMonHashMap(map);
    	}
    	
    	List<Integer> countStatus= new ArrayList<Integer>();                           
    	List<String> xList= new ArrayList<String>();                              
    	for (Map countStatusMap : countStatusList) {
    		countStatus.add(Integer.valueOf(countStatusMap.get("stunamecount").toString()));
    		if(StringUtils.isBlank(flag)){
    			xList.add(wordstatusmap.get(countStatusMap.get("status").toString()));   
    		}else{
    			xList.add(monthmap.get(countStatusMap.get("MON")+""));
    		}
		}                                                                           
    	dataMap.put("avgScore", countStatus);                                        
    	dataMap.put("xList", xList);                                              
    	return dataMap;                                                           
    }   
    /**
     * 按查询结果导出excel
     * @param columns
     * @param Rows
     * @throws Exception 
     */
    @PostMapping("/exportWordofmouthExcel")
    @ResponseBody
    public String exportWordofmouthExcel(HttpServletRequest req, HttpServletResponse resp,@RequestBody Map map) throws Exception{
    	LinkedHashMap<String,String> titleMap = new LinkedHashMap<String,String>(); 
    	//获取表头
    	JSONArray columnsJsonArray = JSONArray.fromObject(map.get("columns"));
    	List<Map<String,Object>> mapListJsonColumns = (List<Map<String,Object>>)columnsJsonArray;
    	//反射获取实体类中的字段名
    	Field[] fs=Wordofmouth.class.getDeclaredFields();
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
    	List<WordofmouthVo> wordofmouthVoList = new ArrayList<WordofmouthVo>();
    	for (Map<String, Object> dataMap : mapListJsonDatagridRows) {
    		WordofmouthVo word = new WordofmouthVo(); 
    		word.setId(Long.valueOf(dataMap.get("id").toString()));
    		word.setStuname(dataMap.get("stuname").toString());
    		word.setStuphone(dataMap.get("stuphone").toString());
    		word.setTeaname(dataMap.get("teaname").toString());
    		word.setTeaphone(dataMap.get("teaphone").toString());
    		word.setRemark(dataMap.get("remark").toString());
    		word.setCreatetime(dataMap.get("createtime").toString());
    		wordofmouthVoList.add(word);
		}
    	String path = req.getSession().getServletContext().getRealPath("/")+ConstantUtils.UPLOAD_PATH+File.separator;
    	String fileName = ExcelUitl.listToExcelFile(wordofmouthVoList, titleMap, "口碑信息列表", 1000, resp,path);
    	return fileName;
    }
}