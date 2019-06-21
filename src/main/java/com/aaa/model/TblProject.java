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
 * @author sunxicai
 * @since 2017-12-04
 */
@TableName("tbl_project")
public class TblProject extends Model<TblProject> {

    private static final long serialVersionUID = 1L;

	@TableId(value="id", type= IdType.AUTO)
	private Long id;
	private String projectname;
	private Date createtime;
	private Long projectstatusid;
	private String projectpath;


	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getProjectname() {
		return projectname;
	}

	public void setProjectname(String projectname) {
		this.projectname = projectname;
	}

	public Date getCreatetime() {
		return createtime;
	}

	public void setCreatetime(Date createtime) {
		this.createtime = createtime;
	}

	public Long getProjectstatusid() {
		return projectstatusid;
	}

	public void setProjectstatusid(Long projectstatusid) {
		this.projectstatusid = projectstatusid;
	}

	public String getProjectpath() {
		return projectpath;
	}

	public void setProjectpath(String projectpath) {
		this.projectpath = projectpath;
	}

	@Override
	protected Serializable pkVal() {
		return this.id;
	}

}
