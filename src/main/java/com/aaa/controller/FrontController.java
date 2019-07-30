package com.aaa.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.swing.JFrame;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.aaa.commons.base.BaseController;
import com.aaa.commons.utils.ConstantUtils;
import com.aaa.commons.utils.DateUtil;
import com.aaa.commons.utils.StringUtils;
import com.aaa.model.Answer;
import com.aaa.model.Course;
import com.aaa.model.Question;
import com.aaa.model.StuEvaluate;
import com.aaa.model.Student;
import com.aaa.model.TblScl;
import com.aaa.model.TblSclRecord;
import com.aaa.model.TblSclRecorddetail;
import com.aaa.model.TeaQuestion;
import com.aaa.model.TeacherDetail;
import com.aaa.model.TeacherPlan;
import com.aaa.model.TestQuestion;
import com.aaa.model.TestQuestionAnswer;
import com.aaa.model.TestQuestionRecord;
import com.aaa.model.Wordofmouth;
import com.aaa.model.vo.DataVo;
import com.aaa.model.vo.UserVo;
import com.aaa.service.ICourseService;
import com.aaa.service.IExamPaperService;
import com.aaa.service.IExamRecordService;
import com.aaa.service.IStuEvaluateService;
import com.aaa.service.IStudentService;
import com.aaa.service.ITblSclFrontService;
import com.aaa.service.ITblSclRecordInsertService;
import com.aaa.service.ITblSclRecorddetailService;
import com.aaa.service.ITeaQuestionService;
import com.aaa.service.ITeacherDetailService;
import com.aaa.service.ITeacherPlanService;
import com.aaa.service.ITestQuestionRecordService;
import com.aaa.service.ITestQuestionService;
import com.aaa.service.IUserService;
import com.aaa.service.IWordofmouthService;
import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.fasterxml.jackson.core.JsonParseException;
import com.fasterxml.jackson.databind.JavaType;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;

/**
 * @author TeacherChen
 * @description 前台页面控制器（国耻日）
 * @company AAA软件
 * 2017-9-18下午11:23:50
 */
@Controller
@RequestMapping("/front")
public class FrontController extends BaseController{
	 @Autowired private IStudentService studentService;
	 @Autowired private IStuEvaluateService stuEvaluateService;
	 @Autowired private ICourseService courseService;
	  @Autowired private ITblSclFrontService tblSclFrontService;
	@Autowired private ITblSclRecorddetailService tblSclRecorddetailService;
	@Autowired private ITblSclRecordInsertService tTblSclRecordInsertService;
	 @Autowired private ITeaQuestionService iTeacherQuestionService;
	 @Autowired private ITeacherDetailService iTeacherDetailService;
	 @Autowired private ITeacherPlanService iTeacherPlanService;
	 @Autowired
	 private IUserService userService;
	 @Autowired
	 private IWordofmouthService wordofmouthService;
	 @Autowired
	 private ITestQuestionService testQuestionService;
	 @Autowired
	 private ITestQuestionRecordService testQuestionRecordService;
	 @Autowired
	 private IExamPaperService examPaperService;
	 @Autowired
	 private IExamRecordService examRecordService;
	@RequestMapping("/question")
	public  String  toQuestionPage() {
		return "front/question";
	}
	@RequestMapping("/login")
	public  String  toLoginPage() {
		return "front/login";
	}
	/**
	 * 跳转评价老师登录界面
	 * @return
	 */
	@RequestMapping("/tealogin")
	public  String  tealogin() {
		return "front/tealogin";
	}
	/**
	 * 跳转题目界面
	 * @return
	 */
	@RequestMapping("/teaQuestion")
	public  String  teaQuestion() {
		return "front/teaQuestion";
		
	}

         /**
	 * 跳转评价老师登录界面  ----分模块
	 * @return
	 */
	@RequestMapping("/teaFenlogin")
	public  String  teaFenlogin() {
		return "front/teaFenlogin";
	}
	/**
	 * 跳转题目界面   --分模块
	 * @return
	 */
	@RequestMapping("/teacherQuestion")
	public  String  teacherQuestion() {
		return "front/teacherQuestion";
		
	}

	/**
	 * 跳转评价成功界面
	 * @return
	 */
	@RequestMapping("/thanks")
	public  ModelAndView  thanks(String flag) {
		ModelAndView mv = new ModelAndView("front/thanks");
		mv.addObject("flag",flag);
		return mv;
	}

