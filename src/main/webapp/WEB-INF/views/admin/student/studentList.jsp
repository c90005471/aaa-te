<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/global.jsp" %>
<script type="text/javascript">
    var studentDataGrid;
    var classTreeStudent;
    var classidStudent=0;
    var orgidStudent;
    var leafNode=false;
    $(function() {
    		classidStudent = null;
    		orgidStudent = null;
    	    classTreeStudent = $('#classTreeStudent').tree({
            url : '${path }/tblClass/tree?Math.random()',
            parentField : 'pid',
            lines : true,
            onLoadSuccess: function (node, data) {
            	$("#classTreeStudent").tree("collapseAll");
            	var roots= $("#classTreeStudent").tree('getRoots');  
                for(var i=0;i<roots.length;i++){  
                    $("#classTreeStudent").tree('expand', roots[i].target);  
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
        		    orgidStudent = node.id;
        		    classidStudent = null;
        		    leafNode=false;
                	$("#orgidStudent").val(orgidStudent);
                	$("#classidStudent").val("");
        		    studentDataGrid.datagrid('load',$.serializeObject($('#studentSearchForm')));
        		}else{ 
        		    //将classid传入到后台
        		    leafNode=true;
        		    classidStudent=node.id;
        		    orgidStudent = null;
        		    $("#orgidStudent").val("");
                	$("#classidStudent").val(classidStudent);
        			studentDataGrid.datagrid('load',$.serializeObject($('#studentSearchForm')));

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
        studentDataGrid = $('#studentDataGrid').datagrid({
        url : '${path}/student/dataGrid',
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
            
            title : '学号',
            field : 'stuno'
        },{
           
            title : '学生姓名',
            field : 'stuname'
        },{
            
            title : '身份证号码',
            field : 'idno'
        },
        {
            
            title : '生日',
            field : 'birthday',
            formatter : function(value, row, index) {
               return GetBirthday(row.idno);
            }
        },
        {
            title : '性别',
            field : 'sex',
            formatter : function(value, row, index) {
               return Getsex(row.idno);
            }
        },
        {
            title : '手机号码',
            field : 'phone'
        },
        {
            title : 'QQ号码',
            field : 'qq'
        }
        ,
        {
            title : '毕业院校名称',
            field : 'schoolname'
        },
        {
            title : '专业',
            field : 'major'
        },
        {
            title : '学历',
            field : 'degree'
        },
        {
            title : '家庭电话',
            field : 'family_phone'
        },
        {
            title : '家庭地址',
            field : 'address'
        },
        {
            title : '班级',
            field : 'classname'
        }, 
        {
            title : '状态',
            field : 'delete_flag',
            sortable : true,
            formatter : function(value, row, index) {
                switch (value) {
                case 0:
                    return '正常';
                case 1:
                    return '停用';
                }
            }
        },  {
            width : '140',
            title : '创建时间',
            field : 'createTime',
            sortable : true
        }, {
            field : 'action',
            title : '操作',
            width : 200,
            formatter : function(value, row, index) {
                var str = '';
                <shiro:hasPermission name="/student/edit">
                    str += $.formatString('<a href="javascript:void(0)" class="student-easyui-linkbutton-edit" data-options="plain:true,iconCls:\'fi-pencil icon-blue\'" onclick="studentEditFun(\'{0}\');" >编辑</a>', row.id);
                </shiro:hasPermission>
                <shiro:hasPermission name="/student/delete">
                    str += '&nbsp;&nbsp;|&nbsp;&nbsp;';
                    str += $.formatString('<a href="javascript:void(0)" class="student-easyui-linkbutton-del" data-options="plain:true,iconCls:\'fi-x icon-red\'" onclick="studentDeleteFun(\'{0}\');" >删除</a>', row.id);
                </shiro:hasPermission>
                return str;
            }
        } ] ],
        onLoadSuccess:function(data){
            $('.student-easyui-linkbutton-edit').linkbutton({text:'编辑'});
            $('.student-easyui-linkbutton-del').linkbutton({text:'删除'});
        },
        toolbar : '#studentToolbar'
    });
   
});

/**
 * 添加框
 * @param url
 */
function studentAddFun() {
 if(!leafNode){
        	parent.$.messager.alert('警告', '请在左侧班级组织中选择所属班级！');
        }else
        {
    parent.$.modalDialog({
        title : '添加',
        width : 500,
        height : 300,
        href : '${path}/student/addPage',
        buttons : [ {
            text : '确定',
            handler : function() {
                parent.$.modalDialog.openner_dataGrid = studentDataGrid;//因为添加成功之后，需要刷新这个treeGrid，所以先预定义好
                var f = parent.$.modalDialog.handler.find('#studentAddForm');
                f.submit();
            }
        } ]
    });
    }
}
function importExcelStudentByClassId() {
     		 //判断是否选中了班级
        if(!leafNode){
        	parent.$.messager.alert('警告', '请在左侧班级组织中选择所属班级！');
        }else
        {
	        parent.$.modalDialog({
	        title : '批量添加',
	        width : 400,
	        height : 200,
	        href : '${path}/student/addManyPage',
	        buttons : [ {
	            text : '确定',
	            handler : function() {
	                parent.$.modalDialog.openner_dataGrid = studentDataGrid;//因为添加成功之后，需要刷新这个treeGrid，所以先预定义好
	                var f = parent.$.modalDialog.handler.find('#studentAddManyForm');
	                f.submit();
	            }
	        } ]
	    });
	}
}
function exportExcelStudentByClassId(){
	if(!leafNode){
        parent.$.messager.alert('警告', '请在左侧班级组织中选择所属班级！');
    }else{
	    $("#stuExport").attr('href','${path}/student/exportExcelStudentByClassId?classid='+classidStudent);
	}
}
/* function exportExcelStudentByClassId() {
     $.ajax({
     		url:"${path}/student/exportExcelStudentByClassId",
     		type:"post",
     	 	data:{
     			classid:classid
     		}, 
     		success:function(data){
     		   var fileName=data;
     		//下载文件
     			location.href="${pageContext.request.contextPath}/download/"+fileName.replace('"','').replace('"',''); 
     		},
     		error:function(xhr,msg){
     			alert(msg);
     		}
     		}
     		);
} */


/**
 * 编辑
 */
function studentEditFun(id) {
    if (id == undefined) {
        var rows = studentDataGrid.datagrid('getSelections');
        id = rows[0].id;
    } else {
        studentDataGrid.datagrid('unselectAll').datagrid('uncheckAll');
    }
    parent.$.modalDialog({
        title : '编辑',
        width : 700,
        height : 360,
        href :  '${path}/student/editPage?id=' + id,
        buttons : [ {
            text : '确定',
            handler : function() {
                parent.$.modalDialog.openner_dataGrid = studentDataGrid;//因为添加成功之后，需要刷新这个dataGrid，所以先预定义好
                var f = parent.$.modalDialog.handler.find('#studentEditForm');
                f.submit();
            }
        } ]
    });
}


/**
 * 删除
 */
 function studentDeleteFun(id) {
     if (id == undefined) {//点击右键菜单才会触发这个
         var rows = studentDataGrid.datagrid('getSelections');
         id = rows[0].id;
     } else {//点击操作里面的删除图标会触发这个
         studentDataGrid.datagrid('unselectAll').datagrid('uncheckAll');
     }
     parent.$.messager.confirm('询问', '您是否要删除当前学生？', function(b) {
         if (b) {
             progressLoad();
             $.post('${path}/student/delete', {
                 id : id
             }, function(result) {
                 if (result.success) {
                     parent.$.messager.alert('提示', result.msg, 'info');
                     studentDataGrid.datagrid('reload');
                 }
                 progressClose();
             }, 'JSON');
         }
     });
}


/**
 * 清除
 */
function studentCleanFun() {
    $('#studentSearchForm input').val('');
    studentDataGrid.datagrid('load', {});
}
/**
 * 搜索
 */
function studentSearchFun() {
	$("#orgidStudent").val(orgidStudent);
	$("#classidStudent").val(classidStudent);
     studentDataGrid.datagrid('load', $.serializeObject($('#studentSearchForm')));
}

  //----------------------------------------------------------
//    功能：根据身份证号获得出生日期
//  参数：身份证号 psidno
//    返回值：
//    出生日期
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
    return birthday    ;
}

