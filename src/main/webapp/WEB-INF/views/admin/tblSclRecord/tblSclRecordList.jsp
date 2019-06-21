<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/global.jsp" %>
<script type="text/javascript">
    var tblSclRecordDataGrid;
    var classidTblScl;
	var orgidTblScl;
	var classTreeTblScl;
    $(function() {
    		/* 班级树 */
    		classidTblScl = null;
    		orgidTblScl = null;
    		classTreeTblScl = $('#classTreeTblScl').tree({
            url : '${path }/tblClass/tree?Math.random()',
            parentField : 'pid',
            lines : true,
            onClick : function(node) {
                //返回树对象  
        	var tree = $(this).tree;  
        	//选中的节点是否为叶子节点,如果不是叶子节点,清除所有右边的数据
        		var isLeaf = tree('isLeaf', node.target);  
        		if (!isLeaf) {  
        		   // $("#studentToolbar").hide();//将添加按钮隐藏
            		//studentDataGrid.datagrid('loadData', []);  
        		    //如果不是叶子节点,则判断点击的是校区或专业的节点
        		    //将orgid(校区或专业的id)传到后台
        		    orgidTblScl = node.id;
        		    classidTblScl = null;
        		    //leafNode=false;
                    $("#classidTblScl").val("");
                    $("#orgidTblScl").val(orgidTblScl);
        		    tblSclRecordDataGrid.datagrid('load',$.serializeObject($('#tblSclRecordSearchForm')));
        		}else{ 
        		    //将classid传入到后台
        		    leafNode=true;
        		    classidTblScl=node.id;
        		    orgidTblScl = null;
        		    $("#classidTblScl").val(classidTblScl);
                    $("#orgidTblScl").val("");
        			tblSclRecordDataGrid.datagrid('load',$.serializeObject($('#tblSclRecordSearchForm')));
                
        		}
            }
        });
    	/* 健康自评统计显示 */
        tblSclRecordDataGrid = $('#tblSclRecordDataGrid').datagrid({
        url : '${path}/tblSclRecord/dataGrid',
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
        }, {
            width : '60',
            title : '学号',
            field : 'stuno'
        }, {
            width : '60',
            title : '学生姓名',
            field : 'stuname'
        }, {
            width : '140',
            title : '身份证号',
            field : 'idno'
        }, {
            width : '100',
            title : '电话',
            field : 'phone'
        }, {
            width : '50',
            title : '性别',
            field : 'sex',
            formatter : function(value, row, index) {
            	return Getsex(row.idno);
            }
        },{
            width : '60',
            title : '班级',
            field : 'classname'
        },{
            width : '80',
            title : '阳性项目数',
            field : 'sunCount'
        }, {
            width : '80',
            title : '测试总成绩',
            field : 'sclScore'
        },{
            width : '130',
            title : '测试时间',
            field : 'createtime'
        },{
            field : 'action',
            title : '操作',
            width : 240,
            formatter : function(value, row, index) {
                var str = '';
                <shiro:hasPermission name="/tblSclRecord/showDetail">/* 资源管理中查看详情的路径 */
                	//两个参数{0},{1}
                    str += $.formatString('<a href="javascript:void(0)" class="tblSclRecord-easyui-linkbutton-show" data-options="plain:true,iconCls:\'fi-results icon-pruple\'" onclick="showDetail(\'{0}\',\'{1}\');" >查看详情</a>',row.studentId,row.createtime);
                </shiro:hasPermission>
                <shiro:hasPermission name="/tblSclRecord/showCount">/* 资源管理中查看统计分析雷达图的路径 */
                    str += '&nbsp;&nbsp;|&nbsp;&nbsp;';
                    //两个参数{0},{1}
                    str += $.formatString('<a href="javascript:void(0)" class="tblSclRecord-easyui-linkbutton-count" data-options="plain:true,iconCls:\'fi-graph-pie icon-red\'" onclick="showCount(\'{0}\',\'{1}\');" >统计分析</a>',row.studentId,row.createtime);
                </shiro:hasPermission>
                <shiro:hasPermission name="/tblSclRecord/delete">/* 资源管理中删除的路径 */
                	str += '|&nbsp;&nbsp;';
                	str += $.formatString('<a href="javascript:void(0)" class="tblSclRecord-easyui-linkbutton-del" data-options="plain:true,iconCls:\'fi-x icon-red\'" onclick="tblSclRecordDeleteFun(\'{0}\');" >删除</a>',row.id);
            </shiro:hasPermission>
                return str;
            }
        } ] ],
        onLoadSuccess:function(data){//页面加载成功时显示详情按钮和统计分析按钮
            $('.tblSclRecord-easyui-linkbutton-show').linkbutton({text:'查看详情'});
            $('.tblSclRecord-easyui-linkbutton-count').linkbutton({text:'统计分析'});
            $('.tblSclRecord-easyui-linkbutton-del').linkbutton({text:'删除'});
        },
        toolbar : '#tblSclRecordToolbar'
    });
});
    /**
     * 删除
     */
     function tblSclRecordDeleteFun(id) {
         if (id == undefined) {//点击右键菜单才会触发这个
             var rows = tblSclRecordDataGrid.datagrid('getSelections');
             id = rows[0].id;
         } else {//点击操作里面的删除图标会触发这个
        	 tblSclRecordDataGrid.datagrid('unselectAll').datagrid('uncheckAll');
         }
         parent.$.messager.confirm('询问', '您是否要删除当前学生？', function(b) {
             if (b) {
                 progressLoad();
                 $.post('${path}/tblSclRecord/delete', {
                     id : id
                 }, function(result) {
                     if (result.success) {
                         parent.$.messager.alert('提示', result.msg, 'info');
                         tblSclRecordDataGrid.datagrid('reload');
                     }
                     progressClose();
                 }, 'JSON');
             }
         });
    }
