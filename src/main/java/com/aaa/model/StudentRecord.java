package com.aaa.model;

import java.io.Serializable;
import java.util.Date;

import com.baomidou.mybatisplus.activerecord.Model;
import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;
import com.baomidou.mybatisplus.enums.IdType;

/**
 * <p>
 * 
 * </p>
 *
 * @author sunshaoshan
 * @since 2017-10-18
 */
@TableName("student_record")
public class StudentRecord extends Model<StudentRecord> {
    private static final long serialVersionUID = 1L;
    /**
     * 主键id
     */
	@TableId(value="id", type= IdType.AUTO)
	private Long id;
    /**
     * 学生id
     */
	private Long studentid;
	private String studentname;
    /**
     * 原班级id
     */
	private Long oldclass_id;
	private String oldclassname;
    /**
     * 现班级id
     */
	private Long  newclass_id;
	private String newclassname;
	/**
	 * 操作记录  转出或转入
	 */
	private String operrecord;
    /**
     * 操作人
     */
	private Long creator;
	private String creatname;
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
	public String getStudentname() {
		return studentname;
	}

	public void setStudentname(String studentname) {
		this.studentname = studentname;
	}

	public Long getOldclass_id() {
		return oldclass_id;
	}

	public void setOldclass_id(Long oldclass_id) {
		this.oldclass_id = oldclass_id;
	}

	public Long getNewclass_id() {
		return newclass_id;
	}

	public void setNewclass_id(Long newclass_id) {
		this.newclass_id = newclass_id;
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
	
	public String getCreatname() {
		return creatname;
	}
	public void setCreatname(String creatname) {
		this.creatname = creatname;
	}
	
	public String getOldclassname() {
		return oldclassname;
	}

	public void setOldclassname(String oldclassname) {
		this.oldclassname = oldclassname;
	}

	public String getNewclassname() {
		return newclassname;
	}

	public void setNewclassname(String newclassname) {
		this.newclassname = newclassname;
	}
	
	public String getOperrecord() {
		return operrecord;
	}

	public void setOperrecord(String operrecord) {
		this.operrecord = operrecord;
	}
	
	@Override
	public String toString() {
		return "StudentRecord [id=" + id + ", studentid=" + studentid
				+ ", oldclass_id=" + oldclass_id + ", newclass_id="
				+ newclass_id + ", operrecord=" + operrecord + ", creator="
				+ creator + ", createtime=" + createtime + "]";
	}

	@Override
	protected Serializable pkVal() {
		return this.id;
	}

}
