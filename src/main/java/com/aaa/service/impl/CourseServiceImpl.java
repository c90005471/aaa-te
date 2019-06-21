package com.aaa.service.impl;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.aaa.commons.result.Tree;
import com.aaa.commons.shiro.ShiroUser;
import com.aaa.commons.utils.ConstantUtils;
import com.aaa.commons.utils.DateUtil;
import com.aaa.commons.utils.StringUtils;
import com.aaa.mapper.CourseMapper;
import com.aaa.mapper.RoleMapper;
import com.aaa.mapper.RoleResourceMapper;
import com.aaa.mapper.UserRoleMapper;
import com.aaa.model.Course;
import com.aaa.model.Resource;
import com.aaa.model.vo.CourseVo;
import com.aaa.service.ICourseService;
import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;

/**
 *
 * 课程表数据服务层接口实现类
 *
 */
@Service
public class CourseServiceImpl extends ServiceImpl<CourseMapper, Course> implements ICourseService {
    private static final int COURSE_TYPE = 0; // 非知识点
    private static final int JDCOURSE_TYPE = 2; // 非评分标准
    @Autowired
    private CourseMapper courseMapper;
    @Autowired
    private UserRoleMapper userRoleMapper;
    @Autowired
    private RoleMapper roleMapper;
    @Autowired
    private RoleResourceMapper roleResourceMapper;
    
    @Override
    public List<Course> selectAll() {
        EntityWrapper<Course> wrapper = new EntityWrapper<Course>();
        wrapper.orderBy("seq");
        return courseMapper.selectList(wrapper);
    }
    
    public List<Course> selectByType(Integer type) {
        EntityWrapper<Course> wrapper = new EntityWrapper<Course>();
        Course course = new Course();
        wrapper.setEntity(course);
        wrapper.addFilter("course_type = {0}", type);
        wrapper.orderBy("seq");
        return courseMapper.selectList(wrapper);
    }
    public List<Course> selectByTypeOrgid(Integer type,Long orgid) {
    	EntityWrapper<Course> wrapper = new EntityWrapper<Course>();
    	Course course = new Course();
    	wrapper.setEntity(course);
    	Object[] params={type,orgid};
    	wrapper.addFilter("course_type = {0} and orgid = {1} ", params);
    	//如果是杨金路专业
    	String courseVersion = "";
    	if(orgid.equals(Long.valueOf(ConstantUtils.YJ_ORGID))){
    		List<Map> list = courseMapper.selectListByGroup();//获取最新的专业课程体系
    		if(list!=null && list.size()>0){
    			courseVersion = list.get(0).get("course_version").toString();
    			wrapper.addFilter("course_version = {0}", courseVersion);
    		}
    	}
    	wrapper.orderBy("seq");
    	return courseMapper.selectList(wrapper);
    }
    
    @Override
    public List<Tree> selectAllMenu(Long orgid,Integer coursetype) {
        List<Tree> trees = new ArrayList<Tree>();
        // 查询所有菜单
        List<Course> courses=new ArrayList<Course>();
        if(orgid==null){
        		courses = this.selectByType(coursetype);
        }else{
        		courses = this.selectByTypeOrgid(coursetype,orgid);
        }
        
        if (courses == null) {
            return trees;
        }
        for (Course course : courses) {
            Tree tree = new Tree();
            tree.setId(course.getId());
            tree.setPid(course.getPid());
             tree.setText(course.getCourseName());
             tree.setIconCls(course.getIcon());
             tree.setAttributes(coursetype);
             tree.setState(1);//节点展开
            trees.add(tree);
        }
        return trees;
    }
    
    @Override
    public List<Tree> selectAllTree() {
        // 获取所有的资源 tree形式，展示
        List<Tree> trees = new ArrayList<Tree>();
        List<Course> courses = this.selectAll();
        if (courses == null) {
            return trees;
        }
        for (Course course : courses) {
            Tree tree = new Tree();
            tree.setId(course.getId());
           tree.setPid(course.getPid());
            tree.setText(course.getCourseName());
            tree.setIconCls(course.getIcon());
          //  tree.setAttributes(course.getUrl());
            tree.setState(course.getStatus());
            trees.add(tree);
        }
        return trees;
    }
    
