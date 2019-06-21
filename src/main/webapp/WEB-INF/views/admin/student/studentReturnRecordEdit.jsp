<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/global.jsp" %>
<script type="text/javascript">
    $(function() {
        $('#studentReturnCordEditForm').form({
            url : '${path}/student/studentReturnCordEdit',
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
                    //之所以能在这里调用到parent.$.modalDialog.openner_dataGrid这个对象，是因为user.jsp页面预定义好了
                    $('#dialogpage').dialog.openner_dataGrid.datagrid('reload');
                    $('#dialogpage').dialog('close');
                } else {
                    var form = $('#studentReturnCordEditForm');
                    $('#dialogpage').dialog.messager.alert('错误', eval(result.msg), 'error');
                }
            }
        });
        
        $('#dd').datetimebox().datetimebox('calendar').calendar({
			validator: function(date){
				var now = new Date();
				var d1 = new Date(now.getFullYear(), now.getMonth(), now.getDate());
				var d2 = new Date(now.getFullYear(), now.getMonth(), now.getDate()+10);
				return d1<=date && date<=d2;
				}
			});
	});
</script>
<div class="easyui-layout" data-options="fit:true,border:false" >
    <div data-options="region:'center',border:false" style="overflow: hidden;padding: 3px;" >
        <form id="studentReturnCordEditForm" method="post">
        	<input name="id" type="hidden" value="${returnrecord.id}"/>
        	<input name="studentId" type="hidden" value="${returnrecord.studentId}"/>
            <table class="grid">
             <tr>
                <td>回访人</td>
                <td>
                	<input id="userId" name="userId" type="hidden" value="${userId}"/>${userName}
                </td>
            </tr>
             <tr>
                <td>回访记录</td>
                <td>
                	<textarea name="returncontent" style="width:400px;height:90px;resize:none;" class="easyui-validatebox span2" data-options="required:true">${returnrecord.returncontent}</textarea>
                </td>
            </tr>
            <tr>
                <td>回访时间</td>
                <td>
                	<input name="returntime" id="dd" type="text" placeholder="请输入时间" style="height:25px;width:200px;" data-options="required:true" value="<fmt:formatDate value="${returnrecord.returntime}" pattern="yyyy-MM-dd HH:mm:ss"/>">
                </td>
            </tr>
            </table>
        </form>
    </div>
</div>