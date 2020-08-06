<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/global.jsp" %>
<script type="text/javascript">
    var examRecordPaperDataGrid;
    var examRecordClassTree;
    var orgidExamRecord;
    var classidExamRecord;
    var leafByNodeExamRecord=false;
    function changeUrl(){
    	$('#examRecordClassTree').tree({url:"${path }/tblClass/tree?Math.random()&&flag=${flag}"});
    }
    $(function() {
    	$("#classStatusId").change(function(){
    		var params = {
        			flag: $("#classStatusId").val()
        	};
    		examRecordClassTree.tree("options").queryParams = params;
        	examRecordClassTree.tree('reload');
    	});
    	examRecordClassTree = $('#examRecordClassTree').tree({
            url : '${path }/tblClass/tree?Math.random()',
            parentField : 'pid',
            lines : true,
            onLoadSuccess: function (node, data) {
            	$("#examRecordClassTree").tree("collapseAll");
            	var roots= $("#examRecordClassTree").tree('getRoots');  
                for(var i=0;i<roots.length;i++){  
                    $("#examRecordClassTree").tree('expand', roots[i].target);  
                }
             },
            onClick : function(node) {
                //返回树对象  
        	    var tree = $(this).tree;  
        	//选中的节点是否为叶子节点,如果不是叶子节点,清除所有右边的数据
        		var isLeaf = tree('isLeaf', node.target);  
        		if (!isLeaf) {  
        			examRecordPaperDataGrid.datagrid('loadData', []); 
        			orgidExamRecord = node.id;
        		    classidExamRecord = null;
        		    leafByNodeExamRecord = false;
        		    $("#orgidExamRecord").val(orgidExamRecord);
        		    $("#classidExamRecord").val("");
        		    examRecordPaperDataGrid.datagrid('load',$.serializeObject($('#examRecordSearchForm')));
        		}else{ 		
        		    //将classid传入到后台
        		    classidExamRecord=node.id;
        		    orgidExamRecord = null;
        		    leafByNodeExamRecord = true;
        		    var treeParent = $(this).tree('getParent', node.target); 
        		    //orgid=treeParent.id;//获取orgid
        		    leafNode=true;
        		    $("#orgidExamRecord").val("");
        		    $("#classidExamRecord").val(classidExamRecord);
        		    examRecordPaperDataGrid.datagrid('load', $.serializeObject($('#examRecordSearchForm')));
        		}
            }
        });
    	examRecordPaperDataGrid = $('#examRecordPaperDataGrid').datagrid({
            url : '${path}/examPaper/dataGrid1?flag=1',//注:flag为系统管理员的id
            fit : true,
            striped : true,
            rownumbers : true,
            pagination : true,
            singleSelect : true,
            queryParams:{
                graduate:$("#classStatusId").val()
            },
            idField : 'id',
            sortName : 'id',
            sortOrder : 'asc',
            pageSize : 20,
            pageList : [ 10, 20, 30, 40, 50, 100],
            columns : [ [ {
                width : '60',
                title : '编号',
                field : 'id',
                sortable : true
            },{
                width : '400',
                title : '试卷名称',
                field : 'title',
                sortable : true,
                
            },{
                width : '120',
                title : '开始时间',
                field : 'starttime',
                sortable : true,
                
            },{
                width : '60',
                title : '考试时间',
                field : 'needtime'
                
            },{
                width : '60',
                title : '类型',
                field : 'type',
                formatter : function(value, row, index) {
                	switch (value) {
                    case 0:
                        return '结业考试';
                    case 1:
                        return '课程内测';
                    case 2:
                        return '模拟练习';
                    }
                	
                }
            },{
                width : '80',
                title : '状态',
                field : 'state',
                formatter : function(value, row, index) {
                	switch (value) {
                    case 0:
                        return '未启用';
                    case 1:
                        return '已启用';
                    }
                	
                }
            },{
                width : '60',
                title : '平均分',
                field : 'avgscore'
                
            },{
                width : '60',
                title : '及格率',
                field : 'passrate'
                
            },{
                field : 'action',
                title : '操作',
                width : 220,
                formatter : function(value, row, index) {
                    var str = '';
                    str += $.formatString('<a href="javascript:void(0)" class="examRecordPaper-easyui-linkbutton-show" data-options="plain:true,iconCls:\'fi-pencil icon-blue\'" onclick="examRecordShowFun(\'{0}\');" >详情</a>', row.id);
                    str += $.formatString('<a href="javascript:void(0)" class="examResultPaper-easyui-linkbutton-show" data-options="plain:true,iconCls:\'fi-pencil icon-blue\'" onclick="examResultShowFun(\'{0}\');" >结果</a>', row.id);
                    return str;
                }
            } ] ],
            onLoadSuccess:function(data){
                $('.examRecordPaper-easyui-linkbutton-show').linkbutton({text:'详情'});
                $('.examResultPaper-easyui-linkbutton-show').linkbutton({text:'结果'});
            }//,
            //toolbar : '#examPaperToolbar'
        });
});


