<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/global.jsp" %>
<script type="text/javascript">
	var examRecordDataGrid;
    $(function() {
    	examRecordDataGrid = $('#examRecordDataGrid').datagrid({
            url : '${path}/examRecord/dataGrid?paperId=${paperId}',
            fit : true,
            striped : true,
            rownumbers : true,
            pagination : true,
            singleSelect : true,
            idField : 'id',
            sortName : 'id',
            sortOrder : 'asc',
            pageSize : 20,
            pageList : [ 10, 20, 30, 40, 50, 100],
            columns : [ [ {
                width : '60',
                title : '编号',
                field : 'id',
                sortable : true
            },{
                width : '150',
                title : '学号',
                field : 'stuno',
                sortable : true,
                
            },{
                width : '150',
                title : '姓名',
                field : 'stuname',
                sortable : true,
                
            },{
                width : '80',
                title : '成绩',
                field : 'score'
                
            },{
                width : '60',
                title : '状态',
                field : 'state',
                formatter : function(value, row, index) {
                	switch (value) {
                    case 0:
                        return '考试中';
                    case 1:
                        return '考试结束';
                    }
                	
                }
            }, {
                field : 'action',
                title : '操作',
                width : 120,
                formatter : function(value, row, index) {
                    var str = '';
                    <shiro:hasPermission name="/examRecord/edit">
                    	str += $.formatString('<a href="javascript:void(0)" class="examRecord-easyui-linkbutton-edit" data-options="plain:true,iconCls:\'fi-pencil icon-blue\'" onclick="examRecordEditFun(\'{0}\');" >编辑</a>', row.id);
                	</shiro:hasPermission>
                    return str;
                }
            } ] ],
            onLoadSuccess:function(data){
                $('.examRecord-easyui-linkbutton-edit').linkbutton({text:'编辑'});
            },
            toolbar : '#examRecordToolbar'
        });
    });
    
    /**
     * 编辑
     */
    function examRecordEditFun(id) {
        if (id == undefined) {
            var rows = examRecordDataGrid.datagrid('getSelections');
            id = rows[0].id;
        } else {
        	examRecordDataGrid.datagrid('unselectAll').datagrid('uncheckAll');
        }
        $("#addForm").dialog({
            title : '编辑',
            width : 300,
            height : 140,
            href :  '${path}/examRecord/editPage?id=' + id,
            buttons : [ {
                text : '确定',
                handler : function() {
                    $("#addForm").dialog.openner_dataGrid = examRecordDataGrid;//因为添加成功之后，需要刷新这个dataGrid，所以先预定义好
                    var f = $("#examRecordEditForm");
                    f.submit();
                }
            } ]
        });
    }
    function exportExcelExamRecord(){
    	var len = examRecordDataGrid.datagrid("getData").total;
    	if(len==0){
            parent.$.messager.alert('警告', '暂无记录！');
        }else{
    	    $("#export").attr('href','${path}/examRecord/exportExamRecordByExcel?paperId=${paperId}');
    	}
    }
</script>
<div id="addForm"></div>
<div class="easyui-layout" data-options="fit:true,border:false">
    <div data-options="region:'center',border:false" title="" style="overflow: hidden;padding: 3px;">
        <table id="examRecordDataGrid" data-options="fit:true,border:false"></table>
    </div>
</div>
<div id="examRecordToolbar" style="display: none;">
    <a onclick="exportExcelExamRecord();" id="export" href="javascript:void(0);"   class="easyui-linkbutton" data-options="plain:true,iconCls:'fi-download icon-green'">导出excel</a>
</div>