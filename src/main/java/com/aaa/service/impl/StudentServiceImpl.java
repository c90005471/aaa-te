package com.aaa.service.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.validation.Valid;

import com.aaa.commons.result.PageInfo;
import com.aaa.commons.utils.ConstantUtils;
import com.aaa.commons.utils.DateUtil;
import com.aaa.model.*;
import com.aaa.model.vo.StudentCompanyVo;
import com.aaa.model.vo.StudentVo;
import com.aaa.mapper.ReturnrecordMapper;
import com.aaa.mapper.StudentCompanyMapper;
import com.aaa.mapper.StudentMapper;
import com.aaa.mapper.StudentRecordMapper;
import com.aaa.service.IStudentService;
import com.baomidou.mybatisplus.mapper.EntityWrapper;
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
public class StudentServiceImpl extends ServiceImpl<StudentMapper, Student> implements IStudentService {

	@Autowired
	private StudentMapper studentMapper;
	@Autowired
	private StudentRecordMapper studentRecordMapper;
	@Autowired
	private StudentCompanyMapper studentCompanyMapper;
	
	@Autowired
	private ReturnrecordMapper returnRecordMapper;
	@Override
	public void selectDataGrid(PageInfo pageInfo) {
		 Page<Map<String, Object>> page = new Page<Map<String, Object>>(pageInfo.getNowpage(), pageInfo.getSize());
	        page.setOrderByField(pageInfo.getSort());
	        page.setAsc(pageInfo.getOrder().equalsIgnoreCase("asc"));
	        String flag = (String)pageInfo.getCondition().get("flag");
	        List<Map<String, Object>> list  = null;
	        if("1".equals(flag)){//已毕业
	        	list = studentCompanyMapper.selectStudentCompanyPage(page, pageInfo.getCondition());
	        }else{
	        	list = studentMapper.selectStudentPage(page, pageInfo.getCondition());
	        }
	        pageInfo.setRows(list);
	        pageInfo.setTotal(page.getTotal());
		
	}
	@Override
	public Map selectCapterByStuId(Long id) {
		return studentMapper.selectCapterByStuId(id);
	}

	@Override
	public List<Map<String, Object>> getDegree() {
		return studentMapper.getDegree();
	}

	@Override
	public List<Map<String, Object>> getMajor() {
		return studentMapper.getMajor();
	}

	@Override
	public List<Map<String, Object>> getClassById(Long id) {
		return studentMapper.getClassById(id);
	}