    @Override
    public List<Tree> selectTree(ShiroUser shiroUser,Long orgid,String flag) {
        List<Tree> trees = new ArrayList<Tree>();
        // shiro中缓存的用户角色
        Set<String> roles = shiroUser.getRoles();
        if (roles == null) {
            return trees;
        }
        // 如果有超级管理员权限
        if (roles.contains("admin")) {
        	List<Course> courseList = null;
        	if(StringUtils.isNotBlank(flag)){
        		courseList = this.selectByTypeOrgid(JDCOURSE_TYPE,orgid);
        	}else{
        		courseList = this.selectByTypeOrgid(COURSE_TYPE,orgid);
        	}
            if (courseList == null) {
                return trees;
            }
            for (Course course : courseList) {
                Tree tree = new Tree();
                tree.setId(course.getId());
               tree.setPid(course.getPid());
                tree.setText(course.getCourseName());
                tree.setIconCls(course.getIcon());
            //    tree.setAttributes(course.getUrl());
             //   tree.setOpenMode(course.getOpenMode());
                tree.setState(course.getStatus());
                tree.setState(1);//节点展开
                trees.add(tree);
            }
            return trees;
        }
        // 普通用户
        List<Long> roleIdList = userRoleMapper.selectRoleIdListByUserId(shiroUser.getId());
        if (roleIdList == null) {
            return trees;
        }
        List<Resource> resourceLists = roleMapper.selectResourceListByRoleIdList(roleIdList);
        if (resourceLists == null) {
            return trees;
        }
        for (Resource resource : resourceLists) {
            Tree tree = new Tree();
            tree.setId(resource.getId());
            tree.setPid(resource.getPid());
            tree.setText(resource.getName());
            tree.setIconCls(resource.getIcon());
            tree.setAttributes(resource.getUrl());
            tree.setOpenMode(resource.getOpenMode());
            tree.setState(resource.getOpened());
            trees.add(tree);
        }
        return trees;
    }

	@Override
	public boolean deleteById(Serializable resourceId) {
		roleResourceMapper.deleteByResourceId(resourceId);
		return super.deleteById(resourceId);
	}

