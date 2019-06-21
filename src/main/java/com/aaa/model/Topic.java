package com.aaa.model;

import java.io.Serializable;
import java.util.Date;

import com.aaa.commons.utils.JsonUtils;
import com.fasterxml.jackson.annotation.JsonProperty;

/**
 * 
 * 知识点实体类
 * 
 */
public class Topic implements Serializable {

	private static final long serialVersionUID = 1L;

	/** 主键 */
	private Integer topicId;
	/** 知识点代码 */
	private String topicCode;
	/** 知识点名称 */
	private String topicName;
	/** 排序 */
	private Integer seq;

	/** 状态 */
	private Integer status;

	/** 知识点图标 */
	@JsonProperty("iconCls")
	private String icon;

	/** 创建时间 */
	private Date createTime;

	/** 所属章节 */
	private Integer chapterId;

	public Integer getTopicId() {
		return topicId;
	}

	public void setTopicId(Integer topicId) {
		this.topicId = topicId;
	}

	public String getTopicCode() {
		return topicCode;
	}

	public void setTopicCode(String topicCode) {
		this.topicCode = topicCode;
	}

	public String getTopicName() {
		return topicName;
	}

	public void setTopicName(String topicName) {
		this.topicName = topicName;
	}

	public Integer getSeq() {
		return seq;
	}

	public void setSeq(Integer seq) {
		this.seq = seq;
	}

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	public String getIcon() {
		return icon;
	}

	public void setIcon(String icon) {
		this.icon = icon;
	}

	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	public Integer getChapterId() {
		return chapterId;
	}

	public void setChapterId(Integer chapterId) {
		this.chapterId = chapterId;
	}

	@Override
	public String toString() {
		return JsonUtils.toJson(this);
	}
}
