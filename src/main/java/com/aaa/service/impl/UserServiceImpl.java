package com.aaa.service.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.aaa.commons.result.PageInfo;
import com.aaa.commons.result.Tree;
import com.aaa.commons.utils.BeanUtils;
import com.aaa.commons.utils.StringUtils;
import com.aaa.mapper.TblClassMapper;
import com.aaa.mapper.TblClassRecordMapper;
import com.aaa.mapper.UserMapper;
import com.aaa.mapper.UserRoleMapper;
import com.aaa.model.User;
import com.aaa.model.UserRole;
import com.aaa.model.vo.UserVo;
import com.aaa.service.IUserService;
import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.plugins.Page;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;

/**
 *
 * User 表数据服务层接口实现类
 *
 */
@Service
public class UserServiceImpl extends ServiceImpl<UserMapper, User> implements IUserService {

    @Autowired
    private UserMapper userMapper;
    @Autowired
    private UserRoleMapper userRoleMapper;
    @Autowired
    private TblClassMapper tblClassMapper;
    @Autowired
    private TblClassRecordMapper tblClassRecordMapper;
    @Override
    public List<User> selectByLoginName(UserVo userVo) {
        User user = new User();
        user.setLoginName(userVo.getLoginName());
        EntityWrapper<User> wrapper = new EntityWrapper<User>(user);
        if (null != userVo.getId()) {
            wrapper.where("id != {0}", userVo.getId());
        }
        return this.selectList(wrapper);
    }

    @Override
    public void insertByVo(UserVo userVo) {
        User user = BeanUtils.copy(userVo, User.class);
        user.setCreateTime(new Date());
        this.insert(user);
        
        Long id = user.getId();
        String[] roles = userVo.getRoleIds().split(",");
        UserRole userRole = new UserRole();
        for (String string : roles) {
            userRole.setUserId(id);
            userRole.setRoleId(Long.valueOf(string));
            userRoleMapper.insert(userRole);
        }
    }

    @Override
    public UserVo selectVoById(Long id) {
        return userMapper.selectUserVoById(id);
    }

    @Override
    public void updateByVo(UserVo userVo) {
        User user = BeanUtils.copy(userVo, User.class);
        if (StringUtils.isBlank(user.getPassword())) {
            user.setPassword(null);
        }
        this.updateById(user);
        
        Long id = userVo.getId();
        List<UserRole> userRoles = userRoleMapper.selectByUserId(id);
        if (userRoles != null && !userRoles.isEmpty()) {
            for (UserRole userRole : userRoles) {
                userRoleMapper.deleteById(userRole.getId());
            }
        }

        String[] roles = userVo.getRoleIds().split(",");
        UserRole userRole = new UserRole();
        for (String string : roles) {
            userRole.setUserId(id);
            userRole.setRoleId(Long.valueOf(string));
            userRoleMapper.insert(userRole);
        }
    }

    @Override
    public void updatePwdByUserId(Long userId, String md5Hex) {
        User user = new User();
        user.setId(userId);
        user.setPassword(md5Hex);
        this.updateById(user);
    }

    @Override
    public void selectDataGrid(PageInfo pageInfo) {
        Page<Map<String, Object>> page = new Page<Map<String, Object>>(pageInfo.getNowpage(), pageInfo.getSize());
        page.setOrderByField(pageInfo.getSort());
        page.setAsc(pageInfo.getOrder().equalsIgnoreCase("asc"));
        List<Map<String, Object>> list = userMapper.selectUserPage(page, pageInfo.getCondition());
        pageInfo.setRows(list);
        pageInfo.setTotal(page.getTotal());
    }

    @Override
    public void deleteUserById(Long id) {
        this.deleteById(id);
        userRoleMapper.deleteByUserId(id);
    }

    /**
     * 如果传入的organization_id有值则按照organization_id查询，否则查询所有的老师
     */
	@Override
	public Object selectTree(String organizationId) {
		 List<Tree> trees = new ArrayList<Tree>();
		 EntityWrapper<User> wrapper = new EntityWrapper<User>();
		 if(organizationId!=null&&(!"null".equals(organizationId))){
			  User userTmp = new User();
		        wrapper.setEntity(userTmp);
		        wrapper.addFilter("organization_id = {0}", organizationId);
		 }
	        List<User> users =userMapper.selectList(wrapper);
	        for (User user : users) {
	            Tree tree = new Tree();
	            tree.setId(user.getId());
	            tree.setText(user.getName());
	            trees.add(tree);
	        }
	        return trees;
	}

	/**
     * 根据传入的classid查询该班所有老师
     */
	@Override
	public List<Tree> selectAllTeacher(Long classid) {
		// TODO Auto-generated method stub
		List<Tree> trees = new ArrayList<Tree>();
		List<User> users=new ArrayList<User>();
		
		List<Long> userid=tblClassMapper.selectUseridListByClassid(classid);
		//获取变更老师的记录
		List<Long> oldUseridList = tblClassRecordMapper.selectUserIdListByClassId(classid);
		//把教师id放入set中防止出现重复的情况
		Set<Long> userIdSet = new HashSet<Long>();
		for (Long userId : oldUseridList) {//变更记录
			userIdSet.add(userId);
		}
		for (Long long1 : userid) {//现记录
			userIdSet.add(long1);
		}
		for (Long userId : userIdSet) {
			User user=userMapper.selectById(userId);
			users.add(user);
		}
		for (User user : users) {
			Tree tree = new Tree();
            tree.setId(user.getId());
            tree.setText(user.getName());           
            trees.add(tree);
		}
		return trees;
	}
	/**
	 * 根据角色id查询教师
	 */
	@Override
	public List<User> selectUserByRoleId(Long roleid) {
		return userMapper.selectUserByRoleId(roleid);
	}

}