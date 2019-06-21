<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/global.jsp" %>
<script type="text/javascript">
    var teaEvaluateDataGrid;
    var teaEvaluateClassTree;
    var orgid;
    var classid;
    var selectRowStr;
    $(function() {
     teaEvaluateClassTree = $('#teaEvaluateClassTree').tree({
            url : '${path }/tblClass/tree?Math.random()',
            parentField : 'pid',
            lines : true,
            onLoadSuccess: function (node, data) {
            	$("#teaEvaluateClassTree").tree("collapseAll");
            	var roots= $("#teaEvaluateClassTree").tree('getRoots');  
                for(var i=0;i<roots.length;i++){  
                    $("#teaEvaluateClassTree").tree('expand', roots[i].target);  
                }
             },
            onClick : function(node) {
                //返回树对象  
        	    var tree = $(this).tree;  
        	//选中的节点是否为叶子节点,如果不是叶子节点,清除所有右边的数据
        		var isLeaf = tree('isLeaf', node.target);  
        		if (!isLeaf) {  
        		   // $("#stuEvaluateToolbar").hide();//将添加按钮隐藏
            	   //teaEvaluateDataGrid.datagrid('loadData', []);
        			orgid = node.id;
        		    classid = null;
                	$("#orgid").val(orgid);
                	$("#classid").val("");
        		    teaEvaluateDataGrid.datagrid('load',$.serializeObject($('#teaEvaluateSearchForm')));
        		}else{ 
        		    //将classid传入到后台
        		    classid=node.id;
        		    orgid = null;
        		    var treeParent = $(this).tree('getParent', node.target); 
        		    //orgid=treeParent.id;//获取orgid   经查无用
        		    $("#orgid").val("");
                	$("#classid").val(classid);
        			teaEvaluateDataGrid.datagrid('load',$.serializeObject($('#teaEvaluateSearchForm')));
                	//将添加按钮显示
        			/* teaEvaluateDataGrid.datagrid( {
                    	toolbar : '#stuEvaluateToolbar'
                	}
                	
                	); */
        		}
            }
        });
     	$("#begintimeTeaId").val(time(1));
     	$("#stoptimeTeaId").val(time(0));
        teaEvaluateDataGrid = $('#teaEvaluateDataGrid').datagrid({
        url : '${path}/teacherPlanTea/dataGrid',
        queryParams:$.serializeObject($('#teaEvaluateSearchForm')),
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
        }
        , 
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
        },/* {
            title : '验证码',
            field : 'code'
        }, */
         {
            title : '得分',
            field : 'score'
        }, 
        {
            field : 'action2',
            title : '操作',
            width : 260,
            formatter : function(value, row, index) {
                var str = '';
                <shiro:hasPermission name="/teaEvaluate/showDetail">
                    str += $.formatString('<a href="javascript:void(0)" class="teaPlan-easyui-linkbutton-show" data-options="plain:true,iconCls:\'fi-results icon-purple\'" onclick="showTeaDetail(\'{0}\',\'{1}\');" >查看详情</a>', row.id,row.classid);
                </shiro:hasPermission>
                <shiro:hasPermission name="/teaEvaluate/showCount">
                    str += '&nbsp;&nbsp;|&nbsp;&nbsp;';
                    str += $.formatString('<a href="javascript:void(0)" class="teaPlan-easyui-linkbutton-count" data-options="plain:true,iconCls:\'fi-graph-pie icon-purple\'" onclick="showTeaCount(\'{0}\',\'{1}\',\'{2}\',\'{3}\',\'{4}\');" >统计分析</a>', row.id,row.classname,row.teachername,row.stoptime,row.score);
                </shiro:hasPermission>
                <shiro:hasPermission name="/teaEvaluate/showRate">
                    str += '&nbsp;&nbsp;|&nbsp;&nbsp;';
                    str += $.formatString('<a href="javascript:void(0)" class="teaPlan-easyui-linkbutton-rate" data-options="plain:true,iconCls:\'fi-web icon-purple\'" onclick="showTeaRate(\'{0}\',\'{1}\');" >评价占比</a>', row.id,row.classid);
                </shiro:hasPermission>
                return str;
            }
        } ] ],
        onLoadSuccess:function(data){
            $('.teaPlan-easyui-linkbutton-show').linkbutton({text:'查看详情'});
            $('.teaPlan-easyui-linkbutton-count').linkbutton({text:'统计分析'});
            $('.teaPlan-easyui-linkbutton-rate').linkbutton({text:'教评率'});
        },
        toolbar : '#teaEvaluateToolbar'
    });
        
});




/**
 * 显示详情
 */
