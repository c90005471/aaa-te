package com.aaa.controller;

import java.io.File;
import java.io.InputStream;
import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.text.SimpleDateFormat;
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

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.ServletRequestDataBinder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.aaa.commons.base.BaseController;
import com.aaa.commons.result.PageInfo;
import com.aaa.commons.utils.CalBonusesUtil;
import com.aaa.commons.utils.ConstantUtils;
import com.aaa.commons.utils.ExcelUitl;
import com.aaa.commons.utils.IdnoUtil;
import com.aaa.mapper.StudentMapper;
import com.aaa.model.Organization;
import com.aaa.model.Returnrecord;
import com.aaa.model.Student;
import com.aaa.model.StudentCompany;
import com.aaa.model.vo.StudentCompanyVo;
import com.aaa.model.vo.TeacherPlanExcelVo;
import com.aaa.service.IOrganizationService;
import com.aaa.service.IStudentCompanyService;
import com.aaa.service.IStudentService;
import com.baomidou.mybatisplus.mapper.EntityWrapper;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author chenjian
 * @since 2017-09-14
 */
@Controller
@RequestMapping("/student")
public class StudentController extends BaseController {

    @Autowired private IStudentService studentService;
    @Autowired private IStudentCompanyService studentCompanyService;
    @Autowired
    private IOrganizationService organizationService;
    
    @GetMapping("/manager")
    public ModelAndView manager(String flag) {//是否已毕业
    	ModelAndView mv = new ModelAndView ();
    	if(StringUtils.isNotBlank(flag)){
    		mv.setViewName("admin/student/studentByList");
    		mv.addObject("flag", flag);
    	}else{
    		mv.setViewName("admin/student/studentList");
    	}
        return mv;
    }
    
    @PostMapping("/dataGrid")
    @ResponseBody
    public PageInfo dataGrid(Student student, Integer page, Integer rows, String sort,String order ,Long orgid,String flag) {
        PageInfo pageInfo = new PageInfo(page, rows, sort, order);
        Map<String, Object> condition = new HashMap<String, Object>();
        if(student!=null){
        	//拼接过滤条件
        	if(student.getId()!=null){
        		condition.put("id", student.getId());//班级id
        	}
        	if(orgid!=null){//校区或专业的id 
        		String idstr = findOrgList(orgid+"","");//获取校区或专业下所有的子类
        		if(StringUtils.isNotBlank(idstr)&&idstr.length()>1){
        			idstr = idstr.substring(0,idstr.length()-1);
        			condition.put("orgids", idstr);
        		}
        	}
        	if(StringUtils.isNotBlank(student.getStuname())){
        		condition.put("stuname", student.getStuname());//学生姓名
        	}
        	if(StringUtils.isNotBlank(student.getQq())){
        		condition.put("qq", student.getQq());//学生qq
        	}
        	if(StringUtils.isNotBlank(student.getSchoolname())){
        		condition.put("schoolname", student.getSchoolname());//学生毕业院校
        	}
        }
        if(StringUtils.isNotBlank(flag)){
        	condition.put("flag", flag);//已毕业
        }else{
        	condition.put("flag", "0");//未毕业
        }
        pageInfo.setCondition(condition);
        studentService.selectDataGrid(pageInfo);
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
        return "admin/student/studentAdd";
    }
    @GetMapping("/addManyPage")
    public String addManyPage(String flag,Model model) {
    	//flag为标识导入毕业信息
    	model.addAttribute("flag",flag);
    	return "admin/student/studentAddMany";
    }
    
