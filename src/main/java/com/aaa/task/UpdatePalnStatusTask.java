package com.aaa.task;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.aaa.commons.utils.DoubleUtil;
import com.aaa.model.StuPlan;
import com.aaa.model.TeacherPlan;
import com.aaa.service.IStuEvaluateService;
import com.aaa.service.IStuPlanService;
import com.aaa.service.ITeacherDetailService;
import com.aaa.service.ITeacherPlanService;
import com.baomidou.mybatisplus.mapper.EntityWrapper;

/**
 * 定时刷新计划的状态，计划超时之后
 * 注意：不适合用于集群
 * @author aaa.teacher
 */
@Component
public class UpdatePalnStatusTask {
	protected Logger logger = LogManager.getLogger(getClass());
	@Autowired
	private IStuPlanService stuPlanService;
	@Autowired
	private ITeacherPlanService teacherPlanService;
	@Autowired 
	private ITeacherDetailService teacherDetailService;
	@Autowired private IStuEvaluateService stuEvaluateService;
	
	@Scheduled(cron="0/300 * *  * * ? ")   //每100秒执行一次
	public void updateStuPlanStatus() {
		//logger.debug(new Date());
		//logger.debug("检查当前是否有超时的自评价计划");
		EntityWrapper<StuPlan> stuPlanwrapper = new EntityWrapper<StuPlan>();
		StuPlan sp = new StuPlan();
		stuPlanwrapper.setEntity(sp);
		stuPlanwrapper.addFilter("NOW() > endtime and dostatus=0");// 添加过滤条件
		List<StuPlan> selectList = stuPlanService.selectList(stuPlanwrapper);
		List<StuPlan> selectListUpdate= new ArrayList<StuPlan>();
		if(selectList!=null&&selectList.size()>0){
			for (StuPlan stuPlan : selectList) {
				//logger.debug("计划Id"+stuPlan.getId()+"超时，将被强制设置为已关闭状态");
				stuPlan.setDostatus(1);
				//计算自评得分
				Double avgScore = getStuPlanScore(stuPlan.getId());
				stuPlan.setScore(avgScore);
				selectListUpdate.add(stuPlan);
			}
			stuPlanService.updateBatchById(selectListUpdate);
		}
		
	}
	@Scheduled(cron="0/300 * *  * * ? ")   //每100秒执行一次
	public void updateTeaPlanStatus() {
		//logger.debug(new Date());
		//logger.debug("检查当前是否有超时的教评计划");
		EntityWrapper<TeacherPlan> teaPlanwrapper = new EntityWrapper<TeacherPlan>();
		TeacherPlan tp = new TeacherPlan();
		teaPlanwrapper.setEntity(tp);
		teaPlanwrapper.addFilter("NOW() > stoptime and dostatus=0");// 添加过滤条件
		List<TeacherPlan> selectList = teacherPlanService.selectList(teaPlanwrapper);
		List<TeacherPlan> selectListUpdate= new ArrayList<TeacherPlan>();
		if(selectList!=null&&selectList.size()>0){
			for (TeacherPlan teacherPlan : selectList) {
				//logger.debug("计划Id"+teacherPlan.getId()+"超时，将被强制设置为已关闭状态");
				teacherPlan.setDostatus(1);
				//计算最终得分，计入数据库教评计划表中
				Double avgScore = getTeacherPlanScore(teacherPlan.getId());
				teacherPlan.setScore(avgScore);
				selectListUpdate.add(teacherPlan);
			}
			teacherPlanService.updateBatchById(selectListUpdate);
		}
	}
	/**
	 * 计算教评最终得分
	 */
	private Double getTeacherPlanScore(Long planId){
		Map<String,Long> map = new HashMap<String,Long>();                                                  
    	map.put("planid", planId);                                                
    	List<Map> avgscoreList = teacherDetailService.selectAvgscoreByplanid(map);
    	Double scoreSum = 0d;
    	if(avgscoreList!=null && avgscoreList.size()>0){
    		for (Map avgscoreMap : avgscoreList) { 
        		if(avgscoreMap.get("avgscore")!=null){
        			scoreSum += Double.parseDouble(avgscoreMap.get("avgscore")+"");
        		}
    		} 
    		scoreSum = DoubleUtil.round(scoreSum, 2);//小数点后取两位
    		return scoreSum/avgscoreList.size();
    	}else{
    		return scoreSum;
    	}
	}
	/**
	 * 计算自评最终得分
	 */
	private Double getStuPlanScore(Long planId){
		Double scoreSum = 0d;
		Map<String,Long> map = new HashMap<String,Long>();        
    	map.put("planid", planId);
    	List<Map> avgscoreList = stuEvaluateService.selectAvgscoreByplanid(map);
    	if(avgscoreList!=null && avgscoreList.size()>0){
	    	for (Map avgscoreMap : avgscoreList) {
	    		if(avgscoreMap.get("avgscore")!=null){
	    			scoreSum += Double.parseDouble(avgscoreMap.get("avgscore")+"");
	    		}
	    	}
	    	scoreSum = DoubleUtil.round(scoreSum, 2);//小数点后取两位
    		return scoreSum/avgscoreList.size();
    	}else{
    		return scoreSum;
    	}
	}
}
