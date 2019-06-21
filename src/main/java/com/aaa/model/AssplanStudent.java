package com.aaa.model;

import java.io.Serializable;

import com.baomidou.mybatisplus.activerecord.Model;
import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.enums.IdType;
/**
 * 类名称：Assplan_student
 * 类描述： 帮扶计划与学生关系表
 * 创建人：sunshaoshan
 * 创建时间：2018-2-1 上午9:10:55
 * @version
 */
public class AssplanStudent extends Model<AssplanStudent> {
	/**
     * 主键，Id
     */
	@TableId(value="id", type= IdType.AUTO)
	private Long id;
	/**
	 * 计划id
	 */
	private Long assid;
	/**
	 * 学生id
	 */
	private Long stuid;
	
	
	public Long getId() {
		return id;
	}

	
	public void setId(Long id) {
		this.id = id;
	}


	public Long getAssid() {
		return assid;
	}


	public void setAssid(Long assid) {
		this.assid = assid;
	}


	public Long getStuid() {
		return stuid;
	}


	public void setStuid(Long stuid) {
		this.stuid = stuid;
	}


	@Override
	protected Serializable pkVal() {
		return this.id;
	}

}
