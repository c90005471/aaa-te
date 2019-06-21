<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/global.jsp" %>
<script type="text/javascript">
	var tblProjectDataGrid;
	$(function() {
    		/* 班级树 */
    		classid = null;
    		orgid = null;
    	    classTree = $('#classTree').tree({
            url : '${path }/tblClass/tree?Math.random()',
            parentField : 'pid',
            lines : true,
            onClick : function(node) {
                //返回树对象  
        	var tree = $(this).tree;  
        	//选中的节点是否为叶子节点,如果不是叶子节点,清除所有右边的数据
        		var isLeaf = tree('isLeaf', node.target);  
        		if (!isLeaf) {   
        		    //如果不是叶子节点,则判断点击的是校区或专业的节点
        		    //将orgid(校区或专业的id)传到后台
        		    orgid = node.id;
        		    classid = null;
        		    leafNode=false;
        		    tblProjectDataGrid.datagrid('load', {
        		    		orgid: node.id
               				}
               			);
        		}else{ 
        		    //将classid传入到后台
        		    leafNode=true;
        		    classid=node.id;
        		    orgid = null;
        			tblProjectDataGrid.datagrid('load', {
                    	 classid: node.id
                	});
                
        		}
            }
        });
		//使用EasyUI和分页查询项目信息
		tblProjectDataGrid = $('#tblProjectDataGrid').datagrid(
						{
							url : '${path}/tblProject/dataGrid',
							striped : true,
							rownumbers : true,
							pagination : true,
							singleSelect : true,
							idField : 'id',
							sortName : 'id',
							sortOrder : 'asc',
							pageSize : 20,
							pageList : [ 10, 20, 30, 40, 50, 100, 200, 300,
									400, 500 ],
							frozenColumns : [ [
									{
										width : '60',
										title : '编号',
										field : 'id',
										sortable : true
									},
									{
										width : '140',
										title : '项目名称',
										field : 'projectname'
									},
									{
										width : '140',
										title : '创建时间',
										field : 'createtime'
									},
									{
										width : '200',
										title : '成员',
										field : 'students'
									},
									{
										width : '140',
										title : '评审老师',
										field : 'teacher'
									},{
										width : '140',
										title : '开始时间',
										field : 'starttime'
									},{
										width : '140',
										title : '结束时间',
										field : 'endtime'
									},{
										width : '60',
										title : '班级',
										field : 'classname'
									},
									{
										width : '60',
										title : '状态',
										field : 'statusname'
									},
									{
										width : '140',
										title : '保存路径',
										field : 'projectpath'
									},
									{
										field : 'action',
										title : '操作',
										width : 200,
										formatter : function(value, row, index) {
											var str = '';
											<shiro:hasPermission name="/tblProject/edit">
												str += $.formatString('<a href="javascript:void(0)" class="tblProject-easyui-linkbutton-edit" data-options="plain:true,iconCls:\'fi-pencil icon-blue\'" onclick="tblProjectEditFun(\'{0}\');" >编辑</a>',row.id);
											</shiro:hasPermission>
											<shiro:hasPermission name="/tblProject/delete">
												str += '&nbsp;&nbsp;|&nbsp;&nbsp;';
												str += $.formatString('<a href="javascript:void(0)" class="tblProject-easyui-linkbutton-del" data-options="plain:true,iconCls:\'fi-x icon-red\'" onclick="tblProjectDeleteFun(\'{0}\');" >删除</a>',row.id);
											</shiro:hasPermission>
											return str;
										}
									} ] ],
							onLoadSuccess : function(data) {
								$('.tblProject-easyui-linkbutton-edit')
										.linkbutton({
											text : '编辑'
										});
								$('.tblProject-easyui-linkbutton-del')
										.linkbutton({
											text : '删除'
										});
							},
							toolbar : '#tblProjectToolbar'
					});
	});

	/**
	 * 添加框
	 * @param url
	 */
	function tblProjectAddFun() {
		parent.$.modalDialog({
			title : '添加',
			width : 700,
			height : 600,
			href : '${path}/tblProject/addPage',
			buttons : [ {
				text : '确定',
				handler : function() {
					//因为添加成功之后，需要刷新这个treeGrid，所以先预定义好
					parent.$.modalDialog.openner_dataGrid = tblProjectDataGrid;
					var f = parent.$.modalDialog.handler
							.find('#tblProjectAddForm');
					f.submit();
				}
			} ]
		});
	}

	/**
	 * 编辑
	 */
	function tblProjectEditFun(id) {
		if (id == undefined) {
			var rows = tblProjectDataGrid.datagrid('getSelections');
			id = rows[0].id;
		} else {
			tblProjectDataGrid.datagrid('unselectAll').datagrid('uncheckAll');
		}
		parent.$.modalDialog({
			title : '编辑',
			width : 700,
			height : 600,
			href : '${path}/tblProject/editPage?id=' + id,
			buttons : [ {
				text : '确定',
				handler : function() {
					parent.$.modalDialog.openner_dataGrid = tblProjectDataGrid;//因为添加成功之后，需要刷新这个dataGrid，所以先预定义好
					var f = parent.$.modalDialog.handler
							.find('#tblProjectEditForm');
					f.submit();
				}
			} ]
		});
	}

	/**
	 * 删除
	 */
	function tblProjectDeleteFun(id) {
		if (id == undefined) {//点击右键菜单才会触发这个
			var rows = tblProjectDataGrid.datagrid('getSelections');
			id = rows[0].id;
		} else {//点击操作里面的删除图标会触发这个
			tblProjectDataGrid.datagrid('unselectAll').datagrid('uncheckAll');
		}
		parent.$.messager.confirm('询问', '您是否要删除当前角色？', function(b) {
			if (b) {
				progressLoad();
				$.post('${path}/tblProject/delete', {
					id : id
				}, function(result) {
					if (result.success) {
						parent.$.messager.alert('提示', result.msg, 'info');
						tblProjectDataGrid.datagrid('reload');
					}
					progressClose();
				}, 'JSON');
			}
		});
	}

	/**
	 * 清除
	 */
	function tblProjectCleanFun() {
		$('#tblProjectSearchForm input').val('');
		tblProjectDataGrid.datagrid('load', {});
	}
	/**
	 * 搜索
	 */
	function tblProjectSearchFun() {
		tblProjectDataGrid.datagrid('load', $
				.serializeObject($('#tblProjectSearchForm')));
	}
