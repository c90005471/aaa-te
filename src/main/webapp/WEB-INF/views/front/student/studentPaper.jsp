<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/global.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <%@ include file="/commons/basejs.jsp" %>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>主页</title>
    <link rel="stylesheet" href="${staticPath }/static/bootstrap/bootstrap.min.css">
    <link rel="stylesheet" href="${staticPath }/static/bootstrap/table/bootstrap-table.min.css">
    <link rel="stylesheet" href="${staticPath }/static/bootstrap/treeview/bootstrap-treeview.css">
    <style type="text/css">
        #ban{
            height: 30px;
            line-height: 30px;
            background-color: #F3F3F3;
        }
        #left{
            float: left;
            width: 13%;
            height: 100%;
            border: 1px solid #F1F1F1;
        }
        #right{
            float: left;
            width: 87%;
            height: 100%;
            border: 1px solid #F1F1F1;
        }
    </style>
</head>
<body>
<div id="loading" style="position: fixed;top: -50%;left: -50%;width: 200%;height: 200%;background: #fff;z-index: 100;overflow: hidden;">
    <img src="${staticPath }/static/style/images/ajax-loader.gif" style="position: absolute;top: 0;left: 0;right: 0;bottom: 0;margin: auto;"/>
</div>
<div id="index_layout">
    <div data-options="region:'north',border:false" style="overflow: hidden;">
        <div>
                <span style="float: right; padding-right: 20px; margin-top: 15px; color: #333">
                    <i class="fi-torso"></i>
                    <b>${stuname }</b>&nbsp;&nbsp;
                    <a href="javascript:void(0)" onclick="logout()" class="easyui-linkbutton" plain="true" icon="fi-x">安全退出</a>
                </span>
            <span class="header"></span>
        </div>
    </div>
    <div style="border: 1px solid #F1F1F1;height:638px;overflow: auto">
        <%--
            主页面
        --%>
        <div id="left">
            <div id="ban">菜单</div>
            <div id="tree"></div>
        </div>
        <div id="right">
            <div style="height: 30px;line-height: 30px;margin-bottom: -15px;margin-left: 10px">错题列表</div>
            <div class="tab-pane">
                <table class="table table-bordered table-striped" id="paperList">
                    <thead style="background-color: #BEDDFA">

                    </thead>
                </table>
            </div>
        </div>
    </div>
    <div data-options="region:'south',border:false" style="height: 30px;line-height:30px; overflow: hidden;text-align: center;background-color: #eee" >Copyright © 2017 power by <a href="http://www.zzaaa.net" target="_blank">AAA软件</a></div>
</div>

<!--[if lte IE 7]>
<div id="ie6-warning"><p>您正在使用 低版本浏览器，在本页面可能会导致部分功能无法使用。建议您升级到 <a href="http://www.microsoft.com/china/windows/internet-explorer/" target="_blank">Internet Explorer 8</a> 或以下浏览器：
    <a href="http://www.mozillaonline.com/" target="_blank">Firefox</a> / <a href="http://www.google.com/chrome/?hl=zh-CN" target="_blank">Chrome</a> / <a href="http://www.apple.com.cn/safari/" target="_blank">Safari</a> / <a href="http://www.operachina.com/" target="_blank">Opera</a></p></div>
<![endif]-->
<style>
    /*ie6提示*/
    #ie6-warning{width:100%;position:absolute;top:0;left:0;background:#fae692;padding:5px 0;font-size:12px}
    #ie6-warning p{width:960px;margin:0 auto;}
</style>
</body>
<script type="text/javascript" src="${staticPath }/static/bootstrap/bootstrap.min.js"></script>
<script type="text/javascript" src="${staticPath }/static/bootstrap/table/bootstrap-table.min.js"></script>
<script type="text/javascript" src="${staticPath }/static/bootstrap/treeview/bootstrap-treeview.js"></script>
<script type="text/javascript">
    var paperManager = {};
    var paperId = ${paper};
    $(function () {
        paperManager.initList();
        $.ajax({
            url:"${path}/front/getStudentMenu",
            type:"post",
            data:{
                stuid:${stuno}
            },
            dataType:"json",
            success:function (result) {
                var tree = new Object();
                for (var i = 0; i < result.length; i++) {
                    tree.text = result[i].text;
                    tree.nodes = result[i].treeMenuList;
                }
                var s = [tree];
                $('#tree').treeview({
                    data: s,
                    onNodeSelected: function (event, node) {
                        paperId = node.nodeid;
                        $("#paperList").bootstrapTable('refresh',{pageNumber:1});
                    }
                });
            }
        })
    })
    /**
     * 加载列表
     */
    paperManager.initList = function () {
        $("#paperList").bootstrapTable({
            url: "${path}/front/getQuestionsList", //请求路径
            method: 'post', //请求方式(*)
            contentType: 'application/x-www-form-urlencoded', //使用from表单方式提交(*)
            toolbar: '#toolbar', //工具按钮的容器
            striped: true, //是否启用隔行变色
            cache: false, //使用是否缓存 默认为true,所以一般情况下需要设置一下为false (*)
            pagination: true, //是否显示分页(*)
            sortable: false, //使用启用排序
            sortOrder: 'desc', //排序方式
            queryParams: paperManager.queryParams, //传递参数(*)
            queryParamsType: '',
            sidePagination: 'server', // 分页方式有两种 1.client 客户端分页  2.server分页
            pageNumber: 1, //初始化页数为第一页
            pageSize: 5, //默认每页加载行数
            pageList: [10, 25, 50, 100], //每页可选择记录数
            strictSearch: true,
            showColumns: false, // 是否显示所有的列
            showRefresh: false, // 是否显示刷新按钮
            minimumCountColumns: 2, // 最少允许的列数
            clickToSelect: true, // 是否启用点击选中行
            uniqueId: "id", // 每一行的唯一标识，一般为主键列
            showToggle: false, // 是否显示详细视图和列表视图的切换按钮
            cardView: false, // 是否显示详细视图
            detailView: false, // 是否显示父子表
            smartDisplay: false,
            onClickRow: function (e, row, element) {
                $(".success").removeClass("success");
                $(row).addClass("success");
            },
            responseHandler: function (result) {
                if (result != null) {
                    return {
                        'total': result.len, //总条数
                        'rows': result.list //所有的数据
                    };
                }
                return {
                    'total': 0, //总条数
                    'rows': [] //所有的数据
                }
            },
            //列表显示
            columns: [{
                field: 'id',
                title: "编号",
                visible: false
            }, {
                field: 'tid',
                title: "题号"
            }, {
                field: 'topicname',
                title: "题目名称"
            }, {
                field: 'a',
                title: "A"
            }, {
                field: 'b',
                title: "B"
            }, {
                field: 'c',
                title: "C"
            }, {
                field: 'd',
                title: "D"
            }, {
                field: 'answer',
                title: "你的答案"
            }, {
                field: 'rightAnswer',
                title: "正确答案"
            }]
        })
    }
    /**
     * @author ky
     * @date 2019/12/24
     * 传递参数
     **/
    paperManager.queryParams = function (params) {
        return {
            "pageNumber": params.pageNumber,
            "pageSize": params.pageSize,
            "stuno": ${stuno },
            "paperId":paperId
        }
    }
    function logout(){
        $.messager.confirm('提示','确定要退出?',function(r){
            if (r){
                progressLoad();
                window.location.href = "${path}/front/studentLogin";
            }
        });
    }
</script>