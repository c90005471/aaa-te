package com.aaa.model;

import java.io.Serializable;
import java.util.Date;

import com.aaa.commons.utils.JsonUtils;
import com.fasterxml.jackson.annotation.JsonProperty;

/**
 * 
 * 章节实体类
 * 
 */
public class Chapter implements Serializable {

	private static final long serialVersionUID = 1L;

	/** 主键 */
	private Integer chapterId;
	/** 知识点代码 */
	private String chapterCode;
	/** 知识点名称 */
	private String chapterName;
	/** 排序 */
	private Integer seq;

	/** 状态 */
	private Integer status;

	/** 知识点图标 */
	@JsonProperty("iconCls")
	private String icon;

	/** 创建时间 */
	private Date createTime;

	/** 所属科目 */
	private Integer courseId;

	public Integer getChapterId() {
		return chapterId;
	}

	public void setChapterId(Integer chapterId) {
		this.chapterId = chapterId;
	}

	public String getChapterCode() {
		return chapterCode;
	}

	public void setChapterCode(String chapterCode) {
		this.chapterCode = chapterCode;
	}

	public String getChapterName() {
		return chapterName;
	}

	public void setChapterName(String chapterName) {
		this.chapterName = chapterName;
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

	public Integer getCourseId() {
		return courseId;
	}

	public void setCourseId(Integer courseId) {
		this.courseId = courseId;
	}

	@Override
	public String toString() {
		return JsonUtils.toJson(this);
	}
}
