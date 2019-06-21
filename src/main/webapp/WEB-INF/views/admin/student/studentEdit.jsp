<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/global.jsp" %>
<script type="text/javascript">
    $(function() {
        $('#studentEditForm').form({
            url : '${path}/student/edit',
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
                    var form = $('#studentEditForm');
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
		
		$('#classId').combobox({
			url : '${path }/student/getClassById?id=+${student.id}',
			valueField : 'id',				//隐藏框的value
			value:'${student.class_id}', 
			textField : 'classname',		//要显示的value
			onSelect : function(rec) {
			
			}
		});        
        
    });
</script>
<%-- ${student} --%>
<div class="easyui-layout" data-options="fit:true,border:false">
    <div data-options="region:'center',border:false" title="" style="overflow: hidden;padding: 3px;">
        <form id="studentEditForm" method="post">
             <table class="grid">
             <tr>
                <td>学号</td>
                <input name="id" value="${student.id}" type="hidden"  >
                <td><input name="stuno" value="${student.stuno}" type="text"  placeholder="请输入学号" class="easyui-validatebox span2" data-options="required:true" ></td>
                <td>姓名</td>
                <td>
                <input name="stuname" value="${student.stuname}" type="text" placeholder="请输入姓名" class="easyui-validatebox span2" data-options="required:true" >
                </td>
            </tr>
             <tr>
                <td>身份证号</td>
                <td><input name="idno" value="${student.idno}" type="text" placeholder="请输入身份证号" class="easyui-validatebox span2" data-options="required:true" ></td>
                <td>手机号</td>
                <td>
                <input name="phone" value="${student.phone}" type="text" placeholder="请输入手机号" class="easyui-validatebox span2">
                </td>
            </tr>
            <tr>
                <td>教育程度</td>
                <td><input id="degree" name="degree" value="${student.degree}" type="text" class="easyui-combobox"></td>
 				<td>毕业院校</td>
                <td><input name="schoolname" value="${student.schoolname}" type="text" placeholder="请输毕业院校" class="easyui-validatebox span2" data-options="required:true" ></td>           	
           	</tr>
            <tr>               
                <td>专业</td>
                <td>
                <input id="major" value="${student.major}" name="major" type="text" class="easyui-combobox">
                </td>
                 <td>qq号码</td>
                <td><input name="qq" value="${student.qq}" type="text" placeholder="请输入qq号码" class="easyui-validatebox span2" ></td>
            </tr>
             <tr>
                <td>家庭联系</td>
                <td><input name="familyPhone" value="${student.family_phone}" type="text"  class="easyui-validatebox span2" ></td>
             	<td>家庭住址</td>
                <td><input name="address" value="${student.address}" type="text" placeholder="请输入家庭住址" class="easyui-validatebox span2" ></td>
            </tr>
             <tr>
               
                <td>状态</td>
                <td>
                    <select name="deleteFlag" value="${student.deleteFlag}" class="easyui-combobox" data-options="width:140,height:29,editable:false,panelHeight:'auto'">
                        <option value="0">正常</option>
                        <option value="1">停用</option>
                    </select>
                </td>
                <td>要转班级</td>
                <td><input name="classId" id="classId" value="${student.classname}" class="easyui-combobox" ></td>
            </tr>

            </table>
        </form>
    </div>
</div>