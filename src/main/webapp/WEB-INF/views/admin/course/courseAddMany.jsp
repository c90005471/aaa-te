<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/global.jsp" %>
<script type="text/javascript">
    function checkFile(){
    	var file=$("#excelFile").val();
    			if (file == null||file == ""){  
                     alert("请选择要上传的excel文件!");  
                     return false;  
                }  
                if (file.lastIndexOf('.')==-1){    //如果不存在"."    
                    alert("路径不正确!");  
                    return false;  
                }  
                 var AllImgExt=".xls";  
                 var extName = file.substring(file.lastIndexOf(".")).toLowerCase();//（把路径中的所有字母全部转换为小写）
                 if(AllImgExt.indexOf(extName)==-1){
                 	alert("文件格式不正确，请下载模版文件，后缀为xls!");  
                 	 return false;  
                 }else{
                 	return true;
                 }
    }
    $(function() {
        $('#courseAddManyForm').form({
            url : '${path}/course/importExcelcourseByOrgId?orgId=${orgId}',
            onSubmit : function() {
                //校验文件类型是否合法
                if(checkFile()){
	                progressLoad();
	                var isValid = $(this).form('validate');
	                if (!isValid) {
	                    progressClose();
	                }
	                return isValid;
                
                }else{
                	return false;
                }
            },
            success : function(result) {
                progressClose();
                result = $.parseJSON(result);
                if (result.success) {
                    //之所以能在这里调用到parent.$.modalDialog.openner_dataGrid这个对象，是因为user.jsp页面预定义好了
                    parent.$.modalDialog.openner_dataGrid.datagrid('reload');
                    parent.$.modalDialog.handler.dialog('close');
                } else {
                    var form = $('#courseAddManyForm');
                    parent.$.messager.alert('错误', eval(result.msg), 'error');
                }
            }
        });
        


	});
</script>
<div class="easyui-layout" data-options="fit:true,border:false" >
    <div data-options="region:'center',border:false" style="overflow: hidden;padding: 3px;" >
        <form id="courseAddManyForm"  method="post" enctype="multipart/form-data">
          请选择你要导入的excel: <input type="file" name="mf" id="excelFile">
        </form>
    </div>
</div>