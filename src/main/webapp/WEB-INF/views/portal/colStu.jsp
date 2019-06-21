<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/commons/global.jsp" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'report.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	
  </head>


  <body>
<%--  <script type="text/javascript" src="js/jquery-1.8.3.min.js"></script>--%>
<%--	<script type="text/javascript" src="js/dist/echarts-all.js"></script>--%>
<%--	<script type="text/javascript" src="js/dist/chart/map.js"></script>--%>
      	<div id="main" style="height:450px;width:550px;margin:0 auto">
  		
  	</div>
  	<script type="text/javascript">
  var chartDATA;
  	$.ajax({
  		url:"${path}/portal/getColStu",
  		type:"post",
  		async:false,
  		success:function(data){
  		//	console.log(data);
  			var jsonobj=eval("("+data+")");
  			charDATA=jsonobj;
  				var myChart=echarts.init(document.getElementById("main"));
	option = {
	    title : {
	        text: '大学生学员分布',
	        subtext: '',
	        x:'center'
	    },
	    tooltip : {
	        trigger: 'item'
	    },
	    legend: {
	        orient: 'vertical',
	        x:'left',
	        data:[]
	    },
	    dataRange: {
	        min: 0,
	        max: 2500,
	        x: 'left',
	        y: 'bottom',
	        text:['高','低'],           // 文本，默认为数值文本
	        calculable : true
	    },
	    dataRange: {  
                        x: 'left',  
                        y: 'bottom',  
                        splitList: [{  
                            start: 100  
                        }, {  
                            start: 85,  
                            end: 100  
                        }, {  
                            start: 65,  
                            end: 85  
                        }, {  
                            start: 45,  
                            end: 65  
                        }, {  
                            start: 25,  
                            end: 45,  
                        }, {  
                            start: 25,  
                            end: 5,  
                        }, {  
                            end: 5  
                        }],  
                        color: ['#4682B4', '#87CEFA', '#ADD8E6']  
                    },
     toolbox: {
	        show: true,
	        orient : 'vertical',
	        x: 'right',
	        y: 'center',
	        feature : {
	            mark : {show: true},
	            dataView : {show: true, readOnly: false},
	            restore : {show: true},
	            saveAsImage : {show: true}
	        }
	    },
	    roamController: {
	        show: true,
	        x: 'right',
	        mapTypeControl: {
	            'china': true
	        }
	    },
	    series : [
	        {
	            name: '学生数量',
	            type: 'map',
	            mapType: 'china',
	            roam: false,
	            itemStyle:{
	                normal:{label:{show:true}},
	                emphasis:{label:{show:true}}
	            },

	            data:charDATA
	             
	            
	        }
	    ]
	};
	myChart.setOption(option);
  		}
  	});

  	</script>
  </body>
  
</html>