/**
 * 显示详情
 */
function examRecordShowFun(id,classid) {
    if (id == undefined) {
        var rows = examRecordPaperDataGrid.datagrid('getSelections');
        id = rows[0].id;
    } else {
    	examRecordPaperDataGrid.datagrid('unselectAll').datagrid('uncheckAll');
    }
    parent.$.modalDialog({
        title : '详情',
        width : 800,
        height : 400,
        href : '${path}/examRecord/showExamRecord?paperId=' + id
    });
}
/**
 * 考试结果分析
 */
function examResultShowFun(id,classid) {
    if (id == undefined) {
        var rows = examRecordPaperDataGrid.datagrid('getSelections');
        id = rows[0].id;
    } else {
        examRecordPaperDataGrid.datagrid('unselectAll').datagrid('uncheckAll');
    }
    parent.$.modalDialog({
        title : '结果',
        width : 1000,
        height : 400,
        href : '${path}/examRecord/showExamResult?paperId=' + id
    });
}
/**
 * 清除
 */
function examRecordCleanFun() {
	orgidExamRecord = null;
	classidExamRecord = null;
    $('#examRecordSearchForm input').val('');
    examRecordPaperDataGrid.datagrid('load', {});
}
/**
 * 搜索
 */
function examRecordSearchFun() {
	$("#orgidExamRecord").val(orgidExamRecord);
	$("#classidExamRecord").val(classidExamRecord);
	examRecordPaperDataGrid.datagrid('load', $.serializeObject($('#examRecordSearchForm')));
}
</script>

<div class="easyui-layout" data-options="fit:true,border:false">
    <div data-options="region:'north',border:false" style="height: 30px; overflow: hidden;background-color: #fff">
        <form id="examRecordSearchForm">
            <table>
                <tr>
                	<th>选择班级组织:</th>
                	<td>
                		<select id="classStatusId" style="width:60px;margin-right: 20px;" name="graduate">
                			<option value="0">在校</option>
                			<option value="1">毕业</option>
                		</select>
                	</td>
                     <th>试卷名称:</th>
                    <td>
                    	<input type="hidden" name="orgid" id="orgidExamRecord"/>
                    	<input type="hidden" name="classid" id="classidExamRecord"/>
                    	<input type="text" name="title">
                    </td>
                    <td> 
                        <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'fi-magnifying-glass',plain:true" onclick="examRecordSearchFun();">查询</a>
                        <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'fi-x-circle',plain:true" onclick="examRecordCleanFun();">清空</a>
                    </td>
                </tr>
            </table>
        </form>
     </div>
    <div data-options="region:'center',border:true,title:'记录列表'" >
        <table id="examRecordPaperDataGrid" data-options="fit:true,border:false" ></table>
    </div>
    <div data-options="region:'west',border:true,split:false,title:'班级组织'"  style="width:180px;overflow: auto; ">
        <ul id="examRecordClassTree" style="width:160px;margin: 10px 10px 10px 10px"></ul>
    </div>
</div>
