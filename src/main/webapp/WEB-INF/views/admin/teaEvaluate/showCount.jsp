<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/commons/global.jsp"%>
<script type="text/javascript" charset="utf-8">
/* $('#cc').combo({    
    required:true,    
}); */
    //查询  
$(function(){
        $.ajax({
    	type: "POST",
    	async: false,//关闭异步刷新
		url:'${path}/teaEvaluate/getCountData?planid=${planid}',
		dataType : 'json',
		success : function(data) {
		            xList = data.xList;  //横轴坐标
                    avgScore = data.avgScore;  //纵轴坐标
                    /* commvalues = data.commvalues;   */
                    var  option;
                    if(xList.length!=0&&avgScore.length!=0){
                    	//图表  
                        var teacherChart = echarts.init(document.getElementById('teapsLine'));  
                        teacherChart.clear();  
                        teacherChart.showLoading({text: '正在努力的读取数据中...'}); 
                    	option = {
							    title : {
							        text: '教学评价情况',
							        subtext: selectRowStr
							    },
							    tooltip : {
							        trigger: 'axis'
							    },
							    legend: {
							        //data:['综合','奖金']
							        data:['教评得分统计']
							    },
							    toolbox: {
							        show : true,
							        feature : {
							            mark : {show: true},
							            dataView : {show: true, readOnly: false},
							            magicType : {show: true, type: [ 'bar','line']},
							            restore : {show: true},
							            saveAsImage : {show: true}
							        }
							    },
							    calculable : true,
							    xAxis : [
							        {
							            type : 'category',
							            data : xList
							        }
							    ],
							    yAxis : [
							        {
							            type : 'value'
							        }
							    ],
							    series : [
							        {
							            name:'得分',
							            type:'bar',
							            data:avgScore,
							            markPoint : {
							                data : [
							                    {type : 'max', name: '最大值'},
							                    {type : 'min', name: '最小值'}
							                ]
							            },
							            markLine : {
							                data : [
							                    {type : 'average', name: '平均值'}
							                ]
							            }
							        },
							        /* {
							            name:'奖金',
							            type:'bar',
							            data:commvalues,
							            markPoint : {
							                data : [
							                    {type : 'max', name: '最大值'},
							                    {type : 'min', name: '最小值'}
							                ]
							            },
							            markLine : {
							                data : [
							                    {type : 'average', name : '平均值'}
							                ]
							            }
							        } */
							        
							    ]
							};
                    	teacherChart.setOption(option, true); 
    	                teacherChart.hideLoading();  
                    }else{
                    	$("#teapsLine").html("<span style='font-size:16px;'>暂无数据</sapn>");
                    }
        }});
       
        });
              
       /*  }); */  
    

</script>
<!-- 请选择单项得分<input id="cc" value="综合"> 
<hr> --> 
<div id="teapsLine" style="height:400px;"></div>
