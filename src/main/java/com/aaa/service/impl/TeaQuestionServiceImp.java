package com.aaa.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.aaa.commons.result.PageInfo;
import com.aaa.commons.utils.BeanUtils;
import com.aaa.mapper.TeaQuestionMapper;
import com.aaa.mapper.TeaquestionRoleMapper;
import com.aaa.model.Student;
import com.aaa.model.TeaQuestion;
import com.aaa.model.TeaquestionRole;
import com.aaa.model.UserRole;
import com.aaa.model.vo.TeaQuestionVo;
import com.aaa.service.ITeaQuestionService;
import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.mapper.Wrapper;
import com.baomidou.mybatisplus.plugins.Page;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;

/**
 * @title: TeaQuestionServiceImp
 * @Description:
 * @Company:AAA
 * @Date 2017-9-20 上午11:58:21
 * @author 万舒萌
 */
@Service
public class TeaQuestionServiceImp extends ServiceImpl<TeaQuestionMapper, TeaQuestion> implements ITeaQuestionService {
	@Autowired
	private TeaQuestionMapper teaQuestionMapper;
	@Autowired
	private TeaquestionRoleMapper teaquestionRoleMapper;
	@Override
	public List<TeaQuestion> selectList(Wrapper<TeaQuestion> wrapper) {
		return teaQuestionMapper.selectList(wrapper);
	}

	@Override
	public List<TeaQuestion> selectAll() {
		EntityWrapper<TeaQuestion> wrapper = new EntityWrapper<TeaQuestion>();
		TeaQuestion question=new TeaQuestion();
		wrapper.setEntity(question);
		return teaQuestionMapper.selectList(wrapper);
	}

	@Override
	public List<TeaQuestion> selectQuestionByLoginName(TeaQuestionVo teaQuestionVo) {
		TeaQuestion q=new TeaQuestion();
		EntityWrapper<TeaQuestion> wrapper =new EntityWrapper<TeaQuestion>(q);
		if (null !=teaQuestionVo.getId()) {
			wrapper.where("id !={0}", teaQuestionVo.getId());
		}
		return this.selectList(wrapper);
	}

	@Override
	public void insertQuestionByVo(TeaQuestionVo teaQuestionVo) {
		//添加教师考评点信息
		TeaQuestion q=BeanUtils.copy(teaQuestionVo, TeaQuestion.class);
		this.insert(q);
		//添加考评点与角色的关系
		String[] roles = teaQuestionVo.getRoleIds().split(",");
		TeaquestionRole teaquestionRole = new TeaquestionRole();
        for (String string : roles) {
        	teaquestionRole.setQuestionId(q.getId());
        	teaquestionRole.setRoleId(Long.valueOf(string));
        	teaquestionRoleMapper.insert(teaquestionRole);
        }
	}

	@Override
	public TeaQuestionVo selectQuestionVoById(Long id) {
		return teaQuestionMapper.selectQuestionVoById(id);
	}

	@Override
	public void updateQuestionByVo(TeaQuestionVo teaQuestionVo) {
		TeaQuestion question=BeanUtils.copy(teaQuestionVo,TeaQuestion.class);
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

}
