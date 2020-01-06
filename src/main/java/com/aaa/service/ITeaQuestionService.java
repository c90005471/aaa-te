package com.aaa.service;

import java.util.List;

import com.aaa.commons.result.PageInfo;
import com.aaa.model.TeaQuestion;
import com.aaa.model.vo.TeaQuestionVo;
import com.baomidou.mybatisplus.service.IService;

/**
 * @title: ITeaQuestionService
 * @Description:
 * @Company:AAA
 * @Date 2017-9-20 上午11:54:38
 * @author 万舒萌
 */
public interface ITeaQuestionService extends IService<TeaQuestion>{
	List<TeaQuestion> selectQuestionByLoginName(TeaQuestionVo teaQuestionVo);

    void insertQuestionByVo(TeaQuestionVo teaQuestionVo);

    TeaQuestionVo selectQuestionVoById(Long id);

    void updateQuestionByVo(TeaQuestionVo teaQuestionVo);

    void selectDataGrid(PageInfo pageInfo);

    void deleteQuestionById(Long id);
    
	List<TeaQuestion> selectAll();

	List<TeaQuestion> selectListByRoleId(Long roleId);
    /**
     *   分模块  教评
     */
	List<TeaQuestion> selecFentListByRoleId(Long roleId);

    /**
     * 查询权限+所属校区下的考核点
     * @param roleId
     * @return
     */
    List<TeaQuestion> selectNewListByRoleId(Long roleId,String organiztionid);
}
