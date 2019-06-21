<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/global.jsp" %>
<script type="text/javascript">
    var assistPlanDataGrid;
    var assistPlanClassTree;
    var orgidAssist;
    var classidAssist;
    var leafNodeAssist = false;
    //var classname;
    $(function() {
    	assistPlanClassTree = $('#assistPlanClassTree').tree({
            url : '${path }/tblClass/tree?Math.random()',
            parentField : 'pid',
            lines : true,
            onLoadSuccess: function (node, data) {
            	$("#assistPlanClassTree").tree("collapseAll");
            	var roots= $("#assistPlanClassTree").tree('getRoots');  
                for(var i=0;i<roots.length;i++){  
                    $("#assistPlanClassTree").tree('expand', roots[i].target);  
                }
              },
            onClick : function(node) {
                //返回树对象  
        	    var tree = $(this).tree;  
        	//选中的节点是否为叶子节点,如果不是叶子节点,清除所有右边的数据
        		var isLeaf = tree('isLeaf', node.target);
        		if (!isLeaf){
        			leafNodeAssist = false;
        			orgidAssist = node.id;
        		    classidAssist = null;
        		    $("#orgidAssist").val(orgidAssist);
        		    $("#classidAssist").val("");
        		    assistPlanDataGrid.datagrid('load',$.serializeObject($('#assistPlanSearchForm')));
        		}else{ 		
        		    //将classid传入到后台
        		    classidAssist=node.id;
        		    orgidAssist = null;
        		    //classname=node.text;
        		    //var treeParent = $(this).tree('getParent', node.target); 
        		    //orgid=treeParent.id;//获取orgid
        		    leafNodeAssist = true;
        		    $("#orgidAssist").val("");
        		    $("#classidAssist").val(classidAssist);
        		    assistPlanDataGrid.datagrid('load', $.serializeObject($('#assistPlanSearchForm')));
                	//将添加按钮显示
        			//assistPlanDataGrid.datagrid( {
                    	//toolbar : "#assistPlanToolbar"
                	//}
                	//);
        		}
            }
        });
    	assistPlanDataGrid = $('#assistPlanDataGrid').datagrid({
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
        //columns : [ [ {  右冻结样式冲突
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
          
       },{
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
       }, {
            field : 'action',
            title : '操作',
            width : 200,
            formatter : function(value, row, index) {
                var str = '';
                <shiro:hasPermission name="/assistPlan/edit">
                    str += $.formatString('<a href="javascript:void(0)" class="assistPlan-easyui-linkbutton-edit" data-options="plain:true,iconCls:\'fi-pencil icon-blue\'" onclick="assistPlanEditFun(\'{0}\',\'{1}\');" >编辑</a>', row.id,row.classid);
                </shiro:hasPermission>
                <shiro:hasPermission name="/assistPlan/delete">
                    str += '&nbsp;&nbsp;|&nbsp;&nbsp;';
                    str += $.formatString('<a href="javascript:void(0)" class="assistPlan-easyui-linkbutton-del" data-options="plain:true,iconCls:\'fi-x icon-red\'" onclick="assistPlanDeleteFun(\'{0}\');" >删除</a>', row.id);
                </shiro:hasPermission>
                return str;
            }
        } ] ],
        onLoadSuccess:function(data){
            $('.assistPlan-easyui-linkbutton-edit').linkbutton({text:'编辑'});
            $('.assistPlan-easyui-linkbutton-del').linkbutton({text:'删除'});
        },
        toolbar : "#assistPlanToolbar"
    });
        $("#startTimeAssistPlanId").val(time(1));
        $("#endTimeAssistPlanId").val(time(0));
});

/**
 * 添加框
 * @param url
 */
function assistPlanAddFun() {
	if(!leafNodeAssist){
		parent.$.messager.alert('警告', '请在左侧组织机构中选择班级！');  
	}else{
		parent.$.modalDialog({
	        title : '添加',
	        width : 600,
	        height : 500,
	        href : '${path}/assistPlan/addPage',
	        buttons : [ {
	            text : '确定',
	            width:50,
	            handler : function() {
	                parent.$.modalDialog.openner_dataGrid = assistPlanDataGrid;//因为添加成功之后，需要刷新这个treeGrid，所以先预定义好
	                var f = parent.$.modalDialog.handler.find('#assistPlanAddForm');
	                f.submit();
	            }
	        } ]
	    });
	}
}


/**
 * 编辑
 */
