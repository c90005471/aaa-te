<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/global.jsp" %>
<script type="text/javascript">
    var assistEvaluateDataGrid;
    var assistEvaluateClassTree;
    var orgidAssistEva;
    var classidAssistEva;
    //var selectRowStr;
    $(function() {
    	assistEvaluateClassTree = $('#assistEvaluateClassTree').tree({
            url : '${path}/tblClass/tree?Math.random()',
            parentField : 'pid',
            lines : true,
            onLoadSuccess: function (node, data) {
            	$("#assistEvaluateClassTree").tree("collapseAll");
            	var roots= $("#assistEvaluateClassTree").tree('getRoots');  
                for(var i=0;i<roots.length;i++){  
                    $("#assistEvaluateClassTree").tree('expand', roots[i].target);  
                }
              },
            onClick : function(node) {
                //返回树对象  
        	    var tree = $(this).tree;  
        	//选中的节点是否为叶子节点,如果不是叶子节点,清除所有右边的数据
        		var isLeaf = tree('isLeaf', node.target);  
        		if (!isLeaf) {  
        			orgidAssistEva = node.id;
        		    classidAssistEva = null;
                	$("#orgidAssistEva").val(orgidAssistEva);
                	$("#classidAssistEva").val("");
        		    assistEvaluateDataGrid.datagrid('load',$.serializeObject($('#assistEvaluateSearchForm')));
        		}else{ 
        		    //将classid传入到后台
        		    classidAssistEva=node.id;
        		    orgidAssistEva = null;
        		    $("#orgidAssistEva").val("");
                	$("#classidAssistEva").val(classidAssistEva);
        			assistEvaluateDataGrid.datagrid('load',$.serializeObject($('#assistEvaluateSearchForm')));
        		}
            }
        });
        assistEvaluateDataGrid = $('#assistEvaluateDataGrid').datagrid({
        url : '${path}/assistPlan/dataGrid',
        striped : true,
        rownumbers : true,
        pagination : true,
        singleSelect : true,
        idField : 'id',
        sortName : 'id',
        sortOrder : 'asc',
        pageSize : 20,
        pageList : [ 10, 20, 30, 40, 50, 100, 200, 300, 400, 500],
        columns : [ [ {
            title : '计划ID',
            field : 'id',
            sortable : true
        }, 
        {
            title : '班级名称',
            field : 'classname',
            sortable : true
        }, 
        {
            title : '学习内容',
            field : 'stucontent'
        },
        {
            title : '开始时间',
            field : 'starttime'
        },
        {
            title : '结束时间',
            field : 'endtime'
          
        }, {
            title : '制定人',
            field : 'createname'
          
        },{
            title : '制定时间',
            field : 'createtime'
          
       }, {
           title : '是否完成',
           field : 'isstatus',
           formatter : function(value, row, index) {
               switch (row.isstatus) {
               case 0:
                   return '未完成';
               case 1:
                   return '已完成';
               }
           }
       },{
            field : 'action2',
            title : '操作',
            width : 260,
            formatter : function(value, row, index) {
                var str = '';
                <shiro:hasPermission name="/assistEvaluate/showDetail">
                    str += $.formatString('<a href="javascript:void(0)" class="assistPlan-easyui-linkbutton-show" data-options="plain:true,iconCls:\'fi-results icon-purple\'" onclick="showTeaDetail(\'{0}\',\'{1}\',\'{2}\');" >查看详情</a>', row.id,row.classname,row.createname);
                </shiro:hasPermission>
                <%--<shiro:hasPermission name="/assistEvaluate/showCount">
                    str += '&nbsp;&nbsp;|&nbsp;&nbsp;';
                    str += $.formatString('<a href="javascript:void(0)" class="assistPlan-easyui-linkbutton-count" data-options="plain:true,iconCls:\'fi-graph-pie icon-purple\'" onclick="showTeaCount(\'{0}\',\'{1}\');" >统计分析</a>', row.id,row.classname);
                </shiro:hasPermission>--%>
                return str;
            }
        } ] ],
        onLoadSuccess:function(data){
            $('.assistPlan-easyui-linkbutton-show').linkbutton({text:'查看详情'});
            <%--$('.assistPlan-easyui-linkbutton-count').linkbutton({text:'统计分析'});--%>
        },
        toolbar : '#assistEvaluateToolbar'
    });
        
     $("#startTimeAssistEvaId").val(time(1));
     $("#endTimeAssistEvaId").val(time(0));
});




/**
 * 显示详情
 */
