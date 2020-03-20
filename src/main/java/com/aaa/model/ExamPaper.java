package com.aaa.model;

import java.io.Serializable;
import java.util.Date;

import com.baomidou.mybatisplus.activerecord.Model;
import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;
import com.baomidou.mybatisplus.enums.IdType;
@TableName("exam_paper")
public class ExamPaper extends Model<ExamPaper> {
	@TableId(value="id",type=IdType.AUTO)
	private Long id;
	/**
	 * 试卷标题
	 */
	private String title;
	/**
	 * 开始时间
	 */
	private Date starttime;
	/**
	 * 所需时间
	 */
	private Integer needtime;
	/**
	 * 试题数量
	 */
	private Integer number;
	/**
	 * 试卷类型(模拟1,正式2)
	 */
	private Integer type;
	/**
	 * 试卷状态(0禁用,1启用)
	 */
	private Integer state;
	/**
	 * 阶段
	 */
	private String stage;
	private Long creator;
	private Date createtime;
	private Long classid;
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public String getStage() {
		return stage;
	}

	public void setStage(String stage) {
		this.stage = stage;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public Date getStarttime() {
		return starttime;
	}

	public void setStarttime(Date starttime) {
		this.starttime = starttime;
	}

	public Integer getNeedtime() {
		return needtime;
	}

	public void setNeedtime(Integer needtime) {
		this.needtime = needtime;
	}

	public Integer getType() {
		return type;
	}

	public void setType(Integer type) {
		this.type = type;
	}

	public Integer getState() {
		return state;
	}

	public void setState(Integer state) {
		this.state = state;
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
	public Long getClassid() {
		return classid;
	}

	public void setClassid(Long classid) {
		this.classid = classid;
	}
	public Integer getNumber() {
		return number;
	}

	public void setNumber(Integer number) {
		this.number = number;
	}

	@Override
	protected Serializable pkVal() {
		return this.id;
	}

}
