package com.aaa.model;

import com.baomidou.mybatisplus.annotations.TableField;
import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.enums.IdType;
import com.baomidou.mybatisplus.activerecord.Model;
import com.baomidou.mybatisplus.annotations.TableName;
import java.io.Serializable;
import java.util.Date;

/**
 * @description 健康自评统计详情实体类
 * @author sunxicai
 * @since 2017-11-30
 */
@TableName("tbl_scl_recorddetail")
public class TblSclRecorddetail extends Model<TblSclRecorddetail> {

    private static final long serialVersionUID = 1L;

	@TableId(value="id", type= IdType.AUTO)
	private Long id;
	private Long studentid;//学生编号
	private Integer sclid;//心理测试题题号
	@TableField(value="scoredetail")
	private Integer scoreDetail;//心理测试题答题得分
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

	public Long getStudentid() {
		return studentid;
	}

	public void setStudentid(Long studentid) {
		this.studentid = studentid;
	}

	public Integer getSclid() {
		return sclid;
	}

	public void setSclid(Integer sclid) {
		this.sclid = sclid;
	}

	public Integer getScoreDetail() {
		return scoreDetail;
	}

	public void setScoreDetail(Integer scoreDetail) {
		this.scoreDetail = scoreDetail;
	}

	@Override
	protected Serializable pkVal() {
		return this.id;
	}

}
