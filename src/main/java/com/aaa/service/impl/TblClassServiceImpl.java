package com.aaa.service.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Random;
import java.util.Set;

import com.aaa.commons.result.PageInfo;
import com.aaa.commons.result.Tree;
import com.aaa.model.Organization;
import com.aaa.model.TblClass;
import com.aaa.model.TblClassRecord;
import com.aaa.model.vo.UserVo;
import com.aaa.mapper.OrganizationMapper;
import com.aaa.mapper.TblClassMapper;
import com.aaa.mapper.TblClassRecordMapper;
import com.aaa.mapper.UserMapper;
import com.aaa.service.ITblClassService;
import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.plugins.Page;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang.math.RandomUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author chenjian
 * @since 2017-09-13
 */
@Service
public class TblClassServiceImpl extends ServiceImpl<TblClassMapper, TblClass> implements ITblClassService {

	    @Autowired
	    private TblClassMapper tblClassMapper;
	    @Autowired
	    private OrganizationMapper organizationMapper;
	    @Autowired
	    private UserMapper userMapper;
	    @Autowired
	    private TblClassRecordMapper tblClassRecordMapper;
	@Override
	public void selectDataGrid(PageInfo pageInfo) {
		 Page<Map<String, Object>> page = new Page<Map<String, Object>>(pageInfo.getNowpage(), pageInfo.getSize());
	        page.setOrderByField(pageInfo.getSort());
	        page.setAsc(pageInfo.getOrder().equalsIgnoreCase("asc"));
	        List<Map<String, Object>> list = tblClassMapper.selectClassPage(page, pageInfo.getCondition());
	        pageInfo.setRows(list);
	        pageInfo.setTotal(page.getTotal());
		
	}
	 @Override
	 public List<Map> selectTreeGrid(String flag) {
		 //有待优化
		 Map<String,String> map = new HashMap<String,String>();
		 if(StringUtils.isBlank(flag)){
			 flag = "0";//在校班级
		 }
		 map.put("flag", flag);
		 List<Map> classList = tblClassMapper.selectAllClassMap(map);//查询所有的班级
	        //给所有的班级关联上老师
	       /* for (Map tblClass : classList) {
	        	List<String> teacher =tblClassMapper.selectTeacherByClassId(tblClass.getId());
	        	tblClass.setTeacher(teacher);//设置老师
	        	tblClass.setIcon("fi-torsos icon-red");//设置图标，设置默认
	        	classListNew.add(tblClass);
			}*/
	        //查询所有的组织，然后封装成TblClass对象，添加到classList中
	        EntityWrapper<Organization> wrapper = new EntityWrapper<Organization>();
	        wrapper.orderBy("seq");
	        List<Organization> orgList = organizationMapper.selectList(wrapper);
	        for (Organization organization : orgList) {
				Map tc= new HashMap();
				tc.put("id",organization.getId());
				tc.put("orgid",organization.getPid());
				tc.put("classname",organization.getName());
				tc.put("createtime",organization.getCreateTime());
				tc.put("address",organization.getAddress());
				tc.put("iconCls",organization.getIcon());
				classList.add(tc);
			}
	        return classList;
	    }
	@Override
	public List<Tree> selectTree(String flag) {
		  List<Map> tblClassList = selectTreeGrid(flag);//获取所有班级和组织信息
	      List<Tree> trees = new ArrayList<Tree>();
	       if (tblClassList != null) {
	            for (Map tblClass : tblClassList) {
	                Tree tree = new Tree();
	                tree.setId(Long.parseLong(tblClass.get("id")+""));
	                tree.setText(tblClass.get("classname")+"");
	                tree.setIconCls(tblClass.get("iconCls")+"");
	                tree.setPid(tblClass.get("orgid")==null?null:Long.parseLong(tblClass.get("orgid")+""));
	                trees.add(tree);
	            }
	        }
	        return trees;
	}
	@Override
	public void insertTblClass(TblClass tblClass) {
		//插入班级表记录
		tblClassMapper.insertClass(tblClass);
		//插入班级教师中间表记录
		if(tblClass!=null&&tblClass.getTeacher()!=null){
			
			List<String> teacherList = tblClass.getTeacher();
			for (String teacher : teacherList) {
				Map map = new HashMap();
				map.put("teacherId", teacher);
				map.put("classId",tblClass.getId());
				tblClassMapper.insertClassTeacher(map);
			}
		}
	}
	@Override
	public TblClass selectClassById(Long id) {
		List<String> teacher =tblClassMapper.selectTeacherByClassId(id);
		TblClass tc= tblClassMapper.selectClassById(id);
		tc.setTeacher(teacher);
		return tc;
	}
	@Override
	public void updateClassById(TblClass tblClass,Long loginId) {
		 		//修改班级表记录
				tblClassMapper.updateClass(tblClass);
				//修改班级教师中间表记录
				if(tblClass!=null&&tblClass.getTeacher()!=null){
					List<String> teacherList = tblClass.getTeacher();
					Set<Long> newUserIdSet = new HashSet<Long>();//修改时的老师id集合
					for (String testStr : teacherList) {
						try {
							//如果不能转换成Integer，则直接返回，认为没有修改老师内容
							System.out.println(Integer.parseInt(testStr));
							newUserIdSet.add(Long.valueOf(testStr));//添加修改老师的id
						} catch (Exception e) {
							return;
						}
						
					}
					Set<Long> oldUserIdSet = new HashSet<Long>();//修改前的老师id集合
					//先获取班级之前的记录信息
					List<Long> useridList = tblClassMapper.selectUseridListByClassid(tblClass.getId());
					for (Long userid : useridList) {
						oldUserIdSet.add(userid);
					}
					Set<Long> userIdSet = new HashSet<Long>();//需要插入的教师id
					for (Long userid : newUserIdSet) {
						if(oldUserIdSet.contains(userid)){//若存在就从set中删掉
							oldUserIdSet.remove(userid);//删除后剩余是需要删掉的
						}else{
							userIdSet.add(userid);//集合里面是需要插入的
						}
					}
					String oldUsername = "";
					String newUsername = "";
					List<UserVo> userVoList = new ArrayList<UserVo>();//更换老师的集合
					//删除oldUserIdSet中需要删掉的老师id
					for (Long userid : oldUserIdSet) {
						UserVo userVo = userMapper.selectUserVoById(userid);//获取老师名字
						oldUsername += userVo.getName()+",";
						userVoList.add(userVo);
						tblClassMapper.deleteByClassIdAndUserid(tblClass.getId(),userid);
					}
					if(StringUtils.isNotBlank(oldUsername)&&oldUsername.endsWith(",")){
						oldUsername = oldUsername.substring(0,oldUsername.length()-1);
					}
					//插入userIdSet中需要新增的老师id
					for (Long userid : userIdSet) {
						UserVo userVo = userMapper.selectUserVoById(userid);//获取老师名字
						newUsername += userVo.getName()+",";
						Map<String,Long> map = new HashMap<String,Long>();
						map.put("teacherId", userid);
						map.put("classId",tblClass.getId());
						tblClassMapper.insertClassTeacher(map);
					}
					if(StringUtils.isNotBlank(newUsername)&&newUsername.endsWith(",")){
						newUsername = newUsername.substring(0,newUsername.length()-1);
					}
					/**
					 * oldUsername 原来删掉的老师姓名
					 * newUsername 现在新增的老师姓名
					 * 只有更换老师时才保存更新老师的记录(多条)
					 */
					if(StringUtils.isNotBlank(oldUsername)&&StringUtils.isNotBlank(newUsername)){
						//插入记录表中
						Date date = new Date();
						for (UserVo userVo : userVoList) {
							TblClassRecord tblClassRecord = new TblClassRecord();
							tblClassRecord.setUserid(userVo.getId());
							tblClassRecord.setClass_id(tblClass.getId());
							tblClassRecord.setCreator(loginId);
							tblClassRecord.setCreatetime(date);
							tblClassRecordMapper.insertTblClassRecord(tblClassRecord);
						}
					}
					//先删除之前的记录，然后插入新的记录
//					tblClassMapper.deleteClassTeacherByClassId(tblClass.getId());
//					for (String teacher : teacherList) {
//						Map map = new HashMap();
//						map.put("teacherId", teacher);
//						map.put("classId",tblClass.getId());
//						tblClassMapper.insertClassTeacher(map);
//					}
				}
	}
	/**
	 * 根据班级名称查询班级信息
	 */
	@Override
	public List<TblClass> selectByClassname(String classname) {
		List<TblClass> list = tblClassMapper.selectByClassname(classname);
		return list;
	}

