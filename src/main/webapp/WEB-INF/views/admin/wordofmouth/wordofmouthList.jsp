<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/global.jsp" %>
<script type="text/javascript">
    var wordofmouthDataGrid;

    $(function() {
    	wordofmouthDataGrid = $('#wordofmouthDataGrid').datagrid({
            url : '${path }/wordofmouth/dataGrid',
            fit : true,
            striped : true,
            rownumbers : true,
            pagination : true,
            singleSelect : true,
            idField : 'id',
            sortName : 'createTime',
	        sortOrder : 'asc',
            pageSize : 20,
            pageList : [ 10, 20, 30, 40, 50, 100, 200, 300, 400, 500 ],
            columns : [ [ {
                width : '45',
                title : '口碑ID',
                field : 'id',
                sortable : true
            },{
                width : '60',
                title : '口碑姓名',
                field : 'stuname',
                sortable : true
            }, {
                width : '80',
                title : '口碑手机号',
                field : 'stuphone',
                sortable : true
            }, {
                width : '70',
                title : '口碑状态',
                field : 'status',
                formatter:function(value){
                	switch (value) {
                    case 0:
                        return '${wordstatusmap["0"]}';
                    case 1:
                        return '${wordstatusmap["1"]}';
	                case 2:
	                    return '${wordstatusmap["2"]}';
		            case 3:
		                return '${wordstatusmap["3"]}';
		            }
                }
            },{
                width : '65',
                title : '报备人姓名',
                field : 'teaname',
                sortable : true
            },{
                width : '80',
                title : '报备人手机号',
                field : 'teaphone'
            },{
                width : '450',
                title : '备注',
                field : 'remark',
                formatter: function (value) {
                    return "<span title='" + value + "'>" + value + "</span>";
                },
                sortable : true
            },{
                width : '140',
                title : '创建时间',
                field : 'createtime',
                sortable : true
            }, {
                field : 'action',
                title : '操作',
                width : 200,
                formatter : function(value, row, index) {
                    var str = '';
                    <shiro:hasPermission name="/wordofmouth/edit">
                        str += $.formatString('<a href="javascript:void(0)" class="wordofmouth-easyui-linkbutton-edit" data-options="plain:true,iconCls:\'fi-pencil icon-blue\'" onclick="wordofmouthEditFun(\'{0}\');" >编辑</a>', row.id);
                    </shiro:hasPermission>
                    <shiro:hasPermission name="/wordofmouth/delete">
                        str += '&nbsp;&nbsp;|&nbsp;&nbsp;';
                        str += $.formatString('<a href="javascript:void(0)" class="wordofmouth-easyui-linkbutton-del" data-options="plain:true,iconCls:\'fi-x icon-red\'" onclick="wordofmouthDeleteFun(\'{0}\');" >删除</a>', row.id);
                    </shiro:hasPermission>
                    return str;
                }
            } ] ],
            onLoadSuccess:function(data){
                $('.wordofmouth-easyui-linkbutton-edit').linkbutton({text:'编辑'});
                $('.wordofmouth-easyui-linkbutton-del').linkbutton({text:'删除'});
            },
            toolbar : '#wordOfMouthToolbar'
        });
    	$("#begintimeWordId").val(time(1));
        $("#stoptimeWordId").val(time(0));
    });
        
    function wordSearchFun() {
    	wordofmouthDataGrid.datagrid('load', $.serializeObject($('#wordofmouthForm')));
    }
    function wordCleanFun() {
        $('#wordofmouthForm input').val('');
        wordofmouthDataGrid.datagrid('load', {});
    }
    /**
     * 导出excel
     */
    function exportWordOfMouthExcel(){
    	var datagridRows = wordofmouthDataGrid.datagrid("getRows");
        var columns = wordofmouthDataGrid.datagrid("options").columns[0];
        var dataRows={columns:columns,datagridRows:datagridRows};
        if(datagridRows.length>0){
        	 $.ajax({
          		url:"${path}/wordofmouth/exportWordofmouthExcel",
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
    /**
     * 添加框
     * @param url
     */
    function wordofmouthAddFun() {
    	parent.$.modalDialog({
            title : '添加',
            width : 540,
            height : 300,
            href : '${path}/wordofmouth/addPage',
            buttons : [ {
                text : '确定',
                handler : function() {
                    parent.$.modalDialog.openner_dataGrid = wordofmouthDataGrid;//因为添加成功之后，需要刷新这个treeGrid，所以先预定义好
                    var f = parent.$.modalDialog.handler.find('#wordofmouthAddForm');
                    f.submit();
                }
            } ]
        });
    }
    /**
     * 编辑
     */
    function wordofmouthEditFun(id) {
        if (id == undefined) {
            var rows = wordofmouthDataGrid.datagrid('getSelections');
            id = rows[0].id;
        } else {
        	wordofmouthDataGrid.datagrid('unselectAll').datagrid('uncheckAll');
        }
        parent.$.modalDialog({
            title : '编辑',
            width : 540,
            height : 300,
            href :  '${path}/wordofmouth/editPage?id=' + id,
            buttons : [ {
                text : '确定',
                handler : function() {
                    parent.$.modalDialog.openner_dataGrid = wordofmouthDataGrid;//因为添加成功之后，需要刷新这个dataGrid，所以先预定义好
                    var f = parent.$.modalDialog.handler.find('#wordofmouthEditForm');
                    f.submit();
                }
            } ]
        });
    }

    /**
     * 删除
     */
     function wordofmouthDeleteFun(id) {
         if (id == undefined) {//点击右键菜单才会触发这个
             var rows = wordofmouthDataGrid.datagrid('getSelections');
             id = rows[0].id;
         } else {//点击操作里面的删除图标会触发这个
        	 wordofmouthDataGrid.datagrid('unselectAll').datagrid('uncheckAll');
         }
         parent.$.messager.confirm('询问', '您是否要删除当前口碑信息？', function(b) {
             if (b) {
                 progressLoad();
                 $.post('${path}/wordofmouth/delete', {
                     id : id
                 }, function(result) {
                     if (result.success) {
                         parent.$.messager.alert('提示', result.msg, 'info');
                         wordofmouthDataGrid.datagrid('reload');
                     }
                     progressClose();
                 }, 'JSON');
             }
         });
    }
</script>
<div class="easyui-layout" data-options="fit:true,border:false">
    <div data-options="region:'north',border:false" style="height: 30px; overflow: hidden;background-color: #fff">
        <form id="wordofmouthForm">
            <table>
                <tr>
                    <th>口碑姓名:</th>
                    <td><input name="stuname" placeholder="请输入口碑姓名"/></td>
                    <th>报备人姓名:</th>
                    <td><input name="teaname" placeholder="请输入报备人姓名"/></td>
                    <th>开始时间:</th>
                    <td>
                    	<input id="begintimeWordId" name="begintime"  type="text" editable="false" class="easyui-datebox" ></input> 
                    </td>
                    
                    <th>结束时间:</th>
                    <td>
                    	<input id="stoptimeWordId" name="stoptime"  type="text" editable="false" class="easyui-datebox"></input>
                    </td>
                    <td>
                        <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'fi-magnifying-glass',plain:true" onclick="wordSearchFun();">查询</a>
                        <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'fi-x-circle',plain:true" onclick="wordCleanFun();">清空</a>
                    </td>
                </tr>
            </table>
        </form>
    </div>
    <div data-options="region:'center',border:true,title:'口碑列表'" >
        <table id="wordofmouthDataGrid" data-options="fit:true,border:false"></table>
    </div>
    <div id="wordOfMouthToolbar" style="display: none;">
    	<shiro:hasPermission name="/wordofmouth/add">
	        <a onclick="wordofmouthAddFun();" href="javascript:void(0);" class="easyui-linkbutton" data-options="plain:true,iconCls:'fi-plus icon-green'">添加</a>
	    </shiro:hasPermission>
        <a onclick="exportWordOfMouthExcel();" id="export" href="javascript:void(0);"   class="easyui-linkbutton" data-options="plain:true,iconCls:'fi-download icon-green'">导出excel</a>
	</div>
</div>
