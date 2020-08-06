<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/global.jsp" %>
<script type="text/javascript">
var examTypeDataGrid;
var paperInfoDataGrid;
var questionInfoDataGrid;
var questionid = 2;
$(function(){

    $("#manpapername").combobox({
        url:'${path}/paperBank/dataGridBank',
        valueField:'id',
        textField:'papername',
        editable:false,
        panelHeight:'auto',
        onChange:function (newValue,oldValue) {
            $("#manpapernameval").val(newValue);
            var url='${path}/examPaper/paperInfoDataGrid?id='+newValue;
            paperInfoDataGrid.datagrid("options").url=url;
            paperInfoDataGrid.datagrid('reload');
        }
    });

	examTypeDataGrid = $('#examTypeDataGrid').datagrid({
	    <%--url : '${path}/topicTypes/data?stage=${examPaper.stage}',--%>
	    url : '${path}/topicTypes/data',
	    fit : true,
	    striped : true,
	    fitColumns: true,
	    columns : [ [ {
            width : '30',
            title : '编号',
            field : 'id',
            sortable : true
        },{
	        width : '230',
	        title : '科目',
	        field : 'typename',
	        sortable : true
	    },{
            field : 'action',
            title : '操作',
            width : 40,
            formatter : function(value, row, index) {
                var str = '';
                <shiro:hasPermission name="/examPaper/edit">
                    str += $.formatString('<a href="javascript:void(0)" class="paperInfo-easyui-linkbutton-Manual" data-options="plain:true,iconCls:\'fi-pencil icon-blue\'" onclick="paperAllFun(\'{0}\');" >选择</a>', row.id);
                </shiro:hasPermission>
                return str;
            }
        }]],
	    onClickRow: function (rowIndex, rowData) {
            $(this).datagrid('unselectRow', rowIndex);
		},
		onLoadSuccess:function(data){
			$(".numberClass").numberspinner({
				value:0,
			    min: 0,
			    max: 100,
			    editable: true
			});
            $('.paperInfo-easyui-linkbutton-Manual').linkbutton({text:'选择'});
		}
	});
	
	paperInfoDataGrid = $('#paperInfoDataGrid').datagrid({
        url : '${path}/examPaper/paperInfoDataGrid?id=0',
        fit : true,
        striped : true,
        rownumbers : true,
        pagination : true,
        singleSelect : true,
        idField : 'id',
        sortName : 'id',
        sortOrder : 'asc',
        pageSize : 20,
        pageList : [ 10, 20, 30, 40, 50, 100],
        columns : [ [ {
            width : '60',
            title : '编号',
            field : 'id',
            hidden:true
        },{
            width : '700',
            title : '题目名称',
            field : 'topicname',
            sortable : true,
            formatter:function(value,row,index){
            	return escape4html(value);
            }
        },{
            field : 'action',
            title : '操作',
            width : 60,
            formatter : function(value, row, index) {
                var str = '';
                <shiro:hasPermission name="/examPaper/edit">
                	str += $.formatString('<a href="javascript:void(0)" class="paperInfo-easyui-linkbutton-del" data-options="plain:true,iconCls:\'fi-x icon-red\'" onclick="paperInfoDelFun(\'{0}\');" >删除</a>', row.id);
            	</shiro:hasPermission>
                return str;
            }
        } ] ],
        onLoadSuccess:function(data){
            $('.paperInfo-easyui-linkbutton-del').linkbutton({text:'删除'});
        }
    });
	
	<%--//选择阶段--%>
	<%--$("#stageExamPaperShow").combobox({--%>
	<%--	onLoadSuccess:function(){--%>
	<%--		$("#stageExamPaperShow").combobox("select","${examPaper.stage}");--%>
	<%--	}--%>
	<%--});--%>
});
//格式化html代码显示到页面上
function escape4html(str){
	var sb = "";
	if (str!=null&&str!=""){
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
    }

	//alert(sb);
    return sb; 
}