	@RequestMapping("/findQuestionByChapterId")
	@ResponseBody
	public  List<Question> findQuestionByChapterId(Long chapterid,HttpSession session) {
		 List<Question> questionList= new ArrayList<Question>();
		 EntityWrapper<Course> wrapper = new EntityWrapper<Course>();
		 Course course = new Course();
			wrapper.setEntity(course);
			wrapper.addFilter("pid = {0}", chapterid);// 添加过滤条件
		 List<Course> courseList = courseService.selectList(wrapper);
		 Map<Integer,Long> questionIdTopicIdMap = new HashMap<Integer,Long>();
		 //将所有的知识点封装到试题列表中
		 for (int i = 0; i < courseList.size(); i++) {
			 Question q= new Question();
			// q.setQuestionId(c.getId());
			 //将topicId作为value放到map中，key是0，1，2，3，4，下标
			 questionIdTopicIdMap.put(i, courseList.get(i).getId());
			 q.setQuestionTitle(courseList.get(i).getCourseName());
			 q.setQuestionItems(ConstantUtils.Question_Items);
			 questionList.add(q);
		}
		 session.setAttribute("questionIdTopicIdMap", questionIdTopicIdMap);
		 return questionList;
	}
	
	@RequestMapping("/checkLogin")
	public  ModelAndView  checkLogin(String stuno,String phone,HttpSession session) {
		ModelAndView mv = new ModelAndView();
		EntityWrapper<Student> wrapper = new EntityWrapper<Student>();
		Student student = new Student();
		wrapper.setEntity(student);
		wrapper.addFilter("stuno = {0}", stuno);// 添加过滤条件
		wrapper.addFilter("phone = {0}", phone);// 添加过滤条件
		Student stuObject = studentService.selectOne(wrapper);
		
		//System.out.println(stuObject);
		if(stuObject==null){//登录失败直接返回登录页面
			mv.addObject("errorMessage", "用户名密码错误");
			mv.setViewName("front/login");
		}else
		{
			//根据学生查询所在的班级的自评计划
			Map stuPlan = studentService.selectCapterByStuId(stuObject.getId());
			if(stuPlan==null){
				mv.addObject("errorMessage", "你所在的班级当前时间段内没有评价计划");
				mv.setViewName("front/login");
				
			}else{
				//System.out.println(stuPlan);
				//判断该学生是否已经自评过，通过学生id和计划ID去数据库中查询，如果有直接返回登录页面
				EntityWrapper<StuEvaluate> stuwrapper = new EntityWrapper<StuEvaluate>();
				StuEvaluate se = new StuEvaluate();
				stuwrapper.setEntity(se);
				stuwrapper.addFilter("planid = {0}", stuPlan.get("id"));// 添加过滤条件
				stuwrapper.addFilter("stuid = {0}", stuObject.getId());// 添加过滤条件
				List<StuEvaluate> selectList = stuEvaluateService.selectList(stuwrapper);
				if(selectList!=null&& selectList.size()>0){
					mv.addObject("errorMessage", "对不起，你已经参加过评价了！");
					mv.setViewName("front/login");
				}else
				{
					mv.addObject("student", stuObject);
					mv.addObject("stuPlan", stuPlan);
					session.setAttribute("student", stuObject);
					session.setAttribute("stuPlan", stuPlan);
					mv.addObject("errorMessage", null);
					mv.setViewName("/front/question");
				}
			}
			
			
		}
		return mv;
	}
	@RequestMapping("/saveStuEvaluate")
	@ResponseBody
	public  Map  saveStuEvaluate(HttpServletRequest req,HttpSession session,ModelAndView mv) throws JsonParseException, JsonMappingException, IOException {
		//获取前台传入的json字符串
		String checkQues= req.getParameter("checkQues");
		//将json字符串转换成list《answer》对象
		ObjectMapper objectMapper = new ObjectMapper();
		JavaType javaType = objectMapper.getTypeFactory().constructParametricType(ArrayList.class, Answer.class);
        List<Answer> answerList = (List<Answer>)objectMapper.readValue(checkQues, javaType);
        //
        Map<Integer,Long> questionIdTopicIdMap = (Map<Integer, Long>) session.getAttribute("questionIdTopicIdMap");
        Student stuObject=(Student) session.getAttribute("student");
        Map stuPlan=(Map) session.getAttribute("stuPlan");
        Map map = new HashMap();
        try {
        	 for (Answer answer : answerList) {
             	StuEvaluate se = new StuEvaluate();
             	se.setStuid(stuObject.getId());
             	se.setPlanid(Long.parseLong(stuPlan.get("id")+""));
             	se.setScore(Integer.parseInt(answer.getAnswer()));
             	se.setTopicid(questionIdTopicIdMap.get(Integer.parseInt(answer.getId()+"")));
             	se.setCreatetime(new Date());
             	stuEvaluateService.insert(se);
     		}
        	 map.put("ret", true);
		} catch (Exception e) {
			 map.put("ret", false);
		}
		return map;
	}	
	
