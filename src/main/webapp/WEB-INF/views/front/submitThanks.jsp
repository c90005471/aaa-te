<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/commons/global.jsp" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <%@ include file="/commons/frontjs.jsp" %>
    <title>AAA软件在线自评系统</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<style type="text/css">
		#main{
			width:100%;
			height:98%;
			margin-top:-100px;
			background-image: url("${staticPath}/static/front/images/backg.jpg") ;
			background-repeat: no-repeat;
			background-position: center;
		}
		#p{
			font-size:30px;
			color:white;
			margin-top:10px;
		}
		#aaa a{
			text-decoration:none;
			display:block;
			padding-top:30px;
			padding-left:100px;
			font-size:15px;
			color:white;
		}
	</style>
  </head>
  <script type="text/javascript">   
 </script>
  <body>
	  <div id="p" style="margin-top:5px;">
	  		<h1 style="color:white;margin:0 0;">Thanks<br/>感谢您的使用</h1>
	  		<div id="show" style='color:red;font-size:28px;'></div>
	  </div>
	  <div id="main">
    		<center>
    			
    		</center>
      </div>
  </body>
</html>