/**
 * 删除
 */
 function paperInfoDelFun(id) {
     if (id == undefined) {//点击右键菜单才会触发这个
         var rows = paperInfoDataGrid.datagrid('getSelections');
         id = rows[0].id;
     } else {//点击操作里面的删除图标会触发这个
    	 paperInfoDataGrid.datagrid('unselectAll').datagrid('uncheckAll');
     }
     parent.$.messager.confirm('询问', '您是否要删除当前题目？', function(b) {
         if (b) {
             progressLoad();
             $.post('${path}/examPaper/deletePaperInfo', {
                 id : id
             }, function(result) {
                 if (result.success) {
                     parent.$.messager.alert('提示', result.msg, 'info');
                     paperInfoDataGrid.datagrid('reload');
                 }
                 progressClose();
             }, 'JSON');
         }
     });
}
function paperAllFun(id) {
    questionid = id;
    questionInfoDataGrid.datagrid('options').url= '${path}/examPaper/questionInfoDataGrid?id=' + questionid;
    questionInfoDataGrid.datagrid('reload');
}

/**
 * 加载试题列表
 */
questionInfoDataGrid = $('#questionInfoDataGrid').datagrid({
    url : '${path}/examPaper/questionInfoDataGrid?id=' + questionid,
    fit : true,
    striped : true,
    rownumbers : true,
    pagination : true,
    singleSelect : true,
    idField : 'id',
    sortName : 'id',
    sortOrder : 'asc',
    pageSize : 20,
    pageList : [ 10, 20, 30, 40, 50, 100],
    columns : [ [ {
        width : '60',
        title : '编号',
        field : 'id',
        hidden:true
    },{
        width : '700',
        title : '题目名称',
        field : 'topicname',
        sortable : true,
        formatter:function(value,row,index){
            return escape4html(value);
        }
    },{
        field : 'action',
        title : '操作',
        width : 60,
        formatter : function(value, row, index) {
            var str = '';
            <shiro:hasPermission name="/examPaper/edit">
                str += $.formatString('<a href="javascript:void(0)" class="paperInfo-easyui-linkbutton-add" data-options="plain:true,iconCls:\'fi-pencil icon-blue\'" onclick="paperInfoAddFun(\'{0}\');" >添加</a>', row.id);
            </shiro:hasPermission>
            return str;
        }
    } ] ],
    onLoadSuccess:function(data){
        $('.paperInfo-easyui-linkbutton-add').linkbutton({text:'添加'});
    }
});

function paperInfoAddFun(id) {
    var paperid=$("#manpapername").combobox('getValue');
    if (paperid==undefined||paperid==''||paperid==null){
        parent.$.messager.alert('提示', '请选择试卷', 'info');
        return false;
    }
    $.ajax({
        url:'${path}/paperBank/addPaperByManual',
        type:"post",
        data:{
            "paperid":paperid,
            "infoid":id
        },
        dataType:"json",
        success:function (result) {
            if (result == -1) {
                alert("试题已经添加过了！");
            }
            if (result > 0){
                paperInfoDataGrid.datagrid('reload');
            }
        }
    });
}
</script>

<div class="easyui-layout" data-options="fit:true,border:false">
	<div data-options="region:'north',border:false" style="height: 50px; overflow: hidden;background-color: #fff">
        <form id="examPaperMakeForm" method="post">
        	<input type="hidden" name="sumStr" id="sumStr"/>
            <table>
                <th style="font-size:16px;">试卷名称:</th>
                <td style="font-size:16px;width:auto;padding-right:100px;">
                    <input type="text" id="manpapername"/>
                    <input type="hidden" name="papername" id="manpapernameval"/>
                </td>
            </table>
        </form>
     </div>
    <div data-options="region:'west',collapsed:false,border:true,split:false,title:'题目类型'" style="width:360px;overflow: auto; ">
        <table id="examTypeDataGrid" data-options="fit:true,border:false" ></table>
    </div>
    <div data-options="region:'center',collapsed:false,border:true,title:'试题列表'" >
        <table id="questionInfoDataGrid" data-options="fit:true,border:false"></table>
    </div>
    <div data-options="region:'east',collapsed:true,border:true,title:'试卷列表'" >
        <table id="paperInfoDataGrid" data-options="fit:true,border:false" ></table>
    </div>
</div>