	/**
	 * 跳转到心理在线健康测试登录界面
	 */
	@RequestMapping("/scllogin")
	public String scllogin() {
		return "front/sclLogin";
	}
	
	/**
	 * 检验心理在线健康测试登录，看学号、手机号是否正确
	 * @param stuno
	 * @param phone
	 * @param session
	 * @return
	 */
	@RequestMapping("/checkSclLogin")
	public  ModelAndView  checkSclLogin(String stuno,String phone,HttpSession session) {
		ModelAndView mv = new ModelAndView();
		EntityWrapper<Student> wrapper = new EntityWrapper<Student>();
		Student student = new Student();
		wrapper.setEntity(student);
		wrapper.addFilter("stuno = {0}", stuno);// 添加过滤条件
		wrapper.addFilter("phone = {0}", phone);// 添加过滤条件
		Student stuObject = studentService.selectOne(wrapper);
		if(stuObject==null){//登录失败直接返回登录页面
			mv.addObject("errorMessage", "用户名密码错误");
			mv.setViewName("front/sclLogin");
		}else{
			mv.addObject("student", stuObject);
			session.setAttribute("student", stuObject);
			mv.addObject("errorMessage", null);
			mv.setViewName("/front/sclQuestion");
		}
		return mv;
	}
	
	/**
	  * 跳转心理测试题目界面，只做跳转
	  * @return
	  */
	@RequestMapping("/sclQuestion")
	public  String  toSclQuestionPage() {
		return "front/sclQuestion";
	}
	/**
	 * 查询需要评价的问题
	 * @param questionid 在这里暂时用作教师id
	 * @param session
	 * @return
	 */
	@RequestMapping("/findQuestionByTeaPlanId")
	@ResponseBody
	public  List<Question> findQuestionByTeaPlanId(Long questionid,HttpSession session) {
		/**
		 * 查询问题需要先查询出该教师属于什么角色   
		 */
		UserVo userVo = userService.selectVoById(questionid);
		Long roleId = 2l;//默认是教员的题目
		if(userVo!=null&&userVo.getRolesList()!=null&&userVo.getRolesList().size()>0){
			//获取该教师的角色信息
			roleId = userVo.getRolesList().get(0).getId();
		}
		List<Question> questionList= new ArrayList<Question>();
//		EntityWrapper<TeaQuestion> wrapper = new EntityWrapper<TeaQuestion>();
//		TeaQuestionVo teaQuestionVo = new TeaQuestionVo();
//		wrapper.setEntity(teaQuestion);
//		wrapper.addFilter("questiontype = {0}", type);// 添加过滤条件
		List<TeaQuestion> selectList = iTeacherQuestionService.selectListByRoleId(roleId);
		Map<Integer,Long> questionIdMap = new HashMap<Integer,Long>();
		//将所有的知识点封装到试题列表中
		for (int i = 0; i < selectList.size(); i++) {
			Question q= new Question();
			questionIdMap.put(i, selectList.get(i).getId());
			q.setQuestionTitle(selectList.get(i).getQuestionname());
			q.setQuestionItems(ConstantUtils.Question_Items);
			//将问题分成了两个部分	1:授课教评，2:班级学习
			q.setQuestionType(Integer.parseInt(selectList.get(i).getQuestiontype()));
			questionList.add(q);
		}
		session.setAttribute("questionIdMap", questionIdMap);
		return questionList;
	}
	
	
	/**
	 * 查询分模块教评
	 * @param questionid 在这里暂时用作教师id
	 * @param session
	 * @return
	 */
	@RequestMapping("/findQuestionFenByTeaPlanId")
	@ResponseBody
	public  List<Question> findQuestionFenByTeaPlanId(Long questionid,HttpSession session) {
		/**
		 * 查询问题需要先查询出该教师属于什么角色   
		 */
		UserVo userVo = userService.selectVoById(questionid);
		Long roleId = 2l;//默认是教员的题目
		if(userVo!=null&&userVo.getRolesList()!=null&&userVo.getRolesList().size()>0){
			//获取该教师的角色信息
			roleId = userVo.getRolesList().get(0).getId();
		}
		List<Question> questionList= new ArrayList<Question>();
//		EntityWrapper<TeaQuestion> wrapper = new EntityWrapper<TeaQuestion>();
//		TeaQuestionVo teaQuestionVo = new TeaQuestionVo();
//		wrapper.setEntity(teaQuestion);
//		wrapper.addFilter("questiontype = {0}", type);// 添加过滤条件
		List<TeaQuestion> selectList = iTeacherQuestionService.selecFentListByRoleId(roleId);
		Map<Integer,Long> questionIdMap = new HashMap<Integer,Long>();
		//将所有的知识点封装到试题列表中
		for (int i = 0; i < selectList.size(); i++) {
			Question q= new Question();
			questionIdMap.put(i, selectList.get(i).getId());
			q.setQuestionTitle(selectList.get(i).getQuestionname());
			q.setQuestionItems(ConstantUtils.Question_Items);
			questionList.add(q);
		}
		session.setAttribute("questionIdMap", questionIdMap);
		return questionList;
	}


/**
	 * 心理测试前台显示试题题目
	 * @param chapterid
	 * @param session
	 * @return
	 */
	@RequestMapping("/findSclQuestionByChapterId")
	@ResponseBody
	public  List<Question> findSclQuestionByChapterId(HttpSession session) {
		List<Question> questionList= new ArrayList<Question>();
		/**
		 * baomidou 里面自己封装的类，可以进行条件查询
		 */
		EntityWrapper<TblScl> wrapper = new EntityWrapper<TblScl>();
		TblScl tblScl = new TblScl();
		wrapper.setEntity(tblScl);
		List<TblScl> tblSclList = tblSclFrontService.selectList(wrapper);
		Map<Integer,Integer> questionIdTopicIdMap = new HashMap<Integer,Integer>();
		//将所有的知识点封装到试题列表中
		for (int i = 0; i < tblSclList.size(); i++) {
			Question q= new Question();
			// q.setQuestionId(c.getId());
			//将topicId作为value放到map中，key是0，1，2，3，4，下标
			 questionIdTopicIdMap.put(i, tblSclList.get(i).getId());
			 q.setQuestionTitle(tblSclList.get(i).getItem());
			 q.setQuestionItems(ConstantUtils.TblScl_Items);
			 questionList.add(q);
		}
		 session.setAttribute("questionIdTopicIdMap", questionIdTopicIdMap);
		 return questionList;
	}
	
