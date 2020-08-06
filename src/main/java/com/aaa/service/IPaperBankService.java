package com.aaa.service;

import com.aaa.commons.result.PageInfo;
import com.aaa.model.PaperBank;
import com.baomidou.mybatisplus.service.IService;

import java.util.List;
import java.util.Map;

public interface IPaperBankService extends IService<PaperBank> {
    void selectDataGrid(PageInfo pageInfo);
    void selectDataGridBank(PageInfo pageInfo);
    void deletePaperBank(Long id);
    void updatePapername(String papername,Long id);
    int addPaperByManual(Long userid,Long paperid,Long infoid);
    void addPapername(Long userId,String papername,Integer isparent);
    void addExamPaperAndTopicInfo(String paperid,Long userId,String sumStr,String xin,String papername);
    List<Map<String,Object>> selectDataGridBank(Map<String,Object> params);
}
