<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/global.jsp" %>
<script type="text/javascript">
    $(function() {
        $('#studentAddForm').form({
            url : '${path}/student/add?classId='+classidStudent,
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
                    var form = $('#studentAddForm');
                    parent.$.messager.alert('错误', eval(result.msg), 'error');
                }
            }
        });
        


		$('#degree').combobox({
			url : '${path }/student/getDegree',
			valueField : 'culture',		//隐藏框的value
			textField : 'culture',		//要显示的value
			onSelect : function(rec) {
			
			}
		});
		
		$('#major').combobox({
			url : '${path }/student/getMajor',
			valueField : 'name',
			textField : 'name',
			onSelect : function(rec) {
			
			}
		});

	});
</script>
<div class="easyui-layout" data-options="fit:true,border:false" >
    <div data-options="region:'center',border:false" style="overflow: hidden;padding: 3px;" >
        <form id="studentAddForm" method="post">
            <table class="grid">
             <tr>
                <td>学号</td>
                <td><input name="stuno" type="text" placeholder="请输入学号" class="easyui-validatebox span2" data-options="required:true" ></td>
                <td>姓名</td>
                <td>
                <input name="stuname" type="text" placeholder="请输入姓名" class="easyui-validatebox span2" data-options="required:true" >
                </td>
            </tr>
             <tr>
                <td>身份证号</td>
                <td><input name="idno" type="text" placeholder="请输入身份证号" class="easyui-validatebox span2" data-options="required:true" ></td>
                <td>手机号</td>
                <td>
                <input name="phone" type="text" class="easyui-validatebox span2">
                </td>
            </tr>
            <tr>
                <td>教育程度</td>
                <td><input id="degree" name="degree" type="text" class="easyui-combobox"></td>
           	</tr>
            <tr>
                <td>毕业院校</td>
                <td><input name="schoolname" type="text" placeholder="请输毕业院校" class="easyui-validatebox span2" data-options="required:true" ></td>
                <td>专业</td>
                <td>
                <input id="major" name="major" type="text" class="easyui-combobox">
                </td>
            </tr>
             <tr>
                <td>家庭联系</td>
                <td><input name="familyPhone" type="text"  class="easyui-validatebox span2" ></td>
             	<td>家庭住址</td>
                <td><input name="address" type="text" placeholder="请输入家庭住址" class="easyui-validatebox span2" ></td>
            </tr>
            <tr>
                <td>qq号码</td>
                <td><input name="qq" type="text" placeholder="请输入qq号码" class="easyui-validatebox span2" ></td>
                <td>状态</td>
                <td>
                    <select name="deleteFlag" class="easyui-combobox" data-options="width:140,height:29,editable:false,panelHeight:'auto'">
                        <option value="0">正常</option>
                        <option value="1">停用</option>
                    </select>
                </td>
            </tr>
            </table>
        </form>
    </div>
</div>