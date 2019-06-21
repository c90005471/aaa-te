package com.aaa.model;

import java.io.Serializable;

import org.springframework.data.annotation.Id;

import com.baomidou.mybatisplus.activerecord.Model;
import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;
import com.baomidou.mybatisplus.enums.IdType;

/**
 * 类名称：TopicType
 * 类描述： 试题类型
 * 创建人：sunshaoshan
 * 创建时间：2018-6-22 上午11:04:59
 * @version
 */
@TableName("topic_types")
public class TopicTypes  extends Model<TopicTypes>{

	//题的类型编码
	@TableId(value="id", type= IdType.AUTO)
	private Long id;
	
	//题的类型名称
	private String typename;

	//题的类型状态
	private Integer typestate;
	//阶段
	private String stage;
	
	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getTypename() {
		return typename;
	}

	public void setTypename(String typename) {
		this.typename = typename;
	}

	public Integer getTypestate() {
		return typestate;
	}

	public void setTypestate(Integer typestate) {
		this.typestate = typestate;
	}
	
	public String getStage() {
		return stage;
	}

	public void setStage(String stage) {
		this.stage = stage;
	}

	@Override
	protected Serializable pkVal() {
		return this.id;
	}
	
	
	
	
}
