<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/global.jsp" %>
<script type="text/javascript">
   // var userDataGrid;
    var stageTreeGrid;//定义一个treegrid显示课程表
    var organizationStageTreeNew;
    var orgidStage;
    var leafNode=false;
    var versionStage = "";
    $(function() {
        organizationStageTreeNew = $('#organizationStageTreeNew').tree({
            url : '${path }/organization/tree?Math.random()',
            parentField : 'pid',
            lines : true,
            onClick : function(node) {
            //返回树对象  
        	var tree = $(this).tree;  
        	//选中的节点是否为叶子节点,如果不是叶子节点,清除所有右边的数据
        		var isLeaf = tree('isLeaf', node.target);  
        		if (!isLeaf) {  
        		   // $("#courseToolbar").hide();//将添加按钮隐藏
        		   leafNode=false;
        		   stageTreeGrid.treegrid('loadData', []);  
        		}else
        		{ //将orgid传入到后台
        		    leafNode=true;
        		    stageTreeGrid.treegrid('load', {
                    	organizationId: node.id
                	}
                	);
        		    orgidStage=node.id;//将选中的orgId专业赋值给全局变量orgId
        		    versionStage= $("#versionStageId").val();
        		    if(orgidStage==6){
                		$("#selectStageId").show();
                	}else{
                		$("#selectStageId").hide();
                	}
                	//将添加按钮显示
        			/* courseTreeGrid.treegrid( {
                    	toolbar : '#courseToolbar'
                	} 
                	
                	);*/
        		}
            }
        });

        stageTreeGrid = $('#stageTreeGrid').treegrid({
            url : '${path }/stage/treeGrid?version='+$("#versionStageId").val(),
            idField : 'id',
            treeField : 'courseName',
            parentField : 'pid',
            state:'closed',    
            fit : true,
            fitColumns : true,
            border : false,
            frozenColumns : [ [ {
                title : '编号',
                field : 'id',
                width : 40
            } ] ],
            columns : [ [ {
                field : 'courseName',
                title : '自评阶段/项名称',
                width : 150
            },  {
                field : 'courseCode',
                title : '代码',
                width : 50
            },  {
                field : 'seq',
                title : '排序',
                width : 20
            }, {
                field : 'iconCls',
                title : '图标',
                width : 120
            }, {
                field : 'status',
                title : '状态',
                width : 40,
                formatter : function(value, row, index) {
                    switch (value) {
                    case 0:
                        return '正常';
                    case 1:
                        return '停用';
                    }
                }
            }, {
                field : 'action',
                title : '操作',
                width : 130,
                formatter : function(value, row, index) {
                    var str = '';
                        <shiro:hasPermission name="/stage/edit">
                            str += $.formatString('<a href="javascript:void(0)" class="resource-easyui-linkbutton-edit" data-options="plain:true,iconCls:\'fi-pencil icon-blue\'" onclick="editStageFun(\'{0}\');" >编辑</a>', row.id);
                        </shiro:hasPermission>
                        <shiro:hasPermission name="/stage/delete">
                            str += '&nbsp;&nbsp;|&nbsp;&nbsp;';
                            str += $.formatString('<a href="javascript:void(0)" class="resource-easyui-linkbutton-del" data-options="plain:true,iconCls:\'fi-x icon-red\'" onclick="deleteStageFun(\'{0}\');" >删除</a>', row.id);
                        </shiro:hasPermission>
                    return str;
                }
            } ] ],
            onLoadSuccess:function(data){
                $('.resource-easyui-linkbutton-edit').linkbutton({text:'编辑'});
                $('.resource-easyui-linkbutton-del').linkbutton({text:'删除'});
                //$('#courseTreeGrid').treegrid('collapseAll');
            },
            toolbar : '#stageToolbar'
        });
    });
    
    function addStageFun() {
        //判断是否选中了专业
        if(!leafNode){
        	parent.$.messager.alert('警告', '请在左侧组织机构中选择所属专业！');
        }else
        {
	        parent.$.modalDialog({
	            title : '添加',
	            width : 500,
	            height : 230,
	            href : '${path }/stage/addPage',
	            buttons : [ {
	                text : '添加',
	                handler : function() {
	                    parent.$.modalDialog.openner_courseTreeGrid = stageTreeGrid;//因为添加成功之后，需要刷新这个TreeGrid，所以先预定义好
	                    var f = parent.$.modalDialog.handler.find('#stageAddForm');
	                    f.submit();
	                }
	            } ]
	        });
        }
    }
    
      function editStageFun(id) {
        if (id != undefined) {
        	stageTreeGrid.treegrid('select', id);
        }
        var node = stageTreeGrid.treegrid('getSelected');
        if (node) {
            parent.$.modalDialog({
                title : '编辑',
                width : 500,
                height : 230,
                href : '${path }/stage/editPage?id=' + node.id,
                buttons : [ {
                    text : '确定',
                    handler : function() {
                        parent.$.modalDialog.openner_courseTreeGrid = stageTreeGrid;//因为添加成功之后，需要刷新这个treeGrid，所以先预定义好
                        var f = parent.$.modalDialog.handler.find('#stageEditForm');
                        f.submit();
                    }
                } ]
            });
        }
    }

    function deleteStageFun(id) {
        if (id != undefined) {
        	stageTreeGrid.treegrid('select', id);
        }
        var node = stageTreeGrid.treegrid('getSelected');
        if (node) {
            parent.$.messager.confirm('询问', '您是否要删除当前课程？删除当前课程会连同子课程一起删除!', function(b) {
                if (b) {
                    progressLoad();
                    $.post('${path }/stage/delete', {
                        id : node.id
                    }, function(result) {
                        if (result.success) {
                            parent.$.messager.alert('提示', result.msg, 'info');
                            stageTreeGrid.treegrid('reload');
                            parent.indexMenuZTree.reAsyncChildNodes(null, "refresh");
                        }
                        progressClose();
                    }, 'JSON');
                }
            });
        }
    }
    function searchStageFun() {
    	$("#orgid").val(orgidStage);
    	stageTreeGrid.treegrid('load', $.serializeObject($('#searchStageForm')));
    }
    function cleanStageFun() {
        $('#searchStageForm input').val('');
        stageTreeGrid.treegrid('load', {});
    }
    
  //修改版本
    function changeStageVersion(){
    	stageTreeGrid.treegrid('options').url = "${path }/stage/treeGrid";
    	stageTreeGrid.treegrid('load',{"organizationId":orgidStage,"version":$("#versionStageId").val()});
    }
