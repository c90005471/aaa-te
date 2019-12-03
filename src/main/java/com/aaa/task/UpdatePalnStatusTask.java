package com.aaa.task;

import java.math.BigDecimal;
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
import com.aaa.model.vo.StuPlanVo;
import com.aaa.service.IStuEvaluateService;
import com.aaa.service.IStuPlanService;
import com.aaa.service.ITeacherDetailService;
import com.aaa.service.ITeacherPlanService;
import com.baomidou.mybatisplus.mapper.EntityWrapper;

/**
 * 定时刷新计划的状态，计划超时之后 注意：不适合用于集群
 * 
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
	@Autowired
	private IStuEvaluateService stuEvaluateService;

	@Scheduled(cron = "0/10 * *  * * ? ") // 每100秒执行一次
	public void updateStuPlanStatus() {
		// logger.debug(new Date());
		// logger.debug("检查当前是否有超时的自评价计划");
		EntityWrapper<StuPlan> stuPlanwrapper = new EntityWrapper<StuPlan>();
		StuPlan sp = new StuPlan();
		stuPlanwrapper.setEntity(sp);
		stuPlanwrapper.addFilter("NOW() > endtime and dostatus=0");// 添加过滤条件
		List<StuPlan> selectList = stuPlanService.selectList(stuPlanwrapper);
		List<StuPlan> selectListUpdate = new ArrayList<StuPlan>();
		if (selectList != null && selectList.size() > 0) {
			for (StuPlan stuPlan : selectList) {
				// logger.debug("计划Id"+stuPlan.getId()+"超时，将被强制设置为已关闭状态");
				stuPlan.setDostatus(1);
				// 计算自评得分
				Double avgScore = getStuPlanScore(stuPlan.getId());
				stuPlan.setScore(avgScore);
				selectListUpdate.add(stuPlan);
			}
			stuPlanService.updateBatchById(selectListUpdate);
		}

	}

	/**
	 * updated ky
	 */
	@Scheduled(cron = "0/100 * *  * * ? ") // 每100秒执行一次
	public void updateTeaPlanStatus() {
		// logger.debug(new Date());
		// logger.debug("检查当前是否有超时的教评计划");
		EntityWrapper<TeacherPlan> teaPlanwrapper = new EntityWrapper<TeacherPlan>();
		TeacherPlan tp = new TeacherPlan();
		teaPlanwrapper.setEntity(tp);
		teaPlanwrapper.addFilter("NOW() > stoptime and dostatus=0");// 添加过滤条件
		List<TeacherPlan> selectList = teacherPlanService.selectList(teaPlanwrapper);
		List<TeacherPlan> selectListUpdate = new ArrayList<TeacherPlan>();
		if (selectList != null && selectList.size() > 0) {
			for (TeacherPlan teacherPlan : selectList) {
				// logger.debug("计划Id"+teacherPlan.getId()+"超时，将被强制设置为已关闭状态");
				teacherPlan.setDostatus(1);
				// 计算最终得分，计入数据库教评计划表中
				Map<String, Double> getMap = getTeacherFenPlanScore(teacherPlan.getId());
				// 授课评分 40
				double teaAvgScore = getMap.get("scoreSum") == null ? 0d : getMap.get("scoreSum");
				// 班级学校 20
				double classAvgScore = getMap.get("classScoreSum") == null ? 0d : getMap.get("classScoreSum");
				// 学生自评 40
				// 根据班级id和老师no 去查询 stu_plan
				StuPlan stuplan = stuPlanService.selectPlanInfoByClassIdAndTeaNo(teacherPlan.getClassid(),
						teacherPlan.getTeacherno());
				double stuAvgScore = 0d;
				if (stuplan != null) {
					stuAvgScore = stuplan.getScore();
				}
				// 占比计算
				// 比例暂时固定
				double avgScore = teaAvgScore * 0.5 + classAvgScore * 0.1 + (stuAvgScore * 20) * 0.4;
				avgScore = DoubleUtil.round(avgScore, 2);
				teacherPlan.setScore(avgScore);
				selectListUpdate.add(teacherPlan);
			}
			teacherPlanService.updateBatchById(selectListUpdate);
		}
	}

	private Double getTeacherPlanScore(Long planId) {
		Map<String, Long> map = new HashMap<String, Long>();
		map.put("planid", planId);
		List<Map> avgscoreList = teacherDetailService.selectAvgscoreByplanid(map);
		// 得到的授课教评最终平均分
		Double scoreSum = 0d;
		if (avgscoreList != null && avgscoreList.size() > 0) {
			for (Map avgscoreMap : avgscoreList) {
				if (avgscoreMap.get("avgscore") != null) {
					scoreSum += Double.parseDouble(avgscoreMap.get("avgscore") + "");
				}
			}
			scoreSum = DoubleUtil.round(scoreSum, 2);// 小数点后取两位
			return scoreSum / avgscoreList.size();
		} else {
			return scoreSum;
		}
	}

	/**
	 * 计算自评最终得分
	 */
	private Double getStuPlanScore(Long planId) {
		Double scoreSum = 0d;
		Map<String, Long> map = new HashMap<String, Long>();
		map.put("planid", planId);
		List<Map> avgscoreList = stuEvaluateService.selectAvgscoreByplanid(map);
		if (avgscoreList != null && avgscoreList.size() > 0) {
			for (Map avgscoreMap : avgscoreList) {
				if (avgscoreMap.get("avgscore") != null) {
					scoreSum += Double.parseDouble(avgscoreMap.get("avgscore") + "");
				}
			}
			/**
			 * 	计算学生自评最终得分
			 *  小数点后取两位
			 */
			scoreSum = DoubleUtil.round(scoreSum, 2) / avgscoreList.size();
			return scoreSum;
		} else {
			return scoreSum;
		}
	}

	/**
	 * 计算授课教评和班级学校的平均分
	 * 
	 * @param planId
	 * @return
	 * @author ky
	 */
	private Map<String, Double> getTeacherFenPlanScore(Long planId) {
		// 返回参数
		Map<String, Double> resultMap = new HashMap<String, Double>();
		// 请求参数
		Map<String, Long> map = new HashMap<String, Long>();
		map.put("planid", planId);
		List<Map> avgscoreList = teacherDetailService.selectAvgscoreByplanid(map);
		// 得到的授课教评最终平均分
		Double scoreSum = 0d;
		// 授课教评计数器
		int count = 0;
		// 得到班级学校的最终平均分
		Double classScoreSum = 0d;
		// 授课教评计数器
		int classCount = 0;
		if (avgscoreList != null && avgscoreList.size() > 0) {
			for (Map avgscoreMap : avgscoreList) {
				if (avgscoreMap.get("avgscore") != null) {
					if (avgscoreMap.get("type") != null && "1".equals(avgscoreMap.get("type").toString())) {
						scoreSum += Double.parseDouble(avgscoreMap.get("avgscore") + "");
						count++;
					} else if (avgscoreMap.get("type") != null && "2".equals(avgscoreMap.get("type").toString())) {
						classScoreSum += Double.parseDouble(avgscoreMap.get("avgscore") + "");
						classCount++;
					}
				}
			}
			scoreSum = DoubleUtil.round(scoreSum, 2);// 小数点后取两位
			resultMap.put("scoreSum", scoreSum);
			resultMap.put("classScoreSum", classScoreSum);
			return resultMap;
		} else {
			resultMap.put("scoreSum", scoreSum);
			resultMap.put("classScoreSum", classScoreSum);
			return resultMap;
		}
	}
}