function showTeaDetail(id,classid) {

    if (id == undefined) {
        var rows = teaEvaluateDataGrid.datagrid('getSelections');
        id = rows[0].id;
        classid=rows[0].classid;
    } else {
        teaEvaluateDataGrid.datagrid('unselectAll').datagrid('uncheckAll');
    }
    parent.$.modalDialog({
        title : '显示详情',
        width : 800,
        height : 400,
        href :  '${path}/teaEvaluate/showDetailPage?planid=' + id+'&classid='+classid
    });
}
//显示统计图表
function showTeaCount(id,classname,teachername,stoptime,score) {
    if (id == undefined) {
        var rows = teaEvaluateDataGrid.datagrid('getSelections');
        id = rows[0].id;
        classid=rows[0].classid;
        selectRowStr = "班级："+rows[0].classname+"   教师姓名："+rows[0].teachername+"   结束时间："+rows[0].stoptime;
		if(rows[0].score!=undefined){
			selectRowStr+="  得分："+rows[0].score;
		}
    } else {
    	selectRowStr = "班级："+classname+"   教师姓名："+teachername+"   结束时间："+stoptime;
		if(score!=undefined&&score!="undefined"){
			selectRowStr+="  得分："+score;
		}
        teaEvaluateDataGrid.datagrid('unselectAll').datagrid('uncheckAll');
    }
    parent.$.modalDialog({
        title : '显示教评情况',
        width : 800,
        height : 450,
        href :  '${path}/teaEvaluate/showCountPage?planid=' + id
    });
}
//显示统计比率图表
function showTeaRate(id,classid) {
    if (id == undefined) {
        var rows = teaEvaluateDataGrid.datagrid('getSelections');
        id = rows[0].id;
        classid=rows[0].classid;
    } else {
        teaEvaluateDataGrid.datagrid('unselectAll').datagrid('uncheckAll');
    }
    parent.$.modalDialog({
        title : '显示参加教评人数占班级总人数比例情况',
        width : 600,
        height : 450,
       href :  '${path}/teaEvaluate/showRade?planid=' + id
    });
}

/**
 * 清除
 */
function teaEvaluateCleanFun() {
    $('#teaEvaluateSearchForm input').val('');
    orgid = null;
    classid = null;
    teaEvaluateDataGrid.datagrid('load', {});
}
/**
 * 搜索
 */
function teaEvaluateSearchFun() {
	$("#orgid").val(orgid);
	$("#classid").val(classid);
    teaEvaluateDataGrid.datagrid('load', $.serializeObject($('#teaEvaluateSearchForm')));
}
/**
 * 导出excel
 */
function exportTeaEvaluateExcel(){
	var datagridRows = teaEvaluateDataGrid.datagrid("getRows");
    var columns = teaEvaluateDataGrid.datagrid("options").columns[0];
    var dataRows={columns:columns,datagridRows:datagridRows};
    if(datagridRows.length>0){
    	 $.ajax({
      		url:"${path}/teacherPlan/exportTeaEvaluateExcel",
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
        <form id="teaEvaluateSearchForm">
            <table>
                <tr>
                    <th>教师姓名:</th>
                    <td>
                    	<input type="hidden" name="orgid" id="orgid"/>
                    	<input type="hidden" name="classid" id="classid"/>
                    	<input name="teacherName" placeholder="搜索教师姓名"/>
                    </td>
                    <th>教评开始时间:</th>
                    <td>
                    	<input id="begintimeTeaId" name="beginTime"  type="text" editable="false" class="easyui-datebox" ></input> 
                    </td>
                    
                    <th>教评结束时间:</th>
                    <td>
                    	<input id="stoptimeTeaId" name="stopTime"  type="text" editable="false" class="easyui-datebox"></input>
                    </td>
                    <td>
                        <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'fi-magnifying-glass',plain:true" onclick="teaEvaluateSearchFun();">查询</a>
                        <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'fi-x-circle',plain:true" onclick="teaEvaluateCleanFun();">清空</a>
                    </td>
                </tr>
            </table>
        </form>
     </div>
 
    <div data-options="region:'center',border:false,title:'教评计划列表'">
        <table id="teaEvaluateDataGrid" data-options="fit:true,border:false"></table>
    </div>
     <div data-options="region:'west',border:true,split:false,title:'班级组织'"  style="width:180px;overflow: auto; ">
        <ul id="teaEvaluateClassTree" style="width:160px;margin: 10px 10px 10px 10px"></ul>
    </div>
</div>
<div id="teaEvaluateToolbar" style="display: none;">
      <a onclick="exportTeaEvaluateExcel();" id="teaExport" href="javascript:void(0);"   class="easyui-linkbutton" data-options="plain:true,iconCls:'fi-download icon-green'">导出excel</a>
</div>