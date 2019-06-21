<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/commons/global.jsp"%>
<script type="text/javascript" charset="utf-8">
/* $('#cc').combo({    
    required:true,    
}); */
    //查询  
$(function(){
		//初始化全部数据
		showCountDate("");
        //select改变事件
        $("#flag").change(function(){
        	var flag = $("#flag").val();
        	showCountDate(flag);
        });
        $("#begintimeWordCountId").val(time(1));
        $("#endtimeWordCountId").val(time(0));
       
});
              
	function showCountDate(flag){
		$.ajax({
	    	type: "POST",
	    	async: false,//关闭异步刷新
			url:'${path}/wordofmouth/getCountData?flag='+flag,
			data : $("#wordofmouthCountForm").serialize(),
			dataType : 'json',
			success : function(data) {
			            xList = data.xList;  //横轴坐标
	                    avgScore = data.avgScore;  //纵轴坐标
	                    /* commvalues = data.commvalues;   */
	                    var  option;
	                    if(xList.length!=0&&avgScore.length!=0){
	                    	//图表  
	                        var wordChart = echarts.init(document.getElementById('wordpsLine'));  
	                        wordChart.clear();  
	                        wordChart.showLoading({text: '正在努力的读取数据中...'}); 
	                    	option = {
								    title : {
								        text: '口碑信息情况'//,
								        //subtext: selectRowStr
								    },
								    tooltip : {
								        trigger: 'axis'
								    },
								    legend: {
								        //data:['综合','奖金']
								        data:['口碑信息统计']
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
								            name:'数量',
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
	                    	wordChart.setOption(option, true); 
	                    	wordChart.hideLoading();  
	                    }else{
	                    	$("#wordpsLine").html("<span style='font-size:16px;'>暂无数据</sapn>");
	                    }
	        }});
	}    
	//设月底跟月头时间  
    function time(number){  
        var date=new Date();  
        var strDate=date.getFullYear()+"-";  
        if(number==0){ //0 为月底  
        	strDate+=date.getMonth()+2+"-";  
       	 	strDate+=number;  
        }else{  
        	strDate+=date.getMonth()+1+"-";  
        	strDate+=number;  
        }  
        return strDate;  
    } 
       
       
    function wordCleanFun() {
        $('#wordofmouthCountForm input').val('');
        var flag = $("#flag").val();
        showCountDate(flag);
    }
</script>
<!-- 请选择单项得分<input id="cc" value="综合"> 
<hr> --> 
<center>
	<div style="padding-top:10px;">
		<h1 style="font-size:15px;">当前分类:
		<select id="flag" style="font-size:15px;">
			<option value="">口碑状态分类</option>
			<option value="0">口碑月份分类</option>
		</select>
		</h1>
	</div>
	<div class="easyui-layout" data-options="fit:true,border:false">
    <div data-options="region:'north',border:false" style="padding-left:20%;padding-top:20px; height: 60px; overflow: hidden;background-color: #fff">
        <form id="wordofmouthCountForm">
            <table>
                <tr>
                    <th>报备人姓名:</th>
                    <td><input name="teaname" placeholder="请输入报备人姓名"/></td>
                    <th>开始时间:</th>
                    <td>
                    	<input id="begintimeWordCountId" name="begintime"  type="text" editable="false" class="easyui-datebox" ></input> 
                    </td>
                    
                    <th>结束时间:</th>
                    <td>
                    	<input id="endtimeWordCountId" name="endtime"  type="text" editable="false" class="easyui-datebox"></input>
                    </td>
                    <td>
                        <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'fi-magnifying-glass',plain:true" onclick="showCountDate();">查询</a>
                        <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'fi-x-circle',plain:true" onclick="wordCleanFun();">清空</a>
                    </td>
                </tr>
            </table>
        </form>
    </div>
    <div id="wordpsLine" style="height:400px;width:60%;margin-top: 100px;"></div>
</div>
	
</center>
