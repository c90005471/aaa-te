<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/global.jsp" %>
<script type="text/javascript">
// var examTypeDataGrid;
var examPapersDataGrid;
var paperInfoDataGrid;
var questionid = 2;
var res=${examPaper.id};
$(function(){
    examPapersDataGrid = $('#examPapersDataGrid').datagrid({
	    <%--url : '${path}/topicTypes/data?stage=${examPaper.stage}',--%>
	    url : '${path}/examPaper/data',
	    fit : true,
	    striped : true,
	    fitColumns: true,
	    columns : [ [ {
            width : '30',
            title : '编号',
            field : 'id',
            sortable : true
        },{
	        width : '180',
	        title : '试卷',
	        field : 'title',
	        sortable : true
	    },{
            field : 'action',
            title : '操作',
            width : 40,
            formatter : function(value, row, index) {
                var str = '';
                <shiro:hasPermission name="/examPaper/edit">
                    str += $.formatString('<a href="javascript:void(0)" class="paperInfo-easyui-linkbutton-Detail" data-options="plain:true,iconCls:\'fi-pencil icon-blue\'" onclick="paperAllFun(\'{0}\');" >查看</a>', row.id);
                </shiro:hasPermission>
                <shiro:hasPermission name="/examPaper/edit">
                str += $.formatString('<a href="javascript:void(0)" class="paperInfo-easyui-linkbutton-Manual" data-options="plain:true,iconCls:\'fi-pencil icon-blue\'" onclick="paperDuplicateFun(\'{0}\');" >复用</a>', row.id);
                </shiro:hasPermission>
                return str;
            }
        }]],
	    onClickRow: function (rowIndex, rowData) {
            $(this).datagrid('unselectRow', rowIndex);
		},
		onLoadSuccess:function(data){
			// $(".numberClass").numberspinner({
			// 	value:0,
			//     min: 0,
			//     max: 100,
			//     editable: true
			// });
            $('.paperInfo-easyui-linkbutton-Manual').linkbutton({text:'复用'});
            $('.paperInfo-easyui-linkbutton-Detail').linkbutton({text:'查看'});
		}
	});

});
//格式化html代码显示到页面上
function escape4html(str){
	var sb = "";
	if (str!=""&&str!=null){
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
// paperDuplicateFun
/**
 * 删除
 */
 function paperDuplicateFun(id) {

     parent.$.messager.confirm('询问', '您是否要复用当前试卷？', function(b) {
         if (b) {
             progressLoad();
             $.post('${path}/examPaper/duplicatePaperInfo', {
                 pid : id,
                 eid : res
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
    paperInfoDataGrid = $('#paperInfoDataGrid').datagrid({
        url : '${path}/examPaper/paperInfoDataGrid?id='+questionid,
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
            width : '800',
            title : '题目名称',
            field : 'topicname',
            sortable : true,
            formatter:function(value,row,index){
                return escape4html(value);
            }
        } ] ]
    });
}

</script>

<div class="easyui-layout" data-options="fit:true,border:false">
	<div data-options="region:'north',border:false" style="height: 50px; overflow: hidden;background-color: #fff">
        <form id="examPaperMakeForm" method="post">
        	<input type="hidden" name="sumStr" id="sumStr"/>
            <table>
                <tr>
<%--                	<th>阶段</th>--%>
<%--            		<td style="padding-right:100px;">--%>
<%--            			<select id="stageExamPaperShow" class="easyui-combobox" name="stage" data-options="panelHeight:70" style="height:25px;width:100px;" disabled="disabled">--%>
<%--						    <option value="S1">S1</option>--%>
<%--						    <option value="S2">S2</option>--%>
<%--						    <option value="S3">S3</option>--%>
<%--						</select>--%>
<%--            		</td>--%>
                    <th style="font-size:16px;">试卷名称:</th>
                    <td style="font-size:16px;width:auto;padding-right:100px;">
                    	${examPaper.title}
                    </td>
                    <th style="font-size:16px;">试题数量:</th>
                    <td style="font-size:16px;width:auto;padding-right:100px;">
                    	${examPaper.number}
                    </td>
                </tr>
            </table>
        </form>
     </div>
    <div data-options="region:'west',collapsed:false,border:true,split:false,title:'试卷列表'" style="width:360px;overflow: auto; ">
        <table id="examPapersDataGrid" data-options="fit:true,border:false" ></table>
    </div>
    <div data-options="region:'center',border:true,title:'试题列表'" >
        <table id="paperInfoDataGrid" data-options="fit:true,border:false" ></table>
    </div>
</div>
