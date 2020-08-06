<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/global.jsp" %>
<script type="text/javascript">
    $(function() {
    	/* 表单提交 */
       $('#topicInfoEditForm').form({
            url : '${path}/paperBank/edit',
            onSubmit : function() {
            },
            success : function(result) {
                progressClose();
                result = $.parseJSON(result);
                if (result.success) {
                	$.messager.show({title:'提示',msg:result.msg});
                    //之所以能在这里调用到parent.$.modalDialog.openner_dataGrid这个对象，是因为user.jsp页面预定义好了
                    parent.$.modalDialog.openner_dataGrid.datagrid('reload');
                    parent.$.modalDialog.handler.dialog('close');
                } else {
                    var form = $('#topicInfoEditForm');
                    parent.$.messager.alert('错误', eval(result.msg), 'error');
                }
            }
        });
    	
    	var papers=${optionList};
    	console.log(papers[0].papername);
    	$("#bankpaperid").val(papers[0].id);
    	$("#bankpapername").val(papers[0].papername);

    });  
</script>
<div class="easyui-layout" data-options="fit:true,border:false" >
    <div data-options="region:'center',border:false" style="overflow: hidden;padding: 3px;" >
        <form id="topicInfoEditForm" method="post">
        	<input type="hidden" id="bankpaperid" name="id" value=""/>
            <table class="grid">
                <tr>
                    <td>试卷名称</td>
                    <td>
                    	<input name="papername" id="bankpapername" class="easyui-validatebox span2" style="width:150px;height:20px;" data-options="required:true" value=""/>
                    </td>
                </tr>
            </table>
        </form>
    </div>
</div>
