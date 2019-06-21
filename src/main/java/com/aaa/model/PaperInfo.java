package com.aaa.model;

import java.io.Serializable;

import com.baomidou.mybatisplus.activerecord.Model;
import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;
import com.baomidou.mybatisplus.enums.IdType;
/**
 * 类名称：PaperInfo
 * 类描述： 试卷与实体关系信息
 * 创建人：sunshaoshan
 * 创建时间：2018-7-19 下午5:09:16
 * @version
 */
@TableName("paper_info")
public class PaperInfo extends Model<PaperInfo> {
	@TableId(value="id",type=IdType.AUTO)
	private Long id;
	/**
	 * 试卷id
	 */
	private Long paperid;
	/**
	 * 题目id
	 */
	private Long infoid;
	
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}

	public Long getPaperid() {
		return paperid;
	}
	public void setPaperid(Long paperid) {
		this.paperid = paperid;
	}
	public Long getInfoid() {
		return infoid;
	}
	public void setInfoid(Long infoid) {
		this.infoid = infoid;
	}
	@Override
	protected Serializable pkVal() {
		return this.id;
	}

	

}
