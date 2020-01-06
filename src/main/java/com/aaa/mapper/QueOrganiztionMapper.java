package com.aaa.mapper;

import com.aaa.model.QueOrganiztion;
import com.baomidou.mybatisplus.mapper.BaseMapper;
import org.apache.ibatis.annotations.ResultType;
import org.apache.ibatis.annotations.Select;

import java.util.List;
import java.util.Map;


/**
 * @author ky
 * @date 2020/1/3   
 * 考核点和校区关系
**/ 
public interface QueOrganiztionMapper extends BaseMapper<QueOrganiztion> {
    /**
     * 查询所有考核点
     * @param qid
     * @return
     */
    @Select("select * from question_organiztion where questionid = #{qid}")
    @ResultType(QueOrganiztion.class)
    List<QueOrganiztion> questionAndOrganTree(Long qid);

}
