<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/global.jsp" %>
<!DOCTYPE HTML>
<html>
<head>
<title>AAA在线入学考试系统</title>
<%@ include file="/commons/frontjs.jsp" %>
<!-- Custom Theme files -->
<!-- Custom Theme files --> 
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /> 
<meta name="keywords" content="Login form web template, Sign up Web Templates, Flat Web Templates, Login signup Responsive web template, Smartphone Compatible web template, free webdesigns for Nokia, Samsung, LG, SonyErricsson, Motorola web design" />
<!--Google Fonts-->
<!--Google Fonts-->
<style type="text/css">
	select{
		width: auto;
		border-radius:25px;
		background:#CACACA;
		font-size: 15px;
		padding: 8px 10px;
		
	}
	option{
		text-align: center;
	}
</style>
</head>
<body class="loginbody">
<div class="login">
	<h2>AAA在线入学考试系统</h2>
	<div class="login-top">
		<h1>请输入姓名和手机号</h1>

	   <form id="reg-form" action="${path}/front/testQuestion" method="post" onsubmit="return checkAll()">
			
			<input type="text" id="stuname" name="stuname" value="姓名" onfocus="this.value = '';" id="uid" onblur="if (this.value == '') {this.value = '姓名';}" data-easyform="null;" easyform="char-normal;real-time;" message="姓名为必填项" easytip="disappear:lost-focus;theme:blue;">
			<input type="text" id="stuphone" name="stuphone" value="手机号" onfocus="this.value = '';" onblur="if (this.value == '') {this.value = '手机号';}" data-easyform="null;" easyform="char-normal;real-time;" message="请输入手机号" easytip="disappear:lost-focus;theme:blue;">
	     	<select type="text" id="quesType"  name="quesType" >
	     		<option value="1">逻辑思维</option>
	     		<option value="2">意志力</option>
	     	</select>
	     <div class="forgot" >
	     	<span id="msg"></span>
	    	<input type="submit" value="Login">
	    </div>
	    </form>
	   <script type="text/javascript">
	   		function checkAll(){
	   			var stuname = $("#stuname").val();
	   			var stuphone = $("#stuphone").val();
	   			if(stuname=="姓名"||stuphone=="手机号"){
	   				$("#msg").html("用户名或手机号不能为空");
	   				return false;
	   			}
	   			var myreg=/^[1][3,4,5,7,8][0-9]{9}$/;  
	   			if(myreg.test(stuphone)){
	   				return true;
	   			}else{
	   				$("#msg").html("请输入正确的手机号");
	   				return false;
	   			}
	   		}
	   </script>
	</div>
	<div class="login-bottom">
		<h3>如有疑问请联陈老师 &nbsp;<a href="#">86521760@qq.com</a></h3>
	</div>
</div>	
<div class="copyright">
	<p>Copyright &copy; 2017.<a target="_blank" href="http://www.zzaaa.net">AAA软件</a> All rights reserved.</p>
</div>
<script>
    $(document).ready(function ()

    {

        $('#reg-form').easyform();

    });
</script>

</body>
</html>