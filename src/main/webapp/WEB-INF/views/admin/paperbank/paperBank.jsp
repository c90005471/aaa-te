<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/global.jsp" %>
<script type="text/javascript">
    var paperBankDataGrid;
    var topicInfoNode = false;
    var topictype;
    $(function() {
    	var topicTypesTree = $('#topicTypesTree').tree({
            url : '${path }/topicInfo/tree?Math.random()',
            parentField : 'pid',
            lines : true,
            onClick : function(node) {
            	topicInfoNode = true;
            	topictype = node.id;
            	$("#topictype").val(topictype);
            	paperBankDataGrid.datagrid('load',$.serializeObject($('#paperBankSearchForm')));
            }
        });


    	paperBankDataGrid = $('#paperBankDataGrid').datagrid({
        url : '${path}/paperBank/dataGridBank',
        fit : true,
        striped : true,
        rownumbers : true,
        pagination : true,
        singleSelect : true,
        idField : 'id',
        sortName : 'id',
        sortOrder : 'asc',
        pageSize : 20,
        pageList : [ 10, 20, 30, 40, 50, 100, 200, 300, 400, 500],
        columns : [ [ {
            width : '60',
            title : '编号',
            field : 'id',
            sortable : true
        },{
            width : '560',
            title : '名称',
            field : 'papername',
            sortable : true,
            formatter:function(value,row,index){
            	return escape4html(value);
            }
        },{
            width : '50',
            title : '数量',
            field : 'counts',
            sortable : true,

        },{
            width : '80',
            title : '创建人',
            field : 'teachername',
            sortable : true
        }, {
            field : 'action',
            title : '操作',
            width : 200,
            formatter : function(value, row, index) {
                var str = '';
                <shiro:hasPermission name="/topicInfo/edit">
                    str += $.formatString('<a href="javascript:void(0)" class="topicInfo-easyui-linkbutton-edit" data-options="plain:true,iconCls:\'fi-pencil icon-blue\'" onclick="topicInfoEditFun(\'{0}\');" >编辑</a>', row.id);
                </shiro:hasPermission>
                <shiro:hasPermission name="/topicInfo/delete">
                    str += '&nbsp;&nbsp;|&nbsp;&nbsp;';
                    str += $.formatString('<a href="javascript:void(0)" class="topicInfo-easyui-linkbutton-del" data-options="plain:true,iconCls:\'fi-x icon-red\'" onclick="topicInfoDeleteFun(\'{0}\');" >删除</a>', row.id);
                </shiro:hasPermission>
                return str;
            }
        } ] ],
        onLoadSuccess:function(data){
            $('.topicInfo-easyui-linkbutton-edit').linkbutton({text:'编辑'});
            $('.topicInfo-easyui-linkbutton-del').linkbutton({text:'删除'});
        },
        toolbar : '#paperBankToolbar'
    });

});
    //格式化html代码显示到页面上
    function escape4html(str){
		var sb = "";
        var strs = str.split("");
		for(var i=0;i<strs.length;i++){
            if(strs[i] =='"')
            	sb+="&quot;";
            else if(strs[i] =='<')
            	sb+="&lt;";
            else if(strs[i] =='>')
            	sb+="&gt;";
            else
            	sb+=strs[i];
        }
		//alert(sb);
        return sb;
	}
/**
 * 添加框
 * @param url
 */
function topicInfoAddFun() {

    parent.$.modalDialog({
        title : '添加',
        width : 550,
        height : 540,
        href : '${path}/topicInfo/addPage',
        buttons : [ {
            text : '确定',
            handler : function() {
                parent.$.modalDialog.openner_dataGrid = paperBankDataGrid;//因为添加成功之后，需要刷新这个treeGrid，所以先预定义好
                var f = parent.$.modalDialog.handler.find('#topicInfoAddForm');
                f.submit();
            }
        } ]
    });

}


/**
 * 编辑
 */
