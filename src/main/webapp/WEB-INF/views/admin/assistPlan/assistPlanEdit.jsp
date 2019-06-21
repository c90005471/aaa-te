<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/global.jsp" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<script type="text/javascript">
    $(function() {
    
        $('#assistPlanEditForm').form({
            url : '${path}/assistPlan/edit',
            onSubmit : function() {
                progressLoad();
                var isValid = $(this).form('validate');
                if (!isValid) {
                    progressClose();
                }
                return isValid;
            },
            success : function(result) {
                progressClose();
                result = $.parseJSON(result);
                if (result.success) {
                    parent.$.modalDialog.openner_dataGrid.datagrid('reload');//之所以能在这里调用到parent.$.modalDialog.openner_dataGrid这个对象，是因为user.jsp页面预定义好了
                    parent.$.modalDialog.handler.dialog('close');
                } else {
                    var form = $('#assistPlanEditForm');
                    parent.$.messager.alert('错误',result.msg, 'error');
                }
            }
        });
        
        
      //帮扶学生
        $("#students").combogrid({
        	panelWidth:450,
        	//mode:'remote',//当设置为'remote'模式的时候，用户输入将会发送到名为'q'的http请求参数，向服务器检索新的数据
        	multiple:true,//是否支持多选
        	editable:false,
        	url : '${path}/student/dataGrid?id='+${classid},
            striped : true,
            //rownumbers : true,
            pagination : true,
            fitColumns:false,
            //singleSelect : false,
            idField : 'stuno',
            textField:'stuname',
            value:"${stunos}",//默认值
            sortName : 'id',
            sortOrder : 'asc',
            pageSize : 20,
            pageList : [20, 30, 40, 50, 100],
            columns : [ [ {
            	field:'ck',
            	checkbox:true
            },{
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
            },{
                title : '性别',
                field : 'sex',
                formatter : function(value, row, index) {
                   return Getsex(row.idno);
                }
            },{
                title : '手机号码',
                field : 'phone'
            }]]
        });
      
      
      $("#isstatus").val("${assistPlan.isstatus}");
    });
    
  //----------------------------------------------------------
//  功能：根据身份证号获得性别
//参数：身份证号 psidno
//  返回值：
//  性别
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
    //时间不能选当前时间以前的
    $(function(){
    	$('#startTime').datetimebox().datetimebox('calendar').calendar({
			validator: function(date){
				//var now = new Date();
				//var d1 = new Date(now.getFullYear(), now.getMonth(), now.getDate());
				//var d2 = new Date(now.getFullYear(), now.getMonth(), now.getDate()+10);
				//return d1<=date && date<=d2;
				return true;
				}
			});
		
		$('#endTime').datetimebox().datetimebox('calendar').calendar({
			validator: function(date){
				//var now = new Date();
				//var d1 = new Date(now.getFullYear(), now.getMonth(), now.getDate());
				//var d2 = new Date(now.getFullYear(), now.getMonth(), now.getDate()+10);
				//return d1<=date && date<=d2;
				return true;
				}
			});
		});
</script>
<div class="easyui-layout" data-options="fit:true,border:false">
    <div data-options="region:'center',border:false" title="" style="overflow: hidden;padding: 3px;">
        <form id="assistPlanEditForm" method="post">
        	<input type="hidden" name="id" value="${assistPlan.id}"/>
        	<input type="hidden" name="classid" value="${assistPlan.classid}"/>
        	<input type="hidden" name="creator" value="${assistPlan.creator}"/>
            <table class="grid">
             <tr>
                <td>学习内容</td>
                <td colspan="3">
                    <input id="stucontent" name="stucontent" style="height:25px;width:400px;" type="text" class="easyui-validatebox span2" data-options="required:true" value="${assistPlan.stucontent}">
                </td>               
             </tr>           
             <tr>
                <td>开始时间</td>
                <td><input id="startTime" name="starttime" style="height:30px;width:150px;" type="text" placeholder="请选择开始时间" class="easyui-datetimebox" data-options="required:true" value="<fmt:formatDate value="${assistPlan.starttime}" pattern="yyyy-MM-dd HH:mm:ss"/>"></td>
                
                <td>结束时间</td>
                <td><input id="endTime" name="endtime" style="height:30px;width:150px;" type="text" placeholder="请选择结束时间" class="easyui-datetimebox" data-options="required:true" value="<fmt:formatDate value="${assistPlan.endtime}" pattern="yyyy-MM-dd HH:mm:ss"/>"></td>
             </tr>
             <tr>
                <td>帮扶学生</td>
                <td colspan="3">
                	<input id="students" name="students" style="height:25px;width:300px;" type="text" class="easyui-validatebox span2"/>
                </td>
            </tr>
            <tr>
                <td>计划内容</td>
                <td colspan="3">
                	<textarea name="plancontent" style="width:400px;height:65px;resize:none;" class="easyui-validatebox span2">${assistPlan.plancontent}</textarea>
                </td>
            </tr>
            <tr>
                <td>完成情况</td>
                <td colspan="3">
                	<textarea name="comflan" style="width:400px;height:65px;resize:none;" class="easyui-validatebox span2">${assistPlan.comflan}</textarea>
                </td>
            </tr>
            <tr>
                <td>备注</td>
                <td colspan="3">
                	<textarea name="remark" style="width:400px;height:60px;resize:none;" class="easyui-validatebox span2">${assistPlan.remark}</textarea>
                </td>
            </tr>
            <tr>
                   <td>是否完成</td>
                   <td colspan="3">
                       <select id="isstatus" style="height:30px;width:150px;" name="isstatus" class="easyui-combobox" data-options="width:140,height:29,editable:false,panelHeight:'auto'">
                           <option value="0" selected="selected">未完成</option>
                           <option value="1">已完成</option>                
                       </select>
                   </td>
              </tr>
            </table>
        </form>
    </div>
</div>