	/**
	 * 把前台获取的json数据进行处理(处理心理测试界面传过来的数据问题，将其分开放入到数据库)
	 * @return
	 */
	@RequestMapping("/saveSclEvaluate")
	@ResponseBody
	public  Map  saveSclEvaluate(HttpServletRequest req,HttpSession session,ModelAndView mv) throws JsonParseException, JsonMappingException, IOException {
		//获取前台传入的json字符串
		String checkQues= req.getParameter("checkQues");
		//将json字符串转换成list《answer》对象
		ObjectMapper objectMapper = new ObjectMapper();
		JavaType javaType = objectMapper.getTypeFactory().constructParametricType(ArrayList.class, Answer.class);
		List<Answer> answerList = (List<Answer>)objectMapper.readValue(checkQues, javaType);
		Student stuObject=(Student) session.getAttribute("student");
		Map map = new HashMap();
		String dateFormat = DateUtil.fromDateToString(new Date());
		try {
			List<TblSclRecorddetail> tblSclRecorddetailList=new ArrayList<TblSclRecorddetail>();
			for (Answer answer : answerList) {
	      		TblSclRecorddetail tbldetail = new TblSclRecorddetail();
	      		tbldetail.setStudentid(stuObject.getId());
	      		tbldetail.setScoreDetail(Integer.parseInt(answer.getAnswer()));
	      		tbldetail.setSclid(Integer.parseInt(answer.getId()+"")+1);
	      		tbldetail.setCreatetime(dateFormat);
	      		tblSclRecorddetailList.add(tbldetail);
			}
			tblSclRecorddetailService.insertBatch(tblSclRecorddetailList);//批量插入
			
	       	/**
	       	 * 求插入到tblSclRecorddetail详情表中的该学生的当前总分
	       	 */
	       	//获取该学生和时间（测试题提交的时间）(stuObject.getId(),dateString)
	       	List<Map<String, Object>> selectTblSclScore = tTblSclRecordInsertService.selectTblSclScore(stuObject.getId(),dateFormat);
	       	/**
	       	 * 求插入到tblSclRecorddetail详情表中的该学生的阳性得分个数
	       	 */
	       	List<Map<String, Object>> selectTblSclCount = tTblSclRecordInsertService.selectTblSclCount(stuObject.getId(),dateFormat);
	       	//new一个tblSclRecord实体
	       	TblSclRecord tblSclRecord = new TblSclRecord();
	       	tblSclRecord.setStudentId(stuObject.getId());
	       	tblSclRecord.setSunCount(Integer.valueOf(selectTblSclCount.get(0).get("negacount")+""));
	       	tblSclRecord.setSclScore(Integer.valueOf(selectTblSclScore.get(0).get("scoresum")+""));
	       	tblSclRecord.setCreatetime(dateFormat);
	       	tTblSclRecordInsertService.insertTblSclRecord(tblSclRecord);
	       	map.put("ret", true);
		} catch (Exception e) {
			 e.printStackTrace();
			 map.put("ret", false);
		}
		return map;
	}
	
	
	/*学生教评登录检测*/
	@RequestMapping("/checkTeaLogin")
	public ModelAndView checkTeaLogin(String code,HttpSession session){
		ModelAndView mv = new ModelAndView();
		EntityWrapper<TeacherPlan> wrapper = new EntityWrapper<TeacherPlan>();
		TeacherPlan tp = new TeacherPlan();
		wrapper.setEntity(tp);
		wrapper.addFilter("code = {0}", code);// 添加过滤条件
		wrapper.addFilter("dostatus = {0}", 0);// 添加过滤条件,未结束的标志为0，已经结束为1
		TeacherPlan teaObject = iTeacherPlanService.selectOne(wrapper);
		if(teaObject==null){//登录失败直接返回登录页面
			mv.addObject("errorMessage", "验证随机码错误");
			mv.setViewName("front/tealogin");
		}else
		{	
			Map teacherPlan = iTeacherDetailService.selectByplanidAndclassid(teaObject.getCode());
			EntityWrapper<TeacherDetail> teacWrapper=new EntityWrapper<TeacherDetail>();
			TeacherDetail teDetail=new TeacherDetail();
			teacWrapper.setEntity(teDetail);
			teacWrapper.addFilter("teatestid={0}", teacherPlan.get("id"));
			teacWrapper.addFilter("sessionid={0}", session.getId());//检查sessionID是否重复，如果重复，认为是重复评价
			List<TeacherDetail> selectList = iTeacherDetailService.selectList(teacWrapper);
			if(selectList!=null&&selectList.size()>0){
				mv.addObject("errorMessage", "对不起，您已经参加过评价了");
				mv.setViewName("/front/tealogin");
			}else{
				mv.addObject("teacherPlan", teacherPlan);
				session.setAttribute("teacherPlan", teacherPlan);
				mv.addObject("errorMessage", null);
				mv.setViewName("/front/teaQuestion");
			}
		}
		return mv;
	}

