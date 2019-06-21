package com.aaa.service;

import java.util.Map;

import com.aaa.model.TblSclInterview;
import com.baomidou.mybatisplus.service.IService;

/**
 * 访谈记录服务类
 * @author sunshaoshan
 * @since 2017-12-10
 */
public interface ITblSclInterviewService extends IService<TblSclInterview> {

	Map<String, Object> selectTblSclInterviewById(Long id);

	boolean updateTblSclInterviewById(TblSclInterview tblSclInterview);
}
