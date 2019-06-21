package com.aaa.model.vo;

import java.io.Serializable;

import com.baomidou.mybatisplus.activerecord.Model;
import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.enums.IdType;
/**
 * 健康自评统计表
 * @author sunshaoshan 2017-12-08
 *
 */
public class TblSclRecordExcelVo extends Model<TblSclRecordExcelVo>{
	/**
     * 主键，计划Id
     */
	@TableId(value="id", type= IdType.AUTO)
	private Long id;
	/**
	 * 学号
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
	 * 班级
	 */
	private String classname;
	/**
	 * 阳性项目数
	 */
	private String sunCount;
	/**
	 * 测试总成绩
	 */
	private String sclScore;
	/**
	 * 测试时间
	 */
	private String createtime;
	
	
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






	public String getClassname() {
		return classname;
	}




	public void setClassname(String classname) {
		this.classname = classname;
	}




	public String getSunCount() {
		return sunCount;
	}




	public void setSunCount(String sunCount) {
		this.sunCount = sunCount;
	}




	public String getSclScore() {
		return sclScore;
	}




	public void setSclScore(String sclScore) {
		this.sclScore = sclScore;
	}




	public String getCreatetime() {
		return createtime;
	}




	public void setCreatetime(String createtime) {
		this.createtime = createtime;
	}




	@Override
	protected Serializable pkVal() {
		return this.id;
	}

}