	/*学生教评登录检测   分模块*/
	@RequestMapping("/checkFenTeaLogin")
	public ModelAndView checkFenTeaLogin(String code,HttpSession session){
		ModelAndView mv = new ModelAndView();
		EntityWrapper<TeacherPlan> wrapper = new EntityWrapper<TeacherPlan>();
		TeacherPlan tp = new TeacherPlan();
		wrapper.setEntity(tp);
		wrapper.addFilter("code = {0}", code);// 添加过滤条件
		wrapper.addFilter("dostatus = {0}", 0);// 添加过滤条件,未结束的标志为0，已经结束为1
		TeacherPlan teaObject = iTeacherPlanService.selectOne(wrapper);
		if(teaObject==null){//登录失败直接返回登录页面
			mv.addObject("errorMessage", "验证随机码错误");
			mv.setViewName("front/teaFenlogin");
		}else
		{	
			Map teacherPlan = iTeacherDetailService.selectByplanidAndclassid(teaObject.getCode());
			EntityWrapper<TeacherDetail> teacWrapper=new EntityWrapper<TeacherDetail>();
			TeacherDetail teDetail=new TeacherDetail();
			teacWrapper.setEntity(teDetail);
			teacWrapper.addFilter("teatestid={0}", teacherPlan.get("id"));
			teacWrapper.addFilter("sessionid={0}", session.getId());//检查sessionID是否重复，如果重复，认为是重复评价
			List<TeacherDetail> selectList = iTeacherDetailService.selectList(teacWrapper);
			if(selectList!=null&&selectList.size()>0){
				mv.addObject("errorMessage", "对不起，您已经参加过评价了");
				mv.setViewName("/front/teaFenlogin");
			}else{
				mv.addObject("teacherPlan", teacherPlan);
				session.setAttribute("teacherPlan", teacherPlan);
				mv.addObject("errorMessage", null);
				mv.setViewName("/front/teacherQuestion");
			}
		}
		return mv;
	}

