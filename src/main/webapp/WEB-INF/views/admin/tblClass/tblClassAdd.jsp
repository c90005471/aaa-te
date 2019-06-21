<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/commons/global.jsp"%>
<script type="text/javascript">
    var classAddTeacher;
    var xqid;//定义校区的id
    $(function() {
    	//定义节假日的一个集合
    	var holidayMap={};
    	
    	//$(".time").hide();
    	 //清空按钮
        
    	$('#classAddPid').combotree({
            url : '${path }/organization/tree',
            parentField : 'pid',
            lines : true,
            required:true,//必须输入
            panelHeight : 'auto',
            onClick : function(node) {
            	//alert(JSON.stringify(node));
            //判断选中的必须是专业，否则提示
        	var tree = $(this).tree;  
        	//选中的节点是否为叶子节点,如果不是叶子节点,清除所有右边的数据
        		var isLeaf = tree('isLeaf', node.target);  
        		if (!isLeaf) {
        		//alert("请选择专业！");
        		parent.$.messager.alert('错误', '请选择专业！', 'error');
        		$('#classAddPid').combotree('clear');
        		  return; 
        		}
        		//如果是杨金校区的   对应的开班时间能够自动计算
        		//if(node.pid==3){
        		 // $(".time").show();
        			xqid=node.id;
        		//}
            //选择专业的时候显示本专业的老师
            $('#classAddTeacher').combotree('clear').combotree('reload','${path}/user/tree?organizationId='+node.id);
            //将日历框中的内容清空
            $("#begin").datetimebox('setValue','');
            $("#dd2").datetimebox('setValue', '');
			//$("#dd2").val(newtime);
			$("#firstprojectbegin").datetimebox('setValue','');
			$("#firstprojectover").datetimebox('setValue','');
			$("#secondprojectbegin").datetimebox('setValue','');
			$("#secondprojectover").datetimebox('setValue','');
            }
        });
    
     classAddTeacher=$('#classAddTeacher').combotree({
            url: '${path }/user/tree',
            multiple: true,
            lines : true,
            panelHeight : 'auto'
            
        });
     	//验证班级名称不能为空
     	$("#classname").blur(function(){
     		$.ajaxSettings.async = false;
             $.post("tblClass/chekcClassName",{classname:$("#classname").val()},function(data){
             	if(!data){
             		parent.$.messager.alert('警告', "班级名称不能重复", 'error');
             		$("#classname").val("");
             	}
             },"JSON");
     	});
        $('#tblClassAddForm').form({
            url : '${path}/tblClass/add',
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
                    parent.$.modalDialog.openner_dataGrid.treegrid('reload');
                    parent.$.modalDialog.handler.dialog('close');
                } else {
                    var form = $('#tblClassAddForm');
                    parent.$.messager.alert('错误', eval(result.msg), 'error');
                }
            }
        });
        
        $('#begin').datetimebox({
        	   showSeconds:true,
        	   required:true,
        	   onSelect:function(date){
        	   var time=$('#begin').datetimebox('spinner').spinner('getValue');
        	$('#begin').datetimebox('setValue',date.getFullYear()+'-'+ (date.getMonth()+1) +'-'+date.getDate()+' '+ time);
        	
        	var olddate=date.getFullYear()+'-'+ (date.getMonth()+1) +'-'+date.getDate();
        	//先获取是哪个校区的。
        	//大学生校区  一共是22周课程   每周7天   根据开班的时间 往后推22*7天就是毕业的时间
        	//如果当天的时间是周六的话需要将时间  再往后推1天
        	//alert(date.getDay());
        	var newtime="";
        	var firstproject="";
        	var firstprojectover="";
        	var secondproject="";
        	var secondprojectover="";
        	//xqid==6   代表的是杨金校区的java专业
	          if (xqid == 6) {

							newtime = getworkday(olddate, 132) + " " + time;
							//alert(newtime);

							//第一次项目开始的时间是在第九周的第二天  也就是开班之后的第57天  因为开班的时间是周六  所以时间往后加1
							firstproject = getworkday(olddate, 56)
									+ " 08:30:00";
							//项目结束的时间是第十二周的第五天   也就是开班之后的第83天
							firstprojectover = getworkday(olddate, 77)
									+ " 17:15:00";
							//第二次的项目时间是 第16周的第6天   15*7+6=111
							secondproject = getworkday(olddate, 96)
									+ " 08:30:00";
							//第二次的项目时间是 第20周的第1天   19*6+1=115
							secondprojectover = getworkday(olddate, 115)
									+ " 17:15:00";
							//}
							$('#dd2').datetimebox('setValue', newtime);
							//$("#dd2").val(newtime);
							$("#firstprojectbegin").datetimebox('setValue',
									firstproject);
							$("#firstprojectover").datetimebox('setValue',
									firstprojectover);
							$("#secondprojectbegin").datetimebox('setValue',
									secondproject);
							$("#secondprojectover").datetimebox('setValue',
									secondprojectover);

						}
					}
				});

		function getMap() {
			var hd = [ "2018-01-01", "2018-02-15", "2018-02-16", "2018-02-17",
					"2018-02-18", "2018-02-19", "2018-02-20", "2018-02-21",
					"2018-04-05", "2018-04-06", "2018-04-07", "2018-04-29",
					"2018-04-30", "2018-05-01", "2018-06-16", "2018-06-17",
					"2018-06-18", "2018-09-22", "2018-09-23", "2018-09-24",
					"2018-10-01", "2018-10-02", "2018-10-03", "2018-10-04",
					"2018-10-05", "2018-10-06", "2018-10-07" ];
			for (var i = 0; i < hd.length; i++) {
				holidayMap[hd[i]] = '1';
			}
		}
		
		function formatTen(f) {
			if (parseInt(f, 10) < 10) {
				return '0' + f;
			}
			return f;
		}

		function formateDate(date) {
			var year = date.getFullYear();
			var month = date.getMonth() + 1;
			var day = date.getDate();
			return year + "-" + formatTen(month) + "-" + formatTen(day);
		}

		//获取节假日
		function getworkday(dat, itervalByDay) {
			getMap();
			//alert(holidayMap);
			var str = dat.split("-");
			var date = new Date();
			date.setUTCFullYear(str[0], str[1] - 1, str[2]);
			date.setUTCHours(0, 0, 0, 0);
			var millisceonds = date.getTime();
			for (var i = 1; i <= itervalByDay; i++) {
				millisceonds += 24 * 60 * 60 * 1000;//一天的毫秒数
				date.setTime(millisceonds);
				//判断当前的时间是不是周末
				if (date.getDay() == 0) {
					i--;
				} else {//过滤节假日
					var d = formateDate(date);
					if (holidayMap[d]) {
						i--;
					}
				}
			}

			var year = date.getFullYear();
			var month = date.getMonth() + 1;
			var day = date.getDate();
			var rq = year + "-" + formatTen(month) + "-" + formatTen(day);

			return rq;
		}

	});
