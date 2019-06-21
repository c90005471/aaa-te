<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/global.jsp" %>
<script type="text/javascript">
    var tblClassByTreeGrid;
    $(function() {
    	tblClassByTreeGrid = $('#tblClassByTreeGrid').treegrid({
        url : '${path}/tblClass/treeGrid',
        	queryParams:{flag:${flag}},
            idField : 'id',
            treeField : 'classname',
            parentField : 'orgid',
            fit : true,
            fitColumns : true,
            border : false,
            rownumbers:true,
            frozenColumns : [ [ {
                title : 'id',
                field : 'id',
                width : 40,
                hidden : true
            } ] ],
            columns : [ [ {
                field : 'classname',
                title : '班级名称',
                width : 180
            }, {
                field : 'graduate',
                title : '是否毕业',
                width : 50,
                formatter: function(value,row,index){
				if (row.graduate==0){
					return "在校";
				} else if(row.graduate==1) {
					return "毕业";
				}else
				{
					return "";
				}
			}
                
            }, {
                field : 'teacher',
                title : '老师',
                width : 120
            },  
            {
                field : 'id',
                title : '编号(开发用)',
                width : 60,
            },{
                width : '150',
                title : '创建时间',
                field : 'createtime'
            },{
                field : 'orgid',
                title : '上级资源ID',
                width : 150,
                hidden : true
            },
            {
                field : 'iconCls',
                title : '图标',
                width : 120,
                hidden : true
            }, {
                field : 'address',
                title : '地址',
                width : 120
            },{
            	field : 'action',
            	title : '操作',
            	width : 120,
            	formatter : function(value, row, index) {
			        var str = '';
			        if(row.id>=10000){
				        <shiro:hasPermission name="/tblClass/showDetail">
				            str += $.formatString('<a href="javascript:void(0)" class="tblClassBy-easyui-linkbutton-detail" data-options="plain:true,iconCls:\'fi-book icon-blue\'" onclick="tblClassDetailFun(\'{0}\')" >详情</a>', row.id);
				        </shiro:hasPermission>
			        }
			        return str;
			    }
            } ] ],
            onLoadSuccess:function(data){
                $("#tblClassByTreeGrid").treegrid("collapseAll");
                var roots= $("#tblClassByTreeGrid").treegrid("getRoots");  
                for(var i=0;i<roots.length;i++){
                    $("#tblClassByTreeGrid").treegrid("expand", roots[i].id);  
                }
                $('.tblClassBy-easyui-linkbutton-detail').linkbutton({text:'详情'});
            }
    });
});


    /**
     * 详情
     */
    function tblClassDetailFun(id) {
        if (id == undefined) {
            var rows = tblClassByTreeGrid.treegrid('getSelections');
            id = rows[0].id;
        } else {
        	tblClassByTreeGrid.treegrid('unselectAll').treegrid('uncheckAll');
        }
        parent.$.modalDialog({
            title : '详情',
            width : 500,
            height : 350,
            href :  '${path}/tblClass/editPage?flage=1&id=' + id,
            buttons : [ {
                text : '关闭',
                handler : function() {
                	 parent.$.modalDialog.handler.dialog('close');
                }
            } ]
        });
        
    }






</script>

<div class="easyui-layout" data-options="fit:true,border:false">
    <div data-options="region:'center',border:false">
        <table id="tblClassByTreeGrid" data-options="fit:true,border:false"></table>
    </div>
</div>
