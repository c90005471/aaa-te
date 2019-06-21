<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/global.jsp" %>
<script type="text/javascript">
    var studentRecordDataGrid;
    var classStudentRecordTree;
    var classStuRecid;
    var orgStuRecid;
    var leafNode=false;
    $(function() {
    	classStudentRecordTree = $('#classStudentRecordTree').tree({
            url : '${path }/tblClass/tree?m='+Math.random(),
            parentField : 'pid',
            lines : true,
            onLoadSuccess: function (node, data) {
            	$("#classStudentRecordTree").tree("collapseAll");
            	var roots= $("#classStudentRecordTree").tree('getRoots');  
                for(var i=0;i<roots.length;i++){  
                    $("#classStudentRecordTree").tree('expand', roots[i].target);  
                }
              },
            onClick : function(node) {
                //返回树对象  
        	var tree = $(this).tree;  
        	//选中的节点是否为叶子节点,如果不是叶子节点,清除所有右边的数据
        		var isLeaf = tree('isLeaf', node.target);  
        		if (!isLeaf) {  
        		    //如果不是叶子节点,则判断点击的是校区或专业的节点
        		    //将orgid(校区或专业的id)传到后台
        		    orgStuRecid = node.id;
        		    classStuRecid = null;
        		    leafNode=false;
                	$("#orgStuRecid").val(orgStuRecid);
                	$("#classStuRecid").val("");
        		    studentRecordDataGrid.datagrid('load',$.serializeObject($('#studentRecordSearchForm')));
        		}else{ 
        		    //将classid传入到后台
        		    leafNode=true;
        		    classStuRecid=node.id;
        		    orgStuRecid = null;
        		    $("#orgStuRecid").val("");
                	$("#classStuRecid").val(classStuRecid);
        		    studentRecordDataGrid.datagrid('load',$.serializeObject($('#studentRecordSearchForm')));
        		}
            }
        });
    	studentRecordDataGrid = $('#studentRecordDataGrid').datagrid({
        url : '${path}/studentRecord/dataGrid',
        striped : true,
        rownumbers : true,
        pagination : true,
        fitColumns:false,
        singleSelect : true,
        idField : 'id',
        sortName : 'id',
        sortOrder : 'asc',
        pageSize : 20,
        pageList : [ 10, 20, 30, 40, 50, 100, 200, 300, 400, 500],
        columns : [ [ {
            title : '编号',
            field : 'id',
            sortable : true
        }, {
        	width : '80',
            title : '学号',
            field : 'stuno'
        },{
        	width : '120',
            title : '学生姓名',
            field : 'studentname'
        },
        {
        	width : '120',
            title : '原班级',
            field : 'oldclassname',
            
        },
        {
        	width : '120',
            title : '现班级',
            field : 'newclassname',
        }, 
        {
        	width : '80',
            title : '状态',
            field : 'operrecord',
            formatter : function(value, row, index) {
                switch (value) {
                case '0':
                    return '转出';
                case '1':
                    return '转入';
                }
            }
        },  
        {
            width : '80',
            title : '创建人',
            field : 'creatname',
            sortable : true
        }, {
            width : '140',
            title : '创建时间',
            field : 'createtime',
            sortable : true
        } ] ]
    });
   
    	
    	
    	$("#begintimeStuRecId").val(time(1));
        $("#stoptimeStuRecId").val(time(0));
});



/**
 * 清除
 */
function studentCleanFun() {
    $('#studentRecordSearchForm input').val('');
    studentRecordDataGrid.datagrid('load', {});
}
/**
 * 搜索
 */
function studentSearchFun() {
	$("#orgStuRecid").val(orgStuRecid);
	$("#classStuRecid").val(classStuRecid);
	studentRecordDataGrid.datagrid('load', $.serializeObject($('#studentRecordSearchForm')));
}

//设月底跟月头时间  
function time(number){  
    var date=new Date();  
    var strDate=date.getFullYear()+"-";  
    if(number==0){ //0 为月底  
    	strDate+=date.getMonth()+2+"-";  
   	 	strDate+=number;  
    }else{  
    	strDate+=date.getMonth()+1+"-";  
    	strDate+=number;  
    }  
    return strDate;  
}
</script>

<div class="easyui-layout" data-options="fit:true,border:false">
     <div data-options="region:'north',border:false" style="height: 30px; overflow: hidden;background-color: #fff">
        <form id="studentRecordSearchForm">
            <table>
                <tr>
                    <th>学生姓名:</th>
                    <td>
                    	<input type="hidden" name="orgid" id="orgStuRecid"/>
                    	<input type="hidden" name="id" id="classStuRecid"/>
                    	<input name="studentname" placeholder="请输入学生姓名"/>
                    </td>
                    <th>开始时间:</th>
                    <td>
                    	<input id="begintimeStuRecId" name="beginTime"  type="text" editable="false" class="easyui-datebox" ></input> 
                    </td>
                    
                    <th>结束时间:</th>
                    <td>
                    	<input id="stoptimeStuRecId" name="stopTime"  type="text" editable="false" class="easyui-datebox"></input>
                    </td>
                    <td>
                        <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'fi-magnifying-glass',plain:true" onclick="studentSearchFun();">查询</a>
                        <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'fi-x-circle',plain:true" onclick="studentCleanFun();">清空</a>
                    </td>
                </tr>
            </table>
        </form>
     </div> 
    <div data-options="region:'center',border:true,title:'学生列表'">
        <table id="studentRecordDataGrid" data-options="fit:true,border:false"></table>
    </div>
     <div data-options="region:'west',border:true,split:false,title:'班级组织'"  style="width:180px;overflow: auto; ">
        <ul id="classStudentRecordTree" style="width:160px;margin: 10px 10px 10px 10px"></ul>
    </div>
</div>