	/**
     * 把前台获取的json数据进行处理(老师评价界面)
     * @return
     */
    @RequestMapping("/saveTeaEvaluate")
	@ResponseBody
	public  Map  saveTeaEvaluate(HttpServletRequest req,HttpSession session) throws JsonParseException, JsonMappingException, IOException {
		//获取前台传入的json字符串
		String checkQues= req.getParameter("checkQues");
		//获取传入的意见
		String idea = req.getParameter("idea");
		//将json字符串转换成list《answer》对象
		ObjectMapper objectMapper = new ObjectMapper();
		JavaType javaType = objectMapper.getTypeFactory().constructParametricType(ArrayList.class, Answer.class);
        List<Answer> answerList = (List<Answer>)objectMapper.readValue(checkQues, javaType);
        Map<Integer,Long> questionIdMap = (Map<Integer, Long>) session.getAttribute("questionIdMap");
        Map teacherPlan=(Map) session.getAttribute("teacherPlan");
        Map map = new HashMap();
        try {
        	 for (int i=0;i<answerList.size();i++) {
        		Answer answer = answerList.get(i);  
        		TeacherDetail teacherDetail = new TeacherDetail();
        		teacherDetail.setSessionid(session.getId());
             	teacherDetail.setQuestionid(questionIdMap.get(Integer.parseInt(answer.getId()+"")));
             	teacherDetail.setScore(Integer.parseInt(answer.getAnswer()));
             	teacherDetail.setSubmitime(new Date());
             	teacherDetail.setTeatestid(Long.parseLong(teacherPlan.get("id")+""));
             	teacherDetail.setTeacherid(Long.parseLong(teacherPlan.get("teacherno")+""));
             	if(i==(answerList.size()-1)){//只插入最后一条记录信息的意见
             		teacherDetail.setIdea(idea);
             	}
             	iTeacherDetailService.insert(teacherDetail);
        	 }
        	 map.put("ret", true);
		} catch (Exception e) {
			 map.put("ret", false);
		}
		return map;
	}

     /**
     * 把前台获取的json数据进行处理(老师评价界面)  --分模块
     * @return
     */
    @RequestMapping("/saveFenTeaEvaluate")
	@ResponseBody
	public  Map  saveFenTeaEvaluate(HttpServletRequest req,HttpSession session,ModelAndView mv) throws JsonParseException, JsonMappingException, IOException {
		//获取前台传入的json字符串
		String checkQues= req.getParameter("checkQues");
		//将json字符串转换成list《answer》对象
		ObjectMapper objectMapper = new ObjectMapper();
		JavaType javaType = objectMapper.getTypeFactory().constructParametricType(ArrayList.class, Answer.class);
        List<Answer> answerList = (List<Answer>)objectMapper.readValue(checkQues, javaType);
        Map<Integer,Long> questionIdMap = (Map<Integer, Long>) session.getAttribute("questionIdMap");
        Map teacherPlan=(Map) session.getAttribute("teacherPlan");
        Map map = new HashMap();
        try {
        	 for (Answer answer : answerList) {
        		TeacherDetail teacherDetail = new TeacherDetail();
        		teacherDetail.setSessionid(session.getId());
             	teacherDetail.setQuestionid(questionIdMap.get(Integer.parseInt(answer.getId()+"")));
             	teacherDetail.setScore(Integer.parseInt(answer.getAnswer()));
             	teacherDetail.setSubmitime(new Date());
             	teacherDetail.setTeatestid(Long.parseLong(teacherPlan.get("id")+""));
             	teacherDetail.setTeacherid(Long.parseLong(teacherPlan.get("teacherno")+""));
             	boolean b = iTeacherDetailService.insert(teacherDetail);
             	if(b==true){
             		//添加状态
             		TeacherPlan teacherPlan2 = iTeacherPlanService.selectById(Long.parseLong(teacherPlan.get("id")+""));
             		teacherPlan2.setIsFen(1);//1 是分模块
             		iTeacherPlanService.updateTeacherPlan(teacherPlan2);
             	}
        	 }
        	 map.put("ret", true);
		} catch (Exception e) {
			 map.put("ret", false);
		}
		return map;
	}


