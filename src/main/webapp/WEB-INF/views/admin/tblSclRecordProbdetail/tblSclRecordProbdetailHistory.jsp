<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/global.jsp" %>
<script type="text/javascript">
    var tblSclRecordProbdetailDataGrid;
    $(function() {
        tblSclRecordProbdetailDataGrid = $('#tblSclRecordProbdetailDataGrid').datagrid({
        url : '${path}/tblSclRecordProbdetail/tblSclRecordProlemHistory?studentid=${studentid}&createtime=${createtime}',
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
            width : '60',
            title : '编号',
            field : 'id',
            sortable : true
        }, {
            width : '60',
            title : '学生',
            field : 'stuname'
        }, {
            width : '60',
            title : '教师',
            field : 'name'
        }, {
            width : '140',
            title : '访谈时间',
            field : 'createtime'
        }, {
            width : '100',
            title : '记录',
            field : 'record'
        } , {
            field : 'action',
            title : '操作',
            width : 200,
            formatter : function(value, row, index) {
                var str = '';
                <shiro:hasPermission name="/tblSclRecordProbdetail/edit">
                    str += $.formatString('<a href="javascript:void(0)" class="tblSclInterview-easyui-linkbutton-edit" data-options="plain:true,iconCls:\'fi-pencil icon-blue\'" onclick="tblSclInterviewEditFun(\'{0}\');" >编辑</a>', row.id);
                </shiro:hasPermission>
                <shiro:hasPermission name="/tblSclRecordProbdetail/delete">
                    str += '&nbsp;&nbsp;|&nbsp;&nbsp;';
                    str += $.formatString('<a href="javascript:void(0)" class="tblSclInterview-easyui-linkbutton-del" data-options="plain:true,iconCls:\'fi-x icon-red\'" onclick="tblSclInterviewDeleteFun(\'{0}\');" >删除</a>', row.id);
                </shiro:hasPermission>
                return str;
            }
        } ] ],
        onLoadSuccess:function(data){
            $('.tblSclInterview-easyui-linkbutton-edit').linkbutton({text:'编辑'});
            $('.tblSclInterview-easyui-linkbutton-del').linkbutton({text:'删除'});
        },
        toolbar : '#historyToolbar'
    });
});
    /**
     * 编辑
     */
    function tblSclInterviewEditFun(id) {
        if (id == undefined) {
            var rows = tblSclRecordProbdetailDataGrid.datagrid('getSelections');
            id = rows[0].id;
        } else {
        	tblSclRecordProbdetailDataGrid.datagrid('unselectAll').datagrid('uncheckAll');
        }
        $("#addForm").dialog({
            title : '编辑',
            width : 500,
            height : 360,
            href :  '${path}/tblSclRecordProbdetail/editPage?id=' + id+'&classid=${classid}',
            buttons : [ {
                text : '确定',
                handler : function() {
                	$("#addForm").dialog.openner_dataGrid = tblSclRecordProbdetailDataGrid;//因为添加成功之后，需要刷新这个dataGrid，所以先预定义好
                    var f = $("#tblSclRecordProbdetailEditForm");
                    f.submit();
                }
            } ]
        });
    }

    /**
     * 删除
     */
     function tblSclInterviewDeleteFun(id) {
         if (id == undefined) {//点击右键菜单才会触发这个
             var rows = tblSclRecordProbdetailDataGrid.datagrid('getSelections');
             id = rows[0].id;
         } else {//点击操作里面的删除图标会触发这个
        	 tblSclRecordProbdetailDataGrid.datagrid('unselectAll').datagrid('uncheckAll');
         }
         parent.$.messager.confirm('询问', '您是否要删除当前学生？', function(b) {
             if (b) {
                 progressLoad();
                 $.post('${path}/tblSclRecordProbdetail/delete', {
                     id : id
                 }, function(result) {
                     if (result.success) {
                         parent.$.messager.alert('提示', result.msg, 'info');
                         tblSclRecordProbdetailDataGrid.datagrid('reload');
                     }
                     progressClose();
                 }, 'JSON');
             }
         });
    }

function tblSclRecordProbdetailAddFun(){
	$("#addForm").dialog({
        title : '添加',
        width : 500,
        height : 300,
        href : '${path}/tblSclRecordProbdetail/addPage?studentid=${studentid}&classid=${classid}',
        buttons : [ {
            text : '确定',
            handler : function() {
            	$("#addForm").dialog.openner_dataGrid = tblSclRecordProbdetailDataGrid;//因为添加成功之后，需要刷新这个grid，所以先预定义好
            	var f = $("#tblSclRecordProbdetailAddForm");
                f.submit();
            }
        } ]
    });
}
</script>
<div id="addForm"></div>
<div class="easyui-layout" data-options="fit:true,border:false">
    <div data-options="region:'center',border:false">
        <table id="tblSclRecordProbdetailDataGrid" data-options="fit:true,border:false"></table>
    </div>
</div>

<div id="historyToolbar" style="display: none;">
    <shiro:hasPermission name="/tblSclRecordProbdetail/add">
        <a onclick="tblSclRecordProbdetailAddFun()" href="javascript:void(0);" class="easyui-linkbutton" data-options="plain:true,iconCls:'fi-plus icon-green'">添加</a>
    </shiro:hasPermission>
</div>