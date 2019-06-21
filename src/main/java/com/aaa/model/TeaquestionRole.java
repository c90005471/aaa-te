package com.aaa.model;

import com.aaa.commons.utils.JsonUtils;

import java.io.Serializable;

/**
 * 用户角色
 */
public class TeaquestionRole implements Serializable {

    private static final long serialVersionUID = 1L;

    /**
     * 主键id
     */
    private Long id;

    /**
     * 问题id
     */
    private Long questionId;

    /**
     * 角色id
     */
    private Long roleId;


    public Long getId() {
        return this.id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getQuestionId() {
		return questionId;
	}

	public void setQuestionId(Long questionId) {
		this.questionId = questionId;
	}

	public Long getRoleId() {
        return this.roleId;
    }

    public void setRoleId(Long roleId) {
        this.roleId = roleId;
    }

    @Override
    public String toString() {
        return JsonUtils.toJson(this);
    }
}
