package com.aaa.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import com.aaa.commons.result.PageInfo;
import com.aaa.commons.result.Tree;
import com.aaa.model.Organization;
import com.aaa.model.TblClass;
import com.aaa.model.TblClassRecord;
import com.aaa.mapper.OrganizationMapper;
import com.aaa.mapper.TblClassMapper;
import com.aaa.mapper.TblClassRecordMapper;
import com.aaa.mapper.UserMapper;
import com.aaa.service.ITblClassRecordService;
import com.aaa.service.ITblClassService;
import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.plugins.Page;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;

import org.apache.commons.lang.math.RandomUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author 孙韶山
 * @since 2017-10-17
 */
@Service
public class TblClassRecordServiceImpl extends ServiceImpl<TblClassRecordMapper, TblClassRecord> implements ITblClassRecordService {

	    @Autowired
	    private TblClassRecordMapper tblClassRecordMapper;
	    @Autowired
	    private OrganizationMapper organizationMapper;
	 @Override
	    public List<TblClassRecord> selectTreeGrid() {
		 List<TblClassRecord> classRecordList = tblClassRecordMapper.selectAllTblClassRecord();//查询所有的班级记录
		 List<TblClassRecord> classRecordListNew= new ArrayList<TblClassRecord>();
	        //给所有的班级记录关联上老师
	        for (TblClassRecord tblClassRecord : classRecordList) {
	        	//List<String> teacher =tblClassRecordMapper.selectTeacherByClassId(tblClass.getId());
	        	//tblClass.setTeacher(teacher);//设置老师
	        	tblClassRecord.setIcon("fi-torsos icon-red");//设置图标，设置默认
	        	classRecordListNew.add(tblClassRecord);
			}
	        //查询所有的组织，然后封装成tblClassRecord对象，添加到classList中
	        EntityWrapper<Organization> wrapper = new EntityWrapper<Organization>();
	        wrapper.orderBy("seq");
	        List<Organization> orgList = organizationMapper.selectList(wrapper);
	      
	        
	        for (Organization organization : orgList) {
	        	TblClassRecord tc= new TblClassRecord();
				tc.setId(organization.getId());
				tc.setOrgid(organization.getPid());
				tc.setClassname(organization.getName());
				tc.setCreatetime(organization.getCreateTime());
				tc.setIcon(organization.getIcon());
				classRecordListNew.add(tc);
			}
	        return classRecordListNew;
	    }
//	@Override
//	public void insertTblClassRecord(TblClassRecord tblClassRecord) {
//		//插入班级表记录
//		tblClassMapper.insertClass(tblClass);
//		//插入班级教师中间表记录
//		if(tblClass!=null&&tblClass.getTeacher()!=null){
//			
//			List<String> teacherList = tblClass.getTeacher();
//			for (String teacher : teacherList) {
//				Map map = new HashMap();
//				map.put("teacherId", teacher);
//				map.put("classId",tblClass.getId());
//				tblClassMapper.insertClassTeacher(map);
//			}
//		}
//	}
	
	
	
}
