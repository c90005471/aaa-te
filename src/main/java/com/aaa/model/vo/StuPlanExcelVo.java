package com.aaa.model.vo;

import com.baomidou.mybatisplus.annotations.TableId;
import java.util.Date;
import com.baomidou.mybatisplus.enums.IdType;
import com.baomidou.mybatisplus.activerecord.Model;
import com.baomidou.mybatisplus.annotations.TableName;
import java.io.Serializable;

/**
 * <p>
 * 教师评价计划导出excel信息表
 * </p>
 *
 * @author 孙韶山
 * @since 2017-11-12
 */
public class StuPlanExcelVo extends Model<StuPlanExcelVo> {

    /**
     * 主键，计划Id
     */
	@TableId(value="id", type= IdType.AUTO)
	private Long id;
    /**
     * 阶段/章节名称
     */
	private String coursename;
    /**
     * 开始时间
     */
	private String begintime;
    /**
     * 结束时间
     */
	private String endtime;
	
	/**
     * 计划制定人
     */
	private String name;
	
    /**
     * 班级名称
     */
	private String classname;
    /**
     * 教员
     */
	private String teachername;
	/**
     * 得分
     */
	private String score;
	
	
	public Long getId() {
		return id;
	}




	public void setId(Long id) {
		this.id = id;
	}
	
	public String getCoursename() {
		return coursename;
	}




	public void setCoursename(String coursename) {
		this.coursename = coursename;
	}




	public String getEndtime() {
		return endtime;
	}




	public void setEndtime(String endtime) {
		this.endtime = endtime;
	}




	public String getBegintime() {
		return begintime;
	}




	public void setBegintime(String begintime) {
		this.begintime = begintime;
	}

	
	public String getName() {
		return name;
	}




	public void setName(String name) {
		this.name = name;
	}


	

	public String getClassname() {
		return classname;
	}




	public void setClassname(String classname) {
		this.classname = classname;
	}




	public String getScore() {
		return score;
	}




	public void setScore(String score) {
		this.score = score;
	}
	



	public String getTeachername() {
		return teachername;
	}




	public void setTeachername(String teachername) {
		this.teachername = teachername;
	}




	@Override
	protected Serializable pkVal() {
		return this.id;
	}

}
