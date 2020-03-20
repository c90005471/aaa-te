<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/commons/global.jsp" %>
<script type="text/javascript">
    var examPaperDataGrid;
    var orgidExamPaper;
    var classidExamPaper = 0;
    $(function () {
        examPaperDataGrid = $('#examPaperDataGrid').datagrid({
            url: '${path}/examPaper/dataGrid',
            fit: true,
            striped: true,
            rownumbers: true,
            pagination: true,
            singleSelect: true,
            idField: 'id',
            sortName: 'id',
            sortOrder: 'asc',
            pageSize: 20,
            pageList: [10, 20, 30, 40, 50, 100],
            columns: [[{
                width: '60',
                title: '编号',
                field: 'id',
                sortable: true
            }, {
                width: '400',
                title: '试卷名称',
                field: 'title',
                sortable: true,

            }, {
                width: '120',
                title: '开始时间',
                field: 'starttime',
                sortable: true,

            }, {
                width: '60',
                title: '所需时间',
                field: 'needtime'

            }, {
                width: '60',
                title: '类型',
                field: 'type',
                formatter: function (value, row, index) {
                    switch (value) {
                        case 0:
                            return '结业考试';
                        case 1:
                            return '课程内测';
                        case 2:
                            return '模拟练习';
                    }

                }
            }, {
                width: '80',
                title: '状态',
                field: 'state',
                formatter: function (value, row, index) {
                    switch (value) {
                        case 0:
                            return '未启用';
                        case 1:
                            return '已启用';
                    }

                }
            }, {
                field: 'action',
                title: '操作',
                width: 300,
                formatter: function (value, row, index) {
                    var str = '';
                    <shiro:hasPermission name="/examPaper/edit">
                    str += $.formatString('<a href="javascript:void(0)" class="examPaper-easyui-linkbutton-show" data-options="plain:true,iconCls:\'fi-pencil icon-blue\'" onclick="examPaperShowFun(\'{0}\');" >智能组卷</a>', row.id);
                    </shiro:hasPermission>
                    <shiro:hasPermission name="/examPaper/edit">
                    str += $.formatString('<a href="javascript:void(0)" class="examPaper-easyui-linkbutton-Manual" data-options="plain:true,iconCls:\'fi-pencil icon-blue\'" onclick="examPapeManualFun(\'{0}\');" >手动组卷</a>', row.id);
                    </shiro:hasPermission>
                    <shiro:hasPermission name="/examPaper/edit">
                    str += $.formatString('<a href="javascript:void(0)" class="examPaper-easyui-linkbutton-edit" data-options="plain:true,iconCls:\'fi-pencil icon-blue\'" onclick="examPaperEditFun(\'{0}\');" >编辑</a>', row.id);
                    </shiro:hasPermission>
                    <shiro:hasPermission name="/examPaper/delete">
                    str += '&nbsp;&nbsp;|&nbsp;&nbsp;';
                    str += $.formatString('<a href="javascript:void(0)" class="examPaper-easyui-linkbutton-del" data-options="plain:true,iconCls:\'fi-x icon-red\'" onclick="examPaperDeleteFun(\'{0}\');" >删除</a>', row.id);
                    </shiro:hasPermission>
                    return str;
                }
            }]],
            onLoadSuccess: function (data) {
                $('.examPaper-easyui-linkbutton-show').linkbutton({text: '智能组卷'});
                $('.examPaper-easyui-linkbutton-Manual').linkbutton({text: '手动组卷'});
                $('.examPaper-easyui-linkbutton-edit').linkbutton({text: '编辑'});
                $('.examPaper-easyui-linkbutton-del').linkbutton({text: '删除'});
            },
            toolbar : '#examPaperToolbar'
        });
    });

    /**
     * 查看详情
     */
    function examPaperShowFun(id) {
        if (id == undefined) {
            var rows = examPaperDataGrid.datagrid('getSelections');
            id = rows[0].id;
        } else {
            examPaperDataGrid.datagrid('unselectAll').datagrid('uncheckAll');
        }
        parent.$.modalDialog({
            title: '智能组卷',
            width: 1200,
            height: 580,
            href: '${path}/examPaper/showPage?id=' + id
        });
    }

    /**
     * @author ky
     * @date 2020/2/17
     * 手动组卷
     **/
    function examPapeManualFun(id) {
        if (id == undefined) {
            var rows = examPaperDataGrid.datagrid('getSelections');
            id = rows[0].id;
        } else {
            examPaperDataGrid.datagrid('unselectAll').datagrid('uncheckAll');
        }
        parent.$.modalDialog({
            title: '手动组卷',
            width: 1200,
            height: 580,
            href: '${path}/examPaper/manualPage?id=' + id
        });
    }

    /**
     * 添加框
     * @param url
     */
    function examPaperAddFun() {
        parent.$.modalDialog({
            title: '添加',
            width: 500,
            height: 340,
            href: '${path}/examPaper/newAddPage',
            buttons: [{
                text: '确定',
                handler: function () {
                    parent.$.modalDialog.openner_dataGrid = examPaperDataGrid;//因为添加成功之后，需要刷新这个treeGrid，所以先预定义好
                    var f = parent.$.modalDialog.handler.find('#examPaperAddForm');
                    f.submit();
                }
            }]
        });
    }


    /**
     * 编辑
     */
    function examPaperEditFun(id) {
        if (id == undefined) {
            var rows = examPaperDataGrid.datagrid('getSelections');
            id = rows[0].id;
        } else {
            examPaperDataGrid.datagrid('unselectAll').datagrid('uncheckAll');
        }
        parent.$.modalDialog({
            title: '编辑',
            width: 500,
            height: 420,
            href: '${path}/examPaper/newEditPage?id=' + id,
            buttons: [{
                text: '确定',
                handler: function () {
                    parent.$.modalDialog.openner_dataGrid = examPaperDataGrid;//因为添加成功之后，需要刷新这个dataGrid，所以先预定义好
                    var f = parent.$.modalDialog.handler.find('#examPaperEditForm');
                    f.submit();
                }
            }]
        });
    }

    /**
     * 删除
     */
    function examPaperDeleteFun(id) {
        if (id == undefined) {//点击右键菜单才会触发这个
            var rows = topicInfoDataGrid.datagrid('getSelections');
            id = rows[0].id;
        } else {//点击操作里面的删除图标会触发这个
            examPaperDataGrid.datagrid('unselectAll').datagrid('uncheckAll');
        }
        parent.$.messager.confirm('询问', '您是否要删除当前题目？', function (b) {
            if (b) {
                progressLoad();
                $.post('${path}/examPaper/delete', {
                    id: id
                }, function (result) {
                    if (result.success) {
                        parent.$.messager.alert('提示', result.msg, 'info');
                        examPaperDataGrid.datagrid('reload');
                    }
                    progressClose();
                }, 'JSON');
            }
        });
    }


    /**
     * 清除
     */
    function examPaperCleanFun() {
        orgidExamPaper = null;
        classidExamPaper = null;
        $('#examPaperSearchForm input').val('');
        examPaperDataGrid.datagrid('load', {});
    }

    /**
     * 搜索
     */
    function examPaperSearchFun() {
        $("#orgidExamPaper").val(orgidExamPaper);
        $("#classidExamPaper").val(classidExamPaper);
        examPaperDataGrid.datagrid('load', $.serializeObject($('#examPaperSearchForm')));
    }
