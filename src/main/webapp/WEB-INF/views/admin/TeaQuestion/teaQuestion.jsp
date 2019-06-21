<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/global.jsp" %>
<script type="text/javascript">
    var teacherQuestionDataGrid;

    $(function() {
        teacherQuestionDataGrid = $('#teacherQuestionDataGrid').datagrid({
            url :'${path }/teacherQuestion/dataGrid',
            fit : true,
            striped : true,
            rownumbers : true,
            pagination : true,
            singleSelect : true,
            idField : 'id',
            sortName : 'id',
	        sortOrder : 'asc',
            pageSize : 20,
            pageList : [ 10, 20, 30, 40, 50, 100, 200, 300, 400, 500 ],
            columns : [ [ {
                width : '40',
                title : '编号',
                field : 'id',
                align:'center',
                sortable : true
            }, {
                width : '550',
                title : '教师考核点',
                field : 'questionname',
                /* align:'center', */
                sortable : true
            }, {
            	 width : '150',
                 title : '角色',
                 field : 'rolesList'
            },{
                field : 'action',
                align:'center',
                title : '操作',
                width : 130,
                formatter : function(value, row, index) {
                    var str = '';
                        <shiro:hasPermission name="/teacherQuestion/edit">
                            str += $.formatString('<a href="javascript:void(0)" class="teacherQuestion-easyui-linkbutton-edit" data-options="plain:true,iconCls:\'fi-pencil icon-blue\'" onclick="editteacherQuestionFun(\'{0}\');" >编辑</a>', row.id);
                        </shiro:hasPermission>
                        <shiro:hasPermission name="/teacherQuestion/delete">
                            str += '&nbsp;&nbsp;|&nbsp;&nbsp;';
                            str += $.formatString('<a href="javascript:void(0)" class="teacherQuestion-easyui-linkbutton-del" data-options="plain:true,iconCls:\'fi-x icon-red\'" onclick="deleteteacherQuestionFun(\'{0}\');" >删除</a>', row.id);
                        </shiro:hasPermission>
                    return str;
                }
            }] ],
            onLoadSuccess:function(data){
                $('.teacherQuestion-easyui-linkbutton-edit').linkbutton({text:'编辑'});
                $('.teacherQuestion-easyui-linkbutton-del').linkbutton({text:'删除'});
            },
             toolbar : '#teacherQuestionToolbar'
        });
    });
    
    function addteacherQuestionFun() {
        parent.$.modalDialog({
            title : '添加',
            width : 500,
            height : 350,
            href : '${path }/teacherQuestion/addPage',
            buttons : [ {
                text : '添加',
                handler : function() {
                    parent.$.modalDialog.openner_dataGrid = teacherQuestionDataGrid;//因为添加成功之后，需要刷新这个dataGrid，所以先预定义好
                    var f = parent.$.modalDialog.handler.find('#teacherQuestionAddForm');
                    f.submit();
                }
            } ]
        });
    }
    
    function deleteteacherQuestionFun(id) {
        if (id == undefined) {//点击右键菜单才会触发这个
            var rows = teacherQuestionDataGrid.datagrid('getSelections');
            id = rows[0].id;
        } else {//点击操作里面的删除图标会触发这个
            teacherQuestionDataGrid.datagrid('unselectAll').datagrid('uncheckAll');
        }
        parent.$.messager.confirm('询问', '您是否要删除当前考核点？', function(b) {
            if (b) {
                progressLoad();
                $.post('${path }/teacherQuestion/delete', {
                    id : id
                }, function(result) {
                    if (result.success) {
                        parent.$.messager.alert('提示', result.msg, 'info');
                        teacherQuestionDataGrid.datagrid('reload');
                    } else {
                        parent.$.messager.alert('错误', result.msg, 'error');
                    }
                    progressClose();
                }, 'JSON');
            }
        });
    }
    
    function editteacherQuestionFun(id) {
        if (id == undefined) {
            var rows = teacherQuestionDataGrid.datagrid('getSelections');
            id = rows[0].id;
        } else {
            teacherQuestionDataGrid.datagrid('unselectAll').datagrid('uncheckAll');
        }
        parent.$.modalDialog({
            title : '编辑',
            width : 500,
            height : 350,
            href : '${path }/teacherQuestion/editPage?id=' + id,
            buttons : [ {
                text : '确定',
                handler : function() {
                    parent.$.modalDialog.openner_dataGrid = teacherQuestionDataGrid;//因为添加成功之后，需要刷新这个dataGrid，所以先预定义好
                    var f = parent.$.modalDialog.handler.find('#teacherQuestionEditForm');
                    f.submit();
                }
            } ]
        });
    }
    
    /* function searchStuFun() {
        teacherQuestionDataGrid.datagrid('load', $.serializeObject($('#searchStuForm')));
    }
    function cleanStuFun() {
        $('#searchStuForm input').val('');
        teacherQuestionDataGrid.datagrid('load', {});
    } */
</script>
<div class="easyui-layout" data-options="fit:true,border:false">
   <!-- <div data-options="region:'north',border:false" style="height: 30px; overflow: hidden;background-color: #fff">
        <form id="searchStuForm">
            <table>
                <tr>
                    <th>姓名:</th>
                    <td><input name="stuname" placeholder="请输入学生姓名"/></td>
                    <th>学号:</th>
                    <td>
                        <input name="stuno" placeholder="请输入学号"/>
                   		<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'fi-magnifying-glass',plain:true" onclick="searchStuFun();">查询</a>
                    	<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'fi-x-circle',plain:true" onclick="cleanStuFun();">清空</a>
                    </td>                    
                </tr>
            </table>
        </form>
    </div> -->
    <div data-options="region:'center',border:true,title:'教师考核点'">
        <table id="teacherQuestionDataGrid" data-options="fit:true,border:false"></table>
    </div>
    <!-- <div data-options="region:'west',border:true,split:false,title:'组织机构'"  style="width:150px;overflow: hidden; ">
        <ul id="classesTree" style="width:160px;margin: 10px 10px 10px 10px"></ul>
    </div> -->
</div>
<div id="teacherQuestionToolbar" style="display: none;">
    <shiro:hasPermission name="/teacherQuestion/add">
        <a id="tianjia" onclick="addteacherQuestionFun();" href="javascript:void(0);" class="easyui-linkbutton" data-options="plain:true,iconCls:'fi-plus icon-green'">添加</a>
    </shiro:hasPermission>
</div>