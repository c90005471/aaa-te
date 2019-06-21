package com.aaa.service;

import java.util.List;

import com.aaa.commons.result.PageInfo;
import com.aaa.commons.result.Tree;
import com.aaa.model.Organization;
import com.aaa.model.TblClass;
import com.aaa.model.TblClassRecord;
import com.baomidou.mybatisplus.service.IService;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author chenjian
 * @since 2017-09-13
 */
public interface ITblClassRecordService extends IService<TblClassRecord> {
	 
	 List<TblClassRecord> selectTreeGrid();//将班级挂载到组织信息树上
}
