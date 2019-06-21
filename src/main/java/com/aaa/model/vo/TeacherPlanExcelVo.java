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
public class TeacherPlanExcelVo extends Model<TeacherPlanExcelVo> {

    /**
     * 主键，计划Id
     */
	@TableId(value="id", type= IdType.AUTO)
	private Long id;
    /**
     * 教师姓名
     */
	private String teachername;
	/**
	 * 教师类型
	 */
	private String rolename;
    /**
     * 开始时间
     */
	private String begintime;
    /**
     * 结束时间
     */
	private String stoptime;
	
	/**
     * 计划制定人
     */
	private String name;
	
    /**
     * 班级名称
     */
	private String classname;
    
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




	public String getTeachername() {
		return teachername;
	}




	public void setTeachername(String teachername) {
		this.teachername = teachername;
	}




	public String getBegintime() {
		return begintime;
	}




	public void setBegintime(String begintime) {
		this.begintime = begintime;
	}




	public String getStoptime() {
		return stoptime;
	}




	public void setStoptime(String stoptime) {
		this.stoptime = stoptime;
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
	



	public String getRolename() {
		return rolename;
	}




	public void setRolename(String rolename) {
		this.rolename = rolename;
	}




	@Override
	protected Serializable pkVal() {
		return this.id;
	}

}
