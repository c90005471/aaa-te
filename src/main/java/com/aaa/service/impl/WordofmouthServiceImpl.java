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
import com.aaa.mapper.WordofmouthMapper;
import com.aaa.model.User;
import com.aaa.model.UserRole;
import com.aaa.model.Wordofmouth;
import com.aaa.model.vo.UserVo;
import com.aaa.service.IUserService;
import com.aaa.service.IWordofmouthService;
import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.plugins.Page;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;

/**
 *
 * User 表数据服务层接口实现类
 *
 */
@Service
public class WordofmouthServiceImpl extends ServiceImpl<WordofmouthMapper, Wordofmouth> implements IWordofmouthService {

    @Autowired
    private WordofmouthMapper wordofmouthMapper;
    /**
     * 分页列表
     */
    @Override
    public void selectDataGrid(PageInfo pageInfo) {
        Page<Map<String, Object>> page = new Page<Map<String, Object>>(pageInfo.getNowpage(), pageInfo.getSize());
        page.setOrderByField(pageInfo.getSort());
        page.setAsc(pageInfo.getOrder().equalsIgnoreCase("asc"));
        List<Map<String, Object>> list = wordofmouthMapper.selectWordofmouthPage(page, pageInfo.getCondition());
        pageInfo.setRows(list);
        pageInfo.setTotal(page.getTotal());
    }
    /**
     * 获取口碑状态数量
     */
	@Override
	public List<Map> selectWordStatusByHashMap(Map map) {
		return wordofmouthMapper.selectWordStatusByHashMap(map);
	}
	@Override
	public List<Map> selectWordStatusByMonHashMap(Map map) {
		return wordofmouthMapper.selectWordStatusByMonHashMap(map);
	}

}