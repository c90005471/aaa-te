<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/global.jsp" %>
<script type="text/javascript">
    var topicTypesDataGrid;
    $(function() {
    	topicTypesDataGrid = $('#topicTypesDataGrid').datagrid({
        url : '${path}/topicTypes/dataGrid',
        fit : true,
        striped : true,
        rownumbers : true,
        pagination : true,
        singleSelect : true,
        idField : 'id',
        sortName : 'id',
        sortOrder : 'asc',
        pageSize : 20,
        pageList : [ 10, 20, 30, 40],
        columns : [ [ {
            width : '60',
            title : '编号',
            field : 'id',
            sortable : true
        },{
            width : '560',
            title : '名称',
            field : 'typename',
            sortable : true,
            
        },{
            field : 'action',
            title : '操作',
            width : 200,
            formatter : function(value, row, index) {
                var str = '';
                <shiro:hasPermission name="/topicTypes/edit">
                    str += $.formatString('<a href="javascript:void(0)" class="topicTypes-easyui-linkbutton-edit" data-options="plain:true,iconCls:\'fi-pencil icon-blue\'" onclick="topicTypesEditFun(\'{0}\');" >编辑</a>', row.id);
                </shiro:hasPermission>
                <shiro:hasPermission name="/topicTypes/delete">
                    str += '&nbsp;&nbsp;|&nbsp;&nbsp;';
                    str += $.formatString('<a href="javascript:void(0)" class="topicTypes-easyui-linkbutton-del" data-options="plain:true,iconCls:\'fi-x icon-red\'" onclick="topicTypesDeleteFun(\'{0}\');" >删除</a>', row.id);
                </shiro:hasPermission>
                return str;
            }
        } ] ],
        onLoadSuccess:function(data){
            $('.topicTypes-easyui-linkbutton-edit').linkbutton({text:'编辑'});
            $('.topicTypes-easyui-linkbutton-del').linkbutton({text:'删除'});
        },
        toolbar : '#topicTypesToolbar'
    });
    	
    	
    	$("#stage").combobox({
   		   onSelect: function(param){
   			   topicTypesDataGrid.datagrid("load",{stage:param.value});
   			}
   		});
});

/**
 * 添加框
 * @param url
 */
function topicTypesAddFun() {
	parent.$.modalDialog({
        title : '添加',
        width : 350,
        height : 240,
        href : '${path}/topicTypes/addPage',
        buttons : [ {
            text : '确定',
            handler : function() {
                parent.$.modalDialog.openner_dataGrid = topicTypesDataGrid;//因为添加成功之后，需要刷新这个treeGrid，所以先预定义好
                var f = parent.$.modalDialog.handler.find('#topicTypesAddForm');
                f.submit();
            }
        } ]
    });
}


/**
 * 编辑
 */
function topicTypesEditFun(id) {
    if (id == undefined) {
        var rows = topicTypesDataGrid.datagrid('getSelections');
        id = rows[0].id;
    } else {
    	topicTypesDataGrid.datagrid('unselectAll').datagrid('uncheckAll');
    }
    parent.$.modalDialog({
        title : '编辑',
        width : 350,
        height : 240,
        href :  '${path}/topicTypes/editPage?id=' + id,
        buttons : [ {
            text : '确定',
            handler : function() {
                parent.$.modalDialog.openner_dataGrid = topicTypesDataGrid;//因为添加成功之后，需要刷新这个dataGrid，所以先预定义好
                var f = parent.$.modalDialog.handler.find('#topicTypesEditForm');
                f.submit();
            }
        } ]
    });
}
/**
 * 删除
 */
 function topicTypesDeleteFun(id) {
     if (id == undefined) {//点击右键菜单才会触发这个
         var rows = topicTypesDataGrid.datagrid('getSelections');
         id = rows[0].id;
     } else {//点击操作里面的删除图标会触发这个
    	 topicTypesDataGrid.datagrid('unselectAll').datagrid('uncheckAll');
     }
     parent.$.messager.confirm('询问', '您是否要删除当前类型？', function(b) {
         if (b) {
             progressLoad();
             $.post('${path}/topicTypes/delete', {
                 id : id
             }, function(result) {
                 if (result.success) {
                     parent.$.messager.alert('提示', result.msg, 'info');
                     topicTypesDataGrid.datagrid('reload');
                 }
                 progressClose();
             }, 'JSON');
         }
     });
}


/**
 * 清除
 */
function topicTypesCleanFun() {
    $('#topicTypesSearchForm input').val('');
    topicTypesDataGrid.datagrid('load', {});
}
/**
 * 搜索
 */
function topicTypesSearchFun() {
	topicTypesDataGrid.datagrid('load', $.serializeObject($('#topicTypesSearchForm')));
}
 
 
</script>

<div class="easyui-layout" data-options="fit:true,border:false">
    <div data-options="region:'north',border:false" style="height: 30px; overflow: hidden;background-color: #fff">
        <form id="topicTypesSearchForm">
            <table>
                <tr>
<%--                	<th>阶段</th>--%>
<%--            		<td>--%>
<%--            			<select id="stage" class="easyui-combobox" name="stage" data-options="panelHeight:70" style="height:25px;width:100px;">   --%>
<%--						    <option value="S1">S1</option>   --%>
<%--						    <option value="S2">S2</option>  --%>
<%--						    <option value="S3" selected="selected">S3</option>   --%>
<%--						</select>--%>
<%--            		</td>--%>
                     <th>名称:</th>
                    <td>
                    	<input type="text" name="typename">
                    </td>
                    <td> 
                        <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'fi-magnifying-glass',plain:true" onclick="topicTypesSearchFun();">查询</a>
                        <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'fi-x-circle',plain:true" onclick="topicTypesCleanFun();">清空</a>
                    </td>
                </tr>
            </table>
        </form>
     </div>
    <div data-options="region:'center',border:true" >
        <table id="topicTypesDataGrid" data-options="fit:true,border:false" ></table>
    </div>
</div>
<div id="topicTypesToolbar" style="display: none;">
    <shiro:hasPermission name="/topicTypes/add">
        <a onclick="topicTypesAddFun();" href="javascript:void(0);" class="easyui-linkbutton" data-options="plain:true,iconCls:'fi-plus'">添加</a>
    </shiro:hasPermission>
</div>