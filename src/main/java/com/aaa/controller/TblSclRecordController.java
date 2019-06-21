package com.aaa.controller;

import java.io.File;
import java.lang.reflect.Field;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.aaa.commons.base.BaseController;
import com.aaa.commons.result.PageInfo;
import com.aaa.commons.utils.ConstantUtils;
import com.aaa.commons.utils.ExcelUitl;
import com.aaa.model.Organization;
import com.aaa.model.TblSclRecord;
import com.aaa.model.vo.TblSclRecordExcelVo;
import com.aaa.model.vo.TeacherPlanExcelVo;
import com.aaa.service.IOrganizationService;
import com.aaa.service.ITblSclRecordService;

/**
 * @description:健康自评总页面控制器
 * @author sunxicai
 * @since 2017-11-29
 */
@Controller
@RequestMapping("/tblSclRecord")
public class TblSclRecordController extends BaseController {

    @Autowired private ITblSclRecordService tblSclRecordService;
    @Autowired
    private IOrganizationService organizationService;
    //跳转到健康自评统计的总 页面
    @GetMapping("/manager")
    public String manager() {
        return "admin/tblSclRecord/tblSclRecordList";
    }
    
    //想健康自评统计总页面传输数据
    @PostMapping("/dataGrid")
    @ResponseBody
    public PageInfo dataGrid(TblSclRecord tblSclRecord, Integer page, Integer rows, String sort,String order,String stuno,String stuname,String classId,Long orgid,String createtime_begin,String createtime_end) {
        PageInfo pageInfo = new PageInfo(page, rows, sort, order);//新建分页信息实体类
        Map<String, Object> condition = new HashMap<String, Object>();//新建存放查询条件的map
        if (tblSclRecord != null) {//传入查询条件
        	if(orgid!=null){//校区或专业的id 
        		String idstr = findOrgList(orgid+"","");//获取校区或专业下所有的子类
        		if(StringUtils.isNotBlank(idstr)&&idstr.length()>1){
        			idstr = idstr.substring(0,idstr.length()-1);
        			condition.put("orgids", idstr);
        		}
        	}
        	if (classId != null) {
				condition.put("classId", classId);
			}
			if (stuno != null) {//按学号模糊查询
				condition.put("stuno", stuno);
			}
			if (stuname != null) {//按学生姓名模糊查询
				condition.put("stuname", stuname);
			}
			if (createtime_begin !=null){
				condition.put("createtime_begin", createtime_begin);
			}
			if(createtime_end != null){
				condition.put("createtime_end", createtime_end);
			}
		}
        pageInfo.setCondition(condition);//将查询信息放入到分页信息实体类中
        tblSclRecordService.selectDataGrid(pageInfo);//调用页面查询健康自评统计总页面的数据
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
     * 删除
     * @param id
     * @return
     */
    @PostMapping("/delete")
    @ResponseBody
    public Object delete(Long id) {
        boolean b = tblSclRecordService.deleteById(id);
        if (b) {
            return renderSuccess("删除成功！");
        } else {
            return renderError("删除失败！");
        }
    }
    
    
    /**
     * 按查询结果导出excel
     * @param columns
     * @param Rows
     * @throws Exception 
     */
    @PostMapping("/exportTblSclRecordExcel")
    @ResponseBody
    public String exportTblSclRecordExcel(HttpServletRequest req, HttpServletResponse resp,@RequestBody Map map) throws Exception{
    	LinkedHashMap<String,String> titleMap = new LinkedHashMap<String,String>(); 
    	//获取表头
    	JSONArray columnsJsonArray = JSONArray.fromObject(map.get("columns"));
    	List<Map<String,Object>> mapListJsonColumns = (List<Map<String,Object>>)columnsJsonArray;
    	//反射获取实体类中的字段名
    	Field[] fs=TblSclRecordExcelVo.class.getDeclaredFields();
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
    	List<TblSclRecordExcelVo> tblSclRecordExcelVoList = new ArrayList<TblSclRecordExcelVo>();
    	for (Map<String, Object> dataMap : mapListJsonDatagridRows) {
    		TblSclRecordExcelVo record = new TblSclRecordExcelVo(); 
    		record.setId(Long.valueOf(dataMap.get("id").toString()));
    		record.setStuno(dataMap.get("stuno").toString());
    		record.setStuname(dataMap.get("stuname").toString());
    		record.setIdno(dataMap.get("idno").toString());
    		record.setPhone(dataMap.get("phone").toString());
    		//record.setSex(dataMap.get("sex").toString());
    		record.setClassname(dataMap.get("classname").toString());
    		record.setSunCount(dataMap.get("sunCount").toString());
    		record.setSclScore(dataMap.get("sclScore").toString());
    		record.setCreatetime(dataMap.get("createtime").toString());
    		tblSclRecordExcelVoList.add(record);
		}
    	String path = req.getSession().getServletContext().getRealPath("/")+ConstantUtils.UPLOAD_PATH+File.separator;
    	String fileName = ExcelUitl.listToExcelFile(tblSclRecordExcelVoList, titleMap, "健康自评统计及表", 1000, resp,path);
    	return fileName;
    }
}
