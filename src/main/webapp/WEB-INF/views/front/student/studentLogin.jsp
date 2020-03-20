<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/global.jsp" %>
<!DOCTYPE HTML>
<html>
<head>
    <title>AAA考试结果查询</title>
    <%@ include file="/commons/frontjs.jsp" %>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="keywords" content="Login form web template, Sign up Web Templates, Flat Web Templates, Login signup Responsive web template, Smartphone Compatible web template, free webdesigns for Nokia, Samsung, LG, SonyErricsson, Motorola web design" />
    <style type="text/css">
        html,body {
            margin: 0;
            padding: 0;
            width: 100%;
            height: 100%;
        }
        *{
            font-weight:bold;
            color: gray;

        }
        .login-top h1 {
            text-align: center;
            font-size: 20px;
            font-weight: 500;
            font-weight:bold;
            color: gray;
            margin: 0px 0px 20px 0px;
        }
        .forgot{
            margin-top:15px;
            margin-bottom: -20px;
        }
    </style>
</head>
<body class="loginbody">
<div class="login">
    <h2>AAA考试结果查询</h2>
    <div class="login-top">
        <form action="${path}/front/toStudentPaper" method="post" onsubmit="return checkStu()">
            <div class="inputtext" style="padding-bottom: 20px">
                <span style="letter-spacing: 9px">学号</span>
                <input id="stuno" name="stuno" style="width:45%;height:35px;" />
            </div>
            <div class="inputtext">
                手机号
                <input id="stuphone" name="stuphone" style="width:45%;height:35px;" />
            </div>
            <div class="forgot">
                <span style="color: red;font-size: 16px;margin-right: 20px;" id="msg"></span>
                <input type="submit" value="Login" >
            </div>
        </form>
    </div>
    <div class="login-bottom">
        <h3>如有疑问请联陈老师 &nbsp;<a href="#">86521760@qq.com</a></h3>
    </div>
</div>
<div class="copyright">
    <p>Copyright &copy; 2017.<a target="_blank" href="http://www.zzaaa.net">AAA软件</a> All rights reserved.</p>
</div>

<script type="text/javascript">
    function checkStu(){
        var flag = true;
        var stuno = $("#stuno").val();
        if(stuno==null||stuno==""){
            $("#msg").html("请输入学号");
            return false;
        }
        var stuphone = $("#stuphone").val();
        if(stuphone==null||stuphone==""){
            $("#msg").html("请输入手机号");
            return false;
        }
        //判断该学生是允许登陆
        $.ajaxSettings.async = false;
        $.post("checkStudentLogin",{stuno:$("#stuno").val(),stuphone:$("#stuphone").val()},function(data){
            flag = data;
            if(!data){
                $("#msg").html("学号或者手机号错误,请重新输入");
            }
        },"json");
        return flag;
    }
</script>
</body>
</html>