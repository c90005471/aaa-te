<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/global.jsp" %>
<script type="text/javascript">
    var tblClassRecordTreeGrid;
    $(function() {
    	tblClassRecordTreeGrid = $('#tblClassRecordTreeGrid').treegrid({
        url : '${path}/tblClassRecord/treeGrid',
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
            },   
            {
                field : 'username',
                title : '原老师',
                width : 120
            },{
                width : '120',
                title : '创建人',
                field : 'creatname'
            },
            {
                width : '130',
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
            }] ]
    });
});




</script>

<div class="easyui-layout" data-options="fit:true,border:false">
    <!-- <div data-options="region:'north',border:false" style="height: 30px; overflow: hidden;background-color: #fff">
        <form id="tblClassSearchForm">
            <table>
                <tr>
                    <th>名称:</th>
                    <td><input name="name" placeholder="搜索条件"/></td>
                    <td>
                        <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'fi-magnifying-glass',plain:true" onclick="tblClassSearchFun();">查询</a>
                        <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'fi-x-circle',plain:true" onclick="tblClassCleanFun();">清空</a>
                    </td>
                </tr>
            </table>
        </form>
     </div> -->
 
    <div data-options="region:'center',border:false">
        <table id="tblClassRecordTreeGrid" data-options="fit:true,border:false"></table>
    </div>
</div>
