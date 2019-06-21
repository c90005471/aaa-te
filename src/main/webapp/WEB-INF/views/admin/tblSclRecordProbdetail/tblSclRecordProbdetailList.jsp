<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/global.jsp" %>
<script type="text/javascript">
    var tblSclRecordProbdetailDataGrid;
    $(function() {
        tblSclRecordProbdetailDataGrid = $('#tblSclRecordProbdetailDataGrid').datagrid({
        url : '${path}/tblSclRecordProbdetail/dataGrid?studentid=${studentid}&createtime=${createtime}',
        striped : true,
        rownumbers : true,
        pagination : true, 
        singleSelect : true,
        idField : 'id',
        sortName : 'id',
        sortOrder : 'asc',
        pageSize : 100,
        pageList : [ 100, 200, 300, 400, 500],
        columns : [ [ {
            width : '60',
            title : '编号',
            field : 'id',
            sortable : true
        }, {
            width : '60',
            title : '学号',
            field : 'stuno'
        }, {
            width : '60',
            title : '学生姓名',
            field : 'stuname'
        }, {
            width : '140',
            title : '题目内容',
            field : 'item'
        }, {
            width : '100',
            title : '得分',
            field : 'scoreDetail'
        } ] ],
    });
});

</script>
<div class="easyui-layout" data-options="fit:true,border:false">
    <div data-options="region:'center',border:false">
        <table id="tblSclRecordProbdetailDataGrid" data-options="fit:true,border:false"></table>
    </div>
</div>