package com.aaa.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.aaa.commons.result.PageInfo;
import com.aaa.service.ISysLogService;

/**
 * @description：日志管理
 * @author：aaa.teacher
 * @date：2017/10/30 18:06
 */
@Controller
@RequestMapping("/sysLog")
public class SysLogController {
    @Autowired
    private ISysLogService sysLogService;

    @GetMapping("/manager")
    public String manager() {
        return "admin/syslog";
    }

    @PostMapping("/dataGrid")
    @ResponseBody
    public PageInfo dataGrid(Integer page, Integer rows, 
            @RequestParam(value = "sort", defaultValue = "create_time") String sort, 
            @RequestParam(value = "order", defaultValue = "DESC") String order) {
        PageInfo pageInfo = new PageInfo(page, rows, sort, order);
        sysLogService.selectDataGrid(pageInfo);
        return pageInfo;
    }
}
