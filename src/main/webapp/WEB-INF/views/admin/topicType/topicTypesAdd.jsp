<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/global.jsp" %>
<script type="text/javascript">
    $(function() {
    	/* 表单提交 */
       $('#topicTypesAddForm').form({
            url : '${path}/topicTypes/add',
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
                    var form = $('#topicTypesAddForm');
                    parent.$.messager.alert('错误', eval(result.msg), 'error');
                }
            }
        });
    });  
</script>
<div class="easyui-layout" data-options="fit:true,border:false" >
    <div data-options="region:'center',border:false" style="overflow: hidden;padding: 3px;" >
        <form id="topicTypesAddForm" method="post">
            <table class="grid">
<%--            	<tr>--%>
<%--                    <td>阶段</td>--%>
<%--                    <td>--%>
<%--                    	<select name="stage"  style="height:25px;width:100px;">   --%>
<%--						    <option value="S1">S1</option>   --%>
<%--						    <option value="S2">S2</option>  --%>
<%--						    <option value="S3">S3</option>   --%>
<%--						</select>--%>
<%--                    </td>--%>
<%--                </tr>--%>
                <tr>
                    <td>名称</td>
                    <td>
                    	<input name="typename"  class="easyui-validatebox span2" data-options="required:true" style="width:150px;height:20px;" />
                    </td>
                </tr> 
            </table>
        </form>
    </div>
</div>
