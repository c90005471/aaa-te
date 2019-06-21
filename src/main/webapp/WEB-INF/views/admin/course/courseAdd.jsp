<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/global.jsp" %>
<script type="text/javascript">
    $(function() {
        $('#courseAddPid').combotree({
            url : '${path }/course/allTree?orgid='+orgid+'&coursetype=0',
            parentField : 'pid',
            lines : true,
            panelHeight : '200',
            onLoadSuccess: function (row, data) {
                $('#courseAddPid').combotree('tree').tree("collapseAll");
            }
        });
        
        $('#courseAddForm').form({
            url : '${path }/course/add?orgid='+orgid+'&courseVersion='+coursVersion,//将所属的专业拼接上，orgid为主页面的全局变量
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
                    parent.$.modalDialog.openner_courseTreeGrid.treegrid('reload');//之所以能在这里调用到parent.$.modalDialog.openner_courseTreeGrid这个对象，是因为course.jsp页面预定义好了
                    parent.indexMenuZTree.reAsyncChildNodes(null, "refresh");
                    parent.$.modalDialog.handler.dialog('close');
                } else {
                    var form = $('#courseAddForm');
                    parent.$.messager.alert('提示', eval(result.msg), 'warning');
                }
            }
        });
        
    });
</script>
<div style="padding: 3px;">
    <form id="courseAddForm" method="post">
        <table class="grid">
            <tr>
                <td>课程名称</td>
                <td><input name="courseName" type="text" placeholder="请输入课程名称" class="easyui-validatebox span2" data-options="required:true" ></td>
                <td>课程代码</td>
                 <td><input name="courseCode" type="text" placeholder="请输入课程代码" class="easyui-validatebox span2"></td>
            </tr>
            
            <tr>
                <td>菜单图标</td>
                <td ><input name="icon" value="fi-foundation icon-blue"/></td>
                <td>排序</td>
                <td><input name="seq" value="0"  class="easyui-numberspinner" style="width: 140px; height: 29px;" required="required" data-options="editable:false"></td>
            </tr>
            <tr>
                <td>状态</td>
                <td>
                    <select name="status" class="easyui-combobox" data-options="width:140,height:29,editable:false,panelHeight:'auto'">
                        <option value="0">正常</option>
                        <option value="1">停用</option>
                    </select>
                </td>
                <td>资源类型</td>
                 <td>
                    <select id="courseType" name="courseType" class="easyui-combobox" data-options="width:140,height:29,editable:false,panelHeight:'auto'">
                        <option value="1">知识点</option><!-- 知识点代表没有子节点，非知识点说明还有子节点，是科目，或者是章节。 -->
                        <option value="0">非知识点</option>
                    </select>
                </td>
            </tr>
            <tr>
                <td>上级课程</td>
                <td colspan="3">
                    <select id="courseAddPid" name="pid" style="width: 200px; height: 29px;"></select>
                    <a class="easyui-linkbutton" href="javascript:void(0)" onclick="$('#courseAddPid').combotree('clear');" >清空</a>
                </td>
            </tr>
        </table>
    </form>
</div>