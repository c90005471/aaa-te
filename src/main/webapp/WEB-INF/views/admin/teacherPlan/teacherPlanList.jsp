<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/global.jsp" %>
<script type="text/javascript">
    var teacherPlanDataGrid;
    var teacherPlanClassTree;
    var orgidTea;
    var classidTea;
    var classname;
    $(function() {
    	//设置每月开始时间  和下个月的结束时间
      $("#begintimeTeaPlanId").val(time(1));
      $("#stoptimeTeaPlanId").val(time(0));
     teacherPlanClassTree = $('#teacherPlanClassTree').tree({
            url : '${path }/tblClass/tree?Math.random()',
            parentField : 'pid',
            lines : true,
            onLoadSuccess: function (node, data) {
            	$("#teacherPlanClassTree").tree("collapseAll");
            	var roots= $("#teacherPlanClassTree").tree('getRoots');  
                for(var i=0;i<roots.length;i++){  
                    $("#teacherPlanClassTree").tree('expand', roots[i].target);  
                }
             },
            onClick : function(node) {
                //返回树对象  
        	    var tree = $(this).tree;  
        	//选中的节点是否为叶子节点,如果不是叶子节点,清除所有右边的数据
        		var isLeaf = tree('isLeaf', node.target);  
        		if (!isLeaf) {  
        		    //$("#teacherPlanToolbar").hide();//将添加按钮隐藏
            		//teacherPlanDataGrid.datagrid('loadData', []); 
        			orgidTea = node.id;
        		    classidTea = null;
        		    $("#orgidTea").val(orgidTea);
        		    $("#classidTea").val("");
        		    teacherPlanDataGrid.datagrid('load',$.serializeObject($('#teacherPlanSearchForm')));
        		}else{ 		
        		    //将classid传入到后台
        		    classidTea=node.id;
        		    orgidTea = null;
        		    classname=node.text;
        		    var treeParent = $(this).tree('getParent', node.target); 
        		    //orgid=treeParent.id;//获取orgid
        		    leafNode=true;
        		    $("#orgidTea").val("");
        		    $("#classidTea").val(classidTea);
        			teacherPlanDataGrid.datagrid('load', $.serializeObject($('#teacherPlanSearchForm')));
                	//将添加按钮显示
        			teacherPlanDataGrid.datagrid( {
                    	toolbar : '#teacherPlanToolbar'
                	}
                	
                	);
        		}
            }
        });
        teacherPlanDataGrid = $('#teacherPlanDataGrid').datagrid({
        url : '${path}/teacherPlan/dataGrid',
        queryParams:$.serializeObject($('#teacherPlanSearchForm')),
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
            title : '计划ID',
            field : 'id',
            sortable : true
        }, 
        {
            title : '教师编号',
            field : 'teacherno',
            sortable : true,
            hidden:true
        }, 
        {
            title : '教师姓名',
            field : 'teachername'
        },
        {
            title : '教师类型',
            field : 'rolename'
        },
        {
            title : '开始时间',
            field : 'begintime'
          
        }, {
            title : '结束时间',
            field : 'stoptime'
          
        },{
            title : '制定人id',
            field : 'makerid',
            hidden:true
        },{
            title : '制定人',
            field : 'name'
          
        },{
            title : '制定时间',
            field : 'maketime'
          
        },
        {
            title : '班级',
            field : 'classid',
            hidden:true
          
        },
        {
            title : '班级名称',
            field : 'classname'
          
        },
         {
            title : '评价类型',
            field : 'isFen',
            formatter : function(value, row, index) {
                switch (row.isFen) {
                case 1:
                    return '分模块';
                case undefined:
                    return '正常';
                }
            }
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
                }
            }
        },
        
 		<shiro:hasPermission name="/teacherPlan/edit">
        {
            title : '验证码',
            field : 'code'
        }, 
        </shiro:hasPermission>
        /* {
            title : '得分',
            field : 'score'
        },  */
        {
            field : 'action',
            title : '操作',
            width : 200,
            formatter : function(value, row, index) {
                var str = '';
                <shiro:hasPermission name="/teacherPlan/edit">
                    str += $.formatString('<a href="javascript:void(0)" class="teacherPlan-easyui-linkbutton-edit" data-options="plain:true,iconCls:\'fi-pencil icon-blue\'" onclick="teacherPlanEditFun(\'{0}\',\'{1}\',\'{2}\');" >编辑</a>', row.id,row.classname,row.classid);
                </shiro:hasPermission>
                <shiro:hasPermission name="/teacherPlan/delete">
                    str += '&nbsp;&nbsp;|&nbsp;&nbsp;';
                    str += $.formatString('<a href="javascript:void(0)" class="teacherPlan-easyui-linkbutton-del" data-options="plain:true,iconCls:\'fi-x icon-red\'" onclick="teacherPlanDeleteFun(\'{0}\');" >删除</a>', row.id);
                </shiro:hasPermission>
                return str;
            }
        } ] ],
        onLoadSuccess:function(data){
            $('.teacherPlan-easyui-linkbutton-edit').linkbutton({text:'编辑'});
            $('.teacherPlan-easyui-linkbutton-del').linkbutton({text:'删除'});
        },
        //toolbar : '#teacherPlanToolbar'
    });
       
});

