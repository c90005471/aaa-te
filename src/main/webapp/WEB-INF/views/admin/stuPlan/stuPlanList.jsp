<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/global.jsp" %>
<script type="text/javascript">
    var stuPlanDataGrid;
    var stuPlanClassTree;
    var orgidStuPlan;
    var classidStuPlan;
    $(function() {
    	$("#begintimeId").val(timeStuPlan(1));
        $("#endtimeId").val(timeStuPlan(0));
        
     stuPlanClassTree = $('#stuPlanClassTree').tree({
            url : '${path }/tblClass/tree?Math.random()',
            parentField : 'pid',
            lines : true,
            onLoadSuccess: function (node, data) {
            	$("#stuPlanClassTree").tree("collapseAll");
            	var roots= $("#stuPlanClassTree").tree('getRoots');  
                for(var i=0;i<roots.length;i++){  
                    $("#stuPlanClassTree").tree('expand', roots[i].target);  
                }
             },
            onClick : function(node) {
                //返回树对象  
        	    var tree = $(this).tree;  
        	//选中的节点是否为叶子节点,如果不是叶子节点,清除所有右边的数据
        		var isLeaf = tree('isLeaf', node.target);  
        		if (!isLeaf) {  
        		    //$("#stuPlanToolbar").hide();//将添加按钮隐藏
            		//stuPlanDataGrid.datagrid('loadData', []);  
        			orgidStuPlan = node.id;
        			classidStuPlan = null;
                	$("#orgidStuPlan").val(orgidStuPlan);
                	$("#classidStuPlan").val("");
        			stuPlanDataGrid.datagrid('load', $.serializeObject($('#stuPlanSearchForm')));
        		}else{ 
        		    //将classid传入到后台
        		    classidStuPlan=node.id;
        		    orgidStuPlan = null;
        		    var treeParent = $(this).tree('getParent', node.target); 
        		    orgidStuPlan=treeParent.id;//获取orgid
        		    $("#orgidStuPlan").val("");
                	$("#classidStuPlan").val(classidStuPlan);
        			stuPlanDataGrid.datagrid('load',$.serializeObject($('#stuPlanSearchForm')));
                	//将添加按钮显示
        			stuPlanDataGrid.datagrid( {
                    	toolbar : '#stuPlanToolbar'
                	}
                	
                	);
        		}
            }
        });
        stuPlanDataGrid = $('#stuPlanDataGrid').datagrid({
        url : '${path}/stuPlan/dataGrid',
        queryParams:$.serializeObject($('#stuPlanSearchForm')),
        striped : true,
        rownumbers : true,
        pagination : true,
        singleSelect : true,
        idField : 'id',
        sortName : 'id',
        sortOrder : 'asc',
        pageSize : 20,
        pageList : [ 10, 20, 30, 40, 50, 100, 200, 300, 400, 500],
        frozenColumns : [ [ {
            title : '计划ID',
            field : 'id',
            sortable : true
        }, 
        {
            title : '章节ID',
            field : 'chapterid',
            sortable : true,
            hidden:true
        }
        , 
        {
            title : '阶段/章节名称',
            field : 'coursename'
        },
        {
            title : '开始时间',
            field : 'begintime'
          
        }, {
            title : '结束时间',
            field : 'endtime'
          
        },
        {
            title : '班级ID',
            field : 'classid',
            hidden:true
          
        },
        {
            title : '班级名称',
            field : 'classname'
          
        },
        {
            title : '教员',
            field : 'teachername'
          
        },
        {
            title : '制定人ID',
            field : 'createuserid',
            hidden:true
          
        }
        ,
        {
            title : '制定人',
            field : 'name'
          
        },
        {
            title : '制定时间',
            field : 'createtime'
        }, 
        {
            title : '状态',
            field : 'dostatus',
            formatter : function(value, row, index) {
                switch (row.dostatus) {
                case 0:
                    return '未执行';
                case 1:
                    return '已结束';
               /*  case 2:
                    return '已过期'; */
                }
            }
        }, 
        {
            field : 'action',
            title : '操作',
            width : 200,
            formatter : function(value, row, index) {
                var str = '';
                <shiro:hasPermission name="/stuPlan/edit">
                    str += $.formatString('<a href="javascript:void(0)" class="stuPlan-easyui-linkbutton-edit" data-options="plain:true,iconCls:\'fi-pencil icon-blue\'" onclick="stuPlanEditFun(\'{0}\');" >编辑</a>', row.id);
                </shiro:hasPermission>
                <shiro:hasPermission name="/stuPlan/delete">
                    str += '&nbsp;&nbsp;|&nbsp;&nbsp;';
                    str += $.formatString('<a href="javascript:void(0)" class="stuPlan-easyui-linkbutton-del" data-options="plain:true,iconCls:\'fi-x icon-red\'" onclick="stuPlanDeleteFun(\'{0}\');" >删除</a>', row.id);
                </shiro:hasPermission>
                return str;
            }
        } ] ],
        onLoadSuccess:function(data){
            $('.stuPlan-easyui-linkbutton-edit').linkbutton({text:'编辑'});
            $('.stuPlan-easyui-linkbutton-del').linkbutton({text:'删除'});
        },
        //toolbar : '#stuPlanToolbar'
    });
});

