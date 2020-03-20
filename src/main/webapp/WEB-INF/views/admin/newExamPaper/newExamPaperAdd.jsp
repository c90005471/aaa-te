<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/global.jsp" %>
<script type="text/javascript">
    $(function() {
    	/* 表单提交 */
       $('#examPaperAddForm').form({
            url : '${path}/examPaper/add?classid='+classidExamPaper,
            onSubmit : function() {
            },
            success : function(result) {
                progressClose();
                result = $.parseJSON(result);
                if (result.success) {
                	$.messager.show({title:'提示',msg:result.msg});
                    //之所以能在这里调用到parent.$.modalDialog.openner_dataGrid这个对象，是因为user.jsp页面预定义好了
                    parent.$.modalDialog.openner_dataGrid.datagrid('reload');
                    parent.$.modalDialog.handler.dialog('close');
                } else {
                    var form = $('#examPaperAddForm');
                    parent.$.messager.alert('错误', eval(result.msg), 'error');
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
        <form id="examPaperAddForm" method="post">
            <table class="grid">
            	<tr>
                    <td>阶段</td>
                    <td>
                    	<select   name="stage" data-options="panelHeight:70" style="height:25px;width:100px;">   
						    <option value="S1">S1</option>   
						    <option value="S2">S2</option>  
						    <option value="S3" selected="selected">S3</option>   
						</select>
                    </td>
                </tr>
                <tr>
                    <td>试卷名称</td>
                    <td>
                    	<input name="title"  class="easyui-validatebox span2" data-options="required:true" style="width:200px;height:20px;" />
                    </td>
                </tr> 
                <tr>
                    <td>开始时间</td>
                    <td>
                    	<input id="dd" name="starttime" style="height:30px;width:150px;" type="text" placeholder="请选择开始时间" class="easyui-datetimebox" data-options="required:true" >
                    </td>
                </tr>
                <tr>
                	<td>所需时间(分钟)</td>
                	<td>
                	<input name="needtime" value="60" style="height:30px;width:100px;" type="text" placeholder="请输入分钟数" class="easyui-numberspinner" data-options="required:true,min:1,max:144,editable:true" >
                	</td>
            	</tr>
            	<tr>
                	<td>试题数量</td>
                	<td>
                	<input name="number" value="50" style="height:30px;width:100px;" type="text" placeholder="请输入数量" class="easyui-numberspinner" data-options="required:true,min:1,max:144,editable:true" >
                	</td>
            	</tr>
            	<tr>
            		<td>试卷类型</td>
            		<td>
            			<select name="type" class="easyui-combobox" data-options="width:100,height:29,editable:false,panelHeight:'auto'">
                        	<option value="0">结业考试</option>
                        	<option value="1">课程内测</option>
                        	<option value="2">模拟练习</option>
                    	</select>
            		</td>
            	</tr>
            	<tr>
            		<td>试卷状态</td>
            		<td>
            			<select name="state" class="easyui-combobox" data-options="width:100,height:29,editable:false,panelHeight:'auto'">
                        	<option value="0">未启用</option>
                        	<option value="1">已启用</option>
                    	</select>
            		</td>
            	</tr>
            </table>
        </form>
    </div>
</div>