//----------------------------------------------------------
//    功能：根据身份证号获得性别
//  参数：身份证号 psidno
//    返回值：
//    性别
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
        <form id="studentSearchForm">
            <table>
                <tr>
                    <th>学生姓名:</th>
                    <td>
                    	<input type="hidden" name="orgid" id="orgidStudent"/>
                    	<input type="hidden" name="id" id="classidStudent"/>
                    	<input name="stuname" placeholder="请输入学生姓名"/>
                    </td>
                    <th>QQ号码:</th>
                    <td><input name="qq" placeholder="请输入QQ号码"/></td>
                    <td>
                        <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'fi-magnifying-glass',plain:true" onclick="studentSearchFun();">查询</a>
                        <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'fi-x-circle',plain:true" onclick="studentCleanFun();">清空</a>
                    </td>
                </tr>
            </table>
        </form>
     </div> 
    <div data-options="region:'center',border:true,title:'学生列表'">
        <table id="studentDataGrid" data-options="fit:true,border:false"></table>
    </div>
     <div data-options="region:'west',border:true,split:false,title:'班级组织'"  style="width:180px;overflow: auto; ">
        <ul id="classTreeStudent" style="width:160px;margin: 10px 10px 10px 10px"></ul>
    </div>
</div>
<div id="studentToolbar" style="display: none;">
    <shiro:hasPermission name="/student/add">
        <a onclick="studentAddFun();" href="javascript:void(0);" class="easyui-linkbutton" data-options="plain:true,iconCls:'fi-plus icon-green'">单个添加学生</a>
    </shiro:hasPermission>
    <shiro:hasPermission name="/student/add">
        <a onclick="importExcelStudentByClassId();" href="javascript:void(0);" class="easyui-linkbutton" data-options="plain:true,iconCls:'fi-upload icon-green'">批量添加学生</a>
    </shiro:hasPermission>
    <shiro:hasPermission name="/student/export">
        <a onclick="exportExcelStudentByClassId();" id="stuExport" href="javascript:void(0);"   class="easyui-linkbutton" data-options="plain:true,iconCls:'fi-download icon-green'">导出excel</a>
    </shiro:hasPermission>
        <a  id="download" href="${path}/static/model/student.xls"   class="easyui-linkbutton" data-options="plain:true,iconCls:'fi-page-csv icon-green'">下载模版</a>
</div>