<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/global.jsp" %>
<script type="text/javascript">
	var projectAddTeacher;
	var projectAddStudent;
	var projectAddClass;
    $(function() {
    	//给项目添加班级
    	/*  projectAddClass=$('#projectAddClass').combotree({
            url: '${path }/tblClass/treeForProject?orgid=4',
            multiple: true,
            lines : true,
            panelHeight : 'auto'
        }); */
    	//添加给项目添加指导老师
     	projectAddTeacher=$('#projectAddTeacher').combotree({
            url: '${path }/user/tree',
            multiple: true,
            lines : true,
            panelHeight : 'auto'
        });
        //给项目添加学生组员
        projectAddStudent=$('#projectAddStudent').combotree({
            url: '${path }/student/tree?classid=10000',
            multiple: true,
            lines : true,
            panelHeight : 'auto'
        });
        $('#tblProjectAddForm').form({
            url : '${path}/tblProject/add',
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
                    parent.$.modalDialog.openner_dataGrid.datagrid('reload');
                    parent.$.modalDialog.handler.dialog('close');
                } else {
                    var form = $('#tblProjectAddForm');
                    parent.$.messager.alert('错误', eval(result.msg), 'error');
                }
            }
        });
    });
</script>
<div class="easyui-layout" data-options="fit:true,border:false" >
    <div data-options="region:'center',border:false" style="overflow: hidden;padding: 3px;" >
        <form id="tblProjectAddForm" method="post">
            <table class="grid">
                <tr>
                    <td>项目名称</td>
                    <td colspan="3">
                    	<input name="projectname" type="text" placeholder="请输入名称" class="easyui-validatebox span2" data-options="required:true" value="">
                    </td>
	                <td>班级</td>
	                <td colspan="3">
	                	<select id="projectAddClass" name="classid"style="width: 200px; height: 29px;"></select>
	                	<a class="easyui-linkbutton" href="javascript:void(0)" onclick="$('#projectAddClass').combotree('clear');" >清空</a>
	                </td>
                </tr> 
                <tr>
	              	<td>指导老师</td>
	                <td colspan="3">
	                    <select id="projectAddTeacher" name="teacher" style="width: 200px; height: 29px;"></select>
	                    <a class="easyui-linkbutton" href="javascript:void(0)" onclick="$('#projectAddTeacher').combotree('clear');" >清空</a>
	                </td>
	                <td>组员</td>
                    <td colspan="3">
                    	<select id="projectAddStudent" name="stuid" style="width: 200px; height: 29px;"></select>
                    	<a class="easyui-linkbutton" href="javascript:void(0)" onclick="$('#projectAddStudent').combotree('clear');" >清空</a>
                    </td>
             	</tr>
            </table>
        </form>
    </div>
</div>