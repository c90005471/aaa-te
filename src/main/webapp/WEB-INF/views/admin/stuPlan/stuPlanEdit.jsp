<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/global.jsp" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<script type="text/javascript">
    $(function() {
    	//设置教员id
    	$('#teachernoStuPlan').combotree({
            url : '${path }/teacherPlan/teacher?classid=${stuPlan.classid}',
            parentField : 'pid',
            lines : true,
            panelHeight : 'auto',
            value:'${stuPlan.teacherno}'
        }); 
    	//设置阶段/章节类型
    	$("#courseType").val("${stuPlan.coursetype}");
    	$('#chapterid').combotree({
            url : '${path }/course/allTree?orgid='+orgidStuPlan+'&coursetype=${stuPlan.coursetype}',
            parentField : 'pid',
            lines : true,
            panelHeight : 'auto',
            value : '${stuPlan.chapterid}',
            onLoadSuccess: function (row, data) {
                $('#chapterid').combotree('tree').tree("collapseAll");
            }
        });
        $('#stuPlanEditForm').form({
            url : '${path}/stuPlan/edit',
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
                    var form = $('#stuPlanEditForm');
                    parent.$.messager.alert('错误', eval(result.msg), 'error');
                }
            }
        });
        $("#editStatus").val('${stuPlan.dostatus}'); 
              
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
    function changeChapter(){
    	$('#chapterid').combotree("clear");
    	$('#chapterid').combotree('reload','${path }/course/allTree?orgid='+orgidStuPlan+'&&coursetype='+$('#courseType').val());
    }
</script>
<div class="easyui-layout" data-options="fit:true,border:false">
    <div data-options="region:'center',border:false" title="" style="overflow: hidden;padding: 3px;">
        <form id="stuPlanEditForm" method="post">
            <table class="grid">
            	<tr>
	                <td>选择自<br/>评类型</td>
	                <td colspan="4">
	                    <select id="courseType" style="width: 250px; height: 29px;" data-options="required:true" onchange="changeChapter()">
	                    	<option value="2">阶段自评</option>
	                    	<option value="0">知识点自评</option>
	                    </select>
	                </td>
	            </tr>
	            <tr>
                	<td>选择教员</td>
                	<td colspan="4">
                    	<select id="teachernoStuPlan" name="teacherno" style="width: 150px; height: 30px;"></select>
                    	<a class="easyui-linkbutton" href="javascript:void(0)" onclick="$('#pid').combotree('clear');" style="width:50px;">清空</a>
                	</td>
                </tr>
                <tr>
                    <td>选择阶段/<br/>课程章节</td>
                    <td colspan="4"> <input name="id" type="hidden"  value="${stuPlan.id}">	
                    <select id="chapterid" name="chapterid" style="width: 250px; height: 29px;"></select>
                    <a class="easyui-linkbutton" href="javascript:void(0)" onclick="$('#chapterid').combotree('clear');" >清空</a>
                </tr>
                <tr>
                <td>开始时间</td>
                <td><input name="begintime" type="text" placeholder="请输入开始时间" id="dd" data-options="required:true" value="<fmt:formatDate value="${stuPlan.begintime}" pattern="yyyy-MM-dd HH:mm:ss"/>"></td><td>有效期(小时)</td>
                <td>
                <input name="hourNum" value="${stuPlan.hourNum}" type="text" placeholder="请输入小时数" class="easyui-numberspinner" data-options="required:true,min:1,max:144,editable:true" >
                </td>
            	</tr>
                <tr>
                    <td>状态</td>
                    <td >
                        <select id="editStatus" name="dostatus" class="easyui-combobox" data-options="width:140,height:29,editable:false,panelHeight:'auto'">
                            <option value="0">未执行</option>
                            <option value="1">已执行</option>
                        </select>
                    </td>
                </tr>
            </table>
        </form>
    </div>
</div>