<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/global.jsp" %>
<script type="text/javascript">
    var testQuesRecordDataGrid;
    
    $(function() {
    	testQuesRecordDataGrid = $('#testQuesRecordDataGrid').datagrid({
        url : '${path}/testQuesRecord/dataGrid',
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
            width : '160',
            title : '姓名',
            field : 'stuname',
            sortable : true,
            
        }, {
            width : '160',
            title : '电话',
            field : 'stuphone',
            sortable : true,
            
        },{
            width : '160',
            title : '成绩',
            field : 'stuscore',
            sortable : true,
            
        },{
            width : '140',
            title : '类型编号',
            field : 'questype',
            sortable : true
        }, {
            width : '160',
            title : '测试时间',
            field : 'createtime',
            sortable : true,
            
        }] ]
    });
});


/**
 * 清除
 */
function testQuesRecordCleanFun() {
    $('#testQuesRecordSearchForm input').val('');
    testQuesRecordDataGrid.datagrid('load', {});
}
/**
 * 搜索
 */
function testQuesRecordSearchFun() {
	testQuesRecordDataGrid.datagrid('load', $.serializeObject($('#testQuesRecordSearchForm')));
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
        <form id="testQuesRecordSearchForm">
            <table>
                <tr>
                     <th>姓名:</th>
                    <td><input type="text" name="stuname"></td>
                    <th>电话:</th>
                    <td><input type="text" name="stuphone"></td>
                    <td> 
                        <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'fi-magnifying-glass',plain:true" onclick="testQuesRecordSearchFun();">查询</a>
                        <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'fi-x-circle',plain:true" onclick="testQuesRecordCleanFun();">清空</a>
                    </td>
                </tr>
            </table>
        </form>
     </div>
 
    <div data-options="region:'center',border:true" >
        <table id="testQuesRecordDataGrid" data-options="fit:true,border:false" ></table>
    </div>
    
</div>
