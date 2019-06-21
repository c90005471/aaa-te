package com.aaa.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.aaa.commons.result.PageInfo;
import com.aaa.commons.utils.ExcelUitl;
import com.aaa.model.TblSclRecord;
import com.aaa.model.vo.TblSclRecordVo;
import com.aaa.service.ITblSclRecordProbService;
import com.baomidou.mybatisplus.mapper.EntityWrapper;
	/**
 *@className:TblSclRecordProbController.java
 *@discriptions:
 *@author:徐辉
 *@createTime:2017-11-30下午4:05:16
 *@version:1.0.0
 *
 * <p>
 *  前端控制器
 * </p>
 * @author user
 *
 */
@Controller
@RequestMapping("/tblSclRecordProb")
public class TblSclRecordProbController {
@Autowired private ITblSclRecordProbService tblSclRecordProbService;
    /**
     * 调用manager方法跳转到tblSclRecordProbList.jsp页面
     * @return
     */
    @GetMapping("/manager")
    public String manager() {
        return "admin/tblSclRecordProb/tblSclRecordProbList";
    }
    
    /**
     * 显示学生心理测试异常信息
     * @param tblSclRecord
     * @param page
     * @param rows
     * @param sort
     * @param order
     * @param stuno
     * @param stuname
     * @return
     */
    @PostMapping("/dataGrid")
    @ResponseBody
    public PageInfo dataGrid(TblSclRecord tblSclRecord, Integer page, Integer rows, String sort,String order,String stuno,String stuname) {
        PageInfo pageInfo = new PageInfo(page, rows, sort, order);
        Map<String, Object> condition = new HashMap<String, Object>();
        if (tblSclRecord != null) {
			if (stuno != null) {
				condition.put("stuno", stuno);
			}
			if (stuname != null) {
				condition.put("stuname", stuname);
			}
		}
        pageInfo.setCondition(condition);
        tblSclRecordProbService.selectProbDataGrid(pageInfo);
        return pageInfo;
    }
    
    /**
     * 导出所有的心理测试异常学生
     * @throws Exception 
     * susnhaoshan 2017-12-09
     */
    @GetMapping("/exportTblSclRecordProb")
    public void  exportTblSclRecordProb(HttpServletResponse resp,Integer page, Integer rows, String sort,String order) throws Exception{
    	
    }
}
