package com.aaa.model;

import com.baomidou.mybatisplus.annotations.TableId;
import java.util.Date;
import com.baomidou.mybatisplus.enums.IdType;
import com.baomidou.mybatisplus.activerecord.Model;
import com.baomidou.mybatisplus.annotations.TableName;
import java.io.Serializable;

/**
 * <p>
 * 
 * </p>
 *
 * @author chenjian
 * @since 2017-09-19
 */
@TableName("stu_evaluate")
public class StuEvaluate extends Model<StuEvaluate> {

    private static final long serialVersionUID = 1L;

    /**
     * 主键自增
     */
	@TableId(value="id", type= IdType.AUTO)
	private Long id;
    /**
     * 学生ID，关联学生表主键
     */
	private Long stuid;
    /**
     * 知识点ID，关联course的主键
     */
	private Long topicid;
    /**
     * 知识点得分情况
     */
	private Integer score;
    /**
     * 关联自评计划表的主键
     */
	private Long planid;
    /**
     * 评价时间
     */
	private Date createtime;


	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public Long getStuid() {
		return stuid;
	}

	public void setStuid(Long stuid) {
		this.stuid = stuid;
	}

	public Long getTopicid() {
		return topicid;
	}

	public void setTopicid(Long topicid) {
		this.topicid = topicid;
	}

	public Integer getScore() {
		return score;
	}

	public void setScore(Integer score) {
		this.score = score;
	}

	public Long getPlanid() {
		return planid;
	}

	public void setPlanid(Long planid) {
		this.planid = planid;
	}

	public Date getCreatetime() {
		return createtime;
	}

	public void setCreatetime(Date createtime) {
		this.createtime = createtime;
	}

	@Override
	protected Serializable pkVal() {
		return this.id;
	}

}
