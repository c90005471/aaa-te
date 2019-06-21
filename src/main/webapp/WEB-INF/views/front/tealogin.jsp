<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/global.jsp" %>
<!DOCTYPE HTML>
<html>
<head>
<title>Home</title>
<%@ include file="/commons/frontjs.jsp" %>
<!-- Custom Theme files -->
<!-- Custom Theme files -->
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /> 
<meta name="keywords" content="Login form web template, Sign up Web Templates, Flat Web Templates, Login signup Responsive web template, Smartphone Compatible web template, free webdesigns for Nokia, Samsung, LG, SonyErricsson, Motorola web design" />
<!--Google Fonts-->
<!--Google Fonts-->
</head>
<body class="loginbody">
<div class="login">
	<h2>AAA在线教评系统</h2>
	<div class="login-top">
		<h1>请输入验证码</h1>
		<form action="${path}/front/checkTeaLogin" method="post">
			<input type="password" name="code" value="验证码" onfocus="this.value = '';" onblur="if (this.value == '') {this.value = '验证码';}">
	     <div class="forgot">
	    	<!-- <a href="#">forgot Password</a> -->
	    	<%
	    	String msg= (String)request.getAttribute("errorMessage");
    		if(msg!=null&&!("".equals(msg))){
     			out.print(msg);
    			}
	    	 %>
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


</body>
</html>