<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/global.jsp" %>
<script type="text/javascript">
    $(function() {
        $('#teacherQuestionAddForm').form({
            url : '${path }/teacherQuestion/add',
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
                    var form = $('#teacherQuestionAddForm');
                    parent.$.messager.alert('提示', eval(result.msg), 'warning');
                }
            }
        });
        
        //教师考评点角色
        $('#questionAddRoleIds').combotree({
            url: '${path }/role/tree',
            multiple: true,
            required: true,
            panelHeight : 'auto'
        });
        
    });
</script>
<div class="easyui-layout" data-options="fit:true,border:false">
    <div data-options="region:'center',border:false" title="" style="overflow: hidden;padding: 3px;">
        <form id="teacherQuestionAddForm" method="post">
            <table class="grid">
                <tr>
                    <td>教师考核点</td>
                    <td><input name="questionname" style="width:300px;height:200px;" type="text" placeholder="请输入考核点" class="easyui-textbox" data-options="multiline:true" value=""/></td>
                </tr>
                <tr>
                	<td>教师角色</td>
                    <td><select id="questionAddRoleIds" name="roleIds" style="width: 140px; height: 29px;"></select></td>
                </tr>
            </table>
        </form>
    </div>
</div>