<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/global.jsp" %>
<script type="text/javascript">
var teaPlanDetailDataGrid;
    $(function() {
        teaPlanDetailDataGrid = $('#teaPlanDetailDataGrid').datagrid({
        url : '${path}/teaEvaluate/detailPage?planid=${planid}',
        striped : true,
        rownumbers : true,
        pagination : true,
        singleSelect : true,
        idField : 'id',
        sortName : 'id',
        fitColumns:true,
        sortOrder : 'asc',
        pageSize : 20,
        pageList : [ 10, 20, 30, 40, 50, 100, 200, 300, 400, 500],
        columns : [ [ {
            title : '编号',
            width:20,
            field : 'id',
            sortable : true
        }, 
        {
            title : '会话ID',
             width:30,
            field : 'sessionid',
        }
        , 
        {
            title : '教评名称',
            width:70,
            field : 'questionname'
        } , 
        {
            title : '教评id',
             width:20,
            field : 'teatestid',
            hidden:true
        },
        {
            title : '评价结果',
             width:20,
            field : 'floor',
           formatter : function(value, row, index) {
        	   /* 
        	   	根据类型判断等级(有两个类型因为成绩计算方式不一致)
        	   	现在需要考虑 做个动态的 
        	   */
        	   if(row.type == 1){
        		   switch (row.score) {
	                   case 2:
	                       return '差';
	                   case 4:
	                       return '较差';
	                   case 6:
	                       return '一般';
	                   case 8:
	                       return '好';
	                   case 10:
	                       return '很好';
	               	}
        	   	}else if(row.type == 2){
        	   		switch (row.score) {
	                   case 10:
	                       return '差';
	                   case 20:
	                       return '较差';
	                   case 30:
	                       return '一般';
	                   case 40:
	                       return '好';
	                   case 50:
	                       return '很好';
	               	}
        	   	}
            }
        },{
            title : '意见',
            field : 'idea',
            width:30,
            formatter : function(value, row, index) {
            	if(value!=null && value!=""&&value!=undefined){
            		return "<span title='" + value + "'>" + value + "</span>";  
            	}else{
            		return "";
            	}
            }
        }, {
            title : '分数',
            field : 'score',
            hidden:true
          
        },{
            title : '评价时间',
            field : 'submitime'
          
        }
       ] ],
  /*       onLoadSuccess:function(data){
            $('.stuPlan-easyui-linkbutton-edit').linkbutton({text:'编辑'});
            $('.stuPlan-easyui-linkbutton-del').linkbutton({text:'删除'});
        }, */
        });
        
    });
</script>
<div class="easyui-layout" data-options="fit:true,border:false">
    <div data-options="region:'center',border:false" title="" style="overflow: hidden;padding: 3px;">
        <table id="teaPlanDetailDataGrid" data-options="fit:true,border:false"></table>
    </div>
</div>