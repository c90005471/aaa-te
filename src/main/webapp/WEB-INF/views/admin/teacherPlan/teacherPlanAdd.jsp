<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/global.jsp" %>
<script type="text/javascript">
    $(function() {
        $('#teacherno').combotree({
            url : '${path }/teacherPlan/teacher?classid='+classidTea,
            parentField : 'pid',
            lines : true,
            panelHeight : 'auto'
        }); 
        
        $('#teacherPlanAddForm').form({
            url : '${path}/teacherPlan/add?classid='+classidTea+'&classname='+classname,
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
                    var form = $('#teacherPlanAddForm');
                    parent.$.messager.alert('错误', eval(result.msg), 'error');
                }
            }
        });       
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
	/**
	 * 清除
	 */
	function clearFun() {
		$('#teacherno input').val('');
		$('#teacherno').combotree('load', {});
	}
</script>
<div class="easyui-layout" data-options="fit:true,border:false" >
    <div data-options="region:'center',border:false" style="overflow: hidden;padding: 3px;" >
          <form id="teacherPlanAddForm" method="post">
            <table class="grid">
             <tr>
                <td>选择要评价的老师</td>
                <td>
                    <select id="teacherno" name="teacherno" style="width:150px; height:30px;"></select>
                    <a class="easyui-linkbutton" href="javascript:void(0)" id="clear" style="width:50px;" onclick="clearFun();">清空</a>
                </td>               
             </tr>           
             <tr>
                <td>开始时间</td>
                <td><input id="dd" name="begintime" style="height:30px;width:150px;" type="text" placeholder="请选择开始时间" class="easyui-datetimebox" data-options="required:true" ></td>
             </tr>
             <tr>
                <td>有效期(小时)</td>
                <td>
                <input name="hournum" value="24" style="height:30px;width:150px;" type="text" placeholder="请输入小时数" class="easyui-numberspinner" data-options="required:true,min:1,max:144,editable:true" >
                </td>
            </tr>
            </table>
        </form>
    </div>
</div>