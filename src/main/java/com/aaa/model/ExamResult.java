package com.aaa.model;

/**
 * @author ky
 * @date 2020/2/13
 * 记录考试结果只记录错误的题目
 **/
public class ExamResult {
    private int id;
    private int infoid;
    private int stuid;
    private int paperid;
    private int type;
    /**
     * 自己的答案
     */
    private String answer;
    /**
     * 正确答案
     */
    private String rightAnswer;
    private int sum;

    public int getInfoid() {
        return infoid;
    }

    public void setInfoid(int infoid) {
        this.infoid = infoid;
    }

    public int getStuid() {
        return stuid;
    }

    public void setStuid(int stuid) {
        this.stuid = stuid;
    }

    public int getPaperid() {
        return paperid;
    }

    public void setPaperid(int paperid) {
        this.paperid = paperid;
    }

    public int getType() {
        return type;
    }

    public void setType(int type) {
        this.type = type;
    }

    public String getAnswer() {
        return answer;
    }

    public void setAnswer(String answer) {
        this.answer = answer;
    }

    public String getRightAnswer() {
        return rightAnswer;
    }

    public void setRightAnswer(String rightAnswer) {
        this.rightAnswer = rightAnswer;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getSum() {
        return sum;
    }

    public void setSum(int sum) {
        this.sum = sum;
    }
}