</script>

<div class="easyui-layout" data-options="fit:true,border:false">
    <div data-options="region:'north',border:false" style="height: 30px; overflow: hidden;background-color: #fff">
        <form id="examPaperSearchForm">
            <table>
                <tr>
                    <th>名称:</th>
                    <td>
                        <input type="hidden" name="orgid" id="orgidExamPaper"/>
                        <input type="hidden" name="classid" id="classidExamPaper"/>
                        <input type="text" name="title">
                    </td>
                    <th>类型:</th>
                    <td>
                        <select name="type" class="easyui-combobox"
                                data-options="width:100,height:29,editable:false,panelHeight:'auto'">
                            <option value="">=请选择=</option>
                            <option value="0">结业考试</option>
                            <option value="1">课程内测</option>
                            <option value="2">模拟练习</option>
                        </select>
                    </td>
                    <td>
                        <a href="javascript:void(0);" class="easyui-linkbutton"
                           data-options="iconCls:'fi-magnifying-glass',plain:true"
                           onclick="examPaperSearchFun();">查询</a>
                        <a href="javascript:void(0);" class="easyui-linkbutton"
                           data-options="iconCls:'fi-x-circle',plain:true" onclick="examPaperCleanFun();">清空</a>
                    </td>
                </tr>
            </table>
        </form>
    </div>
    <div data-options="region:'center',border:true,title:'试卷列表'">
        <table id="examPaperDataGrid" data-options="fit:true,border:false"></table>
    </div>
</div>
<div id="examPaperToolbar">
    <a onclick="examPaperAddFun();" href="javascript:void(0);" class="easyui-linkbutton"
       data-options="plain:true,iconCls:'fi-plus'">添加</a>
</div>