<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/global.jsp" %>
<!DOCTYPE HTML>
<html>
<head>
<title>AAA在线考试系统</title>
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
	<h2>AAA在线考试系统</h2>
	<div class="login-top">
		<form action="${path}/front/toExamPaper" method="post" onsubmit="return checkStu()">
			<h1>
				<input type="radio" name="type" checked="checked" value="0"/>结业考试
				<input type="radio" name="type" value="1"/>课程内测
				<input type="radio" name="type" value="2"/>模拟练习
			</h1>
			<br/>
			<div class="selecttext">
<%--				阶段--%>
<%--				<select id="stage" name="stage" style="width:25%;height:35px;">--%>
<%--					<option value="">请选择</option>--%>
<%--					<option value="S1">S1</option>--%>
<%--					<option value="S2">S2</option>--%>
<%--					<option value="S3">S3</option>--%>
<%--				</select>--%>
				试卷
				<select id="examPaper"  name="examPaperId" style="width:85%;height:35px;">
					<option value="">请选择试卷</option>
			 	</select>
			 </div>
		 	<br/>
		 	<div class="inputtext">
				学号
				<input id="stuno" name="stuno" style="width:25%;height:35px;" />	
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
	$(function(){
		 $("input[type=radio][name=type]").change(function() {
			 $("#stage").val("");
			 $("#examPaper").html("<option value=''>请选择试卷</option>");
		 });
		//阶段选择事件
		$("input[type='radio'][name='type']").on("change",function(){
			// var stageVal = $(this).val();
			var typeVal = $("input[name='type']:checked").val();
			if(typeVal!=""){
				$.post("selectExamPaperList",{type:typeVal},function(data){
					var optionStr="";
					for(var i=0;i<data.length;i++){
						optionStr+="<option value='"+data[i].code+"'>"+data[i].name+"</option>";
					}
					$("#examPaper").html(optionStr);
				},"json");
			}else{
				$("#examPaper").html("<option value=''>请选择试卷</option>");
			}
		});
		
	});
		function checkStu(){
			var flag = true;
			var examPaper = $("#examPaper").val();
			if(examPaper==null||examPaper==""){
				$("#msg").html("请选择试卷");
				return false;
			}
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
    		$.post("checkExamLogin",{examPaperId:$("#examPaper").val(),stuno:$("#stuno").val(),stuphone:$("#stuphone").val()},function(data){
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