    /**
     * 添加
     * @param 
     * @return
     */
    @PostMapping("/add")
    @ResponseBody
    public Object add(@Valid Student student) {
        student.setCreatetime(new Date());
        boolean b = studentService.insert(student);
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
        boolean b = studentService.deleteById(id);
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
    @GetMapping("/editPage")
    public String editPage(Model model, Long id,String flag) {
        Map<String, Object> selectStuById = studentService.selectStuById(id);
        Map<String, Object>  studentCompany= studentService.selectStudentCompanyById(id);
        //离校时间取班级的结束时间
        if(selectStuById.get("leaschooltime")!=null){
        	if(studentCompany==null){
        		studentCompany = new HashMap<String, Object>();
        		studentCompany.put("leaschooltime", selectStuById.get("leaschooltime"));
        	}
        }
        model.addAttribute("student", selectStuById);
        model.addAttribute("studentCompany", studentCompany);
        if(StringUtils.isNotBlank(flag)){
        	return "admin/student/studentByEdit";
        }else{
        	return "admin/student/studentEdit";
        }
    }
    
    /**
     * 编辑
     * @param 
     * @return
     */
    @PostMapping("/edit")
    @ResponseBody
    public Object edit(@Valid Student student) {
       // student.setUpdateTime(new Date());
        boolean b = studentService.updateStudentById(student,getUserId());
        if (b) {
            return renderSuccess("编辑成功！");
        } else {
            return renderError("编辑失败！");
        }
    }
    /**
     * 编辑毕业学生信息
     * @param 
     * @return
     */
    @PostMapping("/editBy")
    @ResponseBody
    public Object editBy(@Valid StudentCompany studentCompany,Student student) {
       // student.setUpdateTime(new Date());
        boolean b = studentService.updateByStudentById(student,studentCompany,getUserId());
        if (b) {
            return renderSuccess("编辑成功！");
        } else {
            return renderError("编辑失败！");
        }
    }
    /**
     * 描述:
     * 作者:林增辉
     * 时间:2017-9-21
     * @return
     */
    @PostMapping("/getDegree")
    @ResponseBody
    public Object getDegree() {
    	List<Map<String, Object>> degree = studentService.getDegree();
    	return degree;
    }
    
    /**
     * 描述:
     * 作者:林增辉
     * 时间:2017-9-21
     * @return
     */
    @PostMapping("/getMajor")
    @ResponseBody
    public Object getMajor() {
    	List<Map<String, Object>> major = studentService.getMajor();
    	return major;
    }
    /**
     * 描述:
     * 作者:林增辉
     * 时间:2017-9-21
     * @return
     */
    @PostMapping("/getClassById")
    @ResponseBody
    public Object getClassById(Long id) {
    	List<Map<String, Object>> classById = studentService.getClassById(id);
    	return classById;
    }
    /**
     * 导出所有的学生
     * @throws Exception 
     */
    @GetMapping("/exportExcelStudentByClassId")
    public void  exportExcelStudentByClassId(Long classid,HttpServletResponse resp,String flag) throws Exception{
    	List stuList = null;
    	if(StringUtils.isNotBlank(flag)){
    		stuList = studentService.selectStudentVoList(classid);
    	}else{
    		EntityWrapper<Student> wrapper = new EntityWrapper<Student>();
    		Student student = new Student();
    		wrapper.setEntity(student);
    		wrapper.addFilter("class_id = {0}", classid);// 添加过滤条件
    		stuList = studentService.selectList(wrapper);
    	}
    	
		/*System.out.println(stuList);*/
		LinkedHashMap<String,String> map = new LinkedHashMap<String,String>();
		//map.put("id", "编号");
		map.put("stuno", "学号");
		map.put("stuname", "学生姓名");
		if(StringUtils.isNotBlank(flag)){
			map.put("companyname", "公司名称");
			map.put("prosalary", "试用期工资");
			map.put("forsalary", "正式工资");
			map.put("xphone", "现手机号");
		}else{
			map.put("idno", "身份证号");
			map.put("phone", "手机号码");
			map.put("address", "地址");
			map.put("qq", "QQ号码");
			map.put("deleteFlag", "0在校1不在校");
			map.put("createtime", "入学时间");
			map.put("schoolname", "毕业(在读)院校");
			map.put("major", "专业  (在校所学)");
			map.put("degree", "文化程度");
			map.put("familyPhone", "家人联系方式");
			//map.put("stufl", "学生分类");
			ExcelUitl.listToExcel(stuList, map, "学生列表", 1000, resp);
		}
		
    }
    /**
     * 批量导入学生
     * flag 标识导入的是学生毕业信息
     * @throws Exception 
     */
    @RequestMapping("/importExcelStudentByClassId")
    @ResponseBody
    public Object  importExcelStudentByClassId(Long classid,String flag,@RequestParam MultipartFile mf) throws Exception{
    	/*System.out.println(stuList);
    	System.out.println(mf.getName());*/
    	LinkedHashMap<String,String> map = new LinkedHashMap<String,String>();
    	InputStream in = mf.getInputStream();
    	map.put("stuno", "学号");
    	map.put("stuname", "学生姓名");
    	if(StringUtils.isNotBlank(flag)){
    		map.put("isreporteaxm", "是否上报考试申请");
    		map.put("iseaxm", "是否参加考试");
    		map.put("eaxmstat", "考试情况");
    		map.put("isjob", "是否就业");
    		//性别
    		//map.put("sex", "性别");
    		//学历
    		//map.put("degree", "学历");
    		map.put("leaschooltime", "离校时间");
    		map.put("companyaddr", "就业城市");
    		map.put("citylev", "城市级别");
    		map.put("companyname", "就业企业");
    		map.put("station", "岗位");
    		map.put("prosalary", "试用工资");
    		map.put("forsalary", "转正工资");
    		map.put("xphone", "联系方式");
    		map.put("teachername", "就业老师");
    		map.put("bonus", "就业奖金");
    		map.put("checkstat","审核结果");
    		List<StudentCompanyVo> excelToList = ExcelUitl.excelToList(in, "毕业信息列表", StudentCompanyVo.class, map, null);
    		List<StudentCompany> excelToListNew = new ArrayList<StudentCompany>();
    		excelToListNew = studentService.selectStudentCompanyByExcel(excelToList,getUserId());
    		//boolean b = studentCompanyService.insertBatch(excelToListNew);//批量插入数据到数据库
    		boolean b =  studentCompanyService.addOrUpdStudentCompany(excelToListNew);
    		if (b) {
                return renderSuccess("批量添加成功！"+excelToListNew.size()+"名同学！");
            } else {
                return renderError("添加失败！");
            }
    	}else{
    		//map.put("id", "编号");
        	map.put("idno", "身份证号");
        	map.put("phone", "手机号码");
        	map.put("address", "地址");
        	map.put("qq", "QQ号码");
        	map.put("deleteFlag", "0在校1不在校");
        	map.put("createtime", "入学时间");
        	map.put("schoolname", "毕业(在读)院校");
        	map.put("major", "专业  (在校所学)");
        	map.put("degree", "文化程度");
        	map.put("familyPhone", "家人联系方式");
        	List<Student> excelToList = ExcelUitl.excelToList(in, "学生列表", Student.class, map, null);
        	List<Student> excelToListNew = new ArrayList<Student>();
        	for (Student student : excelToList) {
        		student.setClassId(classid);
        		excelToListNew.add(student);
    		}
        	boolean b = studentService.insertBatch(excelToListNew);//批量插入数据到数据库
        	if (b) {
                return renderSuccess("批量添加成功！"+excelToListNew.size()+"名同学！");
            } else {
                return renderError("添加失败！");
            }
    	}
    }
    /**
     * 跳转回访记录页面
     */
    @RequestMapping("/returnCordPage")
    public String returnCordPage(Model model, Long id){
    	model.addAttribute("id",id);
    	return "admin/student/studentReturnCordPage";
    }
    /**
     * 回访记录列表
     */
    @ResponseBody
    @RequestMapping("/returnCordDataGrid")
    public PageInfo returnCordDataGrid(Integer page, Integer rows, String sort,String order ,Long studentId){
    	PageInfo pageInfo = new PageInfo(page, rows, sort, order);
    	Map<String, Object> condition = new HashMap<String, Object>();
    	condition.put("studentId", studentId);
    	pageInfo.setCondition(condition);
        studentService.selectRerturnCordDataGrid(pageInfo);
        return pageInfo;
    }
    /**
     * 跳转添加页面
     */
    @RequestMapping("/addReturnRecordPage")
    public String addReturnRecordPage(Model model, Long studentId){
    	//获取登陆用户信息
    	model.addAttribute("userId",getUserId());
    	model.addAttribute("userName",getStaffName());
    	model.addAttribute("studentId",studentId);
    	return "admin/student/studentReturnRecordAdd";
    }
    /**
     * 添加
     * @param 
     * @return
     */
    @PostMapping("/studentReturnCordAdd")
    @ResponseBody
    public Object studentReturnCordAdd(@Valid Returnrecord returnrecord) {
        boolean b = studentService.insertReturnrecord(returnrecord);
        if (b) {
            return renderSuccess("添加成功！");
        } else {
            return renderError("添加失败！");
        }
    }
    /**
     * 检查是否是本人编辑
     */
    @PostMapping("/studentReturnCordCheckEdit")
    @ResponseBody
    public Object checkEditReturnRecordPage(Model model, Long id){
    	//获取登陆用户信息
    	Long userId = getUserId();
    	model.addAttribute("userId",userId);
    	model.addAttribute("userName",getStaffName());
    	Returnrecord returnrecord = studentService.selectReturnRecordById(id);
    	if (!userId.equals(returnrecord.getUserId())) {
    		return renderError("您没有权限修改别人的回访记录信息!");
        } else {
            return renderSuccess();
        }
    }
    /**
     * 跳转编辑页面
     */
    @RequestMapping("/editReturnRecordPage")
    public String editReturnRecordPage(Model model, Long id){
    	//获取登陆用户信息
    	Long userId = getUserId();
    	model.addAttribute("userId",userId);
    	model.addAttribute("userName",getStaffName());
    	Returnrecord returnrecord = studentService.selectReturnRecordById(id);
    	model.addAttribute("returnrecord",returnrecord);
    	return "admin/student/studentReturnRecordEdit";
    }
    /**
     * 编辑
     * @param 
     * @return
     */
    @PostMapping("/studentReturnCordEdit")
    @ResponseBody
    public Object studentReturnCordEdit(@Valid Returnrecord returnrecord) {
        boolean b = studentService.updateReturnrecordById(returnrecord);
        if (b) {
            return renderSuccess("编辑成功！");
        } else {
            return renderError("编辑失败！");
        }
    }
    /**
     * 删除回访记录信息
     */
    @PostMapping("/returnRecordDelete")
    @ResponseBody
    public Object returnRecordDelete(Long id) {
    	Returnrecord returnrecord = studentService.selectReturnRecordById(id);
    	//判断是否是本人删除
    	if(getUserId().equals(returnrecord.getUserId())){
    		boolean b = studentService.deleteReturnRecordById(id);
            if (b) {
                return renderSuccess("删除成功！");
            } else {
                return renderError("删除失败！");
            }
    	}else{
    		return renderError("您没有权限删除别人的回访记录信息!");
    	}
    }
    
    
    
    /**
     * 按查询结果导出excel
     * @param columns
     * @param Rows
     * @throws Exception 
     */
    @PostMapping("/exportStudentByExcel")
    @ResponseBody
    public String exportStudentByExcel(HttpServletRequest req, HttpServletResponse resp,@RequestBody Map map) throws Exception{
    	LinkedHashMap<String,String> titleMap = new LinkedHashMap<String,String>(); 
    	//获取表头
    	JSONArray columnsJsonArray = JSONArray.fromObject(map.get("columns"));
    	List<Map<String,Object>> mapListJsonColumns = (List<Map<String,Object>>)columnsJsonArray;
    	//反射获取实体类中的字段名
    	Field[] fs=StudentCompanyVo.class.getDeclaredFields();
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
    	List<StudentCompanyVo> studentCompanyVoList = new ArrayList<StudentCompanyVo>();
    	for (Map<String, Object> dataMap : mapListJsonDatagridRows) {
    		StudentCompanyVo vo = new StudentCompanyVo();
    		//获取字段名
    		for (String columnStr : titleMap.keySet()) {
    			// 将属性首字母大写，并获取getter方法名
    			String firstLetter = columnStr.substring(0, 1).toUpperCase();
    			String setter = "set" + firstLetter + columnStr.substring(1);
    			// getMethod第一个参数是方法名，第二个参数是该方法的参数类型，
    			Method setMethod = vo.getClass().getMethod(setter, String.class);
    			// invoke第一个参数是具体调用该方法的对象,第二个参数是执行该方法的具体参数
    			setMethod.invoke(vo, dataMap.get(columnStr));//把得到的值放到实体中
    		}
    		//根据学号获取身份证得到性别
    		Map<String,Object> columnMap = new HashMap<String,Object>();
    		columnMap.put("stuno", vo.getStuno());
    		List<Student> stuList = studentService.selectByMap(columnMap);
    		if(stuList!=null&&stuList.size()>0){
    			vo.setSex(IdnoUtil.getSexByIdno(stuList.get(0).getIdno()));
    		}
    		if(StringUtils.isNotBlank(vo.getIsjob())){
    			//特殊处理 自主就业
        		if(StringUtils.isBlank(vo.getTeachername())){
        			vo.setTeachername(ConstantUtils.ZIZHUJIUYE);
        		}
    		}
    		studentCompanyVoList.add(vo);
		}
    	String path = req.getSession().getServletContext().getRealPath("/")+ConstantUtils.UPLOAD_PATH+File.separator;
    	String fileName = ExcelUitl.listToExcelFile(studentCompanyVoList, titleMap, "毕业信息列表", 1000, resp,path);
    	return fileName;
    }
    /**
     * 计算毕业奖金
     */
    @RequestMapping("/calBonus")
    @ResponseBody
    public String calBonus(StudentCompany com){
    	//获取学生的学历
    	String bon = studentCompanyService.calBonus(com);
    	return bon;
    }
    /**
     * 编辑
     * @param model
     * @param id
     * @return
     */
    @GetMapping("/showPage")
    public String showPage(Model model, Long id) {
        Map<String, Object> selectStuById = studentService.selectStuById(id);
        Map<String, Object>  studentCompany= studentService.selectStudentCompanyById(id);
        model.addAttribute("student", selectStuById);
        model.addAttribute("studentCompany", studentCompany);
        return "admin/student/studentByShow";
    }
    /**
     * 毕业学生审核列表
     * @param flag
     * @return
     */
    @GetMapping("/auditmanager")
    public ModelAndView auditmanager() {
    	ModelAndView mv = new ModelAndView ();
    	mv.setViewName("admin/student/studentByAuditList");
        return mv;
    }
    /**
     * 编辑
     * @param model
     * @param id
     * @return
     */
    @GetMapping("/audit")
    public String audit(Model model, Long id) {
        Map<String, Object> selectStuById = studentService.selectStuById(id);
        Map<String, Object>  studentCompany= studentService.selectStudentCompanyById(id);
        model.addAttribute("student", selectStuById);
        model.addAttribute("studentCompany", studentCompany);
        return "admin/student/studentAudit";
    }
    /**
     * 转化页面中获取字符串日期
     * @param request
     * @param binder
     */
    @InitBinder
    protected void init(HttpServletRequest request, ServletRequestDataBinder binder) {
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        dateFormat.setLenient(false);
        binder.registerCustomEditor(Date.class,"leaschooltime", new CustomDateEditor(dateFormat, false));
    }
    /**
     * 审核查看
     */
    @GetMapping("/auditShow")
    public String auditShow(Model model, Long id) {
        Map<String, Object> selectStuById = studentService.selectStuById(id);
        Map<String, Object>  studentCompany= studentService.selectStudentCompanyById(id);
        model.addAttribute("student", selectStuById);
        model.addAttribute("studentCompany", studentCompany);
        return "admin/student/studentAuditShow";
    }
}
