package com.aaa.controller;

import com.aaa.commons.base.BaseController;
import com.aaa.commons.result.PageInfo;
import com.aaa.service.IPaperBankService;
import net.sf.json.JSONArray;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
    @RequestMapping("/paperBank")
public class PaperBankController extends BaseController {
    @Autowired
    private IPaperBankService paperBankService;

    /**
     * 试卷列表页面
     * @return
     */
    @RequestMapping("/manager")
    public String manager(){
        return "admin/paperbank/paperBank";
    }
    /**
     * 试卷列表页面
     * @return
     */
    @RequestMapping("/addPage")
    public String addPage(){
        return "admin/paperbank/paperBankAdd";
    }

    /**
     * 试卷列表页面回调方法
     * @return
     */
    @PostMapping("/dataGrid")
    @ResponseBody
    public Object dataGrid(Integer page, Integer rows, String sort, String order, String papername) {
        PageInfo pageInfo = new PageInfo(page, rows, sort, order);
        Map<String, Object> condition = new HashMap<String, Object>();


        condition.put("papername", papername);

        pageInfo.setCondition(condition);
        paperBankService.selectDataGrid(pageInfo);
        return pageInfo;
    }

    /**
     * 试卷列表页面回调方法
     * @return
     */
    @PostMapping("/dataGridBank")
    @ResponseBody
    public Object dataGridBank(Integer page, Integer rows, String sort, String order, String papername) {
        Map<String, Object> condition = new HashMap<String, Object>();
        condition.put("papername", papername);
        if (page!=null){
            PageInfo pageInfo = new PageInfo(page, rows, sort, order);
            pageInfo.setCondition(condition);
            paperBankService.selectDataGridBank(pageInfo);
            return pageInfo;
        }else {
            List<Map<String, Object>> list = paperBankService.selectDataGridBank(condition);
            return list;
        }
    }

    /**
     * 智能组卷生成方法
     * @param sumStr 科目id 抽取数量
     * @param xin 新增或者重新生成
     * @return
     */
    @PostMapping("/make")
    @ResponseBody
    public Object make(String sumStr, String xin, String papername,String paperid){
        Long userId = getUserId();
        paperBankService.addExamPaperAndTopicInfo(paperid,userId,sumStr,xin,papername);
        return renderSuccess("操作成功");
    }

    /**
     * 删除试题
     * @param id
     * @return
     */
    @PostMapping("/delete")
    @ResponseBody
    public Object delete(Long id) {
        paperBankService.deletePaperBank(id);
        return renderSuccess("删除成功！");
    }

    /**
     * 修改试题页
     */
    @GetMapping("/editPage")
    public String editPage(Model model, Long id) {
        Map<String, Object> params = new HashMap<>();
        params.put("id",id);
        //获取试题选项信息
        List<Map<String,Object>> optionList = paperBankService.selectDataGridBank(params);
        JSONArray jsonArray = JSONArray.fromObject(optionList);
        model.addAttribute("optionList",jsonArray);
        return "admin/paperbank/topicInfoEdit";
    }

    /**
     * 编辑试题信息页
     */
    @PostMapping("/edit")
    @ResponseBody
    public Object edit(String papername,Long id) {
        paperBankService.updatePapername(papername,id);
        return renderSuccess("修改成功！");
    }

    @PostMapping("/add")
    @ResponseBody
    public Object add(String papername,Integer isparent) {
        Long userId = getUserId();
        paperBankService.addPapername(userId,papername,isparent);
        return renderSuccess("修改成功！");
    }

    /**
     * 手动组卷添加试题
     * @param paperid
     * @param infoid
     * @return
     */
    @PostMapping("/addPaperByManual")
    @ResponseBody
    public Object addPaperByManual(Long paperid,Long infoid){
        Long userId = getUserId();

        int len =  paperBankService.addPaperByManual(userId,paperid,infoid);
        return len;
    }
}
