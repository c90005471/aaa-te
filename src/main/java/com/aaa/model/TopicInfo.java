package com.aaa.model;

import java.io.Serializable;
import java.util.Date;

import com.baomidou.mybatisplus.activerecord.Model;
import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;
import com.baomidou.mybatisplus.enums.IdType;
/**
 * 类名称：TopicInfo
 * 类描述： 试题
 * 创建人：sunshaoshan
 * 创建时间：2018-6-30 下午2:23:19
 * @version
 */
@TableName("topic_info")
public class TopicInfo extends Model<TopicInfo> {
	@TableId(value="id",type=IdType.AUTO)
	private Long id;
	/**
	 * 题目
	 */
	private String topicname;
	/**
	 * 题型
	 */
	private Long topictype;
	/**
	 * 答案
	 */
	private String correct;
	/**
	 * 得分
	 */
	private Integer score;
	/**
	 * 解析
	 */
	 private String decipher;
	 /**
	  * 试题类型
	  */
	 private Integer type;
	 /**
	  * 创建人
	  */
	 private Long creator;
	 /**
	  * 创建时间
	  */
	 private Date createtime;
	 /**
	  * 状态
	  */
	 private Integer topicstate;
	 
	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getTopicname() {
		return topicname;
	}

	public void setTopicname(String topicname) {
		this.topicname = topicname;
	}

	public Long getTopictype() {
		return topictype;
	}

	public void setTopictype(Long topictype) {
		this.topictype = topictype;
	}

	public String getCorrect() {
		return correct;
	}

	public void setCorrect(String correct) {
		this.correct = correct;
	}

	public String getDecipher() {
		return decipher;
	}

	public void setDecipher(String decipher) {
		this.decipher = decipher;
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

	public Integer getTopicstate() {
		return topicstate;
	}

	public void setTopicstate(Integer topicstate) {
		this.topicstate = topicstate;
	}
	
	public Integer getType() {
		return type;
	}

	public void setType(Integer type) {
		this.type = type;
	}

	public Integer getScore() {
		return score;
	}
	public void setScore(Integer score) {
		this.score = score;
	}

	@Override
	protected Serializable pkVal() {
		return this.id;
	}
}
