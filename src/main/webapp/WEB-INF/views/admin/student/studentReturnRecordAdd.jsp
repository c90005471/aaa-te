<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/global.jsp" %>
<script type="text/javascript">
    $(function() {
        $('#studentReturnCordAddForm').form({
            url : '${path}/student/studentReturnCordAdd',
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
                    var form = $('#studentReturnCordAddForm');
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
        //设置当前时间
        var curr_time=new Date();     
        var strDate=curr_time.getFullYear()+"-";     
        strDate +=curr_time.getMonth()+1+"-";     
        strDate +=curr_time.getDate()+"-";     
        strDate +=" "+curr_time.getHours()+":";     
        strDate +=curr_time.getMinutes()+":";     
        strDate +=curr_time.getSeconds();     
        $("#dd").datetimebox("setValue",strDate);  
	});
</script>
<div class="easyui-layout" data-options="fit:true,border:false" >
    <div data-options="region:'center',border:false" style="overflow: hidden;padding: 3px;" >
        <form id="studentReturnCordAddForm" method="post">
        	<input type="hidden" name="studentId" value="${studentId}"/>
            <table class="grid">
             <tr>
                <td>回访人</td>
                <td>
                	<input id="userId" name="userId" value="${userId}" type="hidden"/>${userName}
                </td>
            </tr>
             <tr>
                <td>回访记录</td>
                <td>
                	<textarea name="returncontent" style="width:400px;height:90px;resize:none;" class="easyui-validatebox span2" data-options="required:true"></textarea>
                </td>
            </tr>
            <tr>
                <td>回访时间</td>
                <td>
                	<input name="returntime" id="dd" type="text" placeholder="请输入时间" style="height:25px;width:200px;" data-options="required:true" >
                </td>
            </tr>
            </table>
        </form>
    </div>
</div>