package com.aaa.model;

import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.enums.IdType;
import com.baomidou.mybatisplus.activerecord.Model;
import com.baomidou.mybatisplus.annotations.TableName;
import java.io.Serializable;
import java.util.Date;

/**
 * @description 健康自评统计总页面实体类
 * @author sunxicai
 * @since 2017-11-29
 */
@TableName("tbl_scl_record")
public class TblSclRecord extends Model<TblSclRecord> {

    private static final long serialVersionUID = 1L;

	@TableId(value="id", type= IdType.AUTO)
	private Long id;
	private Long studentId;//学生编号
	private Integer sunCount;//阳性项目个数
	private Integer sclScore;//测试题总分
	/**
     * 操作时间
     */
	private String createtime;

	
	/*public Date getCreatetime() {
		return createtime;
	}

	public void setCreatetime(Date createtime) {
		this.createtime = createtime;
	}*/

	public String getCreatetime() {
		return createtime;
	}

	public void setCreatetime(String createtime) {
		this.createtime = createtime;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public Long getStudentId() {
		return studentId;
	}

	public void setStudentId(Long studentId) {
		this.studentId = studentId;
	}

	public Integer getSunCount() {
		return sunCount;
	}

	public void setSunCount(Integer sunCount) {
		this.sunCount = sunCount;
	}

	public Integer getSclScore() {
		return sclScore;
	}

	public void setSclScore(Integer sclScore) {
		this.sclScore = sclScore;
	}

	@Override
	protected Serializable pkVal() {
		return this.id;
	}

}