function showTeaDetail(id,classname,createname) {

    if (id == undefined) {
        var rows = assistEvaluateDataGrid.datagrid('getSelections');
        id = rows[0].id;
        classid=rows[0].classid;
    } else {
        assistEvaluateDataGrid.datagrid('unselectAll').datagrid('uncheckAll');
    }
    parent.$.modalDialog({
        title : '显示详情',
        width : 800,
        height : 450,
        href :  '${path}/assistEvaluate/showDetailPage?id='+id+'&&classname='+classname+'&&createname='+createname
    });
}
//显示统计图表
function showTeaCount(id,classname) {
    if (id == undefined) {
        var rows = assistEvaluateDataGrid.datagrid('getSelections');
        id = rows[0].id;
        classid=rows[0].classid;
        //selectRowStr = "班级："+rows[0].classname+"   教师姓名："+rows[0].teachername+"   结束时间："+rows[0].stoptime;
		//if(rows[0].score!=undefined){
		//	selectRowStr+="  得分："+rows[0].score;
		//}
    } else {
    	//selectRowStr = "班级："+classname+"   教师姓名："+teachername+"   结束时间："+stoptime;
		//if(score!=undefined&&score!="undefined"){
		//	selectRowStr+="  得分："+score;
		//}
        assistEvaluateDataGrid.datagrid('unselectAll').datagrid('uncheckAll');
    }
    parent.$.modalDialog({
        title : '显示教评情况',
        width : 800,
        height : 450,
        href :  '${path}/assistEvaluate/showCountPage?id=' + id
    });
}

/**
 * 清除
 */
function assistEvaluateCleanFun() {
    $('#assistEvaluateSearchForm input').val('');
    orgidAssistEva = null;
    classidAssistEva = null;
    assistEvaluateDataGrid.datagrid('load', {});
}
/**
 * 搜索
 */
function assistEvaluateSearchFun() {
	$("#orgidAssistEva").val(orgidAssistEva);
	$("#classidAssistEva").val(classidAssistEva);
    assistEvaluateDataGrid.datagrid('load', $.serializeObject($('#assistEvaluateSearchForm')));
}
/**
 * 导出excel
 */
function exportAssistPlanExcel(){
	var datagridRows = assistEvaluateDataGrid.datagrid("getRows");
    var columns = assistEvaluateDataGrid.datagrid("options").columns[0];
    var dataRows={columns:columns,datagridRows:datagridRows};
    if(datagridRows.length>0){
    	 $.ajax({
      		url:"${path}/assistPlan/exportAssistPlanExcel",
      		type:"post",
      		contentType:"application/json", 
      		async: false,
      	 	data:JSON.stringify(dataRows),
      	 	success:function(data){
      	 	  	var fileName=data;
      			//下载文件
      			location.href="${path}/download/"+fileName.replace('"','').replace('"',''); 
      	 	}
      	 	
      	 });
    }else{
    	parent.$.messager.alert('警告', '请先查询出结果列表！');
    }
	
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



</script>

<div class="easyui-layout" data-options="fit:true,border:false">
     <div data-options="region:'north',border:false" style="height: 30px; overflow: hidden;background-color: #fff">
        <form id="assistEvaluateSearchForm">
            <table>
                <tr>
                    <th>教师姓名:</th>
                    <td>
                    	<input type="hidden" name="orgid" id="orgidAssistEva"/>
                    	<input type="hidden" name="classid" id="classidAssistEva"/>
                    	<input name="teacherName" placeholder="搜索教师姓名"/>
                    </td>
                    <th>开始时间:</th>
                    <td>
                    	<input id="startTimeAssistEvaId" name="startTime"  type="text" editable="false" class="easyui-datebox" ></input> 
                    </td>
                    
                    <th>结束时间:</th>
                    <td>
                    	<input id="endTimeAssistEvaId" name="endTime"  type="text" editable="false" class="easyui-datebox"></input>
                    </td>
                    <td>
                        <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'fi-magnifying-glass',plain:true" onclick="assistEvaluateSearchFun();">查询</a>
                        <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'fi-x-circle',plain:true" onclick="assistEvaluateCleanFun();">清空</a>
                    </td>
                </tr>
            </table>
        </form>
     </div>
 
    <div data-options="region:'center',border:false,title:'帮扶计划列表'">
        <table id="assistEvaluateDataGrid" data-options="fit:true,border:false"></table>
    </div>
     <div data-options="region:'west',border:true,split:false,title:'班级组织'"  style="width:180px;overflow: auto; ">
        <ul id="assistEvaluateClassTree" style="width:160px;margin: 10px 10px 10px 10px"></ul>
    </div>
</div>
<div id="assistEvaluateToolbar" style="display: none;">
      <a onclick="exportAssistPlanExcel();" id="export" href="javascript:void(0);"   class="easyui-linkbutton" data-options="plain:true,iconCls:'fi-download icon-green'">导出excel</a>
</div>