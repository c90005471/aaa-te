package com.aaa.service.impl;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.validation.Valid;

import com.aaa.commons.result.PageInfo;
import com.aaa.commons.utils.CalBonusesUtil;
import com.aaa.model.Organization;
import com.aaa.model.Returnrecord;
import com.aaa.model.Student;
import com.aaa.model.StudentCompany;
import com.aaa.model.StudentRecord;
import com.aaa.model.TblClass;
import com.aaa.model.vo.StudentCompanyVo;
import com.aaa.model.vo.StudentVo;
import com.aaa.mapper.OrganizationMapper;
import com.aaa.mapper.ReturnrecordMapper;
import com.aaa.mapper.StudentCompanyMapper;
import com.aaa.mapper.StudentMapper;
import com.aaa.mapper.StudentRecordMapper;
import com.aaa.mapper.TblClassMapper;
import com.aaa.service.IStudentCompanyService;
import com.aaa.service.IStudentService;
import com.baomidou.mybatisplus.plugins.Page;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;

import org.apache.commons.lang.StringUtils;
import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author chenjian
 * @since 2017-09-14
 */
@Service
public class StudentCompanyServiceImpl extends ServiceImpl<StudentCompanyMapper, StudentCompany> implements IStudentCompanyService {

	@Autowired
	private StudentCompanyMapper studentCompanyMapper;
	@Autowired
	private StudentMapper studentMapper;
	@Autowired
	private TblClassMapper tblClassMapper;
	@Autowired
	private OrganizationMapper organizationMapper;
	/**
	 * 计算毕业学生奖金
	 */
	@Override
	public String calBonus(StudentCompany com) {
		Student  stu = studentMapper.selectById(com.getStuid());
		//获取学生所属的校区
		String flag = findOrgId(stu.getClassId());
    	StudentCompanyVo vo = new StudentCompanyVo();
    	vo.setDegree(stu.getDegree());
    	vo.setProsalary(com.getProsalary());
    	vo.setCitylev(com.getCitylev());
    	vo.setFlag(flag);//校区区别码
    	String bon = CalBonusesUtil.calBonuses(vo);
    	return bon;
	}
	/**
	 * 获取学生的校区标记  大学生 1  政通路 2 合作院校3
	 * @param classid
	 * @return
	 */
	private String findOrgId(Long classid){
		String flag = "";
		//获取所属专业
		TblClass tblClass  = tblClassMapper.selectClassById(classid);
		Long orgPid = 0l;
		if(tblClass!=null){
			Long orgId = tblClass.getOrgid();
			//获取当前orgid的pid
			Organization organization = organizationMapper.selectById(orgId);
			if(organization!=null){
				orgPid =  organization.getPid();
			}
		}
		if(orgPid.equals(3l)){//大学生校区
			flag="1";
		}else if(orgPid.equals(1l)){
			flag="2";
		}else{
			flag="3";
		}
		return flag;
	}
	/**
	 * 更新或者插入毕业信息
	 */
	@Override
	public boolean addOrUpdStudentCompany(List<StudentCompany> excelToListNew) {
		try {
			if(excelToListNew!=null&&excelToListNew.size()>0){
				for (StudentCompany studentCompany : excelToListNew) {
					//是否保存历史信息
					Map<String,Object> columnMap = new HashMap<String,Object>();
					columnMap.put("stuid", studentCompany.getStuid());
					List<StudentCompany>  list = studentCompanyMapper.selectByMap(columnMap);
					//存在历史信息
					String bon = "";
					if(list!=null&&list.size()>0){
						studentCompany.setCid(list.get(0).getCid());
						if(StringUtils.isBlank(studentCompany.getBonus())){
							//计算奖金
							bon = calBonus(list.get(0));
							studentCompany.setBonus(bon);
						}
						studentCompanyMapper.updateById(studentCompany);//更新信息
					}else{
						if(StringUtils.isBlank(studentCompany.getBonus())){
							bon = calBonus(list.get(0));
							studentCompany.setBonus(bon);
						}
						studentCompanyMapper.insert(studentCompany);//插入信息
					}
				}
			}
			return true;
		} catch (Exception e) {
			return false;
		}
		
	}
	/**
	 * 根据班级id获取就业信息
	 */
	@Override
	public List<Map<String, Object>> selectStudentComByClassId(Long id) {
		List<Map<String, Object>> list = studentCompanyMapper.selectStudentComByClassId(id);
		return list;
	}

	
	
}