function topicInfoEditFun(id) {
    if (id == undefined) {
        var rows = paperBankDataGrid.datagrid('getSelections');
        id = rows[0].id;
    } else {
    	paperBankDataGrid.datagrid('unselectAll').datagrid('uncheckAll');
    }
    parent.$.modalDialog({
        title : '编辑',
        width : 550,
        height : 540,
        href :  '${path}/paperBank/editPage?id=' + id,
        buttons : [ {
            text : '确定',
            handler : function() {
                parent.$.modalDialog.openner_dataGrid = paperBankDataGrid;//因为添加成功之后，需要刷新这个dataGrid，所以先预定义好
                var f = parent.$.modalDialog.handler.find('#topicInfoEditForm');
                f.submit();
            }
        } ]
    });
}
/**
 * 删除
 */
 function topicInfoDeleteFun(id) {
     if (id == undefined) {//点击右键菜单才会触发这个
         var rows = paperBankDataGrid.datagrid('getSelections');
         id = rows[0].id;
     } else {//点击操作里面的删除图标会触发这个
    	 paperBankDataGrid.datagrid('unselectAll').datagrid('uncheckAll');
     }
     parent.$.messager.confirm('询问', '您是否要删除当前题目？', function(b) {
         if (b) {
             progressLoad();
             $.post('${path}/paperBank/delete', {
                 id : id
             }, function(result) {
                 if (result.success) {
                     parent.$.messager.alert('提示', result.msg, 'info');
                     paperBankDataGrid.datagrid('reload');
                 }
                 progressClose();
             }, 'JSON');
         }
     });
}


/**
 * 清除
 */
function topicInfoCleanFun() {
    $('#paperBankSearchForm input').val('');
    paperBankDataGrid.datagrid('load', {});
}
/**
 * 搜索
 */
function topicInfoSearchFun() {
	paperBankDataGrid.datagrid('load', $.serializeObject($('#paperBankSearchForm')));
}

    /**
     * 查看详情
     */
    function examPaperShowFun(){
        parent.$.modalDialog({
            title : '智能组卷',
            width : 1200,
            height : 580,
            href :  '${path}/examPaper/showPage'
        });
    }

    function examPaperAddFun(){
        parent.$.modalDialog({
            title : '试卷添加',
            width : 420,
            height : 120,
            href :  '${path}/paperBank/addPage',
            buttons : [ {
                text : '确定',
                handler : function() {
                    parent.$.modalDialog.openner_dataGrid = paperBankDataGrid;//因为添加成功之后，需要刷新这个dataGrid，所以先预定义好
                    var f = parent.$.modalDialog.handler.find('#paperAddForm');
                    f.submit();
                }
            } ]
        });
    }


    /**
     * @author ky
     * @date 2020/2/17
     * 手动组卷
     **/
    function examPapeManualFun() {
        parent.$.modalDialog({
            title : '手动组卷',
            width : 1200,
            height : 580,
            href :  '${path}/examPaper/manualPage'
        });
    }

</script>

<div class="easyui-layout" data-options="fit:true,border:false">
    <div data-options="region:'north',border:false" style="height: 30px; overflow: hidden;background-color: #fff">
        <form id="paperBankSearchForm">
            <table>
                <tr>
                     <th>名称:</th>
                     <td>
<%--                    	<input type="hidden" id="papername" name="papername"/>--%>
                    	<input type="text" name="papername">
                     </td>
                    <td>
                        <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'fi-magnifying-glass',plain:true" onclick="topicInfoSearchFun();">查询</a>
                        <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'fi-x-circle',plain:true" onclick="topicInfoCleanFun();">清空</a>
                    </td>
                </tr>
            </table>
        </form>
     </div>
    <div data-options="region:'center',border:true,title:'试卷列表'" >
        <table id="paperBankDataGrid" data-options="fit:true,border:false" ></table>
    </div>
</div>
<div id="paperBankToolbar" >
    <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'fi-plus',plain:true" onclick="examPaperAddFun();">新增试卷</a>
    <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'fi-pencil',plain:true" onclick="examPaperShowFun();">智能组卷</a>
    <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'fi-pencil',plain:true" onclick="examPapeManualFun();">手动组卷</a>
</div>