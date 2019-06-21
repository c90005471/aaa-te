package com.aaa.service;

import java.util.List;

import com.baomidou.mybatisplus.service.IService;
import com.aaa.commons.result.PageInfo;
import com.aaa.commons.result.Tree;
import com.aaa.model.User;
import com.aaa.model.vo.UserVo;

/**
 *
 * User 表数据服务层接口
 *
 */
public interface IUserService extends IService<User> {

    List<User> selectByLoginName(UserVo userVo);

    void insertByVo(UserVo userVo);

    UserVo selectVoById(Long id);

    void updateByVo(UserVo userVo);

    void updatePwdByUserId(Long userId, String md5Hex);

    void selectDataGrid(PageInfo pageInfo);

    void deleteUserById(Long id);
    
    Object selectTree(String organizationId );
    
    List<Tree> selectAllTeacher(Long id);

	List<User> selectUserByRoleId(Long roleid);
    
}