package com.aaa.service;

import com.aaa.commons.result.PageInfo;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;

/**
 * @author ky
 * @date 2019/11/15
**/
public interface WeChatService {
    /**
     *
     * @param file
     * @return
     * @throws IOException
     */
    Boolean upload(MultipartFile file,String rname,String type,String remaks,int category) throws IOException;

    /**
     * 获取所有的信息
     * @return
     * @throws Exception
     */
    void getWechatResources(PageInfo pageInfo) throws Exception;

}
