package com.aaa.service;

import java.util.List;
import java.util.Map;

import com.aaa.model.StuEvaluate;
import com.baomidou.mybatisplus.service.IService;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author chenjian
 * @since 2017-09-19
 */
public interface IStuEvaluateService extends IService<StuEvaluate> {
	List<Map> selectByplanidAndclassid(Map map);
	List<Map> selectAvgscoreByplanid(Map map);
	Map selctgetDetailByRade(Long id);
}
