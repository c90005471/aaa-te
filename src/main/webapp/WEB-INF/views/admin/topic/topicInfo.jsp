<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/global.jsp" %>
<script type="text/javascript">
    var topicInfoDataGrid;
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
            	topicInfoDataGrid.datagrid('load',$.serializeObject($('#topicInfoSearchForm')));
            }
        });
    	
    	topicInfoDataGrid = $('#topicInfoDataGrid').datagrid({
        url : '${path}/topicInfo/dataGrid',
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
            title : '题目',
            field : 'topicname',
            sortable : true,
            formatter:function(value,row,index){
            	return escape4html(value);
            }
        },{
            width : '50',
            title : '答案',
            field : 'correct',
            sortable : true,
            
        },{
            width : '80',
            title : '试题类型',
            field : 'type',
            sortable : true,
            formatter : function(value, row, index) {
            	switch (value) {
                case 0:
                    return '单选题';
                case 1:
                    return '多选题';
                }
            }
            
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
        toolbar : '#topicInfoToolbar'
    });
    	

   $("#stageInfo").combobox({
	   onSelect: function(param){
		   topicTypesTree.tree("options").queryParams = {stage:param.value};
		   topicTypesTree.tree("reload");
		}
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
	if(!topicInfoNode){
		parent.$.messager.alert('警告', '请在左侧题目类型中选择所属类型！');
	}else{
		parent.$.modalDialog({
	        title : '添加',
	        width : 550,
	        height : 540,
	        href : '${path}/topicInfo/addPage',
	        buttons : [ {
	            text : '确定',
	            handler : function() {
	                parent.$.modalDialog.openner_dataGrid = topicInfoDataGrid;//因为添加成功之后，需要刷新这个treeGrid，所以先预定义好
	                var f = parent.$.modalDialog.handler.find('#topicInfoAddForm');
	                f.submit();
	            }
	        } ]
	    });
	}
}


/**
 * 编辑
 */
function topicInfoEditFun(id) {
    if (id == undefined) {
        var rows = topicInfoDataGrid.datagrid('getSelections');
        id = rows[0].id;
    } else {
    	topicInfoDataGrid.datagrid('unselectAll').datagrid('uncheckAll');
    }
    parent.$.modalDialog({
        title : '编辑',
        width : 550,
        height : 540,
        href :  '${path}/topicInfo/editPage?id=' + id,
        buttons : [ {
            text : '确定',
            handler : function() {
                parent.$.modalDialog.openner_dataGrid = topicInfoDataGrid;//因为添加成功之后，需要刷新这个dataGrid，所以先预定义好
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
         var rows = topicInfoDataGrid.datagrid('getSelections');
         id = rows[0].id;
     } else {//点击操作里面的删除图标会触发这个
    	 topicInfoDataGrid.datagrid('unselectAll').datagrid('uncheckAll');
     }
     parent.$.messager.confirm('询问', '您是否要删除当前题目？', function(b) {
         if (b) {
             progressLoad();
             $.post('${path}/topicInfo/delete', {
                 id : id
             }, function(result) {
                 if (result.success) {
                     parent.$.messager.alert('提示', result.msg, 'info');
                     topicInfoDataGrid.datagrid('reload');
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
    $('#topicInfoSearchForm input').val('');
    topicInfoDataGrid.datagrid('load', {});
}
/**
 * 搜索
 */
function topicInfoSearchFun() {
	topicInfoDataGrid.datagrid('load', $.serializeObject($('#topicInfoSearchForm')));
}
/**
 * 搜索
 */
 $(function(){
 	/* ajax调用user，下拉 */
    /*	$('#selectItemId').combobox({    
		    url:'${path }/testQues/selecttestQuesType',    
		    method:'post',
		    panelHeight : '100px',
		    valueField:'id',    
		    textField:'typeName'   
		}); */ 
 });
 
 function exportExcelTopicInfo(){
	 if(!topicInfoNode){
		 parent.$.messager.alert('警告', '请在左侧题目类型中选择所属类型！');
	 }else{
		 var datagridRows = topicInfoDataGrid.datagrid("getRows");
	        var columns = topicInfoDataGrid.datagrid("options").columns[0];
	        var dataRows={columns:columns,datagridRows:datagridRows};
	        if(datagridRows.length>0){
	       	 $.ajax({
	         		url:"${path}/topicInfo/exportTopicInfoExcel",
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
	    	
	}
 <%-- 导入信息方法--%>
 function importExcelTopicInfo() {
	 if(!topicInfoNode){
		 parent.$.messager.alert('警告', '请在左侧题目类型中选择所属类型！');
	 }else{
	   parent.$.modalDialog({
	   title : '批量添加',
	   width : 400,
	   height : 200,
	   href : '${path}/topicInfo/addManyPage',
	   buttons : [ {
	       text : '确定',
	       handler : function() {
	           parent.$.modalDialog.openner_dataGrid = topicInfoDataGrid;//因为添加成功之后，需要刷新这个treeGrid，所以先预定义好
	           var f = parent.$.modalDialog.handler.find('#topicInfoAddManyForm');
	           f.submit();
	       }
	   } ]
	});
   }
}
</script>

<div class="easyui-layout" data-options="fit:true,border:false">
    <div data-options="region:'north',border:false" style="height: 30px; overflow: hidden;background-color: #fff">
        <form id="topicInfoSearchForm">
            <table>
                <tr>
<%--                	<th>阶段</th>--%>
<%--            		<td>--%>
<%--            			<select id="stageInfo" class="easyui-combobox" data-options="panelHeight:70" style="height:25px;width:100px;">--%>
<%--						    <option value="S1">S1</option>--%>
<%--						    <option value="S2">S2</option>--%>
<%--						    <option value="S3" selected="selected">S3</option>--%>
<%--						</select>--%>
<%--            		</td>--%>
                     <th>题目:</th>
                    <td>
                    	<input type="hidden" id="topictype" name="topictype"/>
                    	<input type="text" name="topicname">
                    </td>
                    <td> 
                        <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'fi-magnifying-glass',plain:true" onclick="topicInfoSearchFun();">查询</a>
                        <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'fi-x-circle',plain:true" onclick="topicInfoCleanFun();">清空</a>
                    </td>
                </tr>
            </table>
        </form>
     </div>
    <div data-options="region:'center',border:true,title:'题目列表'" >
        <table id="topicInfoDataGrid" data-options="fit:true,border:false" ></table>
    </div>
    <div data-options="region:'west',border:true,split:false,title:'科目类型'"  style="width:150px;overflow: auto; ">
        <ul id="topicTypesTree" style="width:160px;margin: 10px 10px 10px 10px"></ul>
    </div>
</div>
<div id="topicInfoToolbar" style="display: none;">
    <shiro:hasPermission name="/topicInfo/add">
        <a onclick="topicInfoAddFun();" href="javascript:void(0);" class="easyui-linkbutton" data-options="plain:true,iconCls:'fi-plus'">添加</a>
    </shiro:hasPermission>
    <a onclick="exportExcelTopicInfo();" id="export" href="javascript:void(0);"   class="easyui-linkbutton" data-options="plain:true,iconCls:'fi-download icon-green'">导出excel</a>
    <a  id="download" href="${path}/static/model/topicInfo.xls"   class="easyui-linkbutton" data-options="plain:true,iconCls:'fi-page-csv icon-green'">下载模版</a>
    <a onclick="importExcelTopicInfo();" id="import" href="javascript:void(0);"   class="easyui-linkbutton" data-options="plain:true,iconCls:'fi-download icon-green'">批量添加题目信息</a>
</div>