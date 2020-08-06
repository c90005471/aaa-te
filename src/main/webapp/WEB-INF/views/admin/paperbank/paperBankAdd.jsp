<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/global.jsp" %>
<script type="text/javascript">
    $(function() {
    	/* 表单提交 */
       $('#paperAddForm').form({
            url : '${path}/paperBank/add',
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
                    parent.$.messager.alert('错误', eval(result.msg), 'error');
                }
            }
        });
    });  
</script>
<div class="easyui-layout" data-options="fit:true,border:false" >
    <div data-options="region:'center',border:false" style="overflow: hidden;padding: 3px;" >
        <form id="paperAddForm" method="post">
            <table class="grid">
                <tr>
                    <td>试卷名称</td>
                    <td>
                        <input name="papername"  type="text" class="easyui-validatebox span2" data-options="required:true" style="width:200px;height:20px;" />
                        <input name="isparent"  type="hidden" value="1"/>
                    </td>
                </tr>

            </table>
        </form>
    </div>
</div>
