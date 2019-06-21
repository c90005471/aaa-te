<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/global.jsp" %>
<%--<link rel="stylesheet" type="text/css" href="${path}/static/easyui/easyui-rtl.css">  --%>
<%--<script type="text/javascript" src="${path}/static/easyui/easyui-rtl.js"></script>--%>
<script type="text/javascript">
    var studentByDataGrid;
    var classByTree;
    var classByid=0;
    var orgByid;
    var leafByNode=false;
    $(function() {
    		classByid = null;
    		orgByid = null;
    		classByTree = $('#classByTree').tree({
            url : '${path }/tblClass/tree?Math.random()&&flag=${flag}',
            parentField : 'pid',
            lines : true,
            onLoadSuccess: function (node, data) {
            	$("#classByTree").tree("collapseAll");
            	var roots= $("#classByTree").tree('getRoots');  
                for(var i=0;i<roots.length;i++){  
                    $("#classByTree").tree('expand', roots[i].target);  
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
        		    orgByid = node.id;
        		    classByid = null;
        		    leafByNode=false;
                	$("#orgbyid").val(orgByid);
                	$("#classbyid").val("");
        		    studentByDataGrid.datagrid('load',$.serializeObject($('#studentBySearchForm')));
        		}else{ 
        		    //将classid传入到后台
        		    leafByNode=true;
        		    classByid=node.id;
        		    orgByid = null;
        		    $("#orgbyid").val("");
                	$("#classbyid").val(classByid);
        			studentByDataGrid.datagrid('load',$.serializeObject($('#studentBySearchForm')));

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
        studentByDataGrid = $('#studentByDataGrid').datagrid({
        url : '${path}/student/dataGrid?flag=${flag}',
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
            title : '生日',
            field : 'birthday',
            formatter : function(value, row, index) {
               return GetBirthday(row.idno);
            }
        },{
            title : '性别',
            field : 'sex',
            formatter : function(value, row, index) {
               return Getsex(row.idno);
            }
        },{
            title : '手机号码',
            field : 'phone'
        },{
            title : 'QQ号码',
            field : 'qq'
        },{
            title : '毕业院校名称',
            field : 'schoolname'
        },{
            title : '专业',
            field : 'major'
        },{
            title : '学历',
            field : 'degree'
        },{
            title : '家庭电话',
            field : 'family_phone'
        },{
            title : '家庭地址',
            field : 'address'
        },{
            title : '是否上报考试申请',
            field : 'isreporteaxm'
        },{
            title : '是否参加考试',
            field : 'iseaxm'
        },{
            title : '考试情况',
            field : 'eaxmstat'
        },{
            title : '是否就业',
            field : 'isjob'
        },{
            title : '离校时间',
            field : 'leaschooltime',
            formatter : function(value){
            	if(value!=null){
            		var date = new Date(value);
                    var y = date.getFullYear();
                    var m = date.getMonth() + 1;
                    var d = date.getDate();
                    return y + '-' +m + '-' + d;
            	}else{
            		return "";
            	}
            }
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
            field : 'action1',
            title : '回访记录',
            width : 60,
            formatter : function(value, row, index) {
                var str = $.formatString('<a href="javascript:void(0)" class="student-easyui-linkbutton-returnrecord" data-options="plain:true,iconCls:\'fi-pencil icon-blue\'" onclick="studentReturnFun(\'{0}\');" >'+row.returnsum+'次</a>', row.id);
                return str;
            }
        },
        {
            title : '班级',
            field : 'classname'
        },  /*{
            width : '140',
            title : '创建时间',
            field : 'createTime',
            sortable : true
        },*/ 
			{
			    field : 'action',
			    title : '操作',
			    width : 120,
			    formatter : function(value, row, index) {
			        var str = '';
			        <shiro:hasPermission name="/student/byEdit">
			        	if(row.checkstat==null || row.checkstat==''){
			           	   str += $.formatString('<a href="javascript:void(0)" class="student-easyui-linkbutton-edit" data-options="plain:true,iconCls:\'fi-pencil icon-blue\'" onclick="studentByEditFun(\'{0}\');" >编辑</a>', row.id);
			        	}
			        </shiro:hasPermission>
			        <shiro:hasPermission name="/student/byShow">
			        		str += $.formatString('<a href="javascript:void(0)" class="student-easyui-linkbutton-show" data-options="plain:true,iconCls:\'fi-results icon-purple\'" onclick="studentByShowFun(\'{0}\');" >查看</a>', row.id);
			        </shiro:hasPermission>
			        return str;
			    }
			}           
        ]],
        onLoadSuccess:function(data){
        	//$('.student-easyui-linkbutton-returnrecord').linkbutton({text:data.returnsum +''});
            $('.student-easyui-linkbutton-edit').linkbutton({text:'编辑'});
            $('.student-easyui-linkbutton-show').linkbutton({text:'查看'});
        },
        toolbar : '#studentByToolbar'
    });
   
});


function exportExcelStudentByClassId(){
	if(!leafByNode){
        parent.$.messager.alert('警告', '请在左侧班级组织中选择所属班级！');
    }else{
    	var datagridRows = studentByDataGrid.datagrid("getRows");
    	var frozenColumns = studentByDataGrid.datagrid("options").frozenColumns[0];//获取冻结列
        var columns = studentByDataGrid.datagrid("options").columns[0];
        columns = frozenColumns.concat(columns);
        var dataRows={columns:columns,datagridRows:datagridRows};
        if(datagridRows.length>0){
       	 $.ajax({
         		url:"${path}/student/exportStudentByExcel",
         		type:"post",
         		contentType:"application/json", 
         		async: false,
         	 	data:JSON.stringify(dataRows),
         	 	success:function(data){alert(data);
         	 	  	var fileName=data;
         			//下载文件
         			location.href="${path}/download/"+fileName.replace('"','').replace('"',''); 
         	 	}
         	 	
         	 });
       }else{
       	parent.$.messager.alert('警告', '请先查询出结果列表！');
       }
	    //$("#export").attr('href','${path}/student/exportExcelStudentByClassId?classid='+classByid+'&&flag=${flag}');
	}
}
function importExcelStudentByByClassId() {
	 //判断是否选中了班级
	if(!leafByNode){
		parent.$.messager.alert('警告', '请在左侧班级组织中选择所属班级！');
	}else{
	   parent.$.modalDialog({
	   title : '批量添加',
	   width : 400,
	   height : 200,
	   href : '${path}/student/addManyPage?flag=1',
	   buttons : [ {
	       text : '确定',
	       handler : function() {
	           parent.$.modalDialog.openner_dataGrid = studentByDataGrid;//因为添加成功之后，需要刷新这个treeGrid，所以先预定义好
	           var f = parent.$.modalDialog.handler.find('#studentAddManyForm');
	           f.submit();
	       }
	   } ]
	});
	}
}

/**
 * 编辑
 */
function studentByEditFun(id) {
    if (id == undefined) {
        var rows = studentByDataGrid.datagrid('getSelections');
        id = rows[0].id;
    } else {
    	studentByDataGrid.datagrid('unselectAll').datagrid('uncheckAll');
    }
    parent.$.modalDialog({
        title : '编辑',
        width : 700,
        height : 480,
        href :  '${path}/student/editPage?id=' + id+'&&flag=${flag}',
        buttons : [ {
            text : '确定',
            handler : function() {
                parent.$.modalDialog.openner_dataGrid = studentByDataGrid;//因为添加成功之后，需要刷新这个dataGrid，所以先预定义好
                var f = parent.$.modalDialog.handler.find('#studentByEditForm');
                f.submit();
            }
        } ]
    });
}
/**
 * 查看
 */
function studentByShowFun(id) {
    if (id == undefined) {
        var rows = studentByDataGrid.datagrid('getSelections');
        id = rows[0].id;
    } else {
    	studentByDataGrid.datagrid('unselectAll').datagrid('uncheckAll');
    }
    parent.$.modalDialog({
        title : '查看',
        width : 800,
        height : 650,
        href :  '${path}/student/showPage?id='+ id,
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
function studentCleanFun() {
    $('#studentBySearchForm input').val('');
    studentByDataGrid.datagrid('load', {});
}
/**
 * 搜索
 */
function studentSearchFun() {
	$("#orgbyid").val(orgByid);
	$("#classbyid").val(classByid);
	studentByDataGrid.datagrid('load', $.serializeObject($('#studentBySearchForm')));
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
//显示回访记录
function studentReturnFun(id){
	if (id == undefined) {
        var rows = studentByDataGrid.datagrid('getSelections');
        id = rows[0].id;
    } else {
    	studentByDataGrid.datagrid('unselectAll').datagrid('uncheckAll');
    }
    parent.$.modalDialog({
        title : '回访记录列表',
        width : 750,
        height : 350,
        href :  '${path}/student/returnCordPage?id='+id,
        buttons : [ {
            text : '关闭',
            handler : function() {
            	parent.$.modalDialog.handler.dialog('close');
            	studentByDataGrid.datagrid('reload');
            }
        } ]
    });
}
</script>

<div class="easyui-layout" data-options="fit:true,border:false">
     <div data-options="region:'north',border:false" style="height: 30px; overflow: hidden;background-color: #fff">
        <form id="studentBySearchForm">
            <table>
                <tr>
                    <th>学生姓名:</th>
                    <td>
                    	<input type="hidden" name="orgid" id="orgbyid"/>
                    	<input type="hidden" name="id" id="classbyid"/>
                    	<input name="stuname" placeholder="请输入学生姓名"/>
                    </td>
                    <th>毕业院校:</th>
                    <td>
                    	<input name="schoolname" placeholder="请输入毕业院校"/>
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
        <table id="studentByDataGrid" data-options="fit:true,border:false"></table>
    </div>
     <div data-options="region:'west',border:true,split:false,title:'班级组织'"  style="width:180px;overflow: auto; ">
        <ul id="classByTree" style="width:160px;margin: 10px 10px 10px 10px"></ul>
    </div>
</div>
<div id="studentByToolbar" style="display: none;">
	<shiro:hasPermission name="/student/byEdit">
		<a onclick="importExcelStudentByByClassId();" href="javascript:void(0);" class="easyui-linkbutton" data-options="plain:true,iconCls:'fi-upload icon-green'">批量添加毕业信息</a>
	</shiro:hasPermission>
    <shiro:hasPermission name="/student/export">
        <a onclick="exportExcelStudentByClassId();" id="export" href="javascript:void(0);"   class="easyui-linkbutton" data-options="plain:true,iconCls:'fi-download icon-green'">导出excel</a>
    </shiro:hasPermission>
    <a  id="download" href="${path}/static/model/studentBy.xls"   class="easyui-linkbutton" data-options="plain:true,iconCls:'fi-page-csv icon-green'">下载模版</a>
</div>