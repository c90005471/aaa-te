<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/global.jsp" %>
<script type="text/javascript">
    var tblSclRecordProbDataGrid;
    $(function() {
        tblSclRecordProbDataGrid = $('#tblSclRecordProbDataGrid').datagrid({
        url : '${path}/tblSclRecordProb/dataGrid',
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
            width : 200,
            formatter : function(value, row, index) {
                var str = '';
                <shiro:hasPermission name="/tblSclRecordProb/showDetail">
                    str += $.formatString('<a href="javascript:void(0)" class="tblSclRecord-easyui-linkbutton-show" data-options="plain:true,iconCls:\'fi-results icon-pruple\'" onclick="showDetail(\'{0}\',\'{1}\');" >查看详情</a>', row.studentId,row.createtime);
                </shiro:hasPermission>
                <shiro:hasPermission name="/tblSclRecordProb/showInterView">
                    str += '&nbsp;&nbsp;|&nbsp;&nbsp;';
                    str += $.formatString('<a href="javascript:void(0)" class="tblSclRecord-easyui-linkbutton-count" data-options="plain:true,iconCls:\'fi-graph-pie icon-red\'" onclick="showCount(\'{0}\',\'{1}\',\'{2}\');" >访谈记录</a>', row.studentId,row.createtime,row.classid);
                </shiro:hasPermission>
                return str;
            }
        } ] ],
        onLoadSuccess:function(data){
            $('.tblSclRecord-easyui-linkbutton-show').linkbutton({text:'查看详情'});
            $('.tblSclRecord-easyui-linkbutton-count').linkbutton({text:'访谈记录'});
        },
        toolbar : '#tblSclProbToolbar'
    });
});

/**
 * 显示详情
 */
function showDetail(studentId,createtime) {
   
    if (studentId == undefined && createtime == undefined) {
        var rows = tblSclRecordProbDataGrid.datagrid('getSelections');
        studentId = rows[0].studentId;
        createtime = rows[0].createtime;
    } else {
        tblSclRecordProbDataGrid.datagrid('unselectAll').datagrid('uncheckAll');
    }
    parent.$.modalDialog({
        title : '答题详情',
        width : 700,
        height : 400,
        href :  '${path}/tblSclRecordProbdetail/manager?studentid='+studentId+'&createtime='+createtime
    });
}
//查看访谈记录
function showCount(studentId,createtime,classid) {
    if (studentId == undefined && createtime == undefined) {
        var rows = tblSclRecordProbDataGrid.datagrid('getSelections');
        studentId = rows[0].studentId;
        createtime = rows[0].createtime;
        classid = rows[0].classid;
    } else {
        tblSclRecordProbDataGrid.datagrid('unselectAll').datagrid('uncheckAll');
    }
    parent.$.modalDialog({
        title : '访谈记录',
        width : 800,
        height : 450,
        href :  '${path}/tblSclRecordProbdetail/showCountPage?studentid='+studentId+'&createtime='+createtime+'&classid='+classid
    });
}

//----------------------------------------------------------
//功能：根据身份证号获得性别
//参数：身份证号 psidno
//返回值：
//性别
//----------------------------------------------------------

	function Getsex(psidno) {
		var sexno, sex;
		if (psidno.length == 18) {
			sexno = psidno.substring(16, 17);
		} else if (psidno.length == 15) {
			sexno = psidno.substring(14, 15);
		} else {
			//alert("错误的身份证号码，请核对！");
			return false;
		}
		var tempid = sexno % 2;
		if (tempid == 0) {
			sex = '女';
		} else {
			sex = '男';
		}
		return sex;
	}
	/**
	 * 清除
	 */
	function tblSclRecordProbCleanFun() {
		$('#tblSclRecordProbSearchForm input').val('');
		tblSclRecordProbDataGrid.datagrid('load', {});
	}
	/**
	 * 搜索
	 */
	function tblSclRecordProbSearchFun() {
		tblSclRecordProbDataGrid.datagrid('load', $
				.serializeObject($('#tblSclRecordProbSearchForm')));
	}
	/**
	 * 导出异常学生记录
	 */
	function exportExcelTblSclRecordProb() {
		//$("#export").attr('href','${path}/tblSclRecordProb/exportTblSclRecordProb');
		var datagridRows = tblSclRecordProbDataGrid.datagrid("getRows");
	    var columns = tblSclRecordProbDataGrid.datagrid("options").columns[0];
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
        <form id="tblSclRecordProbSearchForm">
            <table>
                <tr>
                    <th></th>
                    <td>
                    	学号：<input name="stuno" placeholder="学号"/>&nbsp;&nbsp;
                    	学生姓名：<input name="stuname" placeholder="学生姓名"/>
                    </td>
                    <td>
                        <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'fi-magnifying-glass',plain:true" onclick="tblSclRecordProbSearchFun();">查询</a>
                        <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'fi-x-circle',plain:true" onclick="tblSclRecordProbCleanFun();">清空</a>
                    </td>
                </tr>
            </table>
        </form>
     </div>
 	
    <div data-options="region:'center',border:false">
        <table id="tblSclRecordProbDataGrid" data-options="fit:true,border:false"></table>
    </div>
</div>
<div id="tblSclProbToolbar" style="display: none;">
    <shiro:hasPermission name="/tblSclRecordProb/exportProb">
        <!-- <a onclick="tblSclRecordAddFun();" href="javascript:void(0);" class="easyui-linkbutton" data-options="plain:true,iconCls:'fi-page-add'">添加</a> -->
        <a onclick="exportExcelTblSclRecordProb();" id="export" href="javascript:void(0);"   class="easyui-linkbutton" data-options="plain:true,iconCls:'fi-download icon-green'">导出excel</a>
    </shiro:hasPermission>
</div>