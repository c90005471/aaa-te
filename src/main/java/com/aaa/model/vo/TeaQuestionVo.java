package com.aaa.model.vo;

import java.io.Serializable;
import java.util.List;

import com.aaa.commons.utils.JsonUtils;
import com.aaa.model.Role;
import com.baomidou.mybatisplus.annotations.TableName;

/**
 * @title: TeaQuestion
 * @Description:
 * @Company:AAA
 * @Date 2017-9-20 上午11:43:39
 * @author 万舒萌
 */
@TableName("teacherquestion")
public class TeaQuestionVo implements Serializable{
	
	private static final long serialVersionUID = 1L;
	
	/** 主键id */
	private Long id;
	
	/** 问题名称 */
	private String questionname;
	
	/** 教师角色*/
	private String roleIds;
	
	/** 类型 */ 
	private int type;
	/**
	 * 校区信息
	 */
	private String organIds;
	
	
	private List<Role> rolesList;
	
	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getQuestionname() {
		return questionname;
	}

	public void setQuestionname(String questionname) {
		this.questionname = questionname;
	}
	
	
	public String getRoleIds() {
		return roleIds;
	}

	public void setRoleIds(String roleIds) {
		this.roleIds = roleIds;
	}

	@Override
	public String toString() {
		return JsonUtils.toJson(this);
	}

	public List<Role> getRolesList() {
		return rolesList;
	}

	public void setRolesList(List<Role> rolesList) {
		this.rolesList = rolesList;
	}

	public int getType() {
		return type;
	}

	public void setType(int type) {
		this.type = type;
	}

	public String getOrganIds() {
		return organIds;
	}

	public void setOrganIds(String organIds) {
		this.organIds = organIds;
	}
}
