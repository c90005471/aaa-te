<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/global.jsp" %>
<script type="text/javascript">
    var tblClassTreeGrid;
    $(function() {
        tblClassTreeGrid = $('#tblClassTreeGrid').treegrid({
        url : '${path}/tblClass/treeGrid',
            idField : 'id',
            treeField : 'classname',
            parentField : 'orgid',
            fit : true,
            fitColumns : true,
            border : false,
            rownumbers:true,
            frozenColumns : [ [ { 
                title : 'id',
                field : 'id',
                width : 40,
                hidden : true
            } ] ],
            columns : [ [ {
                field : 'classname',
                title : '班级名称',
                width : 180
            }, {
                field : 'graduate',
                title : '是否毕业',
                width : 50,
                formatter: function(value,row,index){
				if (row.graduate==0){
					return "在校";
				} else if(row.graduate==1) {
					return "毕业";
				}else
				{
					return "";
				}
			}
                
            }, {
                field : 'teacher',
                title : '老师',
                width : 120
            },  
            {
                field : 'id',
                title : '编号(开发用)',
                width : 60,
            },{
                width : '130',
                title : '创建时间',
                field : 'createtime'
            },{
                field : 'orgid',
                title : '上级资源ID',
                width : 150,
                hidden : true
            },
            {
                field : 'iconCls',
                title : '图标',
                width : 120,
                hidden : true
            }, {
                field : 'address',
                title : '地址',
                width : 120
            } ,{
            field : 'action',
            title : '操作',
            width : 200,
            formatter : function(value, row, index) {
            if(row.id>=10000){
              var str = '';
                <shiro:hasPermission name="/tblClass/edit">
                    str += $.formatString('<a href="javascript:void(0)" class="tblClass-easyui-linkbutton-edit" data-options="plain:true,iconCls:\'fi-pencil icon-blue\'" onclick="tblClassEditFun(\'{0}\');" >编辑</a>', row.id);
                </shiro:hasPermission>
                <shiro:hasPermission name="/tblClass/delete">
                    str += '&nbsp;&nbsp;|&nbsp;&nbsp;';
                    str += $.formatString('<a href="javascript:void(0)" class="tblClass-easyui-linkbutton-del" data-options="plain:true,iconCls:\'fi-x icon-red\'" onclick="tblClassDeleteFun(\'{0}\');" >删除</a>', row.id);
                </shiro:hasPermission>
                <shiro:hasPermission name="/tblClass/edit">
                str += '&nbsp;&nbsp;|&nbsp;&nbsp;';
                str += $.formatString('<a href="javascript:void(0)" class="tblClass-easyui-linkbutton-detail" data-options="plain:true,iconCls:\'fi-book icon-blue\'" onclick="tblClassDetailFun(\'{0}\');" >详情</a>', row.id);
               </shiro:hasPermission>
              //alert(str);
                return str;
            }
              
            }
        } ] ],
        onLoadSuccess:function(data){
            $("#tblClassTreeGrid").treegrid("collapseAll");
            var roots= $("#tblClassTreeGrid").treegrid("getRoots");  
            for(var i=0;i<roots.length;i++){
                $("#tblClassTreeGrid").treegrid("expand", roots[i].id);  
            }
            $('.tblClass-easyui-linkbutton-edit').linkbutton({text:'编辑'});
            $('.tblClass-easyui-linkbutton-del').linkbutton({text:'删除'});
            $('.tblClass-easyui-linkbutton-detail').linkbutton({text:'详情'});
            
        },
        toolbar : '#tblClassToolbar'
    });
});
    
/**
 * 添加框
 * @param url
 */
function tblClassAddFun() {
    parent.$.modalDialog({
        title : '添加',
        width : 500,
        height : 350,
        href : '${path}/tblClass/addPage',
        buttons : [ {
            text : '确定',
            handler : function() {
                parent.$.modalDialog.openner_dataGrid = tblClassTreeGrid;//因为添加成功之后，需要刷新这个treeGrid，所以先预定义好
                var f = parent.$.modalDialog.handler.find('#tblClassAddForm');
                f.submit();
            }
        } ]
    });
}


/**
 * 编辑
 */
function tblClassEditFun(id) {
    if (id == undefined) {
        var rows = tblClassTreeGrid.treegrid('getSelections');
        id = rows[0].id;
    } else {
        tblClassTreeGrid.treegrid('unselectAll').treegrid('uncheckAll');
    }
    parent.$.modalDialog({
        title : '编辑',
        width : 500,
        height : 350,
        href :  '${path}/tblClass/editPage?id=' + id,
        buttons : [ {
            text : '确定',
            handler : function() {
                parent.$.modalDialog.openner_dataGrid = tblClassTreeGrid;//因为添加成功之后，需要刷新这个dataGrid，所以先预定义好
                var f = parent.$.modalDialog.handler.find('#tblClassEditForm');
                f.submit();
            }
        } ]
    });
    
}


/**
 * 详情
 */
function tblClassDetailFun(id) {
    if (id == undefined) {
        var rows = tblClassTreeGrid.treegrid('getSelections');
        id = rows[0].id;
    } else {
        tblClassTreeGrid.treegrid('unselectAll').treegrid('uncheckAll');
    }
    parent.$.modalDialog({
        title : '详情',
        width : 500,
        height : 350,
        href :  '${path}/tblClass/editPage?flage=1&id=' + id,
        buttons : [ {
            text : '关闭',
            handler : function() {
            	 parent.$.modalDialog.handler.dialog('close');
            }
        } ]
    });
    
}

/**
 * 删除
 */
 function tblClassDeleteFun(id) {
     if (id == undefined) {//点击右键菜单才会触发这个
         var rows = tblClassTreeGrid.treegrid('getSelections');
         id = rows[0].id;
     } else {//点击操作里面的删除图标会触发这个
         tblClassTreeGrid.treegrid('unselectAll').treegrid('uncheckAll');
     }
     parent.$.messager.confirm('询问', '您是否要删除当前班级？', function(b) {
         if (b) {
             progressLoad();
             $.post('${path}/tblClass/delete', {
                 id : id
             }, function(result) {
                 if (result.success) {
                     parent.$.messager.alert('提示', result.msg, 'info');
                     tblClassTreeGrid.treegrid('reload');
                 }
                 progressClose();
             }, 'JSON');
         }
     });
}



</script>

<div class="easyui-layout" data-options="fit:true,border:false">
    <!-- <div data-options="region:'north',border:false" style="height: 30px; overflow: hidden;background-color: #fff">
        <form id="tblClassSearchForm">
            <table>
                <tr>
                    <th>名称:</th>
                    <td><input name="name" placeholder="搜索条件"/></td>
                    <td>
                        <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'fi-magnifying-glass',plain:true" onclick="tblClassSearchFun();">查询</a>
                        <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'fi-x-circle',plain:true" onclick="tblClassCleanFun();">清空</a>
                    </td>
                </tr>
            </table>
        </form>
     </div> -->
 
    <div data-options="region:'center',border:false">
        <table id="tblClassTreeGrid" data-options="fit:true,border:false"></table>
    </div>
</div>
<div id="tblClassToolbar" style="display: none;">
    <shiro:hasPermission name="/tblClass/add">
        <a onclick="tblClassAddFun();" href="javascript:void(0);" class="easyui-linkbutton" data-options="plain:true,iconCls:'fi-plus icon-green'">添加</a>
    </shiro:hasPermission>
</div>