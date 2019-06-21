<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/global.jsp" %>
<script type="text/javascript">
    var examquestionDataGrid;
    $(function() {
        examquestionDataGrid = $('#examquestionDataGrid').datagrid({
        url : '${path}/examquestion/dataGrid',
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
            width : '100',
            title : '课程名称',
            field : 'coursename',
            sortable : true,
        }, {
            width : '140',
            title : '选项A',
            field : 'optiona',
            sortable : true
        }, {
            width : '140',
            title : '选项B',
            field : 'optionb',
            sortable : true
        }, {
            width : '140',
            title : '选项C',
            field : 'optionc',
            sortable : true
        }, {
            width : '140',
            title : '选项D',
            field : 'optiond',
            sortable : true
        }, {
            width : '60',
            title : '答案',
            field : 'answer',
            sortable : true
        }, {
            width : '140',
            title : '题目',
            field : 'questionname',
            sortable : true
        }, {
            width : '60',
            title : '题号',
            field : 'questionid',
            sortable : true
        }, {
            field : 'action',
            title : '操作',
            width : 260,
            formatter : function(value, row, index) {
                var str = '';
                <shiro:hasPermission name="/examquestion/showDetail">
                    str += $.formatString('<a href="javascript:void(0)" class="examquestion-easyui-linkbutton-detail" data-options="plain:true,iconCls:\'fi-results icon-pruple\'" onclick="examquestionShowDetailFun(\'{0}\');" >查看详情</a>', row.id);
                </shiro:hasPermission>
                <shiro:hasPermission name="/examquestion/edit">
                	str += '&nbsp;&nbsp;|&nbsp;&nbsp;';
                    str += $.formatString('<a href="javascript:void(0)" class="examquestion-easyui-linkbutton-edit" data-options="plain:true,iconCls:\'fi-pencil icon-blue\'" onclick="examquestionEditFun(\'{0}\');" >编辑</a>', row.id);
                </shiro:hasPermission>
                <shiro:hasPermission name="/examquestion/delete">
                    str += '&nbsp;&nbsp;|&nbsp;&nbsp;';
                    str += $.formatString('<a href="javascript:void(0)" class="examquestion-easyui-linkbutton-del" data-options="plain:true,iconCls:\'fi-x icon-red\'" onclick="examquestionDeleteFun(\'{0}\');" >删除</a>', row.id);
                </shiro:hasPermission>
                return str;
            }
        } ] ],
        onLoadSuccess:function(data){
        	$('.examquestion-easyui-linkbutton-detail').linkbutton({text:'查看详情'});
            $('.examquestion-easyui-linkbutton-edit').linkbutton({text:'编辑'});
            $('.examquestion-easyui-linkbutton-del').linkbutton({text:'删除'});
        },
        toolbar : '#examquestionToolbar'
    });
});

/**
 * 添加框
 * @param url
 */
function examquestionAddFun() {
    parent.$.modalDialog({
        title : '添加',
        width : 700,
        height : 600,
        href : '${path}/examquestion/addPage',
        buttons : [ {
            text : '确定',
            handler : function() {
                parent.$.modalDialog.openner_dataGrid = examquestionDataGrid;//因为添加成功之后，需要刷新这个treeGrid，所以先预定义好
                var f = parent.$.modalDialog.handler.find('#examquestionAddForm');
                f.submit();
            }
        } ]
    });
}

/**
 * 查看详情
 */
function examquestionShowDetailFun(id) {
    if (id == undefined) {
        var rows = examquestionDataGrid.datagrid('getSelections');
        id = rows[0].id;
    } else {
        examquestionDataGrid.datagrid('unselectAll').datagrid('uncheckAll');
    }
    parent.$.modalDialog({
        title : '查看详情',
        width : 700,
        height : 600,
        href :  '${path}/examquestion/editPage?id=' + id,
        buttons : [ {
            text : '确定',
            handler : function() {
                parent.$.modalDialog.openner_dataGrid = examquestionDataGrid;//因为添加成功之后，需要刷新这个dataGrid，所以先预定义好
                var f = parent.$.modalDialog.handler.find('#examquestionEditForm');
                f.submit();
            }
        } ]
    });
}

/**
 * 编辑
 */
function examquestionEditFun(id) {
    if (id == undefined) {
        var rows = examquestionDataGrid.datagrid('getSelections');
        id = rows[0].id;
    } else {
        examquestionDataGrid.datagrid('unselectAll').datagrid('uncheckAll');
    }
    parent.$.modalDialog({
        title : '编辑',
        width : 700,
        height : 600,
        href :  '${path}/examquestion/editPage?id=' + id,
        buttons : [ {
            text : '确定',
            handler : function() {
                parent.$.modalDialog.openner_dataGrid = examquestionDataGrid;//因为添加成功之后，需要刷新这个dataGrid，所以先预定义好
                var f = parent.$.modalDialog.handler.find('#examquestionEditForm');
                f.submit();
            }
        } ]
    });
}


/**
 * 删除
 */
 function examquestionDeleteFun(id) {
     if (id == undefined) {//点击右键菜单才会触发这个
         var rows = examquestionDataGrid.datagrid('getSelections');
         id = rows[0].id;
     } else {//点击操作里面的删除图标会触发这个
         examquestionDataGrid.datagrid('unselectAll').datagrid('uncheckAll');
     }
     parent.$.messager.confirm('询问', '您是否要删除当前角色？', function(b) {
         if (b) {
             progressLoad();
             $.post('${path}/examquestion/delete', {
                 id : id
             }, function(result) {
                 if (result.success) {
                     parent.$.messager.alert('提示', result.msg, 'info');
                     examquestionDataGrid.datagrid('reload');
                 }
                 progressClose();
             }, 'JSON');
         }
     });
}


/**
 * 清除
 */
function examquestionCleanFun() {
    $('#examquestionSearchForm input').val('');
    examquestionDataGrid.datagrid('load', {});
}
/**
 * 搜索
 */
function examquestionSearchFun() {
     examquestionDataGrid.datagrid('load', $.serializeObject($('#examquestionSearchForm')));
}
</script>

<div class="easyui-layout" data-options="fit:true,border:false">
    <div data-options="region:'north',border:false" style="height: 30px; overflow: hidden;background-color: #fff">
        <form id="examquestionSearchForm">
            <table>
                <tr>
                    <th>名称:</th>
                    <td><input name="name" placeholder="搜索条件"/></td>
                    <td>
                        <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'fi-magnifying-glass',plain:true" onclick="examquestionSearchFun();">查询</a>
                        <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'fi-x-circle',plain:true" onclick="examquestionCleanFun();">清空</a>
                    </td>
                </tr>
            </table>
        </form>
     </div>
 
    <div data-options="region:'center',border:false">
        <table id="examquestionDataGrid" data-options="fit:true,border:false"></table>
    </div>
</div>
<div id="examquestionToolbar" style="display: none;">
    <shiro:hasPermission name="/examquestion/add">
        <a onclick="examquestionAddFun();" href="javascript:void(0);" class="easyui-linkbutton" data-options="plain:true,iconCls:'fi-page-add'">添加</a>
    </shiro:hasPermission>
</div>