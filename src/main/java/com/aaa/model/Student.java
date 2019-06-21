package com.aaa.model;

import com.baomidou.mybatisplus.annotations.TableField;
import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.enums.IdType;
import com.baomidou.mybatisplus.activerecord.Model;
import java.io.Serializable;
import java.util.Date;

/**
 * <p>
 * 
 * </p>
 *
 * @author chenjian
 * @since 2017-09-14
 */
public class Student extends Model<Student> {

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
     * 班级编号（外键）
     */
	@TableField("class_id")
	private Long classId;
	/**
	 * 学生分类
	 * @return
	 */
	private String stufl;
/*	private String orgid;//专业id
*/
	public Long getId() {
		return id;
	}
	
	/*public String getOrgid() {
		return orgid;
	}

	public void setOrgid(String orgid) {
		this.orgid = orgid;
	}*/

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

	public Long getClassId() {
		return classId;
	}

	public void setClassId(Long classId) {
		this.classId = classId;
	}

	@Override
	protected Serializable pkVal() {
		return this.id;
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
	
	public String getStufl() {
		return stufl;
	}

	public void setStufl(String stufl) {
		this.stufl = stufl;
	}

	@Override
	public String toString() {
		return "Student [id=" + id + ", stuno=" + stuno + ", stuname="
				+ stuname + ", idno=" + idno + ", phone=" + phone
				+ ", address=" + address + ", qq=" + qq + ", deleteFlag="
				+ deleteFlag + ", createtime=" + createtime + ", schoolname="
				+ schoolname + ", major=" + major + ", degree=" + degree
				+ ", familyPhone=" + familyPhone + ", classId=" + classId + "]";
	}
	
	


}
