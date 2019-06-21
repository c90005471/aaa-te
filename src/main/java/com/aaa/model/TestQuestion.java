package com.aaa.model;

import java.io.Serializable;
import java.util.Date;

import com.baomidou.mybatisplus.activerecord.Model;
import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;
import com.baomidou.mybatisplus.enums.IdType;
/**
 * 类名称：TestQuestion
 * 类描述： 入学试题信息类
 * 创建人：sunshaoshan
 * 创建时间：2018-5-11 下午2:29:40
 * @version
 */
@TableName("testquestion")
public class TestQuestion extends Model<TestQuestion>{
	 /**
     * 主键，答题Id
     */
	@TableId(value="id", type= IdType.AUTO)
	private Long id;
	/**
	 * 问题
	 */
	private String quesname;
	/**
	 * 问题答案
	 */
	private String quesanswer;
	/**
	 * 问题类型
	 */
	private Integer questype;
	/**
	 * 试题类型 单选题或多选题
	 */
	private Integer type;
	private Date createtime;
	@Override
	protected Serializable pkVal() {
		return this.id;
	}
	
	public Integer getType() {
		return type;
	}

	public void setType(Integer type) {
		this.type = type;
	}

	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public String getQuesname() {
		return quesname;
	}
	public void setQuesname(String quesname) {
		this.quesname = quesname;
	}
	public String getQuesanswer() {
		return quesanswer;
	}
	public void setQuesanswer(String quesanswer) {
		this.quesanswer = quesanswer;
	}
	public Integer getQuestype() {
		return questype;
	}
	public void setQuestype(Integer questype) {
		this.questype = questype;
	}
	public Date getCreatetime() {
		return createtime;
	}
	public void setCreatetime(Date createtime) {
		this.createtime = createtime;
	}
	
	
	
}