/**
 * 显示详情
 */
function showDetail(studentId,createtime) {
	//判断学生id和创建时间是否未定义，如果未定义，对它们进行赋值
    if (studentId == undefined && createtime == undefined) {
        var rows = tblSclRecordDataGrid.datagrid('getSelections');
        studentId = rows[0].studentId;//对学生id赋值
        createtime = rows[0].createtime;//对创建时间赋值
    } else {
        tblSclRecordDataGrid.datagrid('unselectAll').datagrid('uncheckAll');
    }
    parent.$.modalDialog({
        title : '答题详情',
        width : 700,
        height : 400,
        href :  '${path}/tblSclRecorddetail/manager?studentid='+studentId+'&createtime='+createtime
    });
}
//显示统计图表
function showCount(studentId,createtime) {
	//判断学生id和创建时间是否未定义，如果未定义，对它们进行赋值
    if (studentId == undefined && createtime == undefined) {
        var rows = tblSclRecordDataGrid.datagrid('getSelections');
        studentId = rows[0].studentId;
        createtime = rows[0].createtime;
    } else {
        tblSclRecordDataGrid.datagrid('unselectAll').datagrid('uncheckAll');
    }
    parent.$.modalDialog({
        title : '测试统计',
        width : 600,
        height : 450,
        href :  '${path}/tblSclRecorddetail/showCountPage?studentid=' + studentId+'&createtime='+createtime
    });
}
//----------------------------------------------------------
//功能：根据身份证号获得性别
//参数：身份证号 psidno
//返回值：
//性别
//----------------------------------------------------------
function Getsex(psidno){
var sexno,sex;
if(psidno.length==18){
  sexno=psidno.substring(16,17);
}else if(psidno.length==15){
  sexno=psidno.substring(14,15);
}else{
  //alert("错误的身份证号码，请核对！");
  return false;
}
var tempid=sexno%2;
if(tempid==0){
  sex='女';
}else{
  sex='男';
}
return sex;
}
/**
 * 清除
 */
function tblSclRecordCleanFun() {
	$("#orgid").val("");
	 $("#classid").val("");
    $('#tblSclRecordSearchForm input').val('');
    tblSclRecordDataGrid.datagrid('load', {});
}
/**
 * 搜索
 */
function tblSclRecordSearchFun() {
	 $("#orgid").val(orgidTblScl);
	 $("#classid").val(classidTblScl);
     tblSclRecordDataGrid.datagrid('load', $.serializeObject($('#tblSclRecordSearchForm')));
}


/**
 * 导出excel
 */
function exportTblSclRecordExcel(){
	var datagridRows = tblSclRecordDataGrid.datagrid("getRows");
    var columns = tblSclRecordDataGrid.datagrid("options").columns[0];
    var dataRows={columns:columns,datagridRows:datagridRows};
    if(datagridRows.length>0){
    	 $.ajax({
      		url:"${path}/tblSclRecord/exportTblSclRecordExcel",
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
        <form id="tblSclRecordSearchForm">
            <table>
                <tr>
                    <th></th>
                    <td>
                    	<input type="hidden" id="classidTblScl" name="classId" />
                    	<input type="hidden" id="orgidTblScl" name="orgid"/>
                    	学号：<input name="stuno" placeholder="学号"/>&nbsp;&nbsp;
                    	学生姓名：<input name="stuname" placeholder="学生姓名"/>&nbsp;&nbsp;
                    	创建时间：<input name="createtime_begin" placeholder="起始时间" onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd HH:mm:ss'})" readonly="readonly" />至
                    	<input name="createtime_end" placeholder="结束时间" onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd HH:mm:ss'})" readonly="readonly" />
                    </td>
                    <td>
                        <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'fi-magnifying-glass',plain:true" onclick="tblSclRecordSearchFun();">查询</a>
                        <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'fi-x-circle icon-red',plain:true" onclick="tblSclRecordCleanFun();">清空</a>
                    </td>
                </tr>
            </table>
        </form>
     </div>
 
    <div data-options="region:'center',border:false">
        <table id="tblSclRecordDataGrid" data-options="fit:true,border:false"></table>
    </div>
    <!-- 班级校区树 -->
    <div data-options="region:'west',border:true,split:false,title:'班级组织'"  style="width:180px;overflow: auto; ">
        <ul id="classTreeTblScl" style="width:160px;margin: 10px 10px 10px 10px"></ul>
    </div>
</div>
<div id="tblSclRecordToolbar" style="display: none;">
      <a onclick="exportTblSclRecordExcel();" id="export" href="javascript:void(0);"   class="easyui-linkbutton" data-options="plain:true,iconCls:'fi-download icon-green'">导出excel</a>
</div>