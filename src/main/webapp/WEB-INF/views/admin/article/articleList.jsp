<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/commons/global.jsp"%>
<script type="text/javascript">
	var articleListDataGrid;

	$(function() {
		articleListDataGrid = $('#articleListDataGrid').datagrid({
			url : '${path }/article/dataGrid',
			fit : true,
			striped : true,
			rownumbers : true,
			pagination : true,
			//singleSelect : true,是否支持选中多行
			idField : 'id',
			sortName : 'id',
			sortOrder : 'asc',
			pageSize : 20,
			pageList : [ 10, 20, 30, 40, 50, 100, 200, 300, 400, 500 ],
			columns : [ [ {
				width : '100',
				title : '编号',
				field : 'id',
				align : 'center',
				sortable : true
			}, {
				width : '250',
				title : '标题',
				field : 'title',
				/* align:'center', */
				sortable : true
			}, {
				width : '250',
				title : '作者',
				field : 'author',
				/* align:'center', */
				sortable : true
			}, {
				width : '250',
				title : '日期',
				field : 'time',
				/* align:'center', */
				sortable : true
			}, {
				width : '250',
				field : 'keyword',
				align : 'center',
				title : '关键字',

			} ] ],

			toolbar : '#articleToolbar'
		});
	});

	//删除一篇或者多篇文章
	function del() {
		var rows = articleListDataGrid.datagrid("getSelections");

		var ids = "";
		if (rows.length > 0) {
			$.messager.confirm('确认对话框', '您想要删除选择的行吗？', function(r) {
				if (r) {
					for ( var i = 0; i < rows.length; i++) {
						ids += rows[i].id + ",";

					}
					ids = ids.substring(0, ids.length - 1);
					$.ajax({
						url : '${path }/article/delArticle',
						data : {
							idsStr : ids
						},//将数组以逗号分割
						type : 'post',
						dataType : 'json',
						success : function(result) {
							if (result.success) {
								parent.$.messager.alert('提示', result.msg,
										'info');
								articleListDataGrid.datagrid('reload');
							}

						}
					});

				}
			});
		} else {
			$.messager.alert('警告', '请勾选你要删除的行！', 'warning');
		}
	};
	//查看一篇文章
	function show() {
		var rows = articleListDataGrid.datagrid("getSelections");
		if (rows.length < 1) {
			$.messager.alert('警告', '请勾选你要更新的行！', 'warning');
		} else if (rows.length > 1) {
			$.messager.alert('警告', '一次只能勾选一行！', 'warning');
		} else {
			ClickEvent("查看文章","article/toShow?id="+rows[0].id);
		}
	};
	//更新一篇文章
	function update() {

		var rows = articleListDataGrid.datagrid("getSelections");
		if (rows.length < 1) {
			$.messager.alert('警告', '请勾选你要更新的行！', 'warning');
		} else if (rows.length > 1) {
			$.messager.alert('警告', '一次只能勾选一行！', 'warning');
		} else {
			var updateArticleOpts = {
                 title : "修改文章",
                 border : false,
                 closable : true,
                 fit : true,
                 iconCls :"fi-page-add icon-yellow",
                 href:"article/toUpdate?id="+rows[0].id
           };
           addTab(updateArticleOpts);//必须使用ajax打开页面
		}
	};
	//增加一个选项卡
	function ClickEvent(title,url) {
		//var title = $(this).text();//选项卡名称
		//拼接一个Iframe标签，选项卡内容
		var str = '<iframe id="frmWork" width="100%" height="100%" frameborder="0" scrolling="auto" src="'
				+ url + '"></iframe>'
		//首先判断用户是否已经单击了此项，如果单击了直接获取焦点，否则打开
		var isExist = $("#index_tabs").tabs('exists', title);
		if (!isExist) {
			//添加tab的节点，调用easyUITab标签的方法
			$("#index_tabs").tabs('add', {
				title : title,
				content : str,
				iconCls : 'icon-save',
				closable : true
			});
		} else {
			//如果存在则获取焦点
			$("#index_tabs").tabs('select', title);
			
		}

	}
</script>
<div class="easyui-layout" data-options="fit:true,border:false">
	<div data-options="region:'center',border:true,title:'文章列表'">
		<table id="articleListDataGrid" data-options="fit:true,border:false"></table>
	</div>

</div>
<div id="articleToolbar" style="display: none;">
	<a id="edit" href="javascript:void(0);" onclick="update()"
		class="easyui-linkbutton"
		data-options="plain:true,iconCls:'icon-edit icon-green'">修改</a> <a
		id="del" href="javascript:void(0);" onclick="del()"
		class="easyui-linkbutton"
		data-options="plain:true,iconCls:'icon-del icon-green'">删除</a>
		<a
		id="show" href="javascript:void(0);" onclick="show()"
		class="easyui-linkbutton"
		data-options="plain:true,iconCls:'icon-ok icon-green'">浏览</a>
</div>