<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/global.jsp" %>
<%--<link rel="stylesheet" type="text/css" href="${path}/static/easyui/easyui-rtl.css">  --%>
<%--<script type="text/javascript" src="${path}/static/easyui/easyui-rtl.js"></script>--%>
<script type="text/javascript">
    var studentByAuditDataGrid;
    var classByAuditTree;
    var classByiAuditd=0;
    var orgByAuditid;
    var leafByNode=false;
    $(function() {
    		classByAuditid = null;
    		orgByAuditid = null;
    		classByAuditTree = $('#classByAuditTree').tree({
            url : '${path }/tblClass/tree?Math.random()&&flag=1',
            parentField : 'pid',
            lines : true,
            onLoadSuccess: function (node, data) {
            	$("#classByAuditTree").tree("collapseAll");
            	var roots= $("#classByAuditTree").tree('getRoots');  
                for(var i=0;i<roots.length;i++){  
                    $("#classByAuditTree").tree('expand', roots[i].target);  
                }
              },
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
        		    orgByAuditid = node.id;
        		    classByAuditid = null;
        		    leafByAuditNode=false;
                	$("#orgbyAuditid").val(orgByid);
                	$("#classbyAuditid").val("");
        		    studentByAuditDataGrid.datagrid('load',$.serializeObject($('#studentByAuditSearchForm')));
        		}else{ 
        		    //将classid传入到后台
        		    leafByAuditNode=true;
        		    classByAuditid=node.id;
        		    orgByAuditid = null;
        		    $("#orgbyAuditid").val("");
                	$("#classbyAuditid").val(classByAuditid);
        			studentByAuditDataGrid.datagrid('load',$.serializeObject($('#studentByAuditSearchForm')));

	               	//将添加按钮显示
	       			/* studentDataGrid.datagrid( {
	                    	toolbar : '#studentToolbar'
	                	} 
               	); */

               	//给导出赋值url
                /* $("#export").attr('href','${path}/student/exportExcelStudentByClassId?classid='+classid);  */
                
        		}
            }
        });
        studentByAuditDataGrid = $('#studentByAuditDataGrid').datagrid({
        url : '${path}/student/dataGrid?flag=1',
        striped : true,
        //rownumbers : true,
        pagination : true,
        fitColumns:true,
        singleSelect : true,
        idField : 'id',
        sortName : 'id',
        sortOrder : 'asc',
        pageSize : 20,
        pageList : [ 10, 20, 30, 40, 50, 100, 200, 300, 400, 500],
        frozenColumns:[[
            {
                title : '编号',
                field : 'id',
                sortable : true,
                hidden:true
            },{
                title : '编号',
                field : 'stuid',
                sortable : true,
                hidden:true
            }, {
                
                title : '学号',
                field : 'stuno'
            },{
                
                title : '学生姓名',
                field : 'stuname'
            },
        ]],
        columns : [ [{
            
            title : '身份证号码',
            field : 'idno'
        },{
            title : '就业城市',
            field : 'companyaddr'
        },{
            title : '城市级别',
            field : 'citylev'
        },{
            
            title : '就业企业',
            field : 'companyname'
        },{
            
            title : '岗位',
            field : 'station'
        },{
            
            title : '试用工资',
            field : 'prosalary'
        },{
            
            title : '转正工资',
            field : 'forsalary'
        },{
            
            title : '补助',
            field : 'needs'
        },{
            
            title : '联系方式',
            field : 'xphone'
        },{
            
            title : '就业老师',
            field : 'teachername'
        },{
            
            title : '就业奖金',
            field : 'bonus'
        },{
            
            title : '审核结果',
            field : 'checkstat'
        },{
            title : '班级',
            field : 'classname'
        },{
			    field : 'action',
			    title : '操作',
			    width : 120,
			    formatter : function(value, row, index) {
			        var str = '';
			        <shiro:hasPermission name="/student/audit">
			        	if(row.checkstat==null || row.checkstat==''){
			            	str += $.formatString('<a href="javascript:void(0)" class="student-easyui-linkbutton-edit" data-options="plain:true,iconCls:\'fi-pencil icon-blue\'" onclick="studentByAuditEditFun(\'{0}\');" >审核</a>', row.id);
			        	}
			         </shiro:hasPermission>
			        <shiro:hasPermission name="/student/auditShow">
			        	str += $.formatString('<a href="javascript:void(0)" class="student-easyui-linkbutton-show" data-options="plain:true,iconCls:\'fi-results icon-purple\'" onclick="studentByAuditShowFun(\'{0}\');" >查看</a>', row.id);
			    	</shiro:hasPermission>
			        return str;
			    }
			}           
        ]],
        onLoadSuccess:function(data){
        	//$('.student-easyui-linkbutton-returnrecord').linkbutton({text:data.returnsum +''});
            $('.student-easyui-linkbutton-edit').linkbutton({text:'审核'});
            $('.student-easyui-linkbutton-show').linkbutton({text:'查看'});
        }
    });
   
});


