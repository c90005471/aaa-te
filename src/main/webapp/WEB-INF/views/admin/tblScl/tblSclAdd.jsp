<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/global.jsp" %>
<script type="text/javascript">
    $(function() {
    	/* easyUI下拉菜单 */
    	$('#itemTypeId').combobox({    
		    url:'${path }/tblScl/selectTblSclType',    
		    method:'post',
		    panelHeight : '100px',
		    valueField:'id',    
		    textField:'typeName'   
		});  
    	/* 表单提交 */
       $('#tblSclAddForm').form({
            url : '${path}/tblScl/add',
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
                    var form = $('#tblSclAddForm');
                    parent.$.messager.alert('错误', eval(result.msg), 'error');
                }
            }
        });
    });  
    /* 通过ajax，来判断 */
    $(function(){
    	$("#itemsNo").blur(function(){
    		var itemNo =  $("#itemsNo").val();
    		var obj = $("#itemsNo");
    		if(itemNo==""){
    			return false;
    		}else{
    			$.post("${path }/tblScl/selectItemId",{id:itemNo},function(data){
    			if(data == "0"){
    				/* 将输入编号的文本框清空 */
    				$("#itemsNo").val("");
    				/* 提示从第几个id开始 */
    				$.messager.show({title:'提示',msg:'题目编号不能重复!'});
    				return false;
    			}else{
    				return true;
    			}
    		});
    		}
    	});
    });
</script>
<div class="easyui-layout" data-options="fit:true,border:false" >
    <div data-options="region:'center',border:false" style="overflow: hidden;padding: 3px;" >
        <form id="tblSclAddForm" method="post">
            <table class="grid">
                <tr>
                    <td>题目编号</td>
                    <td><input name="id" id="itemsNo" type="text" placeholder="请输入题目编号" onKeyUp="this.value=this.value.replace(/\D/g,'')" style="width:300px;height:20px;" class="easyui-validatebox span2" data-options="required:true" value="" ></td>
                </tr> 
                <tr>
                    <td>题目内容</td>
                    <td><textarea name="item" placeholder="请输入题目内容" style="width:300px;height:50px;resize:none;" class="easyui-validatebox span2" data-options="required:true" ></textarea></td>
                </tr> 
                <tr>
                    <td>题目类型</td>
                    <td><input id="itemTypeId" name="typeId" type="text" style="width:305px;height:25px;" editable="false" class="easyui-validatebox span2" data-options="required:true" value=""></td>
                </tr> 
            </table>
        </form>
    </div>
</div>
