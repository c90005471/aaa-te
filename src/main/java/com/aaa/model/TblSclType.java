package com.aaa.model;

import java.io.Serializable;

import com.baomidou.mybatisplus.activerecord.Model;

/***
 *@className:TblSclType.java
 *@description:
 *@author:fjw
 *@createTime:2017-11-29下午10:25:43
 *@version:1.0.0
 */
public class TblSclType extends Model<TblScl> {

	
	private static final long serialVersionUID = 1L;
	
	private Integer id;
	private String typeName;
	
	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getTypeName() {
		return typeName;
	}

	public void setTypeName(String typeName) {
		this.typeName = typeName;
	}

	@Override
	protected Serializable pkVal() {
		// TODO Auto-generated method stub
		return this.id;
	}

}
