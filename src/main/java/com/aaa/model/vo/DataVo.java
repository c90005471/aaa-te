package com.aaa.model.vo;
/**
 * 类名称：DataVo
 * 类描述： JFrame使用类
 * 创建人：sunshaoshan
 * 创建时间：2018-7-25 上午10:17:01
 * @version
 */
public class DataVo {
	private String name;
	private String code;
	
	public DataVo() {
	}
	public DataVo(String name, String code) {
		this.name = name;
		this.code = code;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	@Override
	public String toString() {
		return name;
	}
	
}
