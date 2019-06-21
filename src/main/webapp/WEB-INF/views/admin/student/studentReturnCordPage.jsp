<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/global.jsp" %>
<script type="text/javascript">
    var studentReturnCordDataGrid;
    $(function() {
    	studentReturnCordDataGrid = $('#studentReturnCordDataGrid').datagrid({
        url : '${path}/student/returnCordDataGrid?studentId=${id}',
        striped : true,
        rownumbers : true,
        pagination : true,
        fitColumns:false,
        singleSelect : true,
        idField : 'id',
        sortName : 'id',
        sortOrder : 'asc',
        pageSize : 20,
        pageList : [ 10, 20, 30, 40],
        columns : [ [ {
            title : '编号',
            field : 'id',
            sortable : true
        },{
           
            title : '学生姓名',
            field : 'studentname'
        },{
        	width : '60',
            title : '回访人',
            field : 'username'
        },{
        	width : '280',
            title : '回访记录',
            field : 'returncontent'
        },{
            width : '80',
            title : '创建时间',
            field : 'returntime',
            sortable : true
        }, {
            field : 'action',
            title : '操作',
            width : 160,
            formatter : function(value, row, index) {
                var str = '';
                <shiro:hasPermission name="/student/returncordedit">
                    str += $.formatString('<a href="javascript:void(0)" class="student-easyui-linkbutton-returncordedit" data-options="plain:true,iconCls:\'fi-pencil icon-blue\'" onclick="studentReturnRecordEditFun(\'{0}\');" >编辑</a>', row.id);
                </shiro:hasPermission>
                <shiro:hasPermission name="/student/returncorddelete">
                    str += '&nbsp;&nbsp;|&nbsp;&nbsp;';
                    str += $.formatString('<a href="javascript:void(0)" class="student-easyui-linkbutton-returncorddelete" data-options="plain:true,iconCls:\'fi-x icon-red\'" onclick="studentReturnRecordDeleteFun(\'{0}\');" >删除</a>', row.id);
                </shiro:hasPermission>
                return str;
            }
        } ] ],
        onLoadSuccess:function(data){
            $('.student-easyui-linkbutton-returncordedit').linkbutton({text:'编辑'});
            $('.student-easyui-linkbutton-returncorddelete').linkbutton({text:'删除'});
        },
        toolbar : '#studentReturnCordToolbar'
    });
   
});

/**
 * 添加框
 * @param url
 */
function studentReturnCordAddFun() {
	$('#dialogpage').dialog({
        title : '添加',
        width : 500,
        height : 300,
        href : '${path}/student/addReturnRecordPage?studentId=${id}',
        buttons : [ {
            text : '确定',
            handler : function() {
            	$('#dialogpage').dialog.openner_dataGrid = studentReturnCordDataGrid;//因为添加成功之后，需要刷新这个treeGrid，所以先预定义好
            	$('#studentReturnCordAddForm').submit();
            }
        } ]
    });
}

/**
 * 编辑
 */
function studentReturnRecordEditFun(id) {
	if (id == undefined) {
        var rows = studentReturnCordDataGrid.datagrid('getSelections');
        id = rows[0].id;
    } else {
    	studentReturnCordDataGrid.datagrid('unselectAll').datagrid('uncheckAll');
    }
	
	//验证是否是本人编辑
	progressLoad();
    $.post('${path}/student/studentReturnCordCheckEdit', {
        id : id
    }, function(result) {
        if (result.success) {
        	$('#dialogpage').dialog({
                title : '编辑',
                width : 500,
                height : 300,
                href :  '${path}/student/editReturnRecordPage?id=' + id,
                buttons : [ {
                    text : '确定',
                    handler : function() {
                    	$('#dialogpage').dialog.openner_dataGrid = studentReturnCordDataGrid;//因为添加成功之后，需要刷新这个dataGrid，所以先预定义好
                        $('#studentReturnCordEditForm').submit();
                    }
                } ]
            });
        }else{
        	parent.$.messager.alert('提示', result.msg, 'info');
            studentReturnCordDataGrid.datagrid('reload');
        }
        progressClose();
    }, 'JSON');
    
    
}


/**
 * 删除
 */
 function studentReturnRecordDeleteFun(id) {
     if (id == undefined) {//点击右键菜单才会触发这个
         var rows = studentReturnCordDataGrid.datagrid('getSelections');
         id = rows[0].id;
     } else {//点击操作里面的删除图标会触发这个
    	 studentReturnCordDataGrid.datagrid('unselectAll').datagrid('uncheckAll');
     }
     parent.$.messager.confirm('询问', '您是否要删除当前记录？', function(b) {
         if (b) {
             progressLoad();
             $.post('${path}/student/returnRecordDelete', {
                 id : id
             }, function(result) {
                 parent.$.messager.alert('提示', result.msg, 'info');
                 studentReturnCordDataGrid.datagrid('reload');
                 progressClose();
             }, 'JSON');
         }
     });
}

</script>

<div class="easyui-layout" data-options="fit:true,border:false">
<%--     <div data-options="region:'north',border:false" style="height: 30px; overflow: hidden;background-color: #fff">--%>
<%--        <form id="studentSearchForm">--%>
<%--        </form>--%>
<%--     </div> --%>
    <div data-options="region:'center',border:true">
        <table id="studentReturnCordDataGrid" data-options="fit:true,border:false"></table>
    </div>
</div>
<div id="studentReturnCordToolbar" style="display: none;">
    <shiro:hasPermission name="/student/returncordadd">
        <a onclick="studentReturnCordAddFun();" href="javascript:void(0);" class="easyui-linkbutton" data-options="plain:true,iconCls:'fi-plus icon-green'">添加</a>
    </shiro:hasPermission>
</div>
<div id="dialogpage"></div>