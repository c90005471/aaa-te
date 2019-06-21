package com.aaa.model;

import com.baomidou.mybatisplus.annotations.TableId;

import java.util.Date;
import java.util.List;

import com.baomidou.mybatisplus.enums.IdType;
import com.baomidou.mybatisplus.activerecord.Model;
import com.baomidou.mybatisplus.annotations.TableName;
import com.fasterxml.jackson.annotation.JsonProperty;

import java.io.Serializable;

import org.springframework.format.annotation.DateTimeFormat;

/**
 * <p>
 * 
 * </p>
 *
 * @author chenjian
 * @since 2017-09-13
 */
@TableName("tbl_class")
public class TblClass extends Model<TblClass> {

    private static final long serialVersionUID = 1L;

    /**
     * 班级id
     */
	@TableId(value="id", type= IdType.AUTO)
	private Long id;
    /**
     * 班级名
     */
	private String classname;
    /**
     * 开班时间
     */
	private Date createtime;
    /**
     * 班级状态（是否毕业等）
     */
	private Integer graduate;
	
	private List<String> teacher;
    /**
     * 校区表外键
     */
	private Long orgid;

	
	private String address;
	
	/** 图标 */
	@JsonProperty("iconCls")
	private String icon;
	
	/**
	 *开班时间
	 */
	@DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
	private Date begin;
	/**
	 *毕业时间
	 */
	@DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
	private Date over;
	/**
	 *第一次项目开始时间
	 */
	@DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
	private Date firstbegin;
	/**
	 *第一次项目结束时间
	 */
	@DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
	private Date firstover;
	/**
	 *第二次项目开始时间
	 */
	@DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
	private Date secondbegin;
	/**
	 *第二次项目结束时间
	 */
	@DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
	private Date secondover;
	

	public Date getBegin() {
		return begin;
	}



	public void setBegin(Date begin) {
		this.begin = begin;
	}



	public Date getOver() {
		return over;
	}



	public void setOver(Date over) {
		this.over = over;
	}



	public Date getFirstbegin() {
		return firstbegin;
	}



	public void setFirstbegin(Date firstbegin) {
		this.firstbegin = firstbegin;
	}



	public Date getFirstover() {
		return firstover;
	}



	public void setFirstover(Date firstover) {
		this.firstover = firstover;
	}



	public Date getSecondbegin() {
		return secondbegin;
	}



	public void setSecondbegin(Date secondbegin) {
		this.secondbegin = secondbegin;
	}



	public Date getSecondover() {
		return secondover;
	}



	public void setSecondover(Date secondover) {
		this.secondover = secondover;
	}



	public String getIcon() {
		return icon;
	}



	public void setIcon(String icon) {
		this.icon = icon;
	}



	public String getAddress() {
		return address;
	}



	public void setAddress(String address) {
		this.address = address;
	}



	public Long getId() {
		return id;
	}

	
	
	public List<String> getTeacher() {
		return teacher;
	}



	public void setTeacher(List<String> teacher) {
		this.teacher = teacher;
	}



	public void setId(Long id) {
		this.id = id;
	}

	public String getClassname() {
		return classname;
	}

	public void setClassname(String classname) {
		this.classname = classname;
	}

	public Date getCreatetime() {
		return createtime;
	}

	public void setCreatetime(Date createtime) {
		this.createtime = createtime;
	}

	
	public Integer getGraduate() {
		return graduate;
	}



	public void setGraduate(Integer graduate) {
		this.graduate = graduate;
	}



	public Long getOrgid() {
		return orgid;
	}

	public void setOrgid(Long orgid) {
		this.orgid = orgid;
	}

	@Override
	protected Serializable pkVal() {
		return this.id;
	}

}
