<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/global.jsp" %>
<script type="text/javascript">
    $(function() {
    	//选择教员
    	$('#teachernoStuPlan').combotree({
            url : '${path }/teacherPlan/teacher?classid='+classidStuPlan,
            parentField : 'pid',
            lines : true,
            panelHeight : 'auto'
        }); 
    	$('#chapterId').combotree({
            url : '${path }/course/allTree?orgid='+orgidStuPlan+'&&coursetype='+$('#courseType').val(),
            parentField : 'pid',
            lines : true,
            panelHeight : '200',
            onLoadSuccess: function (row, data) {
                $('#chapterId').combotree('tree').tree("collapseAll");
            }
        });
        $('#stuPlanAddForm').form({
            url : '${path}/stuPlan/add?classid='+classidStuPlan,
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
                    //之所以能在这里调用到parent.$.modalDialog.openner_dataGrid这个对象，是因为user.jsp页面预定义好了
                    parent.$.modalDialog.openner_dataGrid.datagrid('reload');
                    parent.$.modalDialog.handler.dialog('close');
                } else {
                    var form = $('#stuPlanAddForm');
                    parent.$.messager.alert('错误', eval(result.msg), 'error');
                }
            }
        });
    });
    
    //时间不能选当前时间以前的
    $(function(){
			$('#dd').datetimebox().datetimebox('calendar').calendar({
				validator: function(date){
					var now = new Date();
					var d1 = new Date(now.getFullYear(), now.getMonth(), now.getDate());
					var d2 = new Date(now.getFullYear(), now.getMonth(), now.getDate()+10);
					return d1<=date && date<=d2;
					}
				});
			});
    function changeChapter(){
    	$('#chapterId').combotree("clear");
    	$('#chapterId').combotree('reload','${path }/course/allTree?orgid='+orgidStuPlan+'&&coursetype='+$('#courseType').val());
    }
    /**
	 * 清除
	 */
	function clearFun() {
		$('#teacherno input').val('');
		$('#teacherno').combotree('load', {});
	}
</script>
<div class="easyui-layout" data-options="fit:true,border:false" >
    <div data-options="region:'center',border:false" style="overflow: hidden;padding: 3px;" >
          <form id="stuPlanAddForm" method="post">
            <table class="grid">
             <tr>
                <td>选择自<br/>评类型</td>
                <td colspan="4">
                    <select id="courseType" style="width: 250px; height: 29px;" data-options="required:true" onchange="changeChapter()">
                    	<option value="2">阶段自评</option>
                    	<option value="0">知识点自评</option>
                    </select>
                </td>
            </tr>
            <tr>
                <td>选择教员</td>
                <td colspan="4">
                    <select id="teachernoStuPlan" name="teacherno" style="width:150px; height:30px;"></select>
                    <a class="easyui-linkbutton" href="javascript:void(0)" id="clear" style="width:50px;" onclick="clearFun();">清空</a>
                </td>               
             </tr>
             <tr>
                <!--  <input name="" type="hidden" > -->
                <td>选择阶段/<br/>课程章节</td>
                <td colspan="4">
                    <select id="chapterId" name="chapterid" style="width: 250px; height: 29px;" ></select>
                    <a class="easyui-linkbutton" href="javascript:void(0)" onclick="$('#chapterId').combotree('clear');" >清空</a>
                </td>
            </tr>
             <tr>
                <td>开始时间</td>
                <td><input name="begintime" id="dd" type="text" placeholder="请输入开始时间"  data-options="required:true" ></td>
                <td>有效期(小时)</td>
                <td>
                	<input name="hourNum" value="24" type="text" placeholder="请输入小时数" class="easyui-numberspinner" data-options="required:true,min:1,max:144,editable:true" >
                </td>
            </tr>
            </table>
        </form>
    </div>
</div>