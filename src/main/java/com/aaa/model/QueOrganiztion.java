package com.aaa.model;

import com.aaa.commons.utils.JsonUtils;
import com.baomidou.mybatisplus.annotations.TableName;

/**
 * @author ky
 * @date 2020/1/3
 * 考核点校区中间表
 **/
@TableName("question_organiztion")
public class QueOrganiztion {
    /**
     * 主键
     */
    private int id;
    /**
     * 考核点ID
     */
    private int questionid;
    /**
     * 校区ID
     */
    private int organiztionid;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getQuestionid() {
        return questionid;
    }

    public void setQuestionid(int questionid) {
        this.questionid = questionid;
    }

    public int getOrganiztionid() {
        return organiztionid;
    }

    public void setOrganiztionid(int organiztionid) {
        this.organiztionid = organiztionid;
    }
    @Override
    public String toString() {
        return JsonUtils.toJson(this);
    }
}
