<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/commons/global.jsp"%>
<script type="text/javascript" charset="utf-8">
     //图表  
    var teapsLineChar = echarts.init(document.getElementById('stupsLine'));  
    //查询  
$(function(){
        teapsLineChar.clear();  
        teapsLineChar.showLoading({text: '正在努力的读取数据中...'}); 
        $.ajax({
    	type: "POST",
    	async: false,//关闭异步刷新，因为显示所有的题目是第一步
		url:'${path}/stuEvaluate/getCountData?planid=${planid}',
		dataType : 'json',
		success : function(data) {
		var  option = {
    title : {
        text: '理想状态 vs 实际状态',
        subtext: selectStr,
    },
    tooltip : {
        trigger: 'axis',
    },
    legend: {
        orient : 'vertical',
        x : 'right',
        y : 'bottom',
        data:['理想状态','实际状态']
    },
    toolbox: {
        show : true,
        feature : {
            mark : {show: true},
            dataView : {show: true, readOnly: false},
            restore : {show: true},
            saveAsImage : {show: true}
        }
    },
    polar : [
       {
           indicator : data.indicator
        }
    ],
    calculable : true,
    series : [
        {
            name: '理想状态 vs 实际状态',
            type: 'radar',
            data : [
                {
                    value : data.dream,
                    name : '理想状态'
                },
                 {
                    value : data.real,
                    name : '实际状态'
                }
            ]
        }
    ]
}; 
         teapsLineChar.setOption(option, true); 
                teapsLineChar.hideLoading();  
        }});
       
        });
              
       /*  }); */  
    

</script>

<div id="stupsLine" style="height:400px;"></div>
