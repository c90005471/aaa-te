package com.aaa.commons.utils;

import java.io.IOException;
import java.util.Properties;

import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.Resource;
import org.springframework.core.io.support.PropertiesLoaderUtils;

import com.aaa.model.vo.StudentCompanyVo;

/**
 * 类名称：CalBonusesInter
 * 类描述： 计算就业奖金工具类
 * 创建人：sunshaoshan
 * 创建时间：2018-6-2 下午4:45:41
 * @version
 */
public class CalBonusesUtil {
	private static final String DEGREE_ONE= "本科";
	private static final String CITY_ONE = "一线";
	private static final String CITY_TWO = "二线";
	private static  Integer salaryone;//本科一线城市工资标准1
	private static Integer bonuseone;//本科一线城市奖金标准1
	private static Integer salarytwo;//本科一线城市工资标准2
	private static Integer bonusetwo;//本科一线城市奖金标准2
	private static Integer salarythree;//本科一线城市工资标准3
	private static Integer bonusethree;//本科一线城市奖金标准3
	private static Integer salaryfour;//本科一线城市工资标准4
	private static Integer bonusefour;//本科一线城市奖金标准4
	private static Double twocity;//本科二线城市标准
	private static Double othersedu;//其余标准
	
	private static Integer deduone;//本科一线扣除标准
	private static Integer dedutwo;//专科一线扣除标准
	private static Integer dedubou;//扣除标准
	static{
		//获取就业奖金参数
		Resource resource = new ClassPathResource("/config/gradacc.properties");
		Properties pop = new Properties();
		try {
			pop = PropertiesLoaderUtils.loadProperties(resource);
			salaryone = Integer.valueOf(pop.getProperty("salaryone"));
			bonuseone = Integer.valueOf(pop.getProperty("bonuseone"));
			salarytwo = Integer.valueOf(pop.getProperty("salarytwo"));
			bonusetwo = Integer.valueOf(pop.getProperty("bonusetwo"));
			salarythree = Integer.valueOf(pop.getProperty("salarythree"));
			bonusethree = Integer.valueOf(pop.getProperty("bonusethree"));
			salaryfour = Integer.valueOf(pop.getProperty("salaryfour"));
			bonusefour = Integer.valueOf(pop.getProperty("bonusefour"));
			twocity = Double.valueOf(pop.getProperty("twocity"));
			othersedu = Double.valueOf(pop.getProperty("othersedu"));
			//扣除标准
			deduone = Integer.valueOf(pop.getProperty("deduone"));//一线 本科扣钱标准
			dedutwo = Integer.valueOf(pop.getProperty("dedutwo"));//一线 专科扣钱标准
			dedubou = Integer.valueOf(pop.getProperty("dedubou"));//其余扣钱标准
		} catch (IOException e) {
			e.printStackTrace();
		}
		
	}
	/**
	 * 根据学生试用期工资计算毕业奖金
	 * @param vo
	 * @return
	 */
	public static String calBonuses(StudentCompanyVo vo){
		String bonuseStr = "0";
		if(StringUtils.isNotBlank(vo.getProsalary())){
			int Prosalary  = Integer.valueOf(vo.getProsalary());
			if(vo.getCitylev().equals(CITY_ONE)){//一线城市
				if(vo.getDegree().equals(DEGREE_ONE)){//本科
					if(Prosalary>=deduone){//如果一线 本科的试用期工资大于最低扣钱标准
						bonuseStr = returnParams(Prosalary,1);
					}else{
						bonuseStr = dedubou+"";
					}
				}else{
					if(Prosalary>=dedutwo){//如果一线 专科的试用期工资大于最低扣钱标准
						bonuseStr = returnParams(Prosalary,othersedu);
					}else{
						bonuseStr = dedubou+"";
					}
				}
			}else if(vo.getCitylev().equals(CITY_TWO)){//二线城市
				if(vo.getDegree().equals(DEGREE_ONE)){//本科
					if(Prosalary>=deduone*twocity){//如果二线 本科的试用期工资大于最低扣钱标准
						bonuseStr = returnParams(Prosalary,twocity);
					}else{
						bonuseStr = dedubou+"";
					}
				}else{
					if(Prosalary>=dedutwo*twocity){//如果二线 专科的试用期工资大于最低扣钱标准
						bonuseStr = returnParams(Prosalary,twocity*othersedu);
					}else{
						bonuseStr = dedubou+"";
					}
				}
			}else{
				if(Prosalary>=dedutwo*twocity){//如果二线 专科的试用期工资大于最低扣钱标准
					bonuseStr = returnParams(Prosalary,twocity*othersedu);
				}else{
					bonuseStr = dedubou+"";
				}
			}
		}
		return bonuseStr;
	}
	/**
	 * 根据计算参数返回奖金
	 * @param Prosalary
	 * @param Params
	 * @return
	 */
	public static String returnParams(int Prosalary,double Params){
		if(Prosalary>=salaryone*Params){
			return bonuseone+"";
		}else if(Prosalary>=salarytwo*Params){
			return bonusetwo+"";
		}else if(Prosalary>=salarythree*Params){
			return bonusethree+"";
		}else if(Prosalary>=salaryfour){
			return bonusefour+"";
		}else{
			return "0";
		}
	}
	public static void main(String[] args) {
		StudentCompanyVo vo = new StudentCompanyVo();
		vo.setDegree("专科");
		vo.setCitylev("二线");
		vo.setProsalary("2800");
		String str = calBonuses(vo);
		System.out.println(str);
	}
}
