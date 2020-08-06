package com.aaa.mapper;

import com.aaa.model.PaperBank;
import com.aaa.model.TopicInfo;
import com.baomidou.mybatisplus.mapper.BaseMapper;
import com.baomidou.mybatisplus.plugins.Page;

import java.util.List;
import java.util.Map;

public interface PaperBankMapper extends BaseMapper<PaperBank> {
    List<Map<String, Object>> selectPaperBankPage(Page<Map<String, Object>> page, Map<String, Object> condition);
    List<TopicInfo> selectInfoByTypeIdAndSum(Map<String, Object> map);
    List<Map<String,Object>> selectPaperGroup(Page<Map<String, Object>> page, Map<String, Object> map);
    List<Map<String,Object>> selectPaperGroup( Map<String, Object> map);
    Integer getPaperid();
    Integer updatePapername(Map<String, Object> map);
    Integer deletePapers(Map<String, Object> map);
}
