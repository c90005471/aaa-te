<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/global.jsp" %>
<script type="text/javascript">
    var testQuesDataGrid;
    
    $(function() {
    	testQuesDataGrid = $('#testQuesDataGrid').datagrid({
        url : '${path}/testQues/dataGrid',
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
        },{
            width : '80',
            title : '题目类型',
            field : 'questype',
            sortable : true
        },{
            width : '560',
            title : '题目',
            field : 'quesname',
            sortable : true,
            
        },{
            width : '80',
            title : '试题类型',
            field : 'type',
            sortable : true,
            formatter : function(value, row, index) {
            	switch (value) {
                case 0:
                    return '单选题';
                case 1:
                    return '多选题';
                }
            }
            
        }, {
            field : 'action',
            title : '操作',
            width : 200,
            formatter : function(value, row, index) {
                var str = '';
                <shiro:hasPermission name="/testQues/edit">
                    str += $.formatString('<a href="javascript:void(0)" class="testQues-easyui-linkbutton-edit" data-options="plain:true,iconCls:\'fi-pencil icon-blue\'" onclick="testQuesEditFun(\'{0}\');" >编辑</a>', row.id);
                </shiro:hasPermission>
                <shiro:hasPermission name="/testQues/delete">
                    str += '&nbsp;&nbsp;|&nbsp;&nbsp;';
                    str += $.formatString('<a href="javascript:void(0)" class="testQues-easyui-linkbutton-del" data-options="plain:true,iconCls:\'fi-x icon-red\'" onclick="testQuesDeleteFun(\'{0}\');" >删除</a>', row.id);
                </shiro:hasPermission>
                return str;
            }
        } ] ],
        onLoadSuccess:function(data){
            $('.testQues-easyui-linkbutton-edit').linkbutton({text:'编辑'});
            $('.testQues-easyui-linkbutton-del').linkbutton({text:'删除'});
        },
        toolbar : '#testQuesToolbar'
    });
});

/**
 * 添加框
 * @param url
 */
function testQuesAddFun() {
    parent.$.modalDialog({
        title : '添加',
        width : 550,
        height : 520,
        href : '${path}/testQues/addPage',
        buttons : [ {
            text : '确定',
            handler : function() {
                parent.$.modalDialog.openner_dataGrid = testQuesDataGrid;//因为添加成功之后，需要刷新这个treeGrid，所以先预定义好
                var f = parent.$.modalDialog.handler.find('#testQuesAddForm');
                f.submit();
            }
        } ]
    });
}


/**
 * 编辑
 */
function testQuesEditFun(id) {
    if (id == undefined) {
        var rows = testQuesDataGrid.datagrid('getSelections');
        id = rows[0].id;
    } else {
    	testQuesDataGrid.datagrid('unselectAll').datagrid('uncheckAll');
    }
    parent.$.modalDialog({
        title : '编辑',
        width : 550,
        height : 520,
        href :  '${path}/testQues/editPage?id=' + id,
        buttons : [ {
            text : '确定',
            handler : function() {
                parent.$.modalDialog.openner_dataGrid = testQuesDataGrid;//因为添加成功之后，需要刷新这个dataGrid，所以先预定义好
                var f = parent.$.modalDialog.handler.find('#testQuesEditForm');
                f.submit();
            }
        } ]
    });
}
/**
 * 删除
 */
 function testQuesDeleteFun(id) {
     if (id == undefined) {//点击右键菜单才会触发这个
         var rows = testQuesDataGrid.datagrid('getSelections');
         id = rows[0].id;
     } else {//点击操作里面的删除图标会触发这个
    	 testQuesDataGrid.datagrid('unselectAll').datagrid('uncheckAll');
     }
     parent.$.messager.confirm('询问', '您是否要删除当前题目？', function(b) {
         if (b) {
             progressLoad();
             $.post('${path}/testQues/delete', {
                 id : id
             }, function(result) {
                 if (result.success) {
                     parent.$.messager.alert('提示', result.msg, 'info');
                     testQuesDataGrid.datagrid('reload');
                 }
                 progressClose();
             }, 'JSON');
         }
     });
}


/**
 * 清除
 */
function testQuesCleanFun() {
    $('#testQuesSearchForm input').val('');
    testQuesDataGrid.datagrid('load', {});
}
/**
 * 搜索
 */
function testQuesSearchFun() {
	testQuesDataGrid.datagrid('load', $.serializeObject($('#testQuesSearchForm')));
}
/**
 * 搜索
 */
 $(function(){
 	/* ajax调用user，下拉 */
    /*	$('#selectItemId').combobox({    
		    url:'${path }/testQues/selecttestQuesType',    
		    method:'post',
		    panelHeight : '100px',
		    valueField:'id',    
		    textField:'typeName'   
		}); */ 
 });
</script>

<div class="easyui-layout" data-options="fit:true,border:false">
    <div data-options="region:'north',border:false" style="height: 30px; overflow: hidden;background-color: #fff">
        <form id="testQuesSearchForm">
            <table>
                <tr>
                    <th>类型:</th>
                    <td>
                    <select name="questype" style="width:100px;height:20px;">
                    		<option value="">请选择</option>
                    		<c:forEach items="${typeMap}" var="map">
                    			<option value="${map.key}">${map.value}</option>
                    		</c:forEach>
                    </select>
                    </td>
                     <th>题目:</th>
                    <td><input type="text" name="quesname"></td>
                    <td> 
                        <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'fi-magnifying-glass',plain:true" onclick="testQuesSearchFun();">查询</a>
                        <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'fi-x-circle',plain:true" onclick="testQuesCleanFun();">清空</a>
                    </td>
                </tr>
            </table>
        </form>
     </div>
 
    <div data-options="region:'center',border:true" >
        <table id="testQuesDataGrid" data-options="fit:true,border:false" ></table>
    </div>
    
</div>
<div id="testQuesToolbar" style="display: none;">
    <shiro:hasPermission name="/tblScl/add">
        <a onclick="testQuesAddFun();" href="javascript:void(0);" class="easyui-linkbutton" data-options="plain:true,iconCls:'fi-plus'">添加</a>
    </shiro:hasPermission>
</div>