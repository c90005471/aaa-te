package com.aaa.model;

import java.io.Serializable;
import java.util.Date;

import com.baomidou.mybatisplus.activerecord.Model;
import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;
import com.baomidou.mybatisplus.enums.IdType;
@TableName("testquestion_record")
public class TestQuestionRecord extends Model<TestQuestionRecord> {
	/**
	 * 主键自增
	 */
	@TableId(value="id",type=IdType.AUTO)
	private Long id;
	/**
	 * 学生姓名
	 */
	private String stuname;
	/**
	 * 学生电话
	 */
	private String stuphone;
	/**
	 * 学生成绩
	 */
	private Integer stuscore;
	/**
	 * 试题类型
	 */
	private Integer questype;
	private Date createtime;
	
	public Integer getQuestype() {
		return questype;
	}

	public void setQuestype(Integer questype) {
		this.questype = questype;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	
	public String getStuname() {
		return stuname;
	}

	public void setStuname(String stuname) {
		this.stuname = stuname;
	}

	public String getStuphone() {
		return stuphone;
	}

	public void setStuphone(String stuphone) {
		this.stuphone = stuphone;
	}
	
	public Integer getStuscore() {
		return stuscore;
	}

	public void setStuscore(Integer stuscore) {
		this.stuscore = stuscore;
	}

	public Date getCreatetime() {
		return createtime;
	}

	public void setCreatetime(Date createtime) {
		this.createtime = createtime;
	}

	@Override
	protected Serializable pkVal() {
		return this.id;
	}

}
