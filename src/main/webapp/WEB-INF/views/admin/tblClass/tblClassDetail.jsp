<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/global.jsp" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script type="text/javascript">
    var classEditTeacher;
    $(function() {
    	
    	
    	//alert($('#classEditPid').val());
    	$('#classEditPid').combotree({
            url : '${path }/organization/tree',
            //parentField : 'pid',
            lines : true,
            required:true,//必须输入
            panelHeight : 'auto',
            value : '${tblClass.orgid}',
            formatter:function(node){
            	var aaa=$("#classEditPid").combotree("getValue");
            	//alert(aaa);
            	if(node.id==aaa){
            		$("#classEditPidData").html(node.text);
                //alert(JSON.stringify(node.text));
            	}

       }
           
        });
    	//var aaa=$("#classEditPid").combotree("getValue");
    	//alert(aaa);
    	
    
     classEditTeacher=$('#classEditTeacher').combotree({
            url: '${path }/user/tree?organizationId='+'${tblClass.orgid}',
            multiple: true,
            lines : true,
            panelHeight : 'auto',
            value:'${tblClass.teacher}'
        });
        $('#tblClassEditForm').form({
            url : '${path}/tblClass/edit',
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
                    parent.$.modalDialog.openner_dataGrid.treegrid('reload');
                    parent.$.modalDialog.handler.dialog('close');
                } else {
                    var form = $('#tblClassEditForm');
                    parent.$.messager.alert('错误', eval(result.msg), 'error');
                }
            }
        });
        
        //$("#firstprojectbegin").datetimebox('setValue',"${tblClass.firstbegin}");
       
        
    });
    
    
    
   
</script>

<div class="easyui-layout" data-options="fit:true,border:false" >
    <div data-options="region:'center',border:false" style="overflow: hidden;pEditing: 3px;" >
        <form id="tblClassEditForm" method="post">
        <input name="id" type="hidden"  value="${tblClass.id}">
            <table class="grid">
                 <tr>
                <td>班级名称</td>
                
                <td>${tblClass.classname}</td>
                <td>状态</td>
                <td>
                <c:if test="${tblClass.graduate eq '1'}">毕业</c:if>
                  <c:if test="${tblClass.graduate eq '0'}">在校</c:if>
                   <%--  <select name="graduate" value="${tblClass.graduate}" class="easyui-combobox" data-options="width:140,height:29,editable:false,panelHeight:'auto'" readonly>
                        <option value="0">在校</option>
                        <option value="1">毕业</option>
                    </select> --%>
                </td>
            </tr>
           <tr>
                <td>所属专业</td>
                <td colspan="3" id="classEditPidData">
                 <input id="classEditPid"   type="hidden"/>
               <%--  ${tblClass.orgid} --%>
                </td>
                
            </tr>
             <tr>
             
              <td>老师</td>
                <td colspan="3">
                    ${tblClass.teacher}
                </td>
             </tr>
           
              <tr class="time">
             
	              <td>开班时间</td>
	              <td ><fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value='${tblClass.begin}' /></td>
                 <td>结束时间</td>
	              <td ><fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value='${tblClass.over}' /></td>
             
             </tr>
              <tr class="time">
             
	              <td>第一次项目<br>开始时间</td>
	              <td ><fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value='${tblClass.firstbegin}' /></td>
                 <td>第一次项目<br>结束时间</td>
	              <td ><fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value='${tblClass.firstover}' /></td>
             
             </tr>
              <tr class="time">
	              <td>第二次项目<br>开始时间</td>
	              <td ><fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value='${tblClass.secondbegin}' /></td>
                 <td>第二次项目<br>结束时间</td>
	              <td ><fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value='${tblClass.secondover}' /></td>
             </tr>
             <c:if test="${stucomMap.leaschooltime!=null}">
	            <tr>
		              <td>离校时间</td>
		              <td ><fmt:formatDate pattern="yyyy-MM-dd" value='${stucomMap.leaschooltime}' /></td>
	                 <td>毕业奖金</td>
		              <td >${stucomMap.bonussum}</td>
	             </tr>
             </c:if>
            </table>
        </form>
    </div>
</div>

