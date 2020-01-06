package com.aaa.mapper;

import com.aaa.commons.result.Tree;
import com.aaa.model.QueOrganiztion;
import com.aaa.model.TblClass;
import com.aaa.model.vo.TeaQuestionVo;
import com.baomidou.mybatisplus.mapper.BaseMapper;
import com.aaa.model.Organization;
import org.apache.ibatis.annotations.ResultType;
import org.apache.ibatis.annotations.Select;

import java.util.List;
import java.util.Map;

/**
 *
 * Organization 表数据库控制层接口
 *
 */
public interface OrganizationMapper extends BaseMapper<Organization> {

    /**
     * 查询考核点所属校区
     * @param id
     * @return
     */
    @Select("SELECT " +
            "t.id, t.questionname,t.type type,o.id oid,o.`name` " +
            "FROM " +
            "teacherquestion t " +
            "right join question_organiztion q on t.id = q.questionid " +
            "left join organization o on q.organiztionid = o.id " +
            "where o.pid is NULL " +
            "and t.id = #{id}")
    @ResultType(Map.class)
    List<Map<String,Object>> questionAndOrganTree(Long id);
}