</script>
<div class="easyui-layout" data-options="fit:true,border:false">
	<div data-options="region:'center',border:false"
		style="overflow: hidden;padding: 3px; height:180px;">
		<form id="tblClassAddForm" method="post">
			<table class="grid">
				<tr>
					<td>班级名称</td>
					<td><input id="classname" name="classname" type="text" placeholder="请输入班级名称"
						class="easyui-validatebox span2" data-options="required:true"></td>
					<td>状态</td>
					<td><select name="graduate" class="easyui-combobox"
						data-options="width:140,height:29,editable:false,panelHeight:'auto'">
							<option value="0">在校</option>
							<option value="1">毕业</option>
					</select></td>
				</tr>
				<tr>
					<td>所属专业</td>
					<td colspan="3"><select id="classAddPid" name="orgid"
						style="width: 200px; height: 29px;"></select> <a
						class="easyui-linkbutton" href="javascript:void(0)"
						onclick="clearcombotree2('classAddPid');">清空</a></td>

				</tr>
				<tr>

					<td>老师</td>
					<td colspan="3"><select id="classAddTeacher" name="teacher"
						style="width: 200px; height: 29px;"></select> <a
						class="easyui-linkbutton" href="javascript:void(0)"
						onclick="$('#classAddTeacher').combotree('clear');">清空</a></td>
				</tr>
				<tr class="time">

					<td>开班时间</td>
					<td><input id="begin" name="begin"
						style="height:30px;width:150px;" type="text" placeholder="请选择开班时间"
						class="easyui-datetimebox" data-options="required:true"></td>
					<td>结束时间</td>
					<td><input id="dd2" name="over"
						style="height:30px;width:150px;" type="text" placeholder="结束时间"
						class="easyui-datetimebox"></td>

				</tr>
				<tr class="time">

					<td>第一次项目开始时间</td>
					<td><input id="firstprojectbegin" name="firstbegin"
						style="height:30px;width:150px;" type="text" placeholder=""
						class="easyui-datetimebox"></td>
					<td>第一次项目结束时间</td>
					<td><input id="firstprojectover" name="firstover"
						style="height:30px;width:150px;" type="text" placeholder=""
						class="easyui-datetimebox"></td>

				</tr>
				<tr class="time">

					<td>第二次项目开始时间</td>
					<td><input id="secondprojectbegin" name="secondbegin"
						style="height:30px;width:150px;" type="text" placeholder=""
						class="easyui-datetimebox"></td>
					<td>第二次项目结束时间</td>
					<td><input id="secondprojectover" name="secondover"
						style="height:30px;width:150px;" type="text" placeholder=""
						class="easyui-datetimebox"></td>

				</tr>

			</table>
		</form>
	</div>
</div>
<script type="text/javascript">
function clearcombotree2(id){
	//alert(id);
	//$('#classAddTeacher').combotree('clear')
	$("#"+id).combotree("clear");
	 $("#begin").datetimebox('setValue','');
     $("#dd2").datetimebox('setValue', '');
		//$("#dd2").val(newtime);
		$("#firstprojectbegin").datetimebox('setValue','');
		$("#firstprojectover").datetimebox('setValue','');
		$("#secondprojectbegin").datetimebox('setValue','');
		$("#secondprojectover").datetimebox('setValue','');
	//$(".time").hide();
}

</script>