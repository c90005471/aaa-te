<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="/commons/global.jsp"%>
<script type="text/javascript">
	$(function() {
		
		//编辑学生
		$('#teacherQuestionEditForm').form({
			url : '${path }/teacherQuestion/edit',
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
					var form = $('#teacherQuestionEditForm');
					parent.$.messager.alert('错误', eval(result.msg), 'error');
				}
			}
		});
		
		$('#questionAddRoleIds').combotree({
            url : '${path }/role/tree',
            parentField : 'pid',
            lines : true,
            panelHeight : 'auto',
            multiple : true,
            required : true,
            cascadeCheck : false,
            value : ${roleIds}
        });
	});
</script>
<div class="easyui-layout" data-options="fit:true,border:false">
	<div data-options="region:'center',border:false" title=""
		style="overflow: hidden;padding: 3px;">
		<form id="teacherQuestionEditForm" method="post">
			<table class="grid">
				<tr>
					<input type="hidden" name="id" value="${QuestionVo.id}"/>
                    <td>教师考核点</td>
                    <td><input name="questionname" style="width:300px;height:200px;" type="text" placeholder="请输入考核点" class="easyui-textbox" data-options="multiline:true" value="${QuestionVo.questionname }"/></td>
                </tr>
                <tr>
                	<td>教师角色</td>
                    <td><select id="questionAddRoleIds" name="roleIds" style="width: 140px; height: 29px;"></select></td>
                </tr>
			</table>
		</form>
	</div>
</div>