package com.aaa.model.vo;

import java.io.Serializable;

import com.aaa.model.TblSclRecord;
import com.baomidou.mybatisplus.activerecord.Model;
import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.enums.IdType;
	/**
 *@className:TblSclRecordVo.java
 *@discriptions:心理测试导出excel信息表
 *@author:徐辉
 *@createTime:2017-12-6下午4:07:52
 *@version:1.0.0
 *
 */
public class TblSclRecordVo extends Model<TblSclRecord>{

	@TableId(value="id", type= IdType.AUTO)
	private Long id;
	private Long studentId;//学生编号
	/**
     * 学生姓名
     */
	private String stuname;
	/**
     * 身份证号
     */
	private String idno;
	/**
     * 手机号
     */
	private String phone;
	/**
	 * 性别
	 */
	private Integer sex;
	/**
     * 地址
     */
	private String address;
	/**
     * 班级名
     */
	private String classname;
	private Integer sunCount;//阳性项目个数
	private Integer sclScore;//测试题总分
	/**
     * 操作时间
     */
	private String createtime;
	
	
	
	@Override
	protected Serializable pkVal() {
		// TODO Auto-generated method stub
		return null;
	}
}