	@Override
	public List<Tree> organizationTree(String flag) {
		List<Map> tblClassList = selectOrganizationTree(flag);//获取所有班级和组织信息
		List<Tree> trees = new ArrayList<Tree>();
		if (tblClassList != null) {
			for (Map tblClass : tblClassList) {
				Tree tree = new Tree();
				tree.setId(Long.parseLong(tblClass.get("id")+""));
				tree.setText(tblClass.get("classname")+"");
				tree.setIconCls(tblClass.get("iconCls")+"");
				tree.setPid(tblClass.get("orgid")==null?null:Long.parseLong(tblClass.get("orgid")+""));
				trees.add(tree);
			}
		}
		return trees;
	}

	@Override
	public List<Map<String, Object>> questionAndOrganTree(Long id) {
		return organizationMapper.questionAndOrganTree(id);
	}

	@Override
	public List<Tree> getTree(int orgid) {
		//根据组织获取所有的班级
		List<Map<String,Object>> tblClassList = tblClassMapper.getTreeGrid(orgid);
		List<Tree> trees = new ArrayList<Tree>();
		if (tblClassList != null) {
			for (Map tblClass : tblClassList) {
				Tree tree = new Tree();
				tree.setId(Long.parseLong(tblClass.get("id")+""));
				tree.setText(tblClass.get("classname")+"");
				tree.setIconCls(tblClass.get("iconCls")+"");
				tree.setPid(tblClass.get("orgid")==null?null:Long.parseLong(tblClass.get("orgid")+""));
				trees.add(tree);
			}
		}
		return trees;
	}

	public List<Map> selectOrganizationTree(String flag) {
		//查询所有的班级
		List<Map> classList = new ArrayList<>();
		//查询所有的组织，然后封装成TblClass对象，添加到classList中
		EntityWrapper<Organization> wrapper = new EntityWrapper<Organization>();
		wrapper.orderBy("seq");
		wrapper.where("pid is null");
		List<Organization> orgList = organizationMapper.selectList(wrapper);
		for (Organization organization : orgList) {
			Map tc= new HashMap();
			tc.put("id",organization.getId());
			tc.put("orgid",organization.getPid());
			tc.put("classname",organization.getName());
			tc.put("createtime",organization.getCreateTime());
			tc.put("address",organization.getAddress());
			tc.put("iconCls",organization.getIcon());
			classList.add(tc);
		}
		return classList;
	}


}
