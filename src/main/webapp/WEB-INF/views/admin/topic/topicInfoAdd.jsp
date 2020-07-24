<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/global.jsp" %>
<script type="text/javascript">
    $(function() {
    	/* 表单提交 */
       $('#topicInfoAddForm').form({
            url : '${path}/topicInfo/add?topictype='+topictype,
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
                    var form = $('#topicInfoAddForm');
                    parent.$.messager.alert('错误', eval(result.msg), 'error');
                }
            }
        });
    });  
</script>
<div class="easyui-layout" data-options="fit:true,border:false" >
    <div data-options="region:'center',border:false" style="overflow: hidden;padding: 3px;" >
        <form id="topicInfoAddForm" method="post">
            <table class="grid">
<%--            	<tr>--%>
<%--                    <td>题目类型</td>--%>
<%--                    <td>--%>
<%--                    	<select name="topictype" style="width:100px;height:30px;">--%>
<%--                    		<c:forEach items="${typeMap}" var="map">--%>
<%--                    			<option value="${map.key}">${map.value}</option>--%>
<%--                    		</c:forEach>--%>
<%--                    	</select>--%>
<%--                    </td>--%>
<%--                </tr>--%>
                <tr>
                    <td>题目内容</td>
                    <td><textarea name="topicname" placeholder="请输入题目内容" style="width:400px;height:70px;resize:none;" class="easyui-validatebox span2" data-options="required:true" ></textarea></td>
                </tr>
                <tr>
                    <td>试题难度</td>
                    <td>
                    	<select name="difficulty" style="width:100px;height:30px;">
                            <option value="0">简单</option>
                            <option value="1">中等</option>
                            <option value="2">困难</option>
                    	</select>
                    </td>
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
                    	<input name="correct"  class="easyui-validatebox span2" data-options="required:true" style="width:150px;height:20px;" />
                    </td>
                </tr> 
                <tr>
                    <td>题目选项</td>
                    <td>
                    	<textarea name="optionnum" style="width:30px;height:30px;resize:none;font-size:18px;" data-options="required:true" readonly="readonly">A</textarea><textarea name="option"  class="easyui-validatebox span2" style="width:370px;height:30px;resize:none;" data-options="required:true" ></textarea><br/>
                    	<textarea name="optionnum" style="width:30px;height:30px;resize:none;font-size:18px;" data-options="required:true" readonly="readonly">B</textarea><textarea name="option"  class="easyui-validatebox span2" style="width:370px;height:30px;resize:none;margin-top:10px" data-options="required:true" ></textarea><br/>
                    	<textarea name="optionnum" style="width:30px;height:30px;resize:none;font-size:18px;" data-options="required:true" readonly="readonly">C</textarea><textarea name="option"  class="easyui-validatebox span2" style="width:370px;height:30px;resize:none;margin-top:10px" data-options="required:true" ></textarea><br/>
                    	<textarea name="optionnum" style="width:30px;height:30px;resize:none;font-size:18px;" data-options="required:true" readonly="readonly">D</textarea><textarea name="option"  class="easyui-validatebox span2" style="width:370px;height:30px;resize:none;margin-top:10px" data-options="required:true" ></textarea><br/>
                    	<br/>
                    </td>
                </tr>
                <tr>
                    <td>题目得分</td>
                    <td>
                    	<input name="score"  class="easyui-validatebox span2" data-options="required:true" style="width:150px;height:20px;" value="2"/>
                    </td>
                </tr>
            </table>
        </form>
    </div>
</div>
