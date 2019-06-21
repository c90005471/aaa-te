package com.aaa.model;

import java.io.Serializable;
import java.util.Date;

import com.baomidou.mybatisplus.activerecord.Model;
import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;
import com.baomidou.mybatisplus.enums.IdType;
import com.fasterxml.jackson.annotation.JsonProperty;

/**
 *
 * @author sunshaoshan
 * @since 2017-10-17
 */
@TableName("tbl_class_record")
public class TblClassRecord extends Model<TblClassRecord>{

	private static final long serialVersionUID = -2202349995741654894L;
	
	/**
     * 记录id
     */
	@TableId(value="id", type= IdType.AUTO)
	private Long id;
	/**
	 * 原老师   
	 */
	private Long userid;
	private String username;
	/**
	 * 操作人
	 */
	private Long creator;
	private String creatname;
	/**
	 * 操作时间
	 */
	private Date createtime;
	
	/**
	 * 班级id
	 */
	private Long class_id;
	
	private Long orgid;
	
	private String classname;
	
	/** 图标 */
	@JsonProperty("iconCls")
	private String icon;
	
	public String getIcon() {
		return icon;
	}


	public void setIcon(String icon) {
		this.icon = icon;
	}


	public Long getId() {
		return id;
	}


	public void setId(Long id) {
		this.id = id;
	}




	public Long getCreator() {
		return creator;
	}


	public void setCreator(Long creator) {
		this.creator = creator;
	}


	public Date getCreatetime() {
		return createtime;
	}


	public void setCreatetime(Date createtime) {
		this.createtime = createtime;
	}


	public Long getClass_id() {
		return class_id;
	}


	public void setClass_id(Long class_id) {
		this.class_id = class_id;
	}

	
	

	public Long getOrgid() {
		return orgid;
	}


	public void setOrgid(Long orgid) {
		this.orgid = orgid;
	}


	public String getClassname() {
		return classname;
	}


	public void setClassname(String classname) {
		this.classname = classname;
	}


	public Long getUserid() {
		return userid;
	}


	public void setUserid(Long userid) {
		this.userid = userid;
	}


	public String getCreatname() {
		return creatname;
	}


	public void setCreatname(String creatname) {
		this.creatname = creatname;
	}


	@Override
	protected Serializable pkVal() {
		return this.id;
	}


	public String getUsername() {
		return username;
	}


	public void setUsername(String username) {
		this.username = username;
	}
	
}
