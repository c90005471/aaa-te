<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/commons/global.jsp" %>
<script type="text/javascript">
    var ftpUploadDataGrid;
    $(function () {
        ftpUploadDataGrid = $('#ftpUploadDataGrid').datagrid({
            url: '${path}/weChatFtp/getWeChatResources',
            queryParams: $.serializeObject($('#ftpUploadSearchForm')),
            striped: true,
            pagination: true,
            singleSelect: true,
            idField: 'id',
            sortName: 'id',
            sortOrder: 'asc',
            pageSize: 20,
            pageList: [10, 20, 30, 40, 50, 100, 200, 300, 400, 500],
            columns: [[{
                    title: '资源ID',
                    field: 'id',
                    sortable: true
                },
                {
                    title: '资源类型',
                    field: 'type',
                    formatter : function(value, row, index) {
                        switch (value) {
                            case 0:
                                return '图片';
                            case 1:
                                return '视频';
                        }
                    }
                }
                ,
                {
                    title: '资源路径',
                    field: 'url'
                },
                {
                    title: '资源名字',
                    field: 'name'
                },
                {
                    title: '资源类别',
                    field: 'category',
                    formatter : function(value, row, index) {
                        switch (value) {
                            case 0:
                                return '实战';
                            case 1:
                                return '推荐';
                        }
                    }
                },
                {
                    title: '创建时间',
                    field: 'created_time',
                    sortable: true
                }
                // ,
                // {
                //     field: 'action2',
                //     title: '操作',
                //     width: 260,
                //     formatter: function (value, row, index) {
                //         var str = '';
                //         str += $.formatString('<a href="javascript:void(0)" class="teaPlan-easyui-linkbutton-rate" onclick="delResource()">删除</a>', row.id);
                //         return str;
                //     }
                // }
                ]],
            onLoadSuccess: function (data) {
                $('.teaPlan-easyui-linkbutton-rate').linkbutton({text: '删除'});
            },
            toolbar: '#teacherFenPlanToolbar'
        });

    });

    /**
     * 添加框
     * @param url
     */
    function uploadAddFun() {
        parent.$.modalDialog({
            title: '添加',
            width: 550,
            height:465,
            href: '${path}/weChatFtp/addUpload',
            buttons: [{
                text: '确定',
                width: 50,
                handler: function () {
                    parent.$.modalDialog.openner_dataGrid = ftpUploadDataGrid;
                    //因为添加成功之后，需要刷新这个treeGrid，所以先预定义好
                    var f = parent.$.modalDialog.handler.find('#uploadAddForm');
                    f.submit();
                }
            }]
        });
    }


    /**
     * 清除
     */
    function uploadSearchCleanFun() {
        $('#uploadSearchForm input').val('');
        ftpUploadDataGrid.datagrid('load', {});
    }

    function uploadSearchFun() {
        ftpUploadDataGrid.datagrid('load', $.serializeObject($('#uploadSearchForm')));
    }

    /**
     * @author ky
     * @date 2019/11/15
     * 删除
    **/
    // function delResource(id) {
    //     if (id == undefined) {
    //         var rows = ftpUploadDataGrid.datagrid('getSelections');
    //         id = rows[0].id;
    //     } else {
    //         ftpUploadDataGrid.datagrid('unselectAll').datagrid('uncheckAll');
    //     }
    //     alert(id);
    // }

</script>

<div class="easyui-layout" data-options="fit:true,border:false">
    <div data-options="region:'north',border:false" style="height: 30px; overflow: hidden;background-color: #fff">
        <form id="uploadSearchForm">
            <table>
                <tr>
                    <th>视频/图片名称:</th>
                    <td>
                        <input id="searchName" name="searchName" placeholder="搜索视频/图片名称"/>
                    </td>
                    <th>视频/图片类型:</th>
                    <td>
                        <select id="category" name="category" class="easyui-combobox combobox-f combo-f textbox-f" style="width: 160px">
                            <option value="">全部</option>
                            <option value="0">实战</option>
                            <option value="1">推荐</option>
                        </select>
                    </td>
                    <td>
                        <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'fi-magnifying-glass',plain:true" onclick="uploadSearchFun();">查询</a>
                        <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'fi-x-circle',plain:true" onclick="uploadSearchCleanFun();">清空</a>
                    </td>
                </tr>
            </table>
        </form>
    </div>
    <div data-options="region:'center',border:false,title:'视频图片资源列表'">
        <table id="ftpUploadDataGrid" data-options="fit:true,border:false"></table>
    </div>
</div>
<div>
    <div id="teacherFenPlanToolbar" style="display: none;float:left;">
        <a onclick="uploadAddFun();" href="javascript:void(0);" class="easyui-linkbutton"
           data-options="plain:true,iconCls:'fi-plus icon-green'">添加计划</a>
    </div>
</div>