    /**
     * 跳转口碑页面
     * 
     */
    @RequestMapping("/toWordOfMouth")
    public String toWordOfMouth(Model model){
    	//获取口碑状态
    	Map<String, String> wordstatusmap = ConstantUtils.WORDSTATUSMAP;
    	model.addAttribute("wordstatusmap", wordstatusmap);
    	return "front/wordOfMouth";
    }
    /**
     * 保存口碑信息
     */
    @RequestMapping("/saveWordOfMouth")
	@ResponseBody
    public Map saveWordOfMouth(Wordofmouth word){
    	Map map = new HashMap();
    	try {
    		//检查口碑姓名和口碑手机号是否已经存在
    		Map<String,Object> columnMap = new HashMap<String,Object>();
    		columnMap.put("stuname", word.getStuname());
    		columnMap.put("stuphone", word.getStuphone());
    		List<Wordofmouth> wordList = wordofmouthService.selectByMap(columnMap);
    		if(wordList!=null&&wordList.size()>0){
    			map.put("msg", true);
    		}else{
    			word.setCreatetime(new Date());
    			wordofmouthService.insert(word);
    			map.put("ret", true);
    		}
		} catch (Exception e) {
			map.put("ret", false);
		}
    	return map;
    }
    /**
     * 跳转入学考试登陆页面
     */
    @RequestMapping("/loginTestQuestion")
    public String loginTestQuestion(){
    	return "front/loginTestQuestion";
    }
    /**
	  * 跳转入学测试页面
	  * @return
	  */
	@RequestMapping("/testQuestion")
	public  ModelAndView  toTestQuestionPage(String stuname,String stuphone,String quesType,Model model) {
		if(StringUtils.isNotBlank(stuname)&&"姓名".equals(stuname)){
			stuname = "";
		}
		if(StringUtils.isNotBlank(stuphone)&&"手机号".equals(stuphone)){
			stuphone = "";
		}
		ModelAndView mv = new ModelAndView();
		if(StringUtils.isBlank(stuname)||StringUtils.isBlank(stuphone)){//登录失败直接返回登录页面
			mv.addObject("errorMessage", "用户名或手机号不能为空");
			mv.setViewName("front/loginTestQuestion");
		}else{
			mv.addObject("stuname",stuname);
			mv.addObject("stuphone",stuphone);
			if("2".equals(quesType)){
				//获取随机的意志力类型
				List<String> list = ConstantUtils.TYPELIST;
				int index = (int)(Math.random()*3);
				quesType = list.get(index);
			}
			mv.addObject("quesType",quesType);
			mv.setViewName("front/testQuestion");
		}
		return mv;
	}
	/**
	 * 前台入学测试显示试题题目
	 * @param chapterid
	 * @param session
	 * @return
	 */
	@RequestMapping("/findTestQuestion")
	@ResponseBody
	public  List<Question> findTestQuestion(HttpSession session,String quesType) {
		/**
		 * baomidou 里面自己封装的类，可以进行条件查询
		 */
		Map<String,Object> map = testQuestionService.selectQuestionMap(quesType);
		session.setAttribute("questionIdTopicIdMap", map.get("questionIdTopicIdMap"));
		List<Question> questionList= (List<Question>)map.get("questionList");
		return questionList;
	}
	/**
	 * 把前台获取的json数据进行处理(处理心理测试界面传过来的数据问题，将其分开放入到数据库)
	 * @return
	 */
	@RequestMapping("/saveTestQuestion")
	@ResponseBody
	public  Map  saveTestQuestion(HttpServletRequest req,HttpSession session,ModelAndView mv) throws JsonParseException, JsonMappingException, IOException {
		//获取前台传入的json字符串
		String checkQues= req.getParameter("checkQues");
		String stuname = req.getParameter("stuname");
		String stuphone = req.getParameter("stuphone");
		String quesType = req.getParameter("quesType");
		//将json字符串转换成list《answer》对象
		ObjectMapper objectMapper = new ObjectMapper();
		JavaType javaType = objectMapper.getTypeFactory().constructParametricType(ArrayList.class, Answer.class);
		List<Answer> answerList = (List<Answer>)objectMapper.readValue(checkQues, javaType);
		Map map = new HashMap();//testQuestionRecordService
		int sum = 0;
		try {
			//计算总分数
			for (Answer answer : answerList) {
				//如果选项不为空并且是多选题
				if(StringUtils.isNotBlank(answer.getItem())&&answer.getItem().length()>5){
					if(answer.getItem().indexOf(",")==0){
						answer.setItem(answer.getItem().substring(1,answer.getItem().length()));
					}
					String[] items =  answer.getItem().replaceAll("item","").split(",");
					
					//获取题目答案    获取题目选项   选项得分
					Map<String, Object> questionMap = testQuestionService.selectTestQuesAndOption(answer.getQuesId());
					TestQuestion testQuestion = (TestQuestion)questionMap.get("testQuestion");
					List<TestQuestionAnswer>  optionList = (List<TestQuestionAnswer>)questionMap.get("optionList");
					//取出选中的选项
					String answerItem = "";
					for (String index : items) {
						String option = optionList.get(Integer.valueOf(index)).getOption().substring(0,1);
						answerItem+=option;
					}
					int score = 1;//暂时写死
					if(answerItem.equals(testQuestion.getQuesanswer())){
						sum += score;
					}
				}else{
					if(StringUtils.isNotBlank(answer.getAnswer())){
		      			sum += Integer.valueOf(answer.getAnswer());
		      		}
				}
			}
			TestQuestionRecord testQuestionRecord = new TestQuestionRecord();
			testQuestionRecord.setStuname(stuname);
			testQuestionRecord.setStuphone(stuphone);
			testQuestionRecord.setStuscore(sum);
			//暂时写死
			if(StringUtils.isNotBlank(quesType)){
				testQuestionRecord.setQuestype(Integer.valueOf(quesType));
			}else{
				testQuestionRecord.setQuestype(1);
			}
			testQuestionRecord.setCreatetime(new Date());
			testQuestionRecordService.insert(testQuestionRecord);//批量插入
	       	map.put("ret", true);
		} catch (Exception e) {
			 e.printStackTrace();
			 map.put("ret", false);
		}
		return map;
	}
    /**
	 * 跳转评价成功界面
	 * @return
	 */
	@RequestMapping("/submitThanks")
	public  ModelAndView  submitThanks() {
		ModelAndView mv = new ModelAndView("front/submitThanks");
		return mv;
	}
	/**
	 * 跳转考试登陆页面
	 */
	@RequestMapping("/examLogin")
	public String examLogin(HttpServletRequest request){
		//String path = request.getRequestURL().substring(0,request.getRequestURL().indexOf("examLogin"));
		//path = path+"toExamPaper";
		return "front/exam/examLogin";
		//new Denglu(examPaperService,path,zuyeJFrame);
	}
	/**
	 * 获取考试类型和阶段下的试卷信息
	 */
	@RequestMapping("/selectExamPaperList")
	@ResponseBody
	public  Object selectExamPaperList(String stage, String type){
		List<DataVo> dataVoList = examPaperService.selectExamPaperList(stage,type);
		return dataVoList;
	}
	/**
	 * 检查学生是否允许登陆
	 */
	@RequestMapping("/checkExamLogin")
	@ResponseBody
	public Object checkExamLogin(Long examPaperId,String stuno,String stuphone){
		boolean flag = examPaperService.checkExamLogin(examPaperId,stuno,stuphone);
		return flag;
	}
	/**
	 * 跳转试题页面
	 */
	@RequestMapping("/toExamPaper")
	public String toExamPage(Long examPaperId,Long id,String stuno,String stuphone,Model model){
		//查询试卷是否有该学生 ,且考试时间在开始时间和结束时间之内
    	Map<String,Object> map = examPaperService.findExamPaperByMap(examPaperId,stuno,stuphone);
    	boolean flag = (boolean)map.get("flag");
    	if(flag){
    		Long recordId = (Long)map.get("id");
    		model.addAttribute("paperId", examPaperId);//试卷id
    		model.addAttribute("id", recordId);//考试记录id
    		return "front/exam/examPaper";
    	}else{
    		return "front/exam/examLogin";
    	}
	}
	
