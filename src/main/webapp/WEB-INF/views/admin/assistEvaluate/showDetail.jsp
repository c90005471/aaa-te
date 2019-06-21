<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/global.jsp" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<script type="text/javascript">
    $(function() {
    
        $('#assistPlanEditForm').form({
            url : '${path}/assistPlan/edit',
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
                    var form = $('#assistPlanEditForm');
                    parent.$.messager.alert('错误',result.msg, 'error');
                }
            }
        });
      $("#isstatus").val("${assistPlan.isstatus}");
    });
    
  //----------------------------------------------------------
//  功能：根据身份证号获得性别
//参数：身份证号 psidno
//  返回值：
//  性别
//----------------------------------------------------------
function Getsex(psidno){
  var sexno,sex;
  if(psidno.length==18){
      sexno=psidno.substring(16,17);
  }else if(psidno.length==15){
      sexno=psidno.substring(14,15);
  }else{
      //alert("错误的身份证号码，请核对！");
      return false;
  }
  var tempid=sexno%2;
  if(tempid==0){
      sex='女';
  }else{
      sex='男';
  }
  return sex;
}
    
</script>
<div class="easyui-layout" data-options="fit:true,border:false">
    <div data-options="region:'center',border:false" title="" style="overflow: auto;padding: 3px;">
        <form id="assistPlanEditForm" method="post">
            <table class="grid">
            <tr>
                <td>班级</td>
                <td>
                     ${classname}
                </td> 
                <td>辅导老师</td>
                <td>
                     ${createname}
                </td>               
             </tr>
             <tr>
                <td>学习内容</td>
                <td colspan="3">
                     ${assistPlan.stucontent}
                </td>               
             </tr>           
             <tr>
                <td>开始时间</td>
                <td><fmt:formatDate value="${assistPlan.starttime}" pattern="yyyy-MM-dd HH:mm:ss"/>
                
                <td>结束时间</td>
                <td><fmt:formatDate value="${assistPlan.endtime}" pattern="yyyy-MM-dd HH:mm:ss"/>
             </tr>
             <tr>
                <td>帮扶学生</td>
                <td colspan="3">
                	<div id="students">${stunames}</div>
                </td>
            </tr>
            <tr>
                <td>计划内容</td>
                <td colspan="3">
                	<textarea name="plancontent" style="width:450px;height:60px;resize:none;" class="easyui-validatebox span2">${assistPlan.plancontent}</textarea>
                </td>
            </tr>
            <tr>
                <td>完成情况</td>
                <td colspan="3">
                	<textarea name="comflan" style="width:450px;height:60px;resize:none;" class="easyui-validatebox span2">${assistPlan.comflan}</textarea>
                </td>
            </tr>
            <tr>
                <td>备注</td>
                <td colspan="3">
                	<textarea name="remark" style="width:450px;height:60px;resize:none;" class="easyui-validatebox span2">${assistPlan.remark}</textarea>
                </td>
            </tr>
            <tr>
                   <td>是否完成</td>
                   <td colspan="3">
                   		<c:if test="${assistPlan.isstatus==0}">未完成</c:if>
                   		<c:if test="${assistPlan.isstatus==1}">已完成</c:if>
                   </td>
              </tr>
            </table>
        </form>
    </div>
</div>