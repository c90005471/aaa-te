package com.aaa.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.ResultType;
import org.apache.ibatis.annotations.Select;

import com.baomidou.mybatisplus.mapper.BaseMapper;
import com.aaa.model.TeaquestionRole;
import com.aaa.model.UserRole;

/**
 *
 * TesquestionRole 表数据库控制层接口
 *
 */
public interface TeaquestionRoleMapper extends BaseMapper<TeaquestionRole> {

    List<TeaquestionRole> selectByQuestionId(@Param("questionId") Long questionId);
//
//    @Select("select role_id AS roleId from teaquestion_role where user_id = #{userId}")
//    @ResultType(Long.class)
//    List<Long> selectRoleIdListByUserId(@Param("userId") Long userId);
    
    @Delete("DELETE FROM teaquestion_role WHERE question_id = #{questionId}")
    int deleteByUserId(@Param("questionId") Long questionId);

}