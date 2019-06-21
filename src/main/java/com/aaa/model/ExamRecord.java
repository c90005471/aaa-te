package com.aaa.model;

import java.io.Serializable;
import java.util.Date;

import com.baomidou.mybatisplus.activerecord.Model;
import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;
import com.baomidou.mybatisplus.enums.IdType;
/**
 * 类名称：ExamRecord
 * 类描述： 考试记录信息
 * 创建人：sunshaoshan
 * 创建时间：2018-7-26 下午3:00:25
 * @version
 */
@TableName(value="exam_record")
public class ExamRecord extends Model<ExamRecord> {
	@TableId(value="id",type=IdType.AUTO)
	private Long id;
	/**
	 * 试卷id
	 */
	private Long paperid;
	/**
	 * 学生id
	 */
	private Long stuid;
	/**
	 * 成绩
	 */
	private Integer score;
	/**
	 * 考试状态 0 考试中 1考试结束
	 */
	private Integer state;
	private Date createtime;
	
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
	public Long getStuid() {
		return stuid;
	}
	public void setStuid(Long stuid) {
		this.stuid = stuid;
	}
	public Integer getScore() {
		return score;
	}
	public void setScore(Integer score) {
		this.score = score;
	}
	public Date getCreatetime() {
		return createtime;
	}
	public void setCreatetime(Date createtime) {
		this.createtime = createtime;
	}
	public Integer getState() {
		return state;
	}
	public void setState(Integer state) {
		this.state = state;
	}
	@Override
	protected Serializable pkVal() {
		return this.id;
	}

}
