package com.aaa.model;

import com.baomidou.mybatisplus.activerecord.Model;
import com.baomidou.mybatisplus.annotations.TableName;

import java.io.Serializable;

@TableName("wechat_resources")
public class WechatResources extends Model<WechatResources> {
    /**
     * id
     */
    private Integer id;

    /**
     * 0:是图片 1:是视频
     */
    private Integer type;

    /**
     * url
     */
    private String url;

    /**
     * 名称
     */
    private String name;
    /**
     * 简介
     */
    private String remaks;
    /**
     * 类别 (0 实战  1推荐)
     */
    private int category;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getType() {
        return type;
    }

    public void setType(Integer type) {
        this.type = type;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getRemaks() {
        return remaks;
    }

    public void setRemaks(String remaks) {
        this.remaks = remaks;
    }

    public int getCategory() {
        return category;
    }

    public void setCategory(int category) {
        this.category = category;
    }

    @Override
    public String toString() {
        return "WechatResources{" +
                "id=" + id +
                ", type=" + type +
                ", url='" + url + '\'' +
                ", name='" + name + '\'' +
                '}';
    }

    @Override
    protected Serializable pkVal() {
        return this.id;
    }
}
