<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/global.jsp" %>
<script type="text/javascript">
    var stuEvaluateDataGrid;
    var stuEvaluateClassTree;
    var orgidStu = null;
    var classidStu = null;
    var selectStr;
    $(function() {
     stuEvaluateClassTree = $('#stuEvaluateClassTree').tree({
            url : '${path }/tblClass/tree?Math.random()',
            parentField : 'pid',
            lines : true,
            onLoadSuccess: function (node, data) {
            	$("#stuEvaluateClassTree").tree("collapseAll");
            	var roots= $("#stuEvaluateClassTree").tree('getRoots');  
                for(var i=0;i<roots.length;i++){  
                    $("#stuEvaluateClassTree").tree('expand', roots[i].target);  
                }
              },
            onClick : function(node) {
                //返回树对象  
        	    var tree = $(this).tree;  
        	//选中的节点是否为叶子节点,如果不是叶子节点,清除所有右边的数据
        		var isLeaf = tree('isLeaf', node.target);  
        		if (!isLeaf) {  
        		   // $("#stuEvaluateToolbar").hide();//将添加按钮隐藏
            		//stuEvaluateDataGrid.datagrid('loadData', []);  
        			orgidStu = node.id;
        		    classidStu = null;
                	$("#orgidStu").val(orgidStu);
                	$("#classidStu").val("");
        		    stuEvaluateDataGrid.datagrid('load', $.serializeObject($('#stuEvaluateSearchForm')));
        		}else
        		{ 
        		    //将classid传入到后台
        		    classidStu=node.id;
        		    orgidStu = null;
        		    var treeParent = $(this).tree('getParent', node.target); 
        		    //orgid=treeParent.id;//获取orgid
        		    $("#orgidStu").val("");
                	$("#classidStu").val(classidStu);
        			stuEvaluateDataGrid.datagrid('load',$.serializeObject($('#stuEvaluateSearchForm')));
                	//将添加按钮显示
        			/* stuEvaluateDataGrid.datagrid( {
                    	toolbar : '#stuEvaluateToolbar'
                	}
                	
                	); */
        		}
            }
        });
     	$("#begintimeid").val(timeStu(1));
     	$("#endtimeid").val(timeStu(0));
        stuEvaluateDataGrid = $('#stuEvaluateDataGrid').datagrid({
        url : '${path}/stuPlan/dataGrid',
        queryParams:$.serializeObject($('#stuEvaluateSearchForm')),
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
            title : '阶段/章节ID',
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
        },{
            title : '得分',
            field : 'score'
        },
        {
            field : 'action',
            title : '操作',
            width : 260,
            formatter : function(value, row, index) {
                var str = '';
                <shiro:hasPermission name="/stuEvaluate/showDetail">
                    str += $.formatString('<a href="javascript:void(0)" class="stuPlan-easyui-linkbutton-show" data-options="plain:true,iconCls:\'fi-results icon-purple\'" onclick="showStuDetail(\'{0}\',\'{1}\');" >查看详情</a>', row.id,row.classid);
                </shiro:hasPermission>
                <shiro:hasPermission name="/stuEvaluate/showCount">
                    str += '&nbsp;&nbsp;|&nbsp;&nbsp;';
                    str += $.formatString('<a href="javascript:void(0)" class="stuPlan-easyui-linkbutton-count" data-options="plain:true,iconCls:\'fi-graph-pie icon-purple\'" onclick="showStuCount(\'{0}\',\'{1}\');" >统计分析</a>', row.id,row.classname);
                </shiro:hasPermission>
                <shiro:hasPermission name="/stuEvaluate/showRate">
                    str += '&nbsp;&nbsp;|&nbsp;&nbsp;';
                    str += $.formatString('<a href="javascript:void(0)" class="stuPlan-easyui-linkbutton-rate" data-options="plain:true,iconCls:\'fi-web icon-purple\'" onclick="showStuRate(\'{0}\');" >自评率</a>', row.id);
                </shiro:hasPermission>
                return str;
            }
        } ] ],
        onLoadSuccess:function(data){
            $('.stuPlan-easyui-linkbutton-show').linkbutton({text:'查看详情'});
            $('.stuPlan-easyui-linkbutton-count').linkbutton({text:'统计分析'});
            $('.stuPlan-easyui-linkbutton-rate').linkbutton({text:'自评率'});
        },
        toolbar : '#stuEvaluateToolbar'
    });
        
});




/**
 * 显示详情
 */
