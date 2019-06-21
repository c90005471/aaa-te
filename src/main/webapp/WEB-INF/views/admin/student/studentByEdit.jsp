<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/global.jsp" %>
<script type="text/javascript">
    $(function() {
        $('#studentByEditForm').form({
            url : '${path}/student/editBy',
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
                    var form = $('#studentEditForm');
                    parent.$.messager.alert('错误', eval(result.msg), 'error');
                }
            }
        });
        
        
		$('#teacherid').combobox({
			//url : '${path }/user/getUserListByRoleId?roleid=12',
			url : '${path }/user/getUserListByRoleId',
			valueField : 'id',		//隐藏框的value
			textField : 'name',		//要显示的value
			panelHeight:"200",
			value:'${studentCompany.teacherid}',
			onSelect : function(rec) {
			
			}
		});
		
		/*$('#major').combobox({
			url : '${path }/student/getMajor',
			valueField : 'name',
			textField : 'name',
			onSelect : function(rec) {
			
			}
		});
		
		$('#classId').combobox({
			url : '${path }/student/getClassById?id='+${student.id},
			valueField : 'id',				//隐藏框的value
			value:'${student.class_id}', 
			textField : 'classname',		//要显示的value
			onSelect : function(rec) {
			
			}
		}); */
		$("#isreporteaxm").val("${empty studentCompany.isreporteaxm ? '是' : studentCompany.isreporteaxm}");
		$("#iseaxm").val("${empty studentCompany.iseaxm ? '是' : studentCompany.iseaxm}");
		$("#eaxmstat").val("${empty studentCompany.eaxmstat ? '通过' : studentCompany.eaxmstat}");
		$("#isjob").val("${empty studentCompany.isjob ? '是' : studentCompany.isjob}");
		$("#citylev").val("${empty studentCompany.citylev ? '一线' : studentCompany.citylev}");
		//$("#checkstat").val("${empty studentCompany.checkstat ? '正确' : studentCompany.checkstat}");
		$("#stufl").val("${empty studentCompany.stufl ? 'A' : studentCompany.stufl}");
		
		 //时间不能选当前时间以前的
	    $(function(){
				$('#dd').datebox().datebox('calendar').calendar({
					validator: function(date){
						//var now = new Date();
						//var d1 = new Date(now.getFullYear(), now.getMonth(), now.getDate());
						//var d2 = new Date(now.getFullYear(), now.getMonth(), now.getDate()+10);
						//return d1<=date && date<=d2;
						return true;
						}
					});
				});
    });
    
    function calBonus(){
    	var citylev = $("#citylev").combobox('getValue');
    	var prosalary = $("#prosalary").val();
    	if(citylev==null||citylev==""){
    		parent.$.messager.alert('警告', '请选择城市级别！');
    		return;
    	}
    	if(prosalary==null||prosalary==""){
    		parent.$.messager.alert('警告', '请输入试用工资！');
    		return;
    	}	
    	if(citylev!=null&&prosalary!=null){
    		$.ajax({
         		url:"${path}/student/calBonus",
         		type:"post",
         		data:{"stuid":$("#stuid").val(),"citylev":citylev,"prosalary":prosalary},
         		async: false,
         	 	success:function(data){
         	 		$("#bonus").val(data);
         	 	}
         	 });
    	}
    }
