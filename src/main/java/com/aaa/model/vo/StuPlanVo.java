package com.aaa.model.vo;

import java.io.Serializable;
import java.util.Date;

import com.aaa.commons.utils.JsonUtils;
import com.baomidou.mybatisplus.activerecord.Model;
import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;
import com.baomidou.mybatisplus.enums.IdType;

/**
 * <p>
 * 学生自评计划表
 * </p>
 *
 * @author chenjian
 * @since 2017-09-17
 */
@TableName("stu_plan")
public class StuPlanVo extends Model<StuPlanVo> {

    private static final long serialVersionUID = 1L;

    /**
     * 主键，计划Id
     */
	@TableId(value="id", type= IdType.AUTO)
	private Long id;
    /**
     * 章节Id
     */
	private Long chapterid;
    /**
     * 开始时间
     */
	private Date begintime;
    /**
     * 结束时间
     */
	private Date endtime;
    /**
     * 班级Id
     */
	
	private Long classid;
	/**
	 * 教员id
	 */
	private Long teacherno;
	
	private Integer hourNum;
    /**
     * 计划制定人的ID
     */
	private Long createuserid;
	private Date createtime;

	/**
     * 计划执行状态（0未执行，1已执行，2过期）
     */
	private Integer dostatus;
	/**
	 * 阶段/章节类型
	 */
	private String coursetype;
	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	

	

	
    
	

	
	
	public Date getBegintime() {
		return begintime;
	}

	public void setBegintime(Date begintime) {
		this.begintime = begintime;
	}

	public Date getEndtime() {
		return endtime;
	}

	public void setEndtime(Date endtime) {
		this.endtime = endtime;
	}

	public Integer getHourNum() {
		return hourNum;
	}

	public void setHourNum(Integer hourNum) {
		this.hourNum = hourNum;
	}

	public Long getChapterid() {
		return chapterid;
	}

	public void setChapterid(Long chapterid) {
		this.chapterid = chapterid;
	}

	public Long getClassid() {
		return classid;
	}

	public void setClassid(Long classid) {
		this.classid = classid;
	}

	public Long getCreateuserid() {
		return createuserid;
	}

	public void setCreateuserid(Long createuserid) {
		this.createuserid = createuserid;
	}

	public Date getCreatetime() {
		return createtime;
	}

	public void setCreatetime(Date createtime) {
		this.createtime = createtime;
	}

	public Integer getDostatus() {
		return dostatus;
	}

	public void setDostatus(Integer dostatus) {
		this.dostatus = dostatus;
	}

	@Override
	protected Serializable pkVal() {
		return this.id;
	}
	@Override
	public String toString() {
		return JsonUtils.toJson(this);
	}

	public String getCoursetype() {
		return coursetype;
	}

	public void setCoursetype(String coursetype) {
		this.coursetype = coursetype;
	}

	public Long getTeacherno() {
		return teacherno;
	}

	public void setTeacherno(Long teacherno) {
		this.teacherno = teacherno;
	}
	
}
