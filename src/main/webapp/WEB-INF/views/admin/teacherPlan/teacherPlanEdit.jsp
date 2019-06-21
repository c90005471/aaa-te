<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/global.jsp" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<script type="text/javascript">
    $(function() {
    	$('#teacherno').combotree({
            url : '${path }/teacherPlan/teacher?classid=${teacherPlan.classid}',
            parentField : 'pid',
            lines : true,
            panelHeight : 'auto',
            value:'${teacherPlan.teacherno}'
        }); 
    
        $('#teacherPlanEditForm').form({
            url : '${path}/teacherPlan/edit',
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
                    var form = $('#teacherPlanEditForm');
                    parent.$.messager.alert('错误', eval(result.msg), 'error');
                }
            }
        });
        $("#editStatus").val('${teacherPlan.dostatus}');
    });
    //时间不能选当前时间以前的
    $(function(){
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
<div class="easyui-layout" data-options="fit:true,border:false">
    <div data-options="region:'center',border:false" title="" style="overflow: hidden;padding: 3px;">
        <form id="teacherPlanEditForm" method="post">
            <table class="grid">
                <tr>
                	<td>选择要评价的老师</td>
                	<td>
                		<input name="id" type="hidden"  value="${teacherPlan.id}">
                		<input name="classname" type="hidden"  value="${classname}">
                    	<select id="teacherno" name="teacherno" style="width: 150px; height: 30px;"></select>
                    	<a class="easyui-linkbutton" href="javascript:void(0)" onclick="$('#pid').combotree('clear');" style="width:50px;">清空</a>
                	</td>
                </tr> 
                <tr>
               		<td>开始时间</td>
               		<td>
               			<input id="dd" name="begintime" style="height:30px;width:150px;" type="text" placeholder="请输入开始时间" class="easyui-datetimebox" data-options="required:true" value="<fmt:formatDate value="${teacherPlan.begintime}" pattern="yyyy-MM-dd HH:mm:ss"/>"/>
               		</td>
               	</tr>
               	<tr>
                	<td>有效期（小时）</td>
                	<td>
                		<input name="hournum" style="height:30px;width:150px;" value="${teacherPlan.hournum }" placeholder="请输入小时数" class="easyui-numberspinner" data-options="required:true,min:1,max:144,editable:true"/>
                	</td>
                </tr>
                <tr>
                    <td>状态</td>
                    <td>
                        <select id="editStatus" style="height:30px;width:150px;" name="dostatus" class="easyui-combobox" data-options="width:140,height:29,editable:false,panelHeight:'auto'">
                            <option value="0" selected="selected">未执行</option>
                            <option value="1">已执行</option>                
                        </select>
                    </td>
                </tr>
            </table>
        </form>
    </div>
</div>