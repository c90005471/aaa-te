<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/global.jsp" %>
<script type="text/javascript">
    $(function() {
			
		$('#tblSclEditTypeIds').combobox({    
		    url:'${path }/tblScl/selectTblSclType',    
		    method:'post',
		    panelHeight : '100px',
		    valueField:'id',    
		    textField:'typeName'   
		});   
    
        $('#tblSclEditForm').form({
            url : '${path}/tblScl/edit',
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
                	$.messager.alert('温馨提示','编辑成功！');
                    parent.$.modalDialog.openner_dataGrid.datagrid('reload');//之所以能在这里调用到parent.$.modalDialog.openner_dataGrid这个对象，是因为user.jsp页面预定义好了
                    parent.$.modalDialog.handler.dialog('close');
                } else {
                    var form = $('#tblSclEditForm');
                    parent.$.messager.alert('错误', eval(result.msg), 'error');
                }
            }
        });
        
    });
</script>
<div class="easyui-layout" data-options="fit:true,border:false">
    <div data-options="region:'center',border:false" title="" style="overflow: hidden;padding: 3px;">
        <form id="tblSclEditForm" method="post">
            <table class="grid">
                <tr>
					<input type="hidden" name="id" value="${tblScl.id}"/>
                    <td>测试题</td>
                    <td><input name="item" style="width:300px;height:100px;" type="text" placeholder="请输入考核点" class="easyui-textbox" data-options="multiline:true" value="${tblScl.item }"/></td>
                </tr>
                <tr>
                    <td>测试题类型</td>
                    <td><input id="tblSclEditTypeIds" name="typeId" style="width:300px;height:25px;" type="text" placeholder="请输入考核点" editable="false" class="easyui-textbox"  data-options="multiline:true" value="${tblScl.typeId }"/></td>
                </tr>
            </table>
        </form>
    </div>
</div>