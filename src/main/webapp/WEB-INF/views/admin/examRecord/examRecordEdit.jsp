<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/global.jsp" %>
<script type="text/javascript">
    $(function() {
    	/* 表单提交 */
       $('#examRecordEditForm').form({
            url : '${path}/examRecord/edit',
            onSubmit : function() {
            },
            success : function(result) {
                progressClose();
                result = $.parseJSON(result);
                if (result.success) {
                	$.messager.show({title:'提示',msg:result.msg});
                    //之所以能在这里调用到parent.$.modalDialog.openner_dataGrid这个对象，是因为user.jsp页面预定义好了
                	 parent.$("#addForm").dialog.openner_dataGrid.datagrid('reload');
                     parent.$("#addForm").dialog('close');
                } else {
                    var form = $('#examRecordEditForm');
                    parent.$("#addForm").dialog.alert('错误', eval(result.msg), 'error');
                }
            }
        });
    	$("#state").val("${examRecord.state}");
    });  
</script>
<div class="easyui-layout" data-options="fit:true,border:false" >
    <div data-options="region:'center',border:false" style="overflow: hidden;padding: 3px;" >
        <form id="examRecordEditForm" method="post">
        	<input type="hidden" name="id" value="${examRecord.id}"/>
            <table class="grid">
            	<tr>
            		<td>试卷状态</td>
            		<td>
            			<select id="state" name="state" class="easyui-combobox" data-options="width:140,height:29,editable:false,panelHeight:'auto'">
                        	<option value="0">考试中</option>
                        	<option value="1">考试结束</option>
                    	</select>
            		</td>
            	</tr>
            </table>
        </form>
    </div>
</div>