	@Override
	public void deleteCourseById(Long id) {
		//获取所有的子节点
		List<Long> selectChildByIdList = courseMapper.selectChildById(id);
		//将自己放进list中
		selectChildByIdList.add(id);
		
		Map map = new HashMap();
		map.put("selectChildByIdList", selectChildByIdList);
		//删除所有的数据
		courseMapper.deleteCourseById(map);//一次删除多行数据
		
		
		
	}
	/**
	 * 把读取到的信息保存到数据库
	 */
	@Override
	public boolean batchAddCource(List<CourseVo> excelToList,Integer orgId) {
		//处理数据
		/**
		 * HTML HTML基础 HTML-1 HTML基础 基本标签;基本表单;div
		  				HTML-2 表格和表单 表格标签;表单特效;table布局
		  				HTML-3 CSS样式基础 css基本选择器;背景样式;盒子模型
		  				HTML-4 CSS样式深入 组合选择器;文本样式;表单样式
		  DIV+CSS DIV+CSS基础 DIV+CSS-1 块状和行内元素的关系 XHTML;标签分类;float属性
		  				DIV+CSS-2 盒子位置关系 盒子模型深入;定位;箭头导航
		 */
		try {
			int m = 0;//记录主课程排序
			Long pid = 0l;//记录第一级的id
			String code="";//记录第一级code的变化
			int n = 0;//记录所属阶段排序
			Long spid = 0l;//记录第一级的阶段
			String stage = "";//记录所属阶段的变化
			int a = 0;//记录阶段所属课程排序
			for (CourseVo courseVo : excelToList) {
				//excelToListNew.add(student);
				System.out.println(courseVo.getCoursecode()+" "+courseVo.getCoursename()+" "+courseVo.getZcoursecode()+" "+courseVo.getZcoursecotent()+" "+courseVo.getCoursepoints());
				Course v = new Course();
				//保存课程信息
				if(StringUtils.isNotBlank(courseVo.getCoursecode())){
					if(StringUtils.isBlank(code)){//如果是第一行的HTML信息
						code = courseVo.getCoursecode();
					}
					//如果code发生变化说明进行到下一个主课程
					if(!code.equals(courseVo.getCoursecode())){
						code = courseVo.getCoursecode();//把code替换为下一个coursecode
						m++;//主课程排序发生变化
					}
					v.setCourseCode(courseVo.getCoursecode());
					v.setCourseName(courseVo.getCoursename());
					v.setSeq(m);
					v.setPid(0l);
					v.setIcon("fi-foundation icon-blue");
					v.setCourseType(0);
					v.setOrgid(orgId);
					if(orgId==Integer.valueOf(ConstantUtils.YJ_ORGID)){
						v.setCourseVersion(DateUtil.fromDateToStringN(new Date()).replaceAll("-", ""));
					}
					v.setStatus(0);
					v.setCreateTime(new Date());
					//判断当前的主课程是否保存过
					Map<String,Object> smap = new HashMap<String,Object>();
					smap.put("course_code", v.getCourseCode());
					smap.put("course_type", 0);
					smap.put("course_version", DateUtil.fromDateToStringN(new Date()).replaceAll("-", ""));
					List<Course>  list = courseMapper.selectByMap(smap);
					if(list!=null&& list.size()>0){
						v = list.get(0);
					}else{
						courseMapper.insertCourse(v);
					}
					pid = v.getId();
					//保存二级课程
					Course two = new Course();
					two.setCourseCode(courseVo.getZcoursecode());
					if(StringUtils.isNotBlank(courseVo.getZcoursecotent())){
						two.setCourseName(courseVo.getZcoursecotent());
					}else{
						two.setCourseName(courseVo.getZcoursecode());
					}
					String seqStr = "";
					if(courseVo.getZcoursecode().contains("-")){
						String[] strs = courseVo.getZcoursecode().split("-");
						seqStr = courseVo.getZcoursecode().split("-")[strs.length-1];
					}else{
						seqStr = "1";
					}
					two.setSeq(Integer.valueOf(seqStr));
					two.setPid(pid);
					two.setIcon("fi-foundation icon-blue");
					two.setCourseType(0);
					two.setOrgid(orgId);
					if(orgId==Integer.valueOf(ConstantUtils.YJ_ORGID)){
						two.setCourseVersion(DateUtil.fromDateToStringN(new Date()).replaceAll("-", ""));
					}
					two.setStatus(0);
					two.setCreateTime(new Date());
					courseMapper.insertCourse(two);//保存二级课程
					//获取知识点
					if(StringUtils.isNotBlank(courseVo.getCoursepoints())){
						String [] points = courseVo.getCoursepoints().split(";");
						for (int i=1;i<=points.length;i++) {
							Course point = new Course();
							point.setCourseCode(two.getCourseCode()+"-"+i);
							point.setCourseName(points[i-1]);
							point.setSeq(i);
							point.setPid(two.getId());
							point.setIcon("fi-foundation icon-blue");
							point.setCourseType(1);
							point.setOrgid(orgId);
							if(orgId==Integer.valueOf(ConstantUtils.YJ_ORGID)){
								point.setCourseVersion(DateUtil.fromDateToStringN(new Date()).replaceAll("-", ""));
			    			}
							point.setStatus(0);
							point.setCreateTime(new Date());
			    			courseMapper.insertCourse(point);//保存知识点
						}
					}
				}else{
					//保存剩余没有一级课程的信息
					//保存二级课程
					Course two = new Course();
					two.setCourseCode(courseVo.getZcoursecode());
					if(StringUtils.isNotBlank(courseVo.getZcoursecotent())){
						two.setCourseName(courseVo.getZcoursecotent());
					}else{
						two.setCourseName(courseVo.getZcoursecode());
					}
					String seqStr = "";
					if(courseVo.getZcoursecode().contains("-")){
						String[] strs = courseVo.getZcoursecode().split("-");
						seqStr = courseVo.getZcoursecode().split("-")[strs.length-1];
					}else{
						seqStr = "1";
					}
					two.setSeq(Integer.valueOf(seqStr));
					two.setPid(pid);
					two.setIcon("fi-foundation icon-blue");
					two.setCourseType(0);
					two.setOrgid(orgId);
					if(orgId==Integer.valueOf(ConstantUtils.YJ_ORGID)){
						two.setCourseVersion(DateUtil.fromDateToStringN(new Date()).replaceAll("-", ""));
					}
					two.setStatus(0);
					two.setCreateTime(new Date());
					courseMapper.insertCourse(two);//保存二级课程
					//获取知识点
					if(StringUtils.isNotBlank(courseVo.getCoursepoints())){
						String [] points = courseVo.getCoursepoints().split(";");
						for (int i=1;i<=points.length;i++) {
							Course point = new Course();
							point.setCourseCode(two.getCourseCode()+"-"+i);
							point.setCourseName(points[i-1]);
							point.setSeq(i);
							point.setPid(two.getId());
							point.setIcon("fi-foundation icon-blue");
							point.setCourseType(1);
							point.setOrgid(orgId);
							if(orgId==Integer.valueOf(ConstantUtils.YJ_ORGID)){
								point.setCourseVersion(DateUtil.fromDateToStringN(new Date()).replaceAll("-", ""));
			    			}
							point.setStatus(0);
							point.setCreateTime(new Date());
			    			courseMapper.insertCourse(point);//保存知识点
						}
					}
				}
				//保存阶段信息
				if(StringUtils.isNotBlank(courseVo.getStage())){
					if(StringUtils.isBlank(stage)){//如果是第一行的阶段信息
						stage = courseVo.getStage();
					}
					//如果stage发生变化说明进行到下一个阶段
					if(!stage.equals(courseVo.getStage())){
						stage = courseVo.getCoursecode();//把stage替换为下一个阶段
						n++;//阶段排序发生变化
					}
//					if(courseVo.getStage().contains("网页基础")){
//						v.setCourseCode("HTML");
//					}else if(courseVo.getStage().contains("java基础")){
//						v.setCourseCode("JAVA1");
//					}else if(courseVo.getStage().contains("WEB阶段")){
//						v.setCourseCode("JAVA1");
//					}
					v.setCourseCode(courseVo.getStage());
					v.setCourseName(courseVo.getStage());
					v.setSeq(n);
					v.setPid(0l);
					v.setIcon("fi-foundation icon-blue");
					v.setCourseType(2);//阶段主节点标记
					v.setOrgid(orgId);
					if(orgId==Integer.valueOf(ConstantUtils.YJ_ORGID)){
						v.setCourseVersion(DateUtil.fromDateToStringN(new Date()).replaceAll("-", ""));
					}
					v.setStatus(0);
					v.setCreateTime(new Date());
					//判断当前的阶段是否保存过
					Map<String,Object> smap = new HashMap<String,Object>();
					smap.put("course_code", v.getCourseCode());
					smap.put("course_type", 2);
					smap.put("course_version", DateUtil.fromDateToStringN(new Date()).replaceAll("-", ""));
					List<Course>  list = courseMapper.selectByMap(smap);
					if(list!=null&& list.size()>0){
						v = list.get(0);
					}else{
						courseMapper.insertCourse(v);
					}
					spid = v.getId();
					//保存阶段下的二级课程
					Course two = new Course();
					two.setCourseCode(courseVo.getZcoursecode());
					if(StringUtils.isNotBlank(courseVo.getZcoursecotent())){
						two.setCourseName(courseVo.getZcoursecotent());
					}else{
						two.setCourseName(courseVo.getZcoursecode());
					}
					two.setSeq(a);
					two.setPid(spid);
					two.setIcon("fi-foundation icon-blue");
					two.setCourseType(3);
					two.setOrgid(orgId);
					if(orgId==Integer.valueOf(ConstantUtils.YJ_ORGID)){
						two.setCourseVersion(DateUtil.fromDateToStringN(new Date()).replaceAll("-", ""));
					}
					two.setStatus(0);
					two.setCreateTime(new Date());
					courseMapper.insertCourse(two);//保存二级课程
				}else{
					//保存剩余没有阶段的信息
					//保存二级课程
					Course two = new Course();
					two.setCourseCode(courseVo.getZcoursecode());
					if(StringUtils.isNotBlank(courseVo.getZcoursecotent())){
						two.setCourseName(courseVo.getZcoursecotent());
					}else{
						two.setCourseName(courseVo.getZcoursecode());
					}
					
					two.setSeq(a);
					two.setPid(spid);
					two.setIcon("fi-foundation icon-blue");
					two.setCourseType(3);
					two.setOrgid(orgId);
					if(orgId==Integer.valueOf(ConstantUtils.YJ_ORGID)){
						two.setCourseVersion(DateUtil.fromDateToStringN(new Date()).replaceAll("-", ""));
					}
					two.setStatus(0);
					two.setCreateTime(new Date());
					courseMapper.insertCourse(two);//保存二级课程
				}
				a++;
			}
			return true;
		} catch (Exception e) {
			return false;
		}
	}

	@Override
	public List<Map> selectListByGroup() {
		return courseMapper.selectListByGroup();
	}
}