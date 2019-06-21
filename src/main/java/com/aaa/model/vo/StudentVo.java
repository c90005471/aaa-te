package com.aaa.model.vo;

import java.io.Serializable;
import java.util.Date;

import com.baomidou.mybatisplus.activerecord.Model;
import com.baomidou.mybatisplus.annotations.TableField;
import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.enums.IdType;

public class StudentVo extends Model<StudentVo>{
	private static final long serialVersionUID = 1L;

    /**
     * 学生id
     */
	@TableId(value="id", type= IdType.AUTO)
	private Long id;
    /**
     * 学生学号
     */
	private String stuno;
    /**
     * 学生姓名
     */
	private String stuname;
    /**
     * 身份证号
     */
	private String idno;
    /**
     * 手机号
     */
	private String phone;
    /**
     * 地址
     */
	private String address;
    /**
     * 学生qq
     */
	private String qq;
    /**
     * 删除标志
     */
	@TableField("delete_flag")
	private Integer deleteFlag;
	
	private Date createtime;
	//毕业(在读)院校名称
	private String schoolname;
	//专业  (在校所学)
	private String major;
	//文化程度
	private String degree;
	//家人联系方式
	private String familyPhone;
	
	
	/**
	 * 公司名称
	 */
	private String companyname;
	
	/**
	 * 试用期工资
	 */
	private String prosalary;
	/**
	 * 正式工资
	 */
	private String forsalary;
	/**
	 * 现手机号
	 */
	private String xphone;
	
    /**
     * 班级编号（外键）
     */
	@TableField("class_id")
	private Long classid;
	
	/**
	 * 学生分类
	 * @return
	 */
	private String stufl;
	public Long getId() {
		return id;
	}




	public void setId(Long id) {
		this.id = id;
	}




	public String getStuno() {
		return stuno;
	}




	public void setStuno(String stuno) {
		this.stuno = stuno;
	}




	public String getStuname() {
		return stuname;
	}




	public void setStuname(String stuname) {
		this.stuname = stuname;
	}




	public String getIdno() {
		return idno;
	}




	public void setIdno(String idno) {
		this.idno = idno;
	}




	public String getPhone() {
		return phone;
	}




	public void setPhone(String phone) {
		this.phone = phone;
	}




	public String getAddress() {
		return address;
	}




	public void setAddress(String address) {
		this.address = address;
	}




	public String getQq() {
		return qq;
	}




	public void setQq(String qq) {
		this.qq = qq;
	}




	public Integer getDeleteFlag() {
		return deleteFlag;
	}




	public void setDeleteFlag(Integer deleteFlag) {
		this.deleteFlag = deleteFlag;
	}




	public Date getCreatetime() {
		return createtime;
	}




	public void setCreatetime(Date createtime) {
		this.createtime = createtime;
	}




	public String getSchoolname() {
		return schoolname;
	}




	public void setSchoolname(String schoolname) {
		this.schoolname = schoolname;
	}




	public String getMajor() {
		return major;
	}




	public void setMajor(String major) {
		this.major = major;
	}




	public String getDegree() {
		return degree;
	}




	public void setDegree(String degree) {
		this.degree = degree;
	}




	public String getFamilyPhone() {
		return familyPhone;
	}




	public void setFamilyPhone(String familyPhone) {
		this.familyPhone = familyPhone;
	}




	public String getCompanyname() {
		return companyname;
	}




	public void setCompanyname(String companyname) {
		this.companyname = companyname;
	}




	public String getProsalary() {
		return prosalary;
	}




	public void setProsalary(String prosalary) {
		this.prosalary = prosalary;
	}




	public String getForsalary() {
		return forsalary;
	}




	public void setForsalary(String forsalary) {
		this.forsalary = forsalary;
	}




	public String getXphone() {
		return xphone;
	}




	public void setXphone(String xphone) {
		this.xphone = xphone;
	}
	
	public Long getClassid() {
		return classid;
	}




	public void setClassid(Long classid) {
		this.classid = classid;
	}
	
	public String getStufl() {
		return stufl;
	}

	public void setStufl(String stufl) {
		this.stufl = stufl;
	}




	@Override
	protected Serializable pkVal() {
		return this.id;
	}

}
