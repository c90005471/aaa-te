package com.aaa.model.vo;

import com.baomidou.mybatisplus.annotations.TableId;
import java.util.Date;
import com.baomidou.mybatisplus.enums.IdType;
import com.baomidou.mybatisplus.activerecord.Model;
import com.baomidou.mybatisplus.annotations.TableName;
import java.io.Serializable;

/**
 * <p>
 * 教师评价计划表
 * </p>
 *
 * @author 张德鑫
 * @since 2017-09-18
 */
@TableName("teacherplan")
public class TeacherPlanVo extends Model<TeacherPlanVo> {

    private static final long serialVersionUID = 1L;

    /**
     * 主键，计划Id
     */
	@TableId(value="id", type= IdType.AUTO)
	private Long id;
    /**
     * 教师ID
     */
	private Long teacherno;
    /**
     * 开始时间
     */
	private Date begintime;
    /**
     * 结束时间
     */
	private Date stoptime;
	
	/**
     * 计划制定人的ID
     */
	private Long makerid;
	
	/**
     * 计划制定时间
     */
	private Date maketime;
	private Integer hournum;
    /**
     * 班级Id
     */
	private Long classid;
    
	/**
     * 计划执行状态（0未执行，1已执行，2过期）
     */
	private Integer dostatus;
	
	/**
     * 验证码
     */
	private Long code;
	
	public Integer getHournum() {
		return hournum;
	}

	public void setHournum(Integer hournum) {
		this.hournum = hournum;
	}

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

	
	public Long getTeacherno() {
		return teacherno;
	}

	public void setTeacherno(Long teacherno) {
		this.teacherno = teacherno;
	}

	public Date getStoptime() {
		return stoptime;
	}

	public void setStoptime(Date stoptime) {
		this.stoptime = stoptime;
	}

	public Long getMakerid() {
		return makerid;
	}

	public void setMakerid(Long makerid) {
		this.makerid = makerid;
	}

	public Date getMaketime() {
		return maketime;
	}

	public void setMaketime(Date maketime) {
		this.maketime = maketime;
	}

	public Long getClassid() {
		return classid;
	}

	public void setClassid(Long classid) {
		this.classid = classid;
	}


	

	public Integer getDostatus() {
		return dostatus;
	}

	public void setDostatus(Integer dostatus) {
		this.dostatus = dostatus;
	}

	public Long getCode() {
		return code;
	}

	public void setCode(Long code) {
		this.code = code;
	}

	@Override
	protected Serializable pkVal() {
		return this.id;
	}

}
