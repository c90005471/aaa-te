<%--标签 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="edge" />
<link rel="shortcut icon"
	href="${staticPath }/static/style/images/favicon.ico" />
<%-- [my97日期时间控件] --%>
<script type="text/javascript"
	src="${staticPath }/static/My97DatePicker/WdatePicker.js"
	charset="utf-8"></script>
<%-- [jQuery] --%>
<script type="text/javascript"
	src="${staticPath }/static/easyui/jquery.min.js" charset="utf-8"></script>
<%-- [EasyUI] --%>
<link id="easyuiTheme" rel="stylesheet" type="text/css"
	href="${staticPath }/static/easyui/themes/gray/easyui.css" />
<link id="easyuiTheme" rel="stylesheet" type="text/css"
	href="${staticPath }/static/easyui/themes/icon.css" />
<link id="portal" rel="stylesheet" type="text/css"
	href="${staticPath }/static/easyui/jquery-easyui-portal/portal.css" />
<script type="text/javascript"
	src="${staticPath }/static/easyui/jquery.easyui.min.js" charset="utf-8"></script>
<script type="text/javascript"
	src="${staticPath }/static/easyui/locale/easyui-lang-zh_CN.js"
	charset="utf-8"></script>
<script type="text/javascript"
	src="${staticPath }/static/easyui/jquery-easyui-portal/jquery.portal.js"
	charset="utf-8"></script>
<%-- [扩展JS] --%>
<script type="text/javascript" src="${staticPath }/static/extJs.js"
	charset="utf-8"></script>
<%-- [ztree] --%>
<link rel="stylesheet" type="text/css"
	href="${staticPath }/static/ztree/css/zTreeStyle.css" />
<script type="text/javascript"
	src="${staticPath }/static/ztree/js/jquery.ztree.core.js"
	charset="utf-8"></script>
<%-- [扩展样式] --%>
<link rel="stylesheet" type="text/css"
	href="${staticPath }/static/style/css/dreamlu.css?v=10" />
<link rel="stylesheet" type="text/css"
	href="${staticPath }/static/foundation-icons/foundation-icons.css" />
	<!-- echarts 插件库 -->
 <script type="text/javascript" src="${staticPath }/static/echarts/dist/echarts-all.js"></script> 
 <script type="text/javascript" src="${staticPath }/static/echarts/macarons.js"></script> 
 <script type="text/javascript" src="${staticPath }/static/echarts/dist/chart/map.js"></script>
 <script src="${staticPath }/static/echarts/dist/echarts.js"></script>
 <script type="text/javascript"
					charset="utf-8" src="${staticPath }/static/ueditor/ueditor.config.js"></script>
				<script type="text/javascript" charset="utf-8"
					src="${staticPath }/static/ueditor/ueditor.all.min.js">
				</script>
				 <script
					type="text/javascript" charset="utf-8"
					src="${staticPath }/static/ueditor/lang/zh-cn/zh-cn.js"></script> 
<script type="text/javascript">
    var basePath = "${staticPath }";
    window.UEDITOR_HOME_URL = "${staticPath }/static/ueditor/";
    window.UEDITOR_SERVER_URL = "${staticPath }/ueditor";
</script>
<!-- Global site tag (gtag.js) - Google Analytics -->
<script async src="https://www.googletagmanager.com/gtag/js?id=UA-110958470-1"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());

  gtag('config', 'UA-110958470-1');
</script>