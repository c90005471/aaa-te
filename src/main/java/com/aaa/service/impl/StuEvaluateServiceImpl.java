package com.aaa.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.aaa.model.StuEvaluate;
import com.aaa.mapper.StuEvaluateMapper;
import com.aaa.service.IStuEvaluateService;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author chenjian
 * @since 2017-09-19
 */
@Service
public class StuEvaluateServiceImpl extends ServiceImpl<StuEvaluateMapper, StuEvaluate> implements IStuEvaluateService {

	@Autowired
	private StuEvaluateMapper stuEvaluateMapper;
	@Override
	public List<Map> selectByplanidAndclassid(Map map) {
		// TODO Auto-generated method stub
		return stuEvaluateMapper.selectByplanidAndclassid(map);
	}
	@Override
	public List<Map> selectAvgscoreByplanid(Map map) {
		// TODO Auto-generated method stub
		return stuEvaluateMapper.selectAvgscoreByplanid(map);
	}
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@Override
	public Map selctgetDetailByRade(Long id) {
		Float count= stuEvaluateMapper.getDetailByCount(id);
		Map rademap=stuEvaluateMapper.getDetailByRade(id);
		Map map=new HashMap();
		Float radecount;
		String string = rademap.get("sum").toString();
		int rade = Integer.parseInt(string);
		String classname=rademap.get("classname").toString();
		if(count==null){
			count = 0f;
		}
		if (rade==0) {
			radecount=(float) 0;
			map.put("radecount", radecount);
		}else {
			radecount= count/rade*100;
			map.put("radecount", radecount);
		}
		int cou= Math.round(count);
		map.put("rade", Math.round(rade));
		map.put("csname", classname);
		map.put("count", cou);
		return map;
	}
	
}
