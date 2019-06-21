package com.aaa.service.impl;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.aaa.mapper.TblSclInterviewMapper;
import com.aaa.model.TblSclInterview;
import com.aaa.service.ITblSclInterviewService;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
/**
 * /**
 * 访谈记录服务类
 * @author sunshaoshan
 * @since 2017-12-10
 */
@Service
public class TblSclInterviewServiceImpl extends ServiceImpl<TblSclInterviewMapper, TblSclInterview> implements ITblSclInterviewService {
	@Autowired
	private TblSclInterviewMapper tblSclInterviewMapper;

	@Override
	public Map<String, Object> selectTblSclInterviewById(Long id) {
		return tblSclInterviewMapper.selectTblSclInterviewById(id);
	}

	@Override
	public boolean updateTblSclInterviewById(TblSclInterview tblSclInterview) {
		Integer row = tblSclInterviewMapper.updateById(tblSclInterview);
		if(row==1){
			return true;
		}else{
			return false;
		}
	}

}
