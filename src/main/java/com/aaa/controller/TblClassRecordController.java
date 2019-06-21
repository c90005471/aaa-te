package com.aaa.controller;

import javax.validation.Valid;

import java.util.List;
import java.util.Date;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.plugins.Page;
import com.aaa.commons.result.PageInfo;
import com.aaa.model.TblClass;
import com.aaa.service.ITblClassRecordService;
import com.aaa.service.ITblClassService;
import com.aaa.commons.base.BaseController;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author sunshaoshan
 * @since 2017-10-17
 */
@Controller
@RequestMapping("/tblClassRecord")
public class TblClassRecordController extends BaseController {

    @Autowired private ITblClassRecordService tblClassRecordService;
    
    @GetMapping("/manager")
    public String manager() {
        return "admin/tblClassRecord/tblClassRecordList";
    }
    
    
    /**
     * 班级列表
     *
     * @return
     */
    @RequestMapping("/treeGrid")
    @ResponseBody
    public Object treeGrid() {
        return tblClassRecordService.selectTreeGrid();
    }
}
