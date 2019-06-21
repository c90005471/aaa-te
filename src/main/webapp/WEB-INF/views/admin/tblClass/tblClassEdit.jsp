<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/global.jsp" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script type="text/javascript">
    var classEditTeacher;
    $(function() {
    	

    	
    	//alert($('#classEditPid').val());
    	$('#classEditPid').combotree({
            url : '${path }/organization/tree',
            parentField : 'pid',
            lines : true,
            required:true,//必须输入
            panelHeight : 'auto',
            value : '${tblClass.orgid}',
            onClick : function(node) {
            	//alert(JSON.stringify(node));
            //判断选中的必须是专业，否则提示
        	var tree = $(this).tree;  
        	//选中的节点是否为叶子节点,如果不是叶子节点,清除所有右边的数据
        		var isLeaf = tree('isLeaf', node.target);  
        		if (!isLeaf) {
        		//alert("请选择专业！");
        		parent.$.messager.alert('错误', '请选择专业！', 'error');
        		$('#classEditPid').combotree('clear');
        		  return; 
        		}
        		//if(node.pid==3){
          		  //$(".time").show();
          		//}
            //选择专业的时候显示本专业的老师
               $('#classEditTeacher').combotree('clear').combotree('reload','${path }/user/tree?organizationId='+node.id);
               $("#begin").datetimebox('setValue','');
               $("#dd2").datetimebox('setValue', '');
          		//$("#dd2").val(newtime);
          		$("#firstprojectbegin").datetimebox('setValue','');
          		$("#firstprojectover").datetimebox('setValue','');
          		$("#secondprojectbegin").datetimebox('setValue','');
          		$("#secondprojectover").datetimebox('setValue','');
            }
        });
    	
    	
    
     classEditTeacher=$('#classEditTeacher').combotree({
            url: '${path }/user/tree?organizationId='+'${tblClass.orgid}',
            multiple: true,
            lines : true,
            panelHeight : 'auto',
            value:'${tblClass.teacher}'
        });
     var classNameFlag = false;
   //验证班级名称不能为空
   function checkClassName(){
	   $.ajaxSettings.async = false;
       $.post("tblClass/chekcClassName",{classname:$("#classnameEdit").val(),id:"${tblClass.id}"},function(data){
       	if(!data){
       		parent.$.messager.alert('警告', "班级名称不能重复", 'error');
       		$("#classname").val("");
       	}else{
       		classNameFlag = true;
       	}
       },"JSON");
   }
        $('#tblClassEditForm').form({
            url : '${path}/tblClass/edit',
            onSubmit : function() {
            	//验证班级名称
                checkClassName();
                if(!classNameFlag){
                	return false;
                }
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
                
                <td><input id="classnameEdit" name="classname" value="${tblClass.classname}" type="text" placeholder="请输入班级名称" class="easyui-validatebox span2" data-options="required:true" onblur="checkClassName()"></td>
                <td>状态</td>
                <td>
                    <select name="graduate" value="${tblClass.graduate}" class="easyui-combobox" data-options="width:140,height:29,editable:false,panelHeight:'auto'">
                        <option value="0">在校</option>
                        <option value="1">毕业</option>
                    </select>
                </td>
            </tr>
           <tr>
                <td>所属专业</td>
                <td colspan="3">
                    <select id="classEditPid" name="orgid"  style="width: 200px; height: 29px;"></select>
                    <a class="easyui-linkbutton" href="javascript:void(0)" onclick="clearCombtreeEdit('classEditPid')" >清空</a>
                </td>
                
            </tr>
             <tr>
             
              <td>老师</td>
                <td colspan="3">
                    <select id="classEditTeacher" name="teacher" style="width: 200px; height: 29px;"></select>
                    <a class="easyui-linkbutton" href="javascript:void(0)" onclick="$('#classEditTeacher').combotree('clear');" >清空</a>
                </td>
             </tr>
           
              <tr class="time">
             
	              <td>开班时间</td>
	              <td ><input id="begin" name="begin" value="<fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value='${tblClass.begin}' />" style="height:30px;width:150px;" type="text" placeholder="请选择开班时间" class="easyui-datetimebox" data-options="required:true" ></td>
                 <td>结束时间</td>
	              <td ><input id="dd2" name="over" value="<fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value='${tblClass.over}' />" style="height:30px;width:150px;" type="text" placeholder="结束时间" class="easyui-datetimebox"></td>
             
             </tr>
              <tr class="time">
             
	              <td>第一次项目开始时间</td>
	              <td ><input id="firstprojectbegin" value="<fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value='${tblClass.firstbegin}' />" name="firstbegin"  style="height:30px;width:150px;" type="text" placeholder="" class="easyui-datetimebox" ></td>
                 <td>第一次项目结束时间</td>
	              <td ><input id="firstprojectover" value="<fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value='${tblClass.firstover}' />" name="firstover" style="height:30px;width:150px;" type="text" placeholder="" class="easyui-datetimebox" ></td>
             
             </tr>
              <tr class="time">
             
	              <td>第二次项目开始时间</td>
	              <td ><input id="secondprojectbegin" value="<fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value='${tblClass.secondbegin}' />" name="secondbegin" style="height:30px;width:150px;" type="text" placeholder="" class="easyui-datetimebox"></td>
                 <td>第二次项目结束时间</td>
	              <td ><input id="secondprojectover" value="<fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value='${tblClass.secondover}' />" name="secondover"  style="height:30px;width:150px;" type="text" placeholder="" class="easyui-datetimebox" ></td>
             
             </tr>
            
            </table>
        </form>
    </div>
</div>
<<script type="text/javascript">
function clearCombtreeEdit(id){
	$("#"+id).combotree("clear");
	$("#begin").datetimebox('setValue','');
    $("#dd2").datetimebox('setValue', '');
		//$("#dd2").val(newtime);
		$("#firstprojectbegin").datetimebox('setValue','');
		$("#firstprojectover").datetimebox('setValue','');
		$("#secondprojectbegin").datetimebox('setValue','');
		$("#secondprojectover").datetimebox('setValue','');
}


</script>