/**
 * 添加框
 * @param url
 */
function teacherPlanAddFun() {
    parent.$.modalDialog({
        title : '添加',
        width : 550,
        height : 190,
        href : '${path}/teacherPlan/addPage',
        buttons : [ {
            text : '确定',
            width:50,
            handler : function() {
                parent.$.modalDialog.openner_dataGrid = teacherPlanDataGrid;//因为添加成功之后，需要刷新这个treeGrid，所以先预定义好
                var f = parent.$.modalDialog.handler.find('#teacherPlanAddForm');
                f.submit();
            }
        } ]
    });
}


/**
 * 编辑
 */
function teacherPlanEditFun(id,classname,classid) {

    if (id == undefined) {
        var rows = teacherPlanDataGrid.datagrid('getSelections');
        id = rows[0].id;
        classname=teacherPlanDataGrid.datagrid('getSelections')[0].classname;
		classid=teacherPlanDataGrid.datagrid('getSelections')[0].classid;
    } else {
        teacherPlanDataGrid.datagrid('unselectAll').datagrid('uncheckAll');
    }
    parent.$.modalDialog({
        title : '编辑',
        width : 550,
        height : 230,
        href :  '${path}/teacherPlan/editPage?id=' + id+'&classname='+classname+'&classid='+classid,
        buttons : [ {
            text : '确定',
            width:50,
            handler : function() {
                parent.$.modalDialog.openner_dataGrid = teacherPlanDataGrid;//因为添加成功之后，需要刷新这个dataGrid，所以先预定义好
                var f = parent.$.modalDialog.handler.find('#teacherPlanEditForm');
                f.submit();
            }
        } ]
    });
}


/**
 * 删除
 */
 function teacherPlanDeleteFun(id) {
     if (id == undefined) {//点击右键菜单才会触发这个
         var rows = teacherPlanDataGrid.datagrid('getSelections');
         id = rows[0].id;
     } else {//点击操作里面的删除图标会触发这个
         teacherPlanDataGrid.datagrid('unselectAll').datagrid('uncheckAll');
     }
     parent.$.messager.confirm('询问', '您是否要删除当前计划？', function(b) {
         if (b) {
             progressLoad();
             $.post('${path}/teacherPlan/delete', {
                 id : id
             }, function(result) {
                 if (result.success) {
                     parent.$.messager.alert('提示', result.msg, 'info');
                     teacherPlanDataGrid.datagrid('reload');
                 }
                 progressClose();
             }, 'JSON');
         }
     });
}


/**
 * 清除
 */
function teacherPlanCleanFun() {
	orgidTea = null;
	classidTea = null;
    $('#teacherPlanSearchForm input').val('');
    teacherPlanDataGrid.datagrid('load', {});
}
/**
 * 搜索
 */
function teacherPlanSearchFun() {
	$("#orgidTea").val(orgidTea);
	$("#classidTea").val(classidTea);
     teacherPlanDataGrid.datagrid('load', $.serializeObject($('#teacherPlanSearchForm')));
}
//设月底跟月头时间  
function time(number){  
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
        <form id="teacherPlanSearchForm">
            <table>
                <tr>
                    <th>教师姓名:</th>
                    <td>
                    	<input type="hidden" name="orgid" id="orgidTea"/>
                    	<input type="hidden" name="classid" id="classidTea"/>
                    	<input id="teacherName" name="teacherName" placeholder="搜索教师姓名"/>
                    </td>
                    <th>教评开始时间:</th>
                    <td>
                    	<input id="begintimeTeaPlanId" name="beginTime"  type="text" editable="false" class="easyui-datebox" ></input> 
                    </td>
                    
                    <th>教评结束时间:</th>
                    <td>
                    	<input id="stoptimeTeaPlanId" name="stopTime"  type="text" editable="false" class="easyui-datebox"></input>
                    </td>
                    <td>
                        <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'fi-magnifying-glass',plain:true" onclick="teacherPlanSearchFun();">查询</a>
                        <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'fi-x-circle',plain:true" onclick="teacherPlanCleanFun();">清空</a>
                    </td>
                </tr>
            </table>
        </form>
     </div> 
 
    <div data-options="region:'center',border:false,title:'计划列表'">
        <table id="teacherPlanDataGrid" data-options="fit:true,border:false"></table>
    </div>
     <div data-options="region:'west',border:true,split:false,title:'班级组织'"  style="width:180px;overflow: auto; ">
        <ul id="teacherPlanClassTree" style="width:160px;margin: 10px 10px 10px 10px"></ul>
    </div>
</div>
<div id="teacherPlanToolbar" style="display: none;">
    <shiro:hasPermission name="/teacherPlan/add">
        <a onclick="teacherPlanAddFun();" href="javascript:void(0);" class="easyui-linkbutton" data-options="plain:true,iconCls:'fi-plus icon-green'">添加计划</a>
    </shiro:hasPermission>
</div>