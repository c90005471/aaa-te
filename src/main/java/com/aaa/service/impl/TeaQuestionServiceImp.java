package com.aaa.service.impl;

import java.util.List;
import java.util.Map;

import com.aaa.mapper.OrganizationMapper;
import com.aaa.mapper.QueOrganiztionMapper;
import com.aaa.model.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.aaa.commons.result.PageInfo;
import com.aaa.commons.utils.BeanUtils;
import com.aaa.mapper.TeaQuestionMapper;
import com.aaa.mapper.TeaquestionRoleMapper;
import com.aaa.model.vo.TeaQuestionVo;
import com.aaa.service.ITeaQuestionService;
import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.mapper.Wrapper;
import com.baomidou.mybatisplus.plugins.Page;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;

/**
 * @author 万舒萌
 * @title: TeaQuestionServiceImp
 * @Description:
 * @Company:AAA
 * @Date 2017-9-20 上午11:58:21
 */
@Service
public class TeaQuestionServiceImp extends ServiceImpl<TeaQuestionMapper, TeaQuestion> implements ITeaQuestionService {
    @Autowired
    private TeaQuestionMapper teaQuestionMapper;
    @Autowired
    private TeaquestionRoleMapper teaquestionRoleMapper;
    @Autowired
    private QueOrganiztionMapper queOrganiztionMapper;
    @Autowired
    private OrganizationMapper organizationMapper;

    @Override
    public List<TeaQuestion> selectList(Wrapper<TeaQuestion> wrapper) {
        return teaQuestionMapper.selectList(wrapper);
    }

    @Override
    public List<TeaQuestion> selectAll() {
        EntityWrapper<TeaQuestion> wrapper = new EntityWrapper<TeaQuestion>();
        TeaQuestion question = new TeaQuestion();
        wrapper.setEntity(question);
        return teaQuestionMapper.selectList(wrapper);
    }

    @Override
    public List<TeaQuestion> selectQuestionByLoginName(TeaQuestionVo teaQuestionVo) {
        TeaQuestion q = new TeaQuestion();
        EntityWrapper<TeaQuestion> wrapper = new EntityWrapper<TeaQuestion>(q);
        if (null != teaQuestionVo.getId()) {
            wrapper.where("id !={0}", teaQuestionVo.getId());
        }
        return this.selectList(wrapper);
    }

    @Override
    public void insertQuestionByVo(TeaQuestionVo teaQuestionVo) {
        //添加教师考评点信息
        TeaQuestion q = new TeaQuestion();
        q.setQuestionname(teaQuestionVo.getQuestionname());
        q.setType(1);
        q.setStatus(1);
        this.insert(q);
        //添加考评点与角色的关系
        String[] roles = teaQuestionVo.getRoleIds().split(",");
        TeaquestionRole teaquestionRole = new TeaquestionRole();
        for (String string : roles) {
            teaquestionRole.setQuestionId(q.getId());
            teaquestionRole.setRoleId(Long.valueOf(string));
            teaquestionRoleMapper.insert(teaquestionRole);
        }
        String[] orgids = teaQuestionVo.getOrganIds().split(",");
        QueOrganiztion queOrganiztion = new QueOrganiztion();
        for (String string : orgids) {
            //添加考评点和校区的关系
            queOrganiztion.setOrganiztionid(Integer.parseInt(string));
            queOrganiztion.setQuestionid(Integer.parseInt(q.getId() + ""));
            queOrganiztionMapper.insert(queOrganiztion);
        }
    }

    @Override
    public TeaQuestionVo selectQuestionVoById(Long id) {
        return teaQuestionMapper.selectQuestionVoById(id);
    }

    @Override
    public void updateQuestionByVo(TeaQuestionVo teaQuestionVo) {
        //先查询本条考核点的状态和类型
        TeaQuestion teaQuestion = teaQuestionMapper.selectTeaQuestionById(teaQuestionVo.getId());
        TeaQuestion question = BeanUtils.copy(teaQuestionVo, TeaQuestion.class);
        question.setType(teaQuestion.getType());
        question.setStatus(teaQuestion.getStatus());
        this.updateById(question);

        //删除原来的教师考评点 角色信息
        List<TeaquestionRole> teaquestionRoles = teaquestionRoleMapper.selectByQuestionId(question.getId());
        if (teaquestionRoles != null && !teaquestionRoles.isEmpty()) {
            for (TeaquestionRole teaquestionRole : teaquestionRoles) {
                teaquestionRoleMapper.deleteById(teaquestionRole.getId());
            }
        }
        //新增教师考评点 角色信息
        String[] roles = teaQuestionVo.getRoleIds().split(",");
        TeaquestionRole teaquestionRole = new TeaquestionRole();
        for (String string : roles) {
            teaquestionRole.setQuestionId(question.getId());
            teaquestionRole.setRoleId(Long.valueOf(string));
            teaquestionRoleMapper.insert(teaquestionRole);
        }

        /**
         * 操作校区和考核点信息
         */
        //删除原来的考核点 校区信息
        List<QueOrganiztion> queOrganiztions = queOrganiztionMapper.questionAndOrganTree(teaQuestion.getId());
        if (queOrganiztions != null && !queOrganiztions.isEmpty()) {
            for (int i = 0; i < queOrganiztions.size(); i++) {
                queOrganiztionMapper.deleteById(queOrganiztions.get(i).getId());
            }
        }
        //添加考核点 校区信息
        String[] organids = teaQuestionVo.getOrganIds().split(",");
        QueOrganiztion queOrganiztion = new QueOrganiztion();
        for (String string : organids) {
            queOrganiztion.setQuestionid(Integer.parseInt(question.getId() + ""));
            queOrganiztion.setOrganiztionid(Integer.parseInt(string));
            queOrganiztionMapper.insert(queOrganiztion);
        }
    }

    @Override
    public void selectDataGrid(PageInfo pageInfo) {
        Page<Map<String, Object>> page = new Page<Map<String, Object>>(pageInfo.getNowpage(), pageInfo.getSize());
        page.setOrderByField(pageInfo.getSort());
        page.setAsc(pageInfo.getOrder().equalsIgnoreCase("asc"));
        List<Map<String, Object>> list = teaQuestionMapper.selectQuestionPage(page, pageInfo.getCondition());
        pageInfo.setRows(list);
        pageInfo.setTotal(page.getTotal());
    }

    @Override
    public void deleteQuestionById(Long id) {
        this.deleteQuestionById(id);
    }

    /**
     * 根据角色id查询教师考评点
     */
    @Override
    public List<TeaQuestion> selectListByRoleId(Long roleId) {
        return teaQuestionMapper.selectListByRoleId(roleId);
    }

    /**
     * 根据角色id查询教师考评点 ----分模块
     */
    @Override
    public List<TeaQuestion> selecFentListByRoleId(Long roleId) {
        return teaQuestionMapper.selecFentListByRoleId(roleId);
    }

    @Override
    public List<TeaQuestion> selectNewListByRoleId(Long roleId, String organiztionid) {
        return teaQuestionMapper.selectNewListByRoleId(roleId, organiztionid);
    }

}
