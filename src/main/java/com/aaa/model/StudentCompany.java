package com.aaa.model;

import java.io.Serializable;
import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import com.baomidou.mybatisplus.activerecord.Model;
import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.enums.IdType;
/**
 * 学生就业信息类
 * @author  sunshaoshan 2017-11-03
 *
 */
public class StudentCompany extends Model<StudentCompany>{
	private static final long serialVersionUID = -7624255556811833715L;
	/**
     * 主键id
     */
	@TableId(value="cid", type= IdType.AUTO)
	private Long cid;
	/**
	 * 学生id
	 */
	private Long stuid;
	/**
	 * 是否上报考试申请
	 */
	private String isreporteaxm;
	/**
	 * 是否参加考试
	 */
	private String iseaxm;
	/**
	 * 考试情况
	 */
	private String eaxmstat;
	/**
	 * 是否就业
	 */
	private String isjob;
	/**
	 * 离校时间
	 */
	private Date leaschooltime;
	/**
	 * 城市级别
	 */
	private String citylev;
	/**
	 * 公司名称
	 */
	private String companyname;
	/**
	 * 岗位
	 */
	private String station;
	/**
	 * 就业城市
	 */
	private String companyaddr;
	/**
	 * 试用期工资
	 */
	private String prosalary;
	/**
	 * 正式工资
	 */
	private String forsalary;
	/**
	 * 补助
	 */
	private String needs;
	/**
	 * 现手机号
	 */
	private String xphone;
	/**
	 * 就业老师
	 */
	private Long teacherid;
	/**
	 * 就业奖金
	 */
	private String bonus;
	/**
	 * 审核结果
	 */
	private String checkstat;
	
	/**
	 * 备注
	 */
	private String remark;
	/**
	 * 学员分类
	 */
	private String stufl;
	/**
	 * 审核备注
	 */
	private String auditremark;
	private Long creator;
	
	private Date createtime;

	public Long getCid() {
		return cid;
	}

	public void setCid(Long cid) {
		this.cid = cid;
	}

	public Long getStuid() {
		return stuid;
	}

	public void setStuid(Long stuid) {
		this.stuid = stuid;
	}

	public String getIsreporteaxm() {
		return isreporteaxm;
	}

	public void setIsreporteaxm(String isreporteaxm) {
		this.isreporteaxm = isreporteaxm;
	}

	public String getIseaxm() {
		return iseaxm;
	}

	public void setIseaxm(String iseaxm) {
		this.iseaxm = iseaxm;
	}

	public String getEaxmstat() {
		return eaxmstat;
	}

	public void setEaxmstat(String eaxmstat) {
		this.eaxmstat = eaxmstat;
	}

	public String getIsjob() {
		return isjob;
	}

	public void setIsjob(String isjob) {
		this.isjob = isjob;
	}

	public Date getLeaschooltime() {
		return leaschooltime;
	}

	public void setLeaschooltime(Date leaschooltime) {
		this.leaschooltime = leaschooltime;
	}

	public String getCitylev() {
		return citylev;
	}

	public void setCitylev(String citylev) {
		this.citylev = citylev;
	}

	public String getCompanyname() {
		return companyname;
	}

	public void setCompanyname(String companyname) {
		this.companyname = companyname;
	}

	public String getStation() {
		return station;
	}

	public void setStation(String station) {
		this.station = station;
	}

	public String getCompanyaddr() {
		return companyaddr;
	}

	public void setCompanyaddr(String companyaddr) {
		this.companyaddr = companyaddr;
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

	public Long getTeacherid() {
		return teacherid;
	}

	public void setTeacherid(Long teacherid) {
		this.teacherid = teacherid;
	}

	public String getBonus() {
		return bonus;
	}

	public void setBonus(String bonus) {
		this.bonus = bonus;
	}

	public String getCheckstat() {
		return checkstat;
	}

	public void setCheckstat(String checkstat) {
		this.checkstat = checkstat;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public String getStufl() {
		return stufl;
	}

	public void setStufl(String stufl) {
		this.stufl = stufl;
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
	public String getNeeds() {
		return needs;
	}
	public void setNeeds(String needs) {
		this.needs = needs;
	}
	@Override
	protected Serializable pkVal() {
		return this.cid;
	}

	public String getAuditremark() {
		return auditremark;
	}

	public void setAuditremark(String auditremark) {
		this.auditremark = auditremark;
	}
	
}
