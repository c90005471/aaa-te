package com.aaa.model;

import java.io.Serializable;
import java.util.Date;

import com.baomidou.mybatisplus.activerecord.Model;
import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;
import com.baomidou.mybatisplus.enums.IdType;
/**
 * 
 * 类名称：TopicOption
 * 类描述： 选项
 * 创建人：sunshaoshan
 * 创建时间：2018-7-3 下午5:12:14
 * @version
 */
@TableName("topic_option")
public class TopicOption extends Model<TopicOption> {
	@TableId(value="id",type=IdType.AUTO)
	private Long id;
	/**
	 * 外键
	 */
	private Long infoid;
	/**
	 * 选项号
	 */
	private String optionnum;
	/**
	 * 答案
	 */
	private String option;
	
	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public Long getInfoid() {
		return infoid;
	}

	public void setInfoid(Long infoid) {
		this.infoid = infoid;
	}

	public String getOptionnum() {
		return optionnum;
	}

	public void setOptionnum(String optionnum) {
		this.optionnum = optionnum;
	}

	public String getOption() {
		return option;
	}

	public void setOption(String option) {
		this.option = option;
	}

	@Override
	protected Serializable pkVal() {
		return this.id;
	}
}
