package com.aaa.service.impl;

import com.aaa.commons.result.PageInfo;
import com.aaa.commons.utils.FileNameUtil;
import com.aaa.commons.utils.FtpUtil;
import com.aaa.config.FtpProperties;
import com.aaa.mapper.WeChatMapper;
import com.aaa.model.WechatResources;
import com.aaa.service.WeChatService;
import com.baomidou.mybatisplus.plugins.Page;
import org.joda.time.DateTime;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.List;
import java.util.Map;

/**
 * @author ky
 * @date 2019/11/14
 **/
@Service
public class WeChatServiceImpl implements WeChatService {
    @Autowired
    private WeChatMapper weChatMapper;

    /**
     * 文件上传
     *
     * @param file
     * @return
     * @throws IOException
     */
    @Override
    public Boolean upload(MultipartFile file, String rname, String type,String remaks,int category) throws IOException {
        FtpProperties ftpProperties = new FtpProperties();
        // 1.获取原始文件名
        String oldName = file.getOriginalFilename();
        // 2.创建新的文件名
        String newFileName = FileNameUtil.getFileName(1L);
        // 3.截取原始文件名的后缀
        newFileName = newFileName + oldName.substring(oldName.lastIndexOf("."));
        // 4.创建文件所在的目录(2019/08/31)
        String filePath = new DateTime().toString("yyyy/MM/dd");
        // 5.调用上传的工具类实现上传功能

        // 保存到数据库
        WechatResources wechatResources = new WechatResources();
        wechatResources.setUrl("https://cdn.ryana.cn/ftp/" + filePath + "/" + newFileName);
        wechatResources.setName(rname);
        wechatResources.setType(Integer.parseInt(type));
        wechatResources.setCategory(category);
        wechatResources.setRemaks(remaks);
        weChatMapper.addWechatResources(wechatResources);

        return FtpUtil.uploadFile(ftpProperties.getHost(),
                Integer.parseInt(ftpProperties.getPort()),
                ftpProperties.getUsername(), ftpProperties.getPassword(),
                ftpProperties.getBasePath(),
                filePath, newFileName, file.getInputStream());
    }

    @Override
    public void getWechatResources(PageInfo pageInfo) throws Exception {
        Page<Map<String, Object>> page = new Page<>(pageInfo.getNowpage(), pageInfo.getSize());
        page.setOrderByField(pageInfo.getSort());
        page.setAsc(pageInfo.getOrder().equalsIgnoreCase("desc"));
        List<Map<String, Object>> list = weChatMapper.getWechatResources(page, pageInfo.getCondition());
        pageInfo.setRows(list);
        pageInfo.setTotal(page.getTotal());
    }

}