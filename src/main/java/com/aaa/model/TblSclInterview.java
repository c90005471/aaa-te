package com.aaa.model;

import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.enums.IdType;
import com.baomidou.mybatisplus.activerecord.Model;
import com.baomidou.mybatisplus.annotations.TableName;
import java.io.Serializable;
import java.util.Date;

/**
 * @description 问题学生 访谈记录实体类
 * @author sunshaoshan
 * @since 2017-12-10
 */
@TableName("tbl_scl_interview")
public class TblSclInterview extends Model<TblSclInterview> {

    private static final long serialVersionUID = 1L;

	@TableId(value="id", type= IdType.AUTO)
	private Long id;
	private Long studentid;//学生编号
	private Integer userid;//老师id
	private String record;//记录
	/**
     * 操作时间
     */
	private Date createtime;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}



	public Long getStudentid() {
		return studentid;
	}



	public void setStudentid(Long studentid) {
		this.studentid = studentid;
	}



	public Integer getUserid() {
		return userid;
	}



	public void setUserid(Integer userid) {
		this.userid = userid;
	}



	public String getRecord() {
		return record;
	}



	public void setRecord(String record) {
		this.record = record;
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
