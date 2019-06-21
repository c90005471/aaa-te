<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/commons/global.jsp"%>
<style>
	#test{
		position:"absolute";
		margin-top:-330px;
		margin-left:10px;
	}
	#csname p{
		color:#4488BB;
		font-size:15px;
	}
	#csname span{
		
		color:gray;
		font-size:15px;
		font-weight:bold;
	}
	#count p{
		font-size:15px;
		color:#4488BB;
	}
	#count span{
		color:gray;
		font-size:15px;
		font-weight:bold;
	}
	#rade p{
		font-size:15px;
		color:#4488BB;
	}
	#rade span{
		color:gray;
		font-size:15px;
		font-weight:bold;
	}
</style>
<script type="text/javascript" charset="utf-8">
     //图表  
    var myChart = echarts.init(document.getElementById('psLine'));  
    //查询  

$(function(){
		
        myChart.clear();
        myChart.showLoading({text: '正在努力的读取数据中...'}); 
        $.ajax({
    	type: "POST",
    	async: false,//关闭异步刷新，因为显示所有的题目是第一步
		url:'${path }/stuEvaluate/countRade?planid=${planid}',
		dataType : 'json',
		success:function(result){
	     option = {
    	tooltip : {
        formatter: "{a} <br/>{b} : {c}%"
    	},
    toolbox: {
        show : true,
        feature : {
            mark : {show: true},
            restore : {show: true},
            saveAsImage : {show: true}
        }
    },
    series : [
        {
            name:'学生评价比例',
            type:'gauge',
            splitNumber: 10,       // 分割段数，默认为5
            axisLine: {            // 坐标轴线
                lineStyle: {       // 属性lineStyle控制线条样式
                    color: [[0.2, '#228b22'],[0.8, '#48b'],[1, '#ff4500']], 
                    width: 8
                }
            },
            axisTick: {            // 坐标轴小标记
                splitNumber: 10,   // 每份split细分多少段
                length :12,        // 属性length控制线长
                lineStyle: {       // 属性lineStyle控制线条样式
                    color: 'auto'
                }
            },
            axisLabel: {           // 坐标轴文本标签，详见axis.axisLabel
                textStyle: {       // 其余属性默认使用全局文本样式，详见TEXTSTYLE
                    color: 'auto'
                }
            },
            splitLine: {           // 分隔线
                show: true,        // 默认显示，属性show控制显示与否
                length :30,         // 属性length控制线长
                lineStyle: {       // 属性lineStyle（详见lineStyle）控制线条样式
                    color: 'auto'
                }
            },
            pointer : {
                width : 5
            },
            title : {
                show : true,
                offsetCenter: [0, '-40%'],       // x, y，单位px
                textStyle: {       // 其余属性默认使用全局文本样式，详见TEXTSTYLE
                    fontWeight: 'bolder'
                }
            },
            detail : {
                formatter:'{value}%',
                textStyle: {       // 其余属性默认使用全局文本样式，详见TEXTSTYLE
                    color: 'auto',
                    fontWeight: 'bolder'
                }
            },
            data:[{value: result, name: '自评率'}]
        }
    ]
};		myChart.hideLoading();
		myChart.setOption(option);
	     	},
	     	error:function(errorMsg){
	     		alert("不好意思数据请求失败啦！");
	     		myChart.hideLoading();	
	     		}
     	})
     })
</script>

	<div id="psLine" style="height:350px;"></div>
	<div id="test">
	<div id="csname" >
	   <p>班级名称： <span>${countt.csname} </span> </p>
	</div>
	<div id="count">
	  <p> 总人数： <span>${countt.rade} </span> </p>
	</div>
	<div id="rade" >
	   <p>参与评价人数： <span >${countt.count} </span></p>
	</div>
	</div>
