<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/global.jsp" %>
<script type="text/javascript">
    var tblSclDataGrid;
    
    $(function() {
        tblSclDataGrid = $('#tblSclDataGrid').datagrid({
        url : '${path}/tblScl/dataGrid',
        fit : true,
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
            width : '360',
            title : '题目',
            field : 'item',
            sortable : true,
            
        }, {
            width : '140',
            title : '类型编号',
            field : 'typeId',
            sortable : true,
            hidden:true
        },{
            width : '140',
            title : '类型名称',
            field : 'typeName',
            sortable : true
        }, {
            field : 'action',
            title : '操作',
            width : 200,
            formatter : function(value, row, index) {
                var str = '';
                <shiro:hasPermission name="/tblScl/edit">
                    str += $.formatString('<a href="javascript:void(0)" class="tblScl-easyui-linkbutton-edit" data-options="plain:true,iconCls:\'fi-pencil icon-blue\'" onclick="tblSclEditFun(\'{0}\');" >编辑</a>', row.id);
                </shiro:hasPermission>
                <shiro:hasPermission name="/tblScl/delete">
                    str += '&nbsp;&nbsp;|&nbsp;&nbsp;';
                    str += $.formatString('<a href="javascript:void(0)" class="tblScl-easyui-linkbutton-del" data-options="plain:true,iconCls:\'fi-x icon-red\'" onclick="tblSclDeleteFun(\'{0}\');" >删除</a>', row.id);
                </shiro:hasPermission>
                return str;
            }
        } ] ],
        onLoadSuccess:function(data){
            $('.tblScl-easyui-linkbutton-edit').linkbutton({text:'编辑'});
            $('.tblScl-easyui-linkbutton-del').linkbutton({text:'删除'});
        },
        toolbar : '#tblSclToolbar'
    });
});

/**
 * 添加框
 * @param url
 */
function tblSclAddFun() {
    parent.$.modalDialog({
        title : '添加',
        width : 400,
        height : 220,
        href : '${path}/tblScl/addPage',
        buttons : [ {
            text : '确定',
            handler : function() {
                parent.$.modalDialog.openner_dataGrid = tblSclDataGrid;//因为添加成功之后，需要刷新这个treeGrid，所以先预定义好
                var f = parent.$.modalDialog.handler.find('#tblSclAddForm');
                f.submit();
            }
        } ]
    });
}


/**
 * 编辑
 */
function tblSclEditFun(id) {
    if (id == undefined) {
        var rows = tblSclDataGrid.datagrid('getSelections');
        id = rows[0].id;
    } else {
        tblSclDataGrid.datagrid('unselectAll').datagrid('uncheckAll');
    }
    parent.$.modalDialog({
        title : '编辑',
        width : 400,
        height : 220,
        href :  '${path}/tblScl/editPage?id=' + id,
        buttons : [ {
            text : '确定',
            handler : function() {
                parent.$.modalDialog.openner_dataGrid = tblSclDataGrid;//因为添加成功之后，需要刷新这个dataGrid，所以先预定义好
                var f = parent.$.modalDialog.handler.find('#tblSclEditForm');
                f.submit();
            }
        } ]
    });
}
/**
 * 删除
 */
 function tblSclDeleteFun(id) {
     if (id == undefined) {//点击右键菜单才会触发这个
         var rows = tblSclDataGrid.datagrid('getSelections');
         id = rows[0].id;
     } else {//点击操作里面的删除图标会触发这个
         tblSclDataGrid.datagrid('unselectAll').datagrid('uncheckAll');
     }
     parent.$.messager.confirm('询问', '您是否要删除当前题目？', function(b) {
         if (b) {
             progressLoad();
             $.post('${path}/tblScl/delete', {
                 id : id
             }, function(result) {
                 if (result.success) {
                     parent.$.messager.alert('提示', result.msg, 'info');
                     tblSclDataGrid.datagrid('reload');
                 }
                 progressClose();
             }, 'JSON');
         }
     });
}


/**
 * 清除
 */
function tblSclCleanFun() {
    $('#tblSclSearchForm input').val('');
    tblSclDataGrid.datagrid('load', {});
}
/**
 * 搜索
 */
function tblSclSearchFun() {
     tblSclDataGrid.datagrid('load', $.serializeObject($('#tblSclSearchForm')));
}
/**
 * 搜索
 */
 $(function(){
 	/* ajax调用user，下拉 */
    	$('#selectItemId').combobox({    
		    url:'${path }/tblScl/selectTblSclType',    
		    method:'post',
		    panelHeight : '100px',
		    valueField:'id',    
		    textField:'typeName'   
		});  
 });
</script>

<div class="easyui-layout" data-options="fit:true,border:false">
    <div data-options="region:'north',border:false" style="height: 30px; overflow: hidden;background-color: #fff">
        <form id="tblSclSearchForm">
            <table>
                <tr>
                    <th>类型名称:</th>
                    <td><input name="typeId" type="text" id="selectItemId" placeholder="搜索条件"/></td>
                     <th>题目:</th>
                    <td><input type="text" name="item"></td>
                    <td> 
                        <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'fi-magnifying-glass',plain:true" onclick="tblSclSearchFun();">查询</a>
                        <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'fi-x-circle',plain:true" onclick="tblSclCleanFun();">清空</a>
                    </td>
                </tr>
            </table>
        </form>
     </div>
 
    <div data-options="region:'center',border:true" >
        <table id="tblSclDataGrid" data-options="fit:true,border:false" ></table>
    </div>
    
</div>
<div id="tblSclToolbar" style="display: none;">
    <shiro:hasPermission name="/tblScl/add">
        <a onclick="tblSclAddFun();" href="javascript:void(0);" class="easyui-linkbutton" data-options="plain:true,iconCls:'fi-plus'">添加</a>
    </shiro:hasPermission>
</div>