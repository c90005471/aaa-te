<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/global.jsp" %>
<script type="text/javascript">
    $(function() {
    	/* 表单提交 */
       $('#testQuesAddForm').form({
            url : '${path}/testQues/add',
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
                    var form = $('#testQuesAddForm');
                    parent.$.messager.alert('错误', eval(result.msg), 'error');
                }
            }
        });
    });  
</script>
<div class="easyui-layout" data-options="fit:true,border:false" >
    <div data-options="region:'center',border:false" style="overflow: hidden;padding: 3px;" >
        <form id="testQuesAddForm" method="post">
            <table class="grid">
            	<tr>
                    <td>题目类型</td>
                    <td>
                    	<select name="questype" style="width:100px;height:30px;">
                    		<c:forEach items="${typeMap}" var="map">
                    			<option value="${map.key}">${map.value}</option>
                    		</c:forEach>
                    	</select>
                    </td>
                </tr>
                <tr>
                    <td>题目内容</td>
                    <td><textarea name="quesname" placeholder="请输入题目内容" style="width:400px;height:70px;resize:none;" class="easyui-validatebox span2" data-options="required:true" ></textarea></td>
                </tr>
                <tr>
                    <td>试题类型</td>
                    <td>
                    	<select name="type" style="width:100px;height:30px;">
                    		<c:forEach items="${types}" var="map">
                    			<option value="${map.key}">${map.value}</option>
                    		</c:forEach>
                    	</select>
                    </td>
                </tr>
                <tr>
                    <td>题目答案</td>
                    <td>
                    	<input name="quesanswer"  class="easyui-validatebox span2" style="width:150px;height:20px;" />
                    </td>
                </tr> 
                <tr>
                    <td>题目选项</td>
                    <td>
                    	<textarea name="option"  class="easyui-validatebox span2" style="width:400px;height:30px;resize:none;" data-options="required:false" >A:</textarea><br/>
                    	<textarea name="option"  class="easyui-validatebox span2" style="width:400px;height:30px;resize:none;margin-top:10px" data-options="required:false" >B:</textarea><br/>
                    	<textarea name="option"  class="easyui-validatebox span2" style="width:400px;height:30px;resize:none;margin-top:10px" data-options="required:false" >C:</textarea><br/>
                    	<textarea name="option"  class="easyui-validatebox span2" style="width:400px;height:30px;resize:none;margin-top:10px" data-options="required:false" >D:</textarea><br/>
                    	<textarea name="option"  class="easyui-validatebox span2" style="width:400px;height:30px;resize:none;margin-top:10px" data-options="required:false" ></textarea>
<%--                    	<input type="button" style="width:35px;height:30px;margin-left:5px;" class="easyui-linkbutton" value="＋"/><br/>--%>
                    	<br/>
                    </td>
                </tr>
                <tr>
                    <td>题目得分</td>
                    <td>
                    	<input name="score"  class="easyui-validatebox span2" style="width:150px;height:20px;" />
                    	<span style="font-size:8px;color: gray;">&nbsp;&nbsp;&nbsp;注:不录入默认为1分,录入多项请使用","分割,例:1,2</span>
                    </td>
                </tr>
            </table>
        </form>
    </div>
</div>
