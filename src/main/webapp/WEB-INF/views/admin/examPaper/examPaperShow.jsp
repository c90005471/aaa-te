<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/global.jsp" %>
<script type="text/javascript">
var examTypeDataGrid;
var paperInfoDataGrid;
$(function(){
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
	        width : '130',
	        title : '科目',
	        field : 'typename',
	        sortable : true
	    },{
	        width : '60',
	        title : '总数量',
	        field : 'sum',
	        sortable : true
	        
	    },{
	        width : '120',
	        title : '抽取数量',
	        field : 'csum',
	        sortable : true,
	        //editor:{
	        //	type:'numberbox',
	        //	options:{precision:0,max:1}
	        //}
			formatter:function(value){
				return '<input name="inputsum" class="numberClass" style="height:20px;width:70px;" value="" >';
			}
	    }]],
	    onClickRow: function (rowIndex, rowData) {
            $(this).datagrid('unselectRow', rowIndex);
		},
		//onDblClickCell: function(index,field,value){
		//	$(this).datagrid('beginEdit', index);
		//	var ed = $(this).datagrid('getEditor', {index:index,field:field});
		//	$(ed.target).focus();
		//},
		onLoadSuccess:function(data){
			$(".numberClass").numberspinner({ 
				value:0,
			    min: 0,    
			    max: 100,    
			    editable: true
			});
		}
	});
	
	paperInfoDataGrid = $('#paperInfoDataGrid').datagrid({
        url : '${path}/examPaper/paperInfoDataGrid?id=${examPaper.id}',
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
            width : 70,
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
	
	//选择阶段
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
//生成试卷
function examPaperMakeFun(){
	var datagridRows = examTypeDataGrid.datagrid("getRows");
	var sum=0;
	var inputsums = $("input[name='inputsum']");
	var sumStr = "";
	for(var i=0;i<inputsums.length;i++){
		if(inputsums[i].value>datagridRows[i].sum){
			$.messager.show({title:'提示',msg:'第'+(i+1)+'项的抽取数量不能大于总数量'});
			return false;
		}
		sum+=Number(inputsums[i].value);
		if(inputsums[i].value!=0){
			sumStr += datagridRows[i].id+"#"+inputsums[i].value+";";
		}
	}
	if(sum==0){
		$.messager.show({title:'提示',msg:'请输入抽取数量'});
		return false;
	}
	var xin = $("input[type='radio']:checked").val();
	var num = 0;
	if(xin=="0"){//新增
		var total = paperInfoDataGrid.datagrid('getData').total;
		sum += total;
	}
	if(sum>Number("${examPaper.number}")){
		$.messager.show({title:'提示',msg:'抽取数量大于试题数量'});
		return false;
	}
	if(sumStr.length=!0){
		$("#sumStr").val(sumStr);
		xin = xin=="0"?"新增":"重新生成";
		if(confirm("你选中了"+xin+"操作,确认吗?")){
			$('#examPaperMakeForm').form({
	            url : '${path}/examPaper/make?id=${examPaper.id}',
	            onSubmit : function() {
	            },
	            success : function(result) {
	            	result = $.parseJSON(result);
	            	if (result.success) {
	                	$.messager.show({title:'提示',msg:result.msg});
	                    //之所以能在这里调用到parent.$.modalDialog.openner_dataGrid这个对象，是因为user.jsp页面预定义好了
	                    examTypeDataGrid.datagrid('reload');
	                    paperInfoDataGrid.datagrid('reload');
	                   // parent.$.modalDialog.handler.dialog('close');
	                } else {
	                    var form = $('#examPaperMakeForm');
	                    //parent.$.messager.alert('错误', eval(result.msg), 'error');
	                }
	            }
	        });
			$('#examPaperMakeForm').submit(); 
		}
	}
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
</script>

<div class="easyui-layout" data-options="fit:true,border:false">
	<div data-options="region:'north',border:false" style="height: 50px; overflow: hidden;background-color: #fff">
        <form id="examPaperMakeForm" method="post">
        	<input type="hidden" name="sumStr" id="sumStr"/>
            <table>
                <tr>
<%--                	<th>阶段</th>--%>
<%--            		<td style="padding-right:100px;">--%>
<%--            			<select id="stageExamPaperShow" class="easyui-combobox" name="stage" data-options="panelHeight:70" style="height:25px;width:100px;" disabled="disabled">   --%>
<%--						    <option value="S1">S1</option>   --%>
<%--						    <option value="S2">S2</option>  --%>
<%--						    <option value="S3">S3</option>   --%>
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
                    <th>&nbsp;&nbsp;</th>
                    <td style="width:100px;">
                    	<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-save',plain:true,size:'large'" onclick="examPaperMakeFun();">生成试卷</a>
                    </td>
                    <td style="font-size:16px;">  
                        <input type="radio" name="xin" value="0"/>新增&nbsp;&nbsp;&nbsp;
                        <input type="radio" name="xin" value="1" checked="checked"/>重新生成
                    </td>
                </tr>
            </table>
        </form>
     </div>
    <div data-options="region:'center',border:true,title:'试题列表'" >
        <table id="paperInfoDataGrid" data-options="fit:true,border:false" ></table>
    </div>
    <div data-options="region:'west',border:true,split:false,title:'题目类型'"  style="width:320px;overflow: auto; ">
        <table id="examTypeDataGrid" data-options="fit:true,border:false" ></table>
    </div>
</div>
