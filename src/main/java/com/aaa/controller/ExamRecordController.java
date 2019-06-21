package com.aaa.controller;

import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.aaa.commons.base.BaseController;
import com.aaa.commons.result.PageInfo;
import com.aaa.commons.utils.ExcelUitl;
import com.aaa.model.ExamRecord;
import com.aaa.model.Organization;
import com.aaa.model.vo.ExamRecordVo;
import com.aaa.service.IExamRecordService;
import com.aaa.service.IOrganizationService;
/**
 * 类名称：ExamRecordController
 * 类描述： 考试记录表
 * 创建人：sunshaoshan
 * 创建时间：2018-7-27 下午4:47:22
 * @version
 */
@Controller
@RequestMapping("/examRecord")
public class ExamRecordController extends BaseController {
	@Autowired
	private IExamRecordService examRecordService; 
	@Autowired
    private IOrganizationService organizationService;
	/**
	 * 考试记录页面
	 * @return
	 */
	@RequestMapping("/manager")
	public String manager(){
		return "admin/examRecord/examRecord";
	}
	/**
     * 考试记录页面回调方法
     * @return
     */
    @PostMapping("/dataGrid")
    @ResponseBody
    public Object dataGrid(Integer page, Integer rows, String sort, String order,Long paperId) {
        PageInfo pageInfo = new PageInfo(page, rows, sort, order);
        Map<String, Object> condition = new HashMap<String, Object>();
        condition.put("paperId", paperId);//试卷id
        pageInfo.setCondition(condition);
        examRecordService.selectDataGrid(pageInfo);
        return pageInfo;
    }
    /**
     * 递归调用获取该校区或专业下的所有专业
     * @param pid 父id 0    
     * @param idstr 专业id字符串
     * @return 
     */
    private String findOrgList(String pid,String idstr){
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
    /***
     * 显示考试详情
     */
    @RequestMapping("/showExamRecord")
    public String showExamRecord(Long paperId,Model model){
    	model.addAttribute("paperId", paperId);
    	return "admin/examRecord/examRecordShow";
    }
    /**
     * 修改考试状态页
     */
    @GetMapping("/editPage")
    public String editPage(Model model, Long id) {
    	ExamRecord examRecord = examRecordService.selectById(id);
    	model.addAttribute("examRecord",examRecord);
        return "admin/examRecord/examRecordEdit";
    }
    /**
     * 编辑考试状态页
     */
    @PostMapping("/edit")
    @ResponseBody
    public Object edit(ExamRecord examRecord) {
    	examRecordService.updateById(examRecord);
        return renderSuccess("修改成功！");
    }
    /**
     * 按查询结果导出excel
     * @param columns
     * @param Rows
     * @throws Exception 
     */
    @GetMapping("/exportExamRecordByExcel")
    public void exportExamRecordByExcel(Long paperId,HttpServletResponse resp) throws Exception{
    	Map<String, Object> condition = new HashMap<String, Object>();
        condition.put("paperId", paperId);//试卷id
		List<ExamRecordVo> examRecordList = examRecordService.selectExamRecordVoList(condition);
		LinkedHashMap<String,String> map = new LinkedHashMap<String,String>();
		map.put("stuno", "学号");
		map.put("stuname", "姓名");
		map.put("score", "成绩");
		ExcelUitl.listToExcel(examRecordList, map, "成绩列表", 1000, resp);
    }
}