</script>

<div class="easyui-layout" data-options="fit:true,border:false">
	<!-- 模糊查询 -->
	<div data-options="region:'north',border:false"
		style="height: 30px; overflow: hidden;background-color: #fff">
		<form id="tblProjectSearchForm">
			<table>
				<tr>
					<td>
						期数：<select name="projectstage">
								<option value="">--请选择期数--</option>
								<option value="1">一期项目</option>
								<option value="2">二期项目</option>
							</select>&nbsp;&nbsp;
						项目名：<input name="projectname" placeholder="项目名称" />&nbsp;&nbsp;
						学生姓名：<input name="stuname" placeholder="学生姓名" />&nbsp;&nbsp; 
					</td>
					<td><a href="javascript:void(0);" class="easyui-linkbutton"
						data-options="iconCls:'fi-magnifying-glass',plain:true"
						onclick="tblProjectSearchFun();">查询</a> <a
						href="javascript:void(0);" class="easyui-linkbutton"
						data-options="iconCls:'fi-x-circle icon-red',plain:true"
						onclick="tblProjectCleanFun();">清空</a></td>
				</tr>
			</table>
		</form>
	</div>
	<div data-options="region:'center',border:false">
		<table id="tblProjectDataGrid" data-options="fit:true,border:false"></table>
	</div>
	<!-- 班级校区树 -->
    <div data-options="region:'west',border:true,split:false,title:'班级组织'"  style="width:180px;overflow: auto; ">
        <ul id="classTree" style="width:160px;margin: 10px 10px 10px 10px"></ul>
    </div>
</div>
<div id="tblProjectToolbar" style="display: none;">
	<shiro:hasPermission name="/tblProject/add">
		<a onclick="tblProjectAddFun();" href="javascript:void(0);" class="easyui-linkbutton" data-options="plain:true,iconCls:'fi-plus icon-green'">添加项目</a>
	</shiro:hasPermission>
</div>