/**
 * 添加框
 * @param url
 */
function stuPlanAddFun() {
    parent.$.modalDialog({
        title : '添加',
        width : 500,
        height : 240,
        href : '${path}/stuPlan/addPage',
        buttons : [ {
            text : '确定',
            handler : function() {
                parent.$.modalDialog.openner_dataGrid = stuPlanDataGrid;//因为添加成功之后，需要刷新这个treeGrid，所以先预定义好
                var f = parent.$.modalDialog.handler.find('#stuPlanAddForm');
                f.submit();
            }
        } ]
    });
}


/**
 * 编辑
 */
function stuPlanEditFun(id) {
    if (id == undefined) {
        var rows = stuPlanDataGrid.datagrid('getSelections');
        id = rows[0].id;
    } else {
        stuPlanDataGrid.datagrid('unselectAll').datagrid('uncheckAll');
    }
    parent.$.modalDialog({
        title : '编辑',
        width : 550,
        height : 230,
        href :  '${path}/stuPlan/editPage?id=' + id,
        buttons : [ {
            text : '确定',
            handler : function() {
                parent.$.modalDialog.openner_dataGrid = stuPlanDataGrid;//因为添加成功之后，需要刷新这个dataGrid，所以先预定义好
                var f = parent.$.modalDialog.handler.find('#stuPlanEditForm');
                f.submit();
            }
        } ]
    });
}


/**
 * 删除
 */
 function stuPlanDeleteFun(id) {
     if (id == undefined) {//点击右键菜单才会触发这个
         var rows = stuPlanDataGrid.datagrid('getSelections');
         id = rows[0].id;
     } else {//点击操作里面的删除图标会触发这个
         stuPlanDataGrid.datagrid('unselectAll').datagrid('uncheckAll');
     }
     parent.$.messager.confirm('询问', '您是否要删除当前计划？', function(b) {
         if (b) {
             progressLoad();
             $.post('${path}/stuPlan/delete', {
                 id : id
             }, function(result) {
                 if (result.success) {
                     parent.$.messager.alert('提示', result.msg, 'info');
                     stuPlanDataGrid.datagrid('reload');
                 }
                 progressClose();
             }, 'JSON');
         }
     });
}


/**
 * 清除
 */
function stuPlanCleanFun() {
	classidStuPlan = null;
	orgidStuPlan = null;
    $('#stuPlanSearchForm input').val('');
    stuPlanDataGrid.datagrid('load', {});
}
/**
 * 搜索
 */
function stuPlanSearchFun() {
    $("#orgidStuPlan").val(orgidStuPlan);
	 $("#classidStuPlan").val(classidStuPlan);
     stuPlanDataGrid.datagrid('load', $.serializeObject($('#stuPlanSearchForm')));
}
//设月底跟月头时间  
function timeStuPlan(number){  
    var date=new Date();  
    var strDate=date.getFullYear()+"-";  
    if(number==0){ //0 为月底  
    	strDate+=date.getMonth()+3+"-";  
   	 	strDate+=number;  
    }else{  
    	strDate+=date.getMonth()+1+"-";  
    	strDate+=number;  
    }  
    return strDate;  
} 
</script>

<div class="easyui-layout" data-options="fit:true,border:false">
     <div data-options="region:'north',border:false" style="height: 30px; overflow: hidden;background-color: #fff">
        <form id="stuPlanSearchForm">
            <table>
                <tr>
                    <td>开始时间:</td>
                    <td>
                    	<input type="hidden"  name="orgid" id="orgidStuPlan"/>
                    	<input  type="hidden" name="classid" id="classidStuPlan"/>
                        <input id="begintimeId" name="beginTime"  type="text" editable="false" class="easyui-datebox" ></input>
                        &nbsp;&nbsp; 结束时间：
                        <input id="endtimeId" name="endTime"  type="text" editable="false" class="easyui-datebox"></input>
                        &nbsp;&nbsp;阶段/章节：
                        <select name="courseType">
                        	<option value="2,3">阶段自评</option>
                        	<option value="0,1">章节自评</option>
                        	<option value="0,1,2,3">全部</option>
                        </select>
                        <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'fi-magnifying-glass',plain:true" onclick="stuPlanSearchFun();">查询</a>
                        <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'fi-x-circle',plain:true" onclick="stuPlanCleanFun()">清空</a>
                    </td>
                </tr>
            </table>
        </form>
     </div> 
 
    <div data-options="region:'center',border:false,title:'计划列表'">
        <table id="stuPlanDataGrid" data-options="fit:true,border:false"></table>
    </div>
     <div data-options="region:'west',border:true,split:false,title:'班级组织'"  style="width:180px;overflow: auto; ">
        <ul id="stuPlanClassTree" style="width:160px;margin: 10px 10px 10px 10px"></ul>
    </div>
</div>
<div id="stuPlanToolbar" style="display: none;">
    <shiro:hasPermission name="/stuPlan/add">
        <a onclick="stuPlanAddFun();" href="javascript:void(0);" class="easyui-linkbutton" data-options="plain:true,iconCls:'fi-plus icon-green'">添加计划</a>
    </shiro:hasPermission>
</div>