	@Override
	public Map<String, Object> selectStuById(Long id) {
		return studentMapper.selectStuById(id);
	}
	/**
	 * student 需要修改的对象
	 * userId 当前登录人的id
	 */
	@Override
	public boolean updateStudentById(Student student, Long userId) {
		boolean flag = false;
		//获取原来的信息
		Student oldStudent = studentMapper.selectById(student.getId());
		
		Integer num = studentMapper.updateById(student);//更新信息
		if(num==1){
			flag = true;
			//如果原来信息中的班级id与现在的班级id不同需保存一条专版记录信息
			if(!oldStudent.getClassId().equals(student.getClassId())){
				StudentRecord studentRecord = new StudentRecord();
				studentRecord.setStudentid(student.getId());
				studentRecord.setOldclass_id(oldStudent.getClassId());
				studentRecord.setNewclass_id(student.getClassId());
				studentRecord.setCreator(userId);
				studentRecord.setCreatetime(new Date());
				studentRecord.setOperrecord("0");
				//记录转出
				studentRecordMapper.insertStudentRecord(studentRecord);
				studentRecord.setOperrecord("1");
				//记录转入
				studentRecordMapper.insertStudentRecord(studentRecord);
			}
			//保存学生就业信息
//			if(studentCompany!=null&&StringUtils.isNotBlank(studentCompany.getCompanyname())){
//				studentCompany.setStuid(student.getId());
//				studentCompany.setCreator(userId);
//				studentCompany.setCreatetime(new Date());
//				if(studentCompany.getCid()!=null){
//					studentCompanyMapper.updateById(studentCompany);
//				}else{
//					studentCompanyMapper.insert(studentCompany);
//				}
//				
//			}
		}
		return flag;
	}
	@Override
	public Map<String, Object> selectStudentCompanyById(Long stuid) {
		return studentCompanyMapper.selectStudentCompanyById(stuid);
	}
	@Override
	public List<StudentVo> selectStudentVoList(Long id) {
		return studentMapper.selectStudentVoList(id);
	}
	@Override
	public List<Map> fillAllColStu(String orgid) {
		return studentMapper.fillAllColStu(orgid);
	}
	@Override
	public List<Map> fillAllHighStu(String orgid) {
		return studentMapper.fillAllHighStu(orgid);
	}
	/**
	 * 获取回访记录列表
	 */
	@Override
	public void selectRerturnCordDataGrid(PageInfo pageInfo) {
		Page<Map<String, Object>> page = new Page<Map<String, Object>>(pageInfo.getNowpage(), pageInfo.getSize());
        page.setOrderByField(pageInfo.getSort());
        page.setAsc(pageInfo.getOrder().equalsIgnoreCase("asc"));
        List<Map<String, Object>> list = returnRecordMapper.selectStudentReturnRecordPage(page,pageInfo.getCondition());
        pageInfo.setRows(list);
        pageInfo.setTotal(page.getTotal());
	}
	/**
	 * 删除回访记录信息
	 */
	@Override
	public boolean deleteReturnRecordById(Long id) {
		try {
			returnRecordMapper.deleteById(id);
			return true;
		} catch (Exception e) {
			return false;
		}
	}
	/**
	 * 保存回访记录信息
	 */
	@Override
	public boolean insertReturnrecord(Returnrecord returnrecord) {
		try {
			returnRecordMapper.insert(returnrecord);
			return true;
		} catch (Exception e) {
			return false;
		}
	}
	/**
	 * 获取回访记录信息
	 */
	@Override
	public Returnrecord selectReturnRecordById(Long id) {
		Returnrecord returnrecord = returnRecordMapper.selectById(id);
		return returnrecord;
	}
	/**
	 * 保存修改后的回访记录信息
	 */
	@Override
	public boolean updateReturnrecordById(Returnrecord returnrecord) {
		try {
			returnRecordMapper.updateAllColumnById(returnrecord);
			return true;
		} catch (Exception e) {
			return false;
		}
	}
	@Override
	public List<Map> selectReturnRecordByMonHashMap(Map map) {
		return returnRecordMapper.selectReturnRecordByMonHashMap(map);
	}
	/**
	 * 更新或添加毕业学生信息
	 */
	@Override
	public boolean updateByStudentById(Student student,StudentCompany studentCompany, Long userId) {
		try {
			if(studentCompany.getCid()!=null){
				//执行修改
				studentCompanyMapper.updateById(studentCompany);
			}else{
				//执行插入
				studentCompanyMapper.insertStudentCompany(studentCompany);
			}
			return true;
		} catch (Exception e) {
			return false;
		}
		
	}
	/**
	 * 获取excel中的数据组装学生毕业信息
	 */
	@Override
	public List<StudentCompany> selectStudentCompanyByExcel(List<StudentCompanyVo> excelToList,Long userId) {
		List<StudentCompany> excelToListNew = new ArrayList<StudentCompany>();
		for (StudentCompanyVo studentCompanyVo : excelToList) {
			StudentCompany sc = new StudentCompany();
			Map<String,Object> columnMap = new HashMap<String,Object>();
			columnMap.put("stuno", studentCompanyVo.getStuno());
			List<Student> stuList= studentMapper.selectByMap(columnMap);
    		if(stuList!=null&&stuList.size()>0){
    			sc.setStuid(stuList.get(0).getId());
        		//是否上报考试申请
        		sc.setIsreporteaxm(studentCompanyVo.getIsreporteaxm());
        		//是否参加考试
        		sc.setIseaxm(studentCompanyVo.getIseaxm());
        		//考试情况
        		sc.setEaxmstat(studentCompanyVo.getEaxmstat());
        		//是否就业
        		if(StringUtils.isNotBlank(studentCompanyVo.getIsjob())){
        			sc.setIsjob(studentCompanyVo.getIsjob());
            		//离校时间
            		if(StringUtils.isNotBlank(studentCompanyVo.getLeaschooltime())){
            			sc.setLeaschooltime(DateUtil.fromStringToDate(studentCompanyVo.getLeaschooltime()));
            		}
            		//就业城市
            		sc.setCompanyaddr(studentCompanyVo.getCompanyaddr());
            		//城市级别
            		sc.setCitylev(studentCompanyVo.getCitylev());
            		//就业企业
            		sc.setCompanyname(studentCompanyVo.getCompanyname());
            		//岗位
            		sc.setStation(studentCompanyVo.getStation());
            		//试用工资
            		sc.setProsalary(studentCompanyVo.getProsalary());
            		//转正工资
            		sc.setForsalary(studentCompanyVo.getForsalary());
            		//联系方式
            		sc.setXphone(studentCompanyVo.getXphone());
            		//就业老师
            		
            		if(!ConstantUtils.ZIZHUJIUYE.equals(studentCompanyVo.getTeachername())){
            			sc.setTeacherid(userId);
            		}
            		//就业奖金
            		sc.setBonus(studentCompanyVo.getBonus());
            		//审核结果
            		sc.setCheckstat(studentCompanyVo.getCheckstat());
            			
            		excelToListNew.add(sc);
        		}
    		}
		}
		return excelToListNew;
	}

	@Override
	public boolean checkStudentLogin(String stuno, String stuphone) {
	    Map<String,Object> map = new HashMap<>();
        map.put("stuno",stuno);
        map.put("stuphone",stuphone);
	    Map<String,Object> stuMap = studentMapper.checkStudentLogin(map);
	    if (stuMap != null){
            return true;
        }
		return false;
	}

	@Override
	public List<TreeMenu> getStudentMenu(String stuid) {
		TreeMenu treeMenu = new TreeMenu();
		treeMenu.setText("考试记录");
		Map<String,Object> map = new HashMap<>();
		map.put("stuno",stuid);
		Student student = studentMapper.getStudentInfo(map);
		map.put("stuid",student.getId());
		List<TreeMenu> nodes = studentMapper.getStudentExam(map);
		treeMenu.setTreeMenuList(nodes);
		List<TreeMenu> treeMenuList1 = new ArrayList<>();
		treeMenuList1.add(treeMenu);
		return treeMenuList1;
	}

	@Override
	public Student getStudentInfo(String stuno, String stuphont) {
		Map<String,Object> map = new HashMap<>();
		map.put("stuno",stuno);
		map.put("stuphone",stuphont);
		return studentMapper.getStudentInfo(map);
	}

}
