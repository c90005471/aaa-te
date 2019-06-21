package com.aaa.service;

import java.util.List;

import com.baomidou.mybatisplus.service.IService;
import com.aaa.commons.result.Tree;
import com.aaa.model.Organization;

/**
 *
 * Organization 表数据服务层接口
 *
 */
public interface IOrganizationService extends IService<Organization> {

    List<Tree> selectTree();

    List<Organization> selectTreeGrid();
    /**
     * 根据pid获取下属的所有子类
     * @param id
     * @return
     */
	List<Organization> selectListByPid(String id);

}