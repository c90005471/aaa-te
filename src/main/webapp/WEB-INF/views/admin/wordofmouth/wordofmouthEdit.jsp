<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/global.jsp" %>
<script type="text/javascript">
    $(function() {
        $('#wordofmouthEditForm').form({
            url : '${path}/wordofmouth/edit',
            onSubmit : function() {
                progressLoad();
                var isValid = $(this).form('validate');
                if (!isValid) {
                    progressClose();
                }
                return isValid;
            },
            success : function(result) {
                progressClose();
                result = $.parseJSON(result);
                if (result.success) {
                    parent.$.modalDialog.openner_dataGrid.datagrid('reload');//之所以能在这里调用到parent.$.modalDialog.openner_dataGrid这个对象，是因为user.jsp页面预定义好了
                    parent.$.modalDialog.handler.dialog('close');
                } else {
                    var form = $('#wordofmouthEditForm');
                    parent.$.messager.alert('错误', result.msg, 'error');
                }
            }
        });
        
        $("#statusId").val("${word.status}");
        
    });
</script>
<div class="easyui-layout" data-options="fit:true,border:false">
    <div data-options="region:'center',border:false" title="" style="overflow: hidden;padding: 3px;">
        <form id="wordofmouthEditForm" method="post">
             <table class="grid">
             <tr>
                <td>口碑姓名</td>
                <input name="id" value="${word.id}" type="hidden"  >
                <td><input name="stuname" value="${word.stuname}" type="text" placeholder="请输入口碑姓名" class="easyui-validatebox span2" data-options="required:true" ></td>
                <td>口碑手机号</td>
                <td>
                <input name="stuphone" value="${word.stuphone}" type="text" placeholder="请输入口碑手机号" class="easyui-validatebox span2" data-options="required:true" >
                </td>
            </tr>
            <tr>
                <td>口碑状态</td>
                <td colspan="3">
                	<select id="statusId" name="status" class="easyui-combobox" data-options="width:140,height:29,editable:false,panelHeight:'auto'">
                        <c:forEach items="${wordstatusmap}" var="map">
                        	<option value="${map.key}">${map.value}</option>
                        </c:forEach>
                    </select>
                </td>
           	</tr>
             <tr>
                <td>报备人姓名</td>
                <td><input name="teaname" value="${word.teaname}" type="text" placeholder="请输入报备人姓名" class="easyui-validatebox span2" data-options="required:true" ></td>
                <td>报备人手机号</td>
                <td>
                <input name="teaphone" value="${word.teaphone}" type="text" placeholder="请输入报备人手机号" class="easyui-validatebox span2" data-options="required:true">
                </td>
            </tr>
            <tr>
                <td>备注</td>
                <td colspan="3">
                	<textarea name="remark" style="width:400px;height:70px;resize:none;" class="easyui-validatebox span2">${word.remark}</textarea>
                </td>
           	</tr>

            </table>
        </form>
    </div>
</div>