	/**
	 * 在线考试显示试题题目
	 * id 考试记录id
	 */
	@RequestMapping("/findExamQuestion")
	@ResponseBody
	public  List<Question> findExamQuestion(Model model,HttpSession session,Long paperId) {
		Map<String,Object> map = examPaperService.selectQuestionMap(paperId);
		session.setAttribute("examQuestions", map.get("examQuestions"));
		List<Question> questionList= (List<Question>)map.get("questionList");
		return questionList;
	}
	/**
	 * 把前台获取的json数据进行处理(提交试卷计算总成绩，将其分开放入到数据库)
	 * id 为考试记录的id
	 * @return
	 */
	@RequestMapping("/saveExamRecord")
	@ResponseBody
	public  Map  saveExamRecord(HttpServletRequest req,Long id) throws JsonParseException, JsonMappingException, IOException {
		//获取前台传入的json字符串
		String checkQues= req.getParameter("checkQues");
		String quesType = req.getParameter("quesType");
		//将json字符串转换成list《answer》对象
		ObjectMapper objectMapper = new ObjectMapper();
		JavaType javaType = objectMapper.getTypeFactory().constructParametricType(ArrayList.class, Answer.class);
		List<Answer> answerList = (List<Answer>)objectMapper.readValue(checkQues, javaType);
		Map map = new HashMap();
		try {
			examRecordService.saveExamRecord(answerList,id);
	       	map.put("ret", true);
	       	//提示信息
	       	//JOptionPane.showMessageDialog(zuyeJFrame, "提交成功", "提示",JOptionPane.WARNING_MESSAGE); 
	       	//隐藏
			//zuyeJFrame.setVisible(false);
	       	//zuyeJFrame.setDefaultCloseOperation(2);//隐藏并释放窗体
		} catch (Exception e) {
			 e.printStackTrace();
			 map.put("ret", false);
		}
		return map;
	}
}