</script>
<%-- ${student} --%>
<div class="easyui-layout" data-options="fit:true,border:false">
    <div data-options="region:'center',border:false" title="" style="overflow: hidden;padding: 3px;">
        <form id="studentByEditForm" method="post">
             <input name="stuid" id="stuid" value="${student.id}" type="hidden"  >
             <input name="cid" value="${studentCompany.cid}" type="hidden"  >
             <table class="grid">
             <tr>
                <td>姓名</td>
                <td>
                	<input name="stuname" value="${student.stuname}" type="text" placeholder="请输入姓名" class="easyui-validatebox span2" data-options="required:true" disabled="disabled">
                </td>
                <td>是否上报考试申请</td>
                <td>
                	<select id="isreporteaxm" name="isreporteaxm"  class="easyui-combobox" data-options="width:140,height:29,editable:false,panelHeight:'auto',required:true">
                        <option value="">请选择</option>
                        <option value="是">是</option>
                        <option value="否">否</option>
                    </select>
                </td>
            </tr>
             <tr>
                <td>是否参加考试</td>
                <td>
                	<select id="iseaxm" name="iseaxm"  class="easyui-combobox" data-options="width:140,height:29,editable:false,panelHeight:'auto'">
                        <option value="">请选择</option>
                        <option value="是">是</option>
                        <option value="否">否</option>
                    </select>
                </td>
                <td>考试情况</td>
                <td>
                	<select id="eaxmstat" name="eaxmstat"  class="easyui-combobox" data-options="width:140,height:29,editable:false,panelHeight:'auto'">
                        <option value="">请选择</option>
                        <option value="通过">通过</option>
                        <option value="不通过">不通过</option>
                    </select>
                </td>
            </tr>
            <tr>
 				<td>是否就业</td>
                <td>
                	<select id="isjob" name="isjob"  class="easyui-combobox" data-options="width:140,height:29,editable:false,panelHeight:'auto'">
                        <option value="">请选择</option>
                        <option value="是">是</option>
                        <option value="否">否</option>
                    </select>
                </td>  
                <td>离校时间</td>
                <td>
                	<input name="leaschooltime" id="dd" type="text" placeholder="请输入离校时间"  data-options="required:true" value="<fmt:formatDate value='${studentCompany.leaschooltime}' pattern='yyyy-MM-dd'/>">
                </td>         	
           	</tr>
            <tr>               
                 <td>就业城市</td>
                <td><input name="companyaddr" value="${empty studentCompany.companyaddr ? '上海' : studentCompany.companyaddr}" type="text" placeholder="请输入就业城市" class="easyui-validatebox span2" ></td>
            	<td>城市级别</td>
                <td>
                	<select id="citylev" name="citylev"  class="easyui-combobox" data-options="width:140,height:29,editable:false,panelHeight:'auto'">
                        <option value="">请选择</option>
                        <option value="一线">一线</option>
                        <option value="二线">二线</option>
                        <option value="三线">三线</option>
                    </select>
                </td>
            </tr>
             <tr>
             	<td>就业企业</td>
                <td><input name="companyname" value="${studentCompany.companyname}" type="text" placeholder="请输入就业企业" class="easyui-validatebox span2"  data-options="required:true"></td>
            	<td>岗位</td>
                <td>
                    <input name="station" value="${studentCompany.station}" type="text" placeholder="请输入就业企业" class="easyui-validatebox span2" >
                </td>
            </tr>
            <tr>
                <td>试用期工资</td>
                <td><input id="prosalary" name="prosalary" value="${studentCompany.prosalary}" type="text" placeholder="请输入试用期工资" class="easyui-validatebox span2" ></td>
             	<td>联系方式</td>
                <td>
                	<c:if test="${studentCompany.xphone==null}">
                		<input name="xphone" value="${student.phone}" type="text" placeholder="请输入联系方式" class="easyui-validatebox span2" >
                	</c:if>
                	<c:if test="${studentCompany.xphone!=null}">
                		<input name="xphone" value="${studentCompany.xphone}" type="text" placeholder="请输入联系方式" class="easyui-validatebox span2" >
                	</c:if>
                </td>
            </tr>
             <tr>
             <td>转正工资</td>
                <td><input name="forsalary" value="${studentCompany.forsalary}" type="text" placeholder="请输入转正工资" class="easyui-validatebox span2" >
               </td>
            	<td>就业老师</td>
                <td>
                	<input id="teacherid" name="teacherid" value="${studentCompany.teacherid}"> 
                </td>
            </tr>
            <tr>
            	<td>补助</td>
                <td>
                	<input name="needs" value="${studentCompany.needs}" type="text" placeholder="请输入补助" class="easyui-validatebox span2" >
                </td>
                <td>学员分类</td>
                <td>
                	<select name="stufl" id="stufl" class="easyui-combobox" data-options="width:140,height:29,editable:false,panelHeight:'auto'">
                        <option value="">=请选择=</option>
                        <option value="A">A</option>
                        <option value="B">B</option>
                        <option value="C">C</option>
                    </select>
                </td>
            </tr>
            <tr>
                <td>就业奖金</td>
                <td >
                	<input name="bonus" id="bonus" value="${studentCompany.bonus}" type="text" placeholder="请输入就业奖金" class="easyui-validatebox span2" >
                	<a class="easyui-linkbutton" href="javascript:void(0)" onclick="calBonus()" style="width:50px;">计算</a>
                </td>
<%--                <td>审核结果</td>--%>
<%--                <td>--%>
<%--                	<select id="checkstat" name="checkstat"  class="easyui-combobox" data-options="width:140,height:29,editable:false,panelHeight:'auto'">--%>
<%--                        <option value="">请选择</option>--%>
<%--                        <option value="正确">正确</option>--%>
<%--                        <option value="不正确">不正确</option>--%>
<%--                    </select>--%>
<%--                </td>--%>
            </tr>
            <tr>
                <td>备注</td>
                <td colspan="3">
                	<textarea name="remark" value="" style="width:90%;height:40px;resize:none;" class="easyui-validatebox span2">${studentCompany.remark}</textarea>
                </td>
            </tr>
            </table>
        </form>
    </div>
</div>