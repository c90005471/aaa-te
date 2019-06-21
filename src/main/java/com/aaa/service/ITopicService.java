package com.aaa.service;

import java.util.List;

import com.aaa.commons.result.Tree;
import com.aaa.commons.shiro.ShiroUser;
import com.aaa.model.Topic;
import com.baomidou.mybatisplus.service.IService;

/**
 *
 * topic 表数据服务层接口
 *
 */
public interface ITopicService extends IService<Topic> {

    List<Topic> selectAll();

    List<Tree> selectAllMenu();

    List<Tree> selectAllTree();

    List<Tree> selectTree(ShiroUser shiroUser);

}