/**
 * 编辑
 */
function studentByAuditEditFun(id) {
    if (id == undefined) {
        var rows = studentByAuditDataGrid.datagrid('getSelections');
        id = rows[0].id;
    } else {
    	studentByAuditDataGrid.datagrid('unselectAll').datagrid('uncheckAll');
    }
    parent.$.modalDialog({
        title : '编辑',
        width : 700,
        height : 400,
        href :  '${path}/student/audit?id='+ id,
        buttons : [ {
            text : '确定',
            handler : function() {
                parent.$.modalDialog.openner_dataGrid = studentByAuditDataGrid;//因为添加成功之后，需要刷新这个dataGrid，所以先预定义好
                var f = parent.$.modalDialog.handler.find('#studentByAuditForm');
                f.submit();
            }
        } ]
    });
}
/**
 * 查看
 */
function studentByAuditShowFun(id) {
    if (id == undefined) {
        var rows = studentByAuditDataGrid.datagrid('getSelections');
        id = rows[0].id;
    } else {
    	studentByAuditDataGrid.datagrid('unselectAll').datagrid('uncheckAll');
    }
    parent.$.modalDialog({
        title : '查看',
        width : 700,
        height : 400,
        href :  '${path}/student/auditShow?id='+ id,
        buttons : [ {
            text : '关闭',
            handler : function() {
            	$.modalDialog.handler.dialog('close');
            }
        } ]
    });
}


/**
 * 清除
 */
function studentAuditCleanFun() {
    $('#studentByAuditSearchForm input').val('');
    studentByAuditDataGrid.datagrid('load', {});
}
/**
 * 搜索
 */
function studentAuditSearchFun() {
	$("#orgbyAuditid").val(orgByAuditid);
	$("#classbyAuditid").val(classByAuditid);
	studentByAuditDataGrid.datagrid('load', $.serializeObject($('#studentByAuditSearchForm')));
}
//----------------------------------------------------------
//功能：根据身份证号获得出生日期
//参数：身份证号 psidno
//返回值：
//出生日期
//----------------------------------------------------------
function GetBirthday(psidno){
var birthdayno,birthdaytemp;
if(psidno.length==18){
  birthdayno=psidno.substring(6,14);
}else if(psidno.length==15){
  birthdaytemp=psidno.substring(6,12);
  birthdayno="19"+birthdaytemp;
}else{
  //alert("错误的身份证号码，请核对！");
  return false;
}
var birthday=birthdayno.substring(0,4)+"-"+birthdayno.substring(4,6)+"-"+birthdayno.substring(6,8);
return birthday;
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

</script>

<div class="easyui-layout" data-options="fit:true,border:false">
     <div data-options="region:'north',border:false" style="height: 30px; overflow: hidden;background-color: #fff">
        <form id="studentByAuditSearchForm">
            <table>
                <tr>
                    <th>学生姓名:</th>
                    <td>
                    	<input type="hidden" name="orgid" id="orgbyAuditid"/>
                    	<input type="hidden" name="id" id="classbyAuditid"/>
                    	<input name="stuname" placeholder="请输入学生姓名"/>
                    </td>
                    <th>毕业院校:</th>
                    <td>
                    	<input name="schoolname" placeholder="请输入毕业院校"/>
                    </td>
                    <td>
                        <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'fi-magnifying-glass',plain:true" onclick="studentAuditSearchFun();">查询</a>
                        <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'fi-x-circle',plain:true" onclick="studentAuditCleanFun();">清空</a>
                    </td>
                </tr>
            </table>
        </form>
     </div> 
    <div data-options="region:'center',border:true,title:'学生列表'">
        <table id="studentByAuditDataGrid" data-options="fit:true,border:false"></table>
    </div>
     <div data-options="region:'west',border:true,split:false,title:'班级组织'"  style="width:180px;overflow: auto; ">
        <ul id="classByAuditTree" style="width:160px;margin: 10px 10px 10px 10px"></ul>
    </div>
</div>