function showStuDetail(id,classid) {
   
    if (id == undefined) {
        var rows = stuEvaluateDataGrid.datagrid('getSelections');
        id = rows[0].id;
        classid=rows[0].classid;
    } else {
        stuEvaluateDataGrid.datagrid('unselectAll').datagrid('uncheckAll');
    }
    parent.$.modalDialog({
        title : '显示详情',
        width : 700,
        height : 400,
        href :  '${path}/stuEvaluate/showDetailPage?planid=' + id+'&&classid='+classid
    });
}
//显示统计图表
function showStuCount(id,classname) {
    if (id == undefined) {
        var rows = stuEvaluateDataGrid.datagrid('getSelections');
        id = rows[0].id;
        classid=rows[0].classid;
        selectStr = "班级："+rows[0].classname;
    } else {
    	 selectStr = "班级："+classname;
        stuEvaluateDataGrid.datagrid('unselectAll').datagrid('uncheckAll');
    }
    parent.$.modalDialog({
        title : '显示章节知识点掌握情况',
        width : 600,
        height : 450,
        href :  '${path}/stuEvaluate/showCountPage?planid=' + id
    });
}
//显示统计比率图表
function showStuRate(id) {
    if (id == undefined) {
        var rows = stuEvaluateDataGrid.datagrid('getSelections');
        id = rows[0].id;
        classid=rows[0].classid;
    } else {
        stuEvaluateDataGrid.datagrid('unselectAll').datagrid('uncheckAll');
    }
    parent.$.modalDialog({
        title : '显示自评比例情况',
        width : 600,
        height : 450,
        href :  '${path}/stuEvaluate/showRade?planid=' + id
    });
}

/**
 * 清除
 */
function stuEvaluateCleanFun() {
	classidStu = null;
    selectStr = null;
    $('#stuEvaluateSearchForm input').val('');
    stuEvaluateDataGrid.datagrid('load', {});
}
/**
 * 搜索
 */
function stuEvaluateSearchFun() {
	 $("#orgidStu").val(orgidStu);
	 $("#classidStu").val(classidStu);
     stuEvaluateDataGrid.datagrid('load', $.serializeObject($('#stuEvaluateSearchForm')));
}
//设月底跟月头时间  
function timeStu(number){  
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
/**
 * 导出excel
 */
function exportStuEvaluateExcel(){
	var datagridRows = stuEvaluateDataGrid.datagrid("getRows");
    var columns = stuEvaluateDataGrid.datagrid("options").columns[0];
    var dataRows={columns:columns,datagridRows:datagridRows};
    if(datagridRows.length>0){
    	 $.ajax({
      		url:"${path}/stuPlan/exportStuEvaluateExcel",
      		type:"post",
      		contentType:"application/json", 
      		async: false,
      	 	data:JSON.stringify(dataRows),
      	 	success:function(data){
      	 	  	var fileName=data;
      			//下载文件
      			location.href="${path}/download/"+fileName.replace('"','').replace('"',''); 
      	 	}
      	 	
      	 });
    }else{
    	parent.$.messager.alert('警告', '请先查询出结果列表！');
    }
	
}
</script>

<div class="easyui-layout" data-options="fit:true,border:false">
<div data-options="region:'north',border:false" style="height: 30px; overflow: hidden;background-color: #fff">
        <form id="stuEvaluateSearchForm">
            <table>
                <tr>
                    <td>开始时间:</td>
                    <td>
                    	<input  type="hidden" name="orgid" id="orgidStu"/>
                    	<input  type="hidden" name="classid" id="classidStu"/>
                        <input id="begintimeid" name="beginTime"  type="text" editable="false" class="easyui-datebox" ></input>
                        &nbsp;&nbsp; 结束时间：
                        <input id="endtimeid" name="endTime"  type="text" editable="false" class="easyui-datebox"></input>
                        &nbsp;&nbsp;阶段/章节：
                        <select name="courseType">
                        	<option value="2,3">阶段自评</option>
                        	<option value="0,1">章节自评</option>
                        	<option value="0,1,2,3">全部</option>
                        </select>
                        <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'fi-magnifying-glass',plain:true" onclick="stuEvaluateSearchFun();">查询</a>
                        <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'fi-x-circle',plain:true" onclick="stuEvaluateCleanFun()">清空</a>
                    </td>
                </tr>
            </table>
        </form>
    </div>
 
    <div data-options="region:'center',border:false,title:'自评计划列表'">
        <table id="stuEvaluateDataGrid" data-options="fit:true,border:false"></table>
    </div>
     <div data-options="region:'west',border:true,split:false,title:'班级组织'"  style="width:180px;overflow: auto; ">
        <ul id="stuEvaluateClassTree" style="width:160px;margin: 10px 10px 10px 10px"></ul>
    </div>
</div>
 <div id="stuEvaluateToolbar" style="display: none;">
    <a onclick="exportStuEvaluateExcel();" id="export" href="javascript:void(0);"   class="easyui-linkbutton" data-options="plain:true,iconCls:'fi-download icon-green'">导出excel</a>
</div> 