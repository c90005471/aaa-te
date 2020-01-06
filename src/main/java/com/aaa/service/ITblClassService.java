package com.aaa.service;

import java.util.List;
import java.util.Map;

import com.aaa.commons.result.PageInfo;
import com.aaa.commons.result.Tree;
import com.aaa.model.Organization;
import com.aaa.model.TblClass;
import com.baomidou.mybatisplus.service.IService;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author chenjian
 * @since 2017-09-13
 */
public interface ITblClassService extends IService<TblClass> {
	 void selectDataGrid(PageInfo pageInfo);
	 
	 List<Map> selectTreeGrid(String flag);//将班级挂载到组织信息树上
	
	 List<Tree> selectTree(String flag);
	 void insertTblClass(TblClass tblClass);
	 TblClass  selectClassById(Long id);
	 void updateClassById(TblClass tblClass,Long userid);
	// void deleteByClassId(Long id);

	List<TblClass> selectByClassname(String classname);

	List<Tree> organizationTree(String flag);

	List<Map<String, Object>> questionAndOrganTree(Long id);

}
