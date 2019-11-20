package com.aaa.controller;

import com.aaa.commons.result.PageInfo;
import com.aaa.commons.result.Result;
import com.aaa.commons.utils.GetOpenIDUtil;
import com.aaa.service.WeChatService;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import java.util.HashMap;
import java.util.Map;


/**
 * @Company AAA软件教育
 * @Author ky
 * @Date Create in 2019/8/31 16:35
 * @Description
 **/
@Controller
@RequestMapping("/weChatFtp")
public class WeChatController {

    @Autowired
    private WeChatService weChatService;

    @GetMapping("/index")
    public String manager() {
        return "admin/ftpUpload/upload";
    }

    @GetMapping("/addUpload")
    public String addUpload() {
        return "admin/ftpUpload/addUpload";
    }

    @RequestMapping("/upload")
    @ResponseBody
    public Object upload(MultipartFile file,String rname,String type,String remaks,int category) throws Exception {
        Boolean b = weChatService.upload(file,rname,type,remaks,category);
        if (b){
            return renderSuccess("添加成功");
        }else {
            return renderSuccess("添加失败");
        }
    }

    /**
     * ajax成功
     * @param msg 消息
     * @return {Object}
     */
    public Object renderSuccess(String msg) {
        Result result = new Result();
        result.setSuccess(true);
        result.setMsg(msg);
        return result;
    }

    /**
     * 获取所有的信息
     * @return
     */
    @PostMapping("/getWeChatResources")
    @ResponseBody
    public PageInfo getWeChatResources(Integer page, Integer rows, String sort,String order,String searchName,Integer category) throws Exception{
        PageInfo pageInfo = new PageInfo(page, rows, sort, order);
        Map<String, Object> condition = new HashMap<String, Object>();
        if(StringUtils.isNotBlank(searchName)){
            condition.put("searchName", searchName);
        }
        if(category != null){
            condition.put("category", category);
        }
        pageInfo.setCondition(condition);
        weChatService.getWechatResources(pageInfo);
        return pageInfo;
    }

    /**
     * 获取小程序openId
     * @param appId
     * @param code
     * @param secret
     * @return
     */
    @RequestMapping("/getOpenId")
    @ResponseBody
    public Object GetOpenid(String appId, String code, String secret) {

        return GetOpenIDUtil.oauth2GetOpenid(appId, code, secret);

    }

}
