<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/global.jsp" %>
<script type="text/javascript">
    var studentReturnRecordEvaDataGrid;
    $(function() {
    	studentReturnRecordEvaDataGrid = $('#studentReturnRecordEvaDataGrid').datagrid({
        url : '${path}/returnRecordEva/returnRecordDataGrid?dateTime=${dateTime}',
        striped : true,
        rownumbers : true,
        pagination : true,
        fitColumns:true,
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
        	width : '350',
            title : '回访记录',
            field : 'returncontent'
        },{
            width : '40',
            title : '创建时间',
            field : 'returntime',
            sortable : true
        } ] ]
    });
   
});

    /**
     * 清除
     */
    function returnRecordCleanFun() {
        $('#returnRecordSearchForm input').val('');
        studentReturnRecordEvaDataGrid.datagrid('load', {});
    }
    /**
     * 搜索
     */
    function returnRecordSearchFun() {
    	studentReturnRecordEvaDataGrid.datagrid('load', $.serializeObject($('#returnRecordSearchForm')));
    }

</script>

<div class="easyui-layout" data-options="fit:true,border:false">
     <div data-options="region:'north',border:false" style="height: 30px; overflow: hidden;background-color: #fff">
        <form id="returnRecordSearchForm">
        	<table>
                <tr>
                    <th>学生姓名:</th>
                    <td>
                    	<input name="stuname" placeholder="请输入学生姓名"/>
                    </td>
                    <th>回访人:</th>
                    <td><input name="username" placeholder="请输入回访人姓名"/></td>
                    <td>
                        <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'fi-magnifying-glass',plain:true" onclick="returnRecordSearchFun();">查询</a>
                        <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'fi-x-circle',plain:true" onclick="returnRecordCleanFun();">清空</a>
                    </td>
                </tr>
            </table>
        </form>
     </div> 
    <div data-options="region:'center',border:true">
        <table id="studentReturnRecordEvaDataGrid" data-options="fit:true,border:false"></table>
    </div>
</div>
