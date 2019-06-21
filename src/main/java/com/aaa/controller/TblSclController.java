package com.aaa.controller;

import javax.validation.Valid;

import java.util.HashMap;
import java.util.List;
import java.util.Date;
import java.util.Map;

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
import com.aaa.commons.utils.StringUtils;
import com.aaa.model.TblScl;
import com.aaa.service.ITblSclService;
import com.aaa.commons.base.BaseController;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author fangjunwei
 * @since 2017-11-29
 */
@Controller
@RequestMapping("/tblScl")
public class TblSclController extends BaseController {

    @Autowired private ITblSclService tblSclService;
    
    @GetMapping("/manager")
    public String manager() {
        return "admin/tblScl/tblSclList";
    }
    
    @PostMapping("/dataGrid")
    @ResponseBody
    public PageInfo dataGrid(TblScl tblScl, Integer page, Integer rows, String sort,String order) {
        /*List<TblScl> selectAll = tblScl.selectAll();
        System.out.println(selectAll);*/
    	PageInfo pageInfo = new PageInfo(page, rows, sort, order);
        Map<String, Object> condition = new HashMap<String, Object>();
        //将查询条件放入condition集合
        if (StringUtils.isNotBlank(tblScl.getTypeId()+"")) {
            condition.put("typeId", tblScl.getTypeId());
        }
        if(StringUtils.isNotBlank(tblScl.getItem())){
        	condition.put("item", tblScl.getItem());
        }
        pageInfo.setCondition(condition);
        tblSclService.selectDataGird(pageInfo);
        return pageInfo;
    }
    
    /**
     * 添加页面
     * @return
     */
    @GetMapping("/addPage")
    public String addPage() {
        return "admin/tblScl/tblSclAdd";
    }
    
    /**
     * 添加
     * @param 
     * @return
     */
    @PostMapping("/add")
    @ResponseBody
    public Object add(TblScl tblScl) {
        boolean b = tblSclService.insert(tblScl);
        if (b) {
            return renderSuccess("添加成功！");
        } else {
            return renderError("添加失败！");
        }
    }
    /**
     * 删除
     * @param id
     * @return
     */
    @PostMapping("/delete")
    @ResponseBody
    public Object delete(Integer id) {
        boolean result = tblSclService.deleteById(id);
        if (result) {
            return renderSuccess("删除成功！");
        } else {
            return renderError("删除失败！");
        }
    }
    
    /**
     * 编辑
     * @param model
     * @param id
     * @return
     */
    @GetMapping("/editPage")
    public String editPage(Model model, Long id) {
        TblScl tblScl = tblSclService.selectById(id);
        model.addAttribute("tblScl", tblScl);
        return "admin/tblScl/tblSclEdit";
    }
    
    /**
     * 编辑
     * @param 
     * @return
     */
    @PostMapping("/edit")
    @ResponseBody
    public Object edit(@Valid TblScl tblScl) {
        boolean result = tblSclService.updateById(tblScl);
        tblSclService.updateById(tblScl);
        if (result) {
            return renderSuccess("编辑成功！");
        } else {
            return renderError("编辑失败！");
        }
    }
    
    /**
     * 查询tbl_scl_type表的id和typeName，为下拉列表
     * @return
     */
    @PostMapping("/selectTblSclType")
    @ResponseBody
    public Object selectTblSclType(){
    	return tblSclService.selectTblSclType();
    }
    /**
     * 查看当前插入的题目id是否已经存在，如果存在则查询出tbl_scl表中的最后一个id与所查询的id拼接传到后台
     * @param id
     * @return
     */
    @PostMapping("/selectItemId")
    @ResponseBody
    public int selectItemId(Long id){
    	List<Map<String,Object>> list = tblSclService.selectItemId(id);
    	//如果集合不为空，将当前查询的id和数据库中最后一条数据的id进行拼接
    	if(list!=null&&list.size()>0){
    		return 0;
    	}else{
    		return 1;
    	}
    	
    }
}
