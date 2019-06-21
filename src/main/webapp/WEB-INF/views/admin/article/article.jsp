<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'article.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

  </head>
  
  <body>
	    <table style="width:800px;margin:0 auto">
	    		<tr><td><h1>${article.title}</h1></td></tr>
	    		<tr><td style="font-size:15px;color:gray">作者：${article.author}</td></tr>
	    		<tr><td style="font-size:15px;color:gray">时间：${article.time}</td></tr>
	    		<tr><td>${article.content}</td></tr>
	    </table>
	 <!-- UY BEGIN -->
		<div id="uyan_frame" style="width:800px;margin:0 auto"></div>
		<script type="text/javascript" src="http://v2.uyan.cc/code/uyan.js?uid=2149535"></script>
		<!-- UY END -->
  </body>
</html>