function assistPlanEditFun(id,classid) {

    if (id == undefined) {
        var rows = assistPlanDataGrid.datagrid('getSelections');
        id = rows[0].id;
        //classname=teacherPlanDataGrid.datagrid('getSelections')[0].classname;
		classid=teacherPlanDataGrid.datagrid('getSelections')[0].classid;
    } else {
    	assistPlanDataGrid.datagrid('unselectAll').datagrid('uncheckAll');
    } 
    parent.$.modalDialog({
        title : '编辑',
        width : 600,
        height : 500,
        href :  '${path}/assistPlan/editPage?id=' + id,
        buttons : [ {
            text : '确定',
            width:50,
            handler : function() {
                parent.$.modalDialog.openner_dataGrid = assistPlanDataGrid;//因为添加成功之后，需要刷新这个dataGrid，所以先预定义好
                var f = parent.$.modalDialog.handler.find('#assistPlanEditForm');
                f.submit();
            }
        } ]
    });
}


/**
 * 删除
 */
 function assistPlanDeleteFun(id) {
     if (id == undefined) {//点击右键菜单才会触发这个
         var rows = assistPlanDataGrid.datagrid('getSelections');
         id = rows[0].id;
     } else {//点击操作里面的删除图标会触发这个
    	 assistPlanDataGrid.datagrid('unselectAll').datagrid('uncheckAll');
     }
     parent.$.messager.confirm('询问', '您是否要删除当前计划？', function(b) {
         if (b) {
             progressLoad();
             $.post('${path}/assistPlan/delete', {
                 id : id
             }, function(result) {
                 if (result.success) {
                     parent.$.messager.alert('提示', result.msg, 'info');
                     assistPlanDataGrid.datagrid('reload');
                 }else {
                     parent.$.messager.alert('错误',result.msg, 'error');
                 }
                 progressClose();
             }, 'JSON');
         }
     });
}


/**
 * 清除
 */
function assistPlanCleanFun() {
	orgidAssist = null;
	classidAssist = null;
    $('#assistPlanSearchForm input').val('');
    assistPlanDataGrid.datagrid('load', {});
}
/**
 * 搜索
 */
function assistPlanSearchFun() {
	$("#orgidAssist").val(orgidAssist);
	$("#classidAssist").val(classidAssist);
	assistPlanDataGrid.datagrid('load', $.serializeObject($('#assistPlanSearchForm')));
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
/**
 * 导出excel
 */
function exportAssistPlanExcel(){
	var datagridRows = assistPlanDataGrid.datagrid("getRows");
    var columns = assistPlanDataGrid.datagrid("options").columns[0];
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
</script>

<div class="easyui-layout" data-options="fit:true,border:false">
     <div data-options="region:'north',border:false" style="height: 30px; overflow: hidden;background-color: #fff">
        <form id="assistPlanSearchForm">
            <table>
                <tr>
                    <th>教师姓名:</th>
                    <td>
                    	<input type="hidden" name="orgid" id="orgidAssist"/>
                    	<input type="hidden" name="classid" id="classidAssist"/>
                    	<input id="teacherNameAssist" name="teacherName" placeholder="搜索教师姓名"/>
                    </td>
                    <th>教评开始时间:</th>
                    <td>
                    	<input id="startTimeAssistPlanId" name="startTime"  type="text" editable="false" class="easyui-datebox" ></input> 
                    </td>
                    
                    <th>教评结束时间:</th>
                    <td>
                    	<input id="endTimeAssistPlanId" name="endTime"  type="text" editable="false" class="easyui-datebox"></input>
                    </td>
                    <td>
                        <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'fi-magnifying-glass',plain:true" onclick="assistPlanSearchFun();">查询</a>
                        <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'fi-x-circle',plain:true" onclick="assistPlanCleanFun();">清空</a>
                    </td>
                </tr>
            </table>
        </form>
     </div> 
 
    <div data-options="region:'center',border:false,title:'计划列表'">
        <table id="assistPlanDataGrid" data-options="fit:true,border:false"></table>
    </div>
     <div data-options="region:'west',border:true,split:false,title:'班级组织'"  style="width:180px;overflow: auto; ">
        <ul id="assistPlanClassTree" style="width:160px;margin: 10px 10px 10px 10px"></ul>
    </div>
</div>
<div id="assistPlanToolbar" style="display: none;">
    <shiro:hasPermission name="/assistPlan/add">
        <a onclick="assistPlanAddFun();" href="javascript:void(0);" class="easyui-linkbutton" data-options="plain:true,iconCls:'fi-plus icon-green'">添加计划</a>
    </shiro:hasPermission>
    <a onclick="exportAssistPlanExcel();" id="export" href="javascript:void(0);"   class="easyui-linkbutton" data-options="plain:true,iconCls:'fi-download icon-green'">导出excel</a>
</div>
