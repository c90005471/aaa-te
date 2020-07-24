package com.aaa.controller;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.aaa.model.vo.UserVo;
import com.aaa.service.IUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.aaa.commons.base.BaseController;
import com.aaa.commons.result.PageInfo;
import com.aaa.commons.utils.StringUtils;
import com.aaa.model.ExamPaper;
import com.aaa.model.Organization;
import com.aaa.service.IExamPaperService;
import com.aaa.service.IOrganizationService;
@Controller
@RequestMapping("/examPaper")
public class ExamPaperController extends BaseController {
	@Autowired
	private IExamPaperService examPaperService; 
	@Autowired
    private IOrganizationService organizationService;

	@Autowired
    private IUserService userService;

	/**
	 * 试卷列表页面
	 * @return
	 */
	@RequestMapping("/manager")
	public String manager(){
		return "admin/examPaper/examPaper";
	}
	/**
     * 试卷列表页面回调方法
     * @return
     */
    @PostMapping("/dataGridManager")
    @ResponseBody
    public Object dataGridManager(Integer page, Integer rows, String sort, String order,ExamPaper examPaper,Long orgid,String flag,String graduate) {
        PageInfo pageInfo = new PageInfo(page, rows, sort, order);
        Map<String, Object> condition = new HashMap<String, Object>();
        if(orgid!=null){//校区或专业的id 
    		String idstr = findOrgList(orgid+"","");//获取校区或专业下所有的子类
    		if(StringUtils.isNotBlank(idstr)&&idstr.length()>1){
    			idstr = idstr.substring(0,idstr.length()-1);
    			condition.put("orgids", idstr);
    		}
    	}
        if(examPaper!=null&& examPaper.getClassid()!=null){
            condition.put("classid", examPaper.getClassid());
        }
        if (StringUtils.isNotBlank(examPaper.getTitle())) {
            condition.put("title", examPaper.getTitle());
        }
        if(examPaper.getType()!=null){
        	condition.put("type", examPaper.getType());
        }
        Long userId = getUserId();

        UserVo userVo = userService.selectVoById(userId);
        //显示当前创建人创建的试卷
//        condition.put("creator", userId);
        condition.put("graduate", graduate);
        condition.put("orgids", userVo.getOrganizationId());

        if(StringUtils.isNotBlank(flag)){//如果显示考试记录 并且 登陆者为admin时
        	if(userId==1l){
        		condition.put("creator", null);
        	}
        }
        pageInfo.setCondition(condition);
        examPaperService.selectDataGrid(pageInfo);
        return pageInfo;
    }
/**
     * 试卷列表页面回调方法
     * @return
     */
    @PostMapping("/dataGrid")
    @ResponseBody
    public Object dataGrid(Integer page, Integer rows, String sort, String order,ExamPaper examPaper,Long orgid,String flag,String graduate) {
        PageInfo pageInfo = new PageInfo(page, rows, sort, order);
        Map<String, Object> condition = new HashMap<String, Object>();
        if(orgid!=null){//校区或专业的id
    		String idstr = findOrgList(orgid+"","");//获取校区或专业下所有的子类
    		if(StringUtils.isNotBlank(idstr)&&idstr.length()>1){
    			idstr = idstr.substring(0,idstr.length()-1);
    			condition.put("orgids", idstr);
    		}
    	}
        if(examPaper!=null&& examPaper.getClassid()!=null){
            condition.put("classid", examPaper.getClassid());
        }
        if (StringUtils.isNotBlank(examPaper.getTitle())) {
            condition.put("title", examPaper.getTitle());
        }
        if(examPaper.getType()!=null){
        	condition.put("type", examPaper.getType());
        }
        Long userId = getUserId();
        //显示当前创建人创建的试卷
        condition.put("creator", userId);
        condition.put("graduate", graduate);
        if(StringUtils.isNotBlank(flag)){//如果显示考试记录 并且 登陆者为admin时
        	if(userId==1l){
        		condition.put("creator", null);
        	}
        }
        pageInfo.setCondition(condition);
        examPaperService.selectDataGrid(pageInfo);
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
    /**
     * 添加试卷信息
     */
    @GetMapping("/addPage")
    public String addPage(Model model) {
        return "admin/examPaper/examPaperAdd";
    }
    /**
     * 添加试题内容和选项
     */
    @PostMapping("/add")
    @ResponseBody
    public Object add(ExamPaper examPaper) {
    	examPaper.setCreator(getUserId());
    	examPaper.setCreatetime(new Date());
    	examPaperService.insert(examPaper);
        return renderSuccess("添加成功");
    }
    
    /**
     * 修改试题页
     */
    @GetMapping("/editPage")
    public String editPage(Model model, Long id) {
    	ExamPaper examPaper = examPaperService.selectById(id);
    	model.addAttribute("examPaper",examPaper);
        return "admin/examPaper/examPaperEdit";
    }
    /**
     * 编辑试题信息页
     */
    @PostMapping("/edit")
    @ResponseBody
    public Object edit(ExamPaper examPaper) {
    	examPaperService.updateById(examPaper);
        return renderSuccess("修改成功！");
    }
    
    /**
     * 删除试题
     * @param id
     * @return
     */
    @PostMapping("/delete")
    @ResponseBody
    public Object delete(Long id) {
    	examPaperService.deleteExamPaperAndInfoById(id);
        return renderSuccess("删除成功！");
    }
    /**
     * 跳转智能组卷页面
     */
    @GetMapping("/showPage")
    public String showPage(Model model, Long id) {
    	ExamPaper examPaper = examPaperService.selectById(id);
    	model.addAttribute("examPaper",examPaper);
        return "admin/examPaper/examPaperShow";
    }
    /**
     * 智能组卷生成方法
     * @param id 试卷id
     * @param sumStr 科目id 抽取数量
     * @param xin 新增或者重新生成
     * @return
     */
    @PostMapping("/make")
    @ResponseBody
    public Object make(Long id,String sumStr,String xin){
    	examPaperService.addExamPaperAndTopicInfo(id,sumStr,xin);
    	return renderSuccess("操作成功");
    }
    
    /**
     * 智能组卷回调的datagrid方法
     * @param id  试卷id
     */
    @PostMapping("/paperInfoDataGrid")
    @ResponseBody
    public Object paperInfoDataGrid(Integer page, Integer rows, String sort, String order,Long id) {
        PageInfo pageInfo = new PageInfo(page, rows, sort, order);
        Map<String, Object> condition = new HashMap<String, Object>();
        condition.put("paperid", id);
        pageInfo.setCondition(condition);
        examPaperService.selectPaperInfoPage(pageInfo);
        return pageInfo;
    }
    /**
     * 智能组卷删除试题
     * @param id
     * @return
     */
    @PostMapping("/deletePaperInfo")
    @ResponseBody
    public Object deletePaperInfo(Long id) {
    	examPaperService.deletePaperInfoById(id);
        return renderSuccess("删除成功！");
    }

    /**
     * 跳转手动组卷页面
     */
    @GetMapping("/manualPage")
    public String manualPage(Model model, Long id) {
        ExamPaper examPaper = examPaperService.selectById(id);
        model.addAttribute("examPaper",examPaper);
        return "admin/examPaper/examManualPageShow";
    }

    /**
     * 手动组卷回调的datagrid方法
     * @param id  试卷id
     */
    @PostMapping("/questionInfoDataGrid")
    @ResponseBody
    public Object questionInfoDataGrid(Integer page, Integer rows, String sort, String order,Long id) {
        PageInfo pageInfo = new PageInfo(page, rows, sort, order);
        Map<String, Object> condition = new HashMap<String, Object>();
        condition.put("topictype", id);
        pageInfo.setCondition(condition);
        examPaperService.selectQuestionInfoPage(pageInfo);
        return pageInfo;
    }

    /**
     * 手动组卷添加试题
     * @param paperid
     * @param infoid
     * @return
     */
    @PostMapping("/addPaperByManual")
    @ResponseBody
    public Object addPaperByManual(Integer paperid,Integer infoid){
        int len =  examPaperService.addPaperByManual(paperid,infoid);
        return len;
    }

    /**
     * 新试卷列表页面
     * @return
     */
    @RequestMapping("/newManager")
    public String newManager(){
        return "admin/newExamPaper/newExamPaper" ;
    }

    /**
     * 新修改试题页
     */
    @GetMapping("/newEditPage")
    public String newEditPage(Model model, Long id) {
        ExamPaper examPaper = examPaperService.selectById(id);
        model.addAttribute("examPaper",examPaper);
        return "admin/newExamPaper/examPaperEdit";
    }

    /**
     * 新添加试卷信息
     */
    @GetMapping("/newAddPage")
    public String newAddPage(Model model) {
        return "admin/newExamPaper/newExamPaperAdd" ;
    }

    /**
     * 新编辑试题信息页
     */
    @PostMapping("/newEdit")
    @ResponseBody
    public Object newEdit(ExamPaper examPaper,String orgid,String classes) {
        //查询 已经有的 examPaper
        ExamPaper examPaper1 = examPaperService.selectById(examPaper.getId());
        if (examPaper1 != null){
            String[] strs =  classes.split(",");
            for (int i = 0; i < strs.length; i++) {
                examPaperService.addPaperClass(examPaper1.getId().intValue(),Integer.parseInt(strs[i]));
            }
        }
        return renderSuccess("修改成功！");
    }
}
