<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/global.jsp" %>
<script type="text/javascript">
    $(function() {
        $('#uploadAddForm').form({
            url : '${path}/weChatFtp/upload',
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
                    parent.$.modalDialog.openner_dataGrid.datagrid('reload');
                    parent.$.modalDialog.handler.dialog('close');
                } else {
                    var form = $('#uploadAddForm');
                    parent.$.messager.alert('错误', eval(result.msg), 'error');
                }
            }
        });
    });

</script>
<div class="easyui-layout" data-options="fit:true,border:false" >
    <div data-options="region:'center',border:false" style="overflow: hidden;padding: 3px;" >
        <form id="uploadAddForm" method="post" enctype="multipart/form-data">
            <table class="grid">
                <tr>
                    <td>请输入视频/图片的名字</td>
                    <td>
                        <input name="rname" type="text" placeholder="请输入视频/图片的名字" >
                    </td>
                </tr>
                <tr>
                    <td>请输入视频/图片的简介</td>
                    <td>
                        <textarea name="remaks" placeholder="请输入简介"
                                   autocomplete="off" style="margin-left: 0px; margin-right: 0px; height: 190px; width: 290px;"></textarea>
                    </td>
                </tr>
                <tr>
                    <td>选择要添加的类型</td>
                    <td>
                        <select id="type" name="type" style="width:150px; height:30px;" class="easyui-combobox combobox-f combo-f textbox-f">
                            <option value="0">图片</option>
                            <option value="1">视频</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td>选择要添加的类型</td>
                    <td>
                        <select id="category" name="category" style="width:150px; height:30px;" class="easyui-combobox combobox-f combo-f textbox-f">
                            <option value="0">实战</option>
                            <option value="1">推荐</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td>选择要添加的视频/图片</td>
                    <td>
                        <input type="file" name="file" />
                    </td>
                </tr>
            </table>
        </form>
    </div>
</div>