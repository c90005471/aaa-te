<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/global.jsp" %>
<script type="text/javascript">
    $(function() {
    	/**
    	 * 获取该班级的老师
    	 */
    	$('#userid').combotree({
            url : '${path}/teacherPlan/teacher?classid=${classid}',
            parentField : 'pid',
            lines : true,
            panelHeight : 'auto'
        }); 
    	/**
    	 * 清除
    	 */
    	function clearFun() {
    		$('#userid input').val('');
    		$('#userid').combotree('load', {});
    	}
        $('#tblSclRecordProbdetailAddForm').form({
            url : '${path}/tblSclRecordProbdetail/add',
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
                    parent.$("#addForm").dialog.openner_dataGrid.datagrid('reload');
                    parent.$("#addForm").dialog('close');
                } else {
                    var form = $('#tblSclRecordProbdetail');
                    parent.$("#addForm").dialog.alert('错误', eval(result.msg), 'error');
                }
            }
        });

	});
</script>
<div class="easyui-layout" data-options="fit:true,border:false" >
    <div data-options="region:'center',border:false" style="overflow: hidden;padding: 3px;" >
        <form id="tblSclRecordProbdetailAddForm" method="post">
            <table class="grid">
             <tr>
                <td>学生姓名</td>
                <td>${stuname}
                	<input type="hidden" name="studentid" value="${studentid}"/>
                </td>
            </tr>
            <tr>
            	<td>访谈老师</td>
            	<td>
                    <select id="userid" name="userid" style="width:150px; height:30px;"></select>
                    <a class="easyui-linkbutton" href="javascript:void(0)" id="clear" style="width:50px;" onclick="clearFun();">清空</a>
                </td>
            </tr>
             <tr>
                <td>访谈记录</td>
                <td>
                	<textarea name="record" style="height:40px;width:200px"></textarea>
                </td>
            </tr>
            </table>
        </form>
    </div>
</div>