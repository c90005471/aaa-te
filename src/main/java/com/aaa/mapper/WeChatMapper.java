package com.aaa.mapper;

import com.aaa.model.TeacherPlan;
import com.aaa.model.WechatResources;
import com.baomidou.mybatisplus.mapper.BaseMapper;
import com.baomidou.mybatisplus.plugins.pagination.Pagination;

import java.util.List;
import java.util.Map;

/**
 * @author ky
 * @date 2019/11/15
**/
public interface WeChatMapper extends BaseMapper<TeacherPlan> {
    /**
     * 获取所有的信息
     * @param page
     * @param params
     * @return
     */
    List<Map<String, Object>> getWechatResources(Pagination page, Map<String, Object> params);

    /**
     * 添加 WechatResources
     * @param wechatResources
     * @return
     */
    boolean addWechatResources(WechatResources wechatResources);
}