</script>
<div class="easyui-layout" data-options="fit:true,border:false">
    <div data-options="region:'north',border:false" style="height: 30px; overflow: hidden;background-color: #fff">
        <form id="searchStageForm">
            <table>
                <tr>
                    <th>阶段名程:</th>
                    <td>
                    	<input type="hidden" name="organizationId" id="orgid" />
                    	<input name="name" placeholder="请输入阶段名程"/>
                    </td>
<%--                    <th>创建时间:</th>--%>
                    <td>
<%--                        <input name="createdateStart" placeholder="点击选择时间" onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd HH:mm:ss'})" readonly="readonly" />至--%>
<%--                        <input  name="createdateEnd" placeholder="点击选择时间" onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd HH:mm:ss'})" readonly="readonly" />--%>
                        <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'fi-magnifying-glass',plain:true" onclick="searchStageFun();">查询</a>
                        <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'fi-x-circle',plain:true" onclick="cleanStageFun();">清空</a>
                    </td>
                </tr>
            </table>
        </form>
    </div>
    <div data-options="region:'center',border:true,title:'课程列表'" >
        <table id="stageTreeGrid" data-options="fit:true,border:false"></table>
    </div>
    <div data-options="region:'west',border:true,split:false,title:'组织机构'"  style="width:150px;overflow: hidden; ">
        <ul id="organizationStageTreeNew" style="width:160px;margin: 10px 10px 10px 10px"></ul>
    </div>
</div>
<div id="stageToolbar" style="display: none;">
    <shiro:hasPermission name="/stage/add">
        <a onclick="addStageFun();" href="javascript:void(0);" class="easyui-linkbutton" data-options="plain:true,iconCls:'fi-plus icon-green'">添加</a>
    </shiro:hasPermission>
    <span id="selectStageId" style="display:none;margin-left:40px ">选择版本
		<select id="versionStageId" onchange="changeStageVersion()">
			<c:forEach items="${map}" var="course">
				<option value="${course.course_version}">${course.course_version}</option>
			</c:forEach>
		</select>
	</span>
</div>