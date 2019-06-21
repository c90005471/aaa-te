<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/commons/global.jsp"%>
<!DOCTYPE html>
<html>
<head lang="en">
<meta charset="UTF-8">
<!--自适应界面,如果出现,在某些设备出现界面偏小的话,检查一下有没有加入这句 -->
<meta http-equiv="Content-type" name="viewport"
	content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no, width=device-width">
<title>AAA软件在线口碑报备系统</title>
<%@ include file="/commons/frontjs.jsp"%>
<link href="${staticPath }/static/front/css/style1.css" rel="stylesheet"
	type="text/css">
<link rel="stylesheet"
	href="${staticPath }/static/jQuery_mobile 1-4-5/jquery.mobile-1.4.5.min.css"
	type="text/css">
<script type="text/javascript"
	src="${staticPath }/static/jQuery_mobile 1-4-5/jquery-1.8.3.min.js"></script>
<script type="text/javascript"
	src="${staticPath }/static/jQuery_mobile 1-4-5/jquery.mobile-1.4.5.min.js"></script>
<style type="text/css">
.msg {
	font-size:12px;
	color:red;
}
</style>
<script>
//验证口碑姓名非空
function checkStuname(){
	var stuname = $("#stuname").val();
	if(stuname!=null&&stuname!=""){
		$("#stunamemsg").text("");
		return true;
	}else{
		$("#stunamemsg").text("请输入口碑姓名");
		return false;
	}
}
//验证口碑手机号
function checkStuphone(){
	var phonereg = /(^1[3|4|5|7|8]\d{9}$)|(^09\d{8}$)/;
	var stuphone = $("#stuphone").val();
	if(stuphone!=null&&stuphone!=""){
		if(phonereg.test(stuphone)){
			$("#stuphonemsg").text("");
			return true;
		}else{
			$("#stuphonemsg").text("请输入正确的口碑手机号");
			return false;
		}
	}else{
		$("#stuphonemsg").text("请输入手机号");
		return false;
	}
}

//验证报备人姓名非空
function checkTeaname(){
	var teaname = $("#teaname").val();
	if(teaname!=null&&teaname!=""){
		$("#teanamemsg").text("");
		return true;
	}else{
		$("#teanamemsg").text("请输入报备人姓名");
		return false;
	}
}
//验证口碑手机号
function checkTeaphone(){
	var phonereg = /(^1[3|4|5|7|8]\d{9}$)|(^09\d{8}$)/;
	var teaphone = $("#teaphone").val();
	if(teaphone!=null&&teaphone!=""){
		if(phonereg.test(teaphone)){
			$("#teaphonemsg").text("");
			return true;
		}else{
			$("#teaphonemsg").text("请输入正确的手机号");
			return false;
		}
	}else{
		$("#teaphonemsg").text("请输入手机号");
		return false;
	}
}
	$(function() {
		//提交试卷
		$("#submitQuestions").click(function() {
					if (checkStuname()&&checkStuphone()&&checkTeaname()&&checkTeaphone()) {
						//提交所有的答案
						$.ajax({
							url : "${path}/front/saveWordOfMouth",
							type : "post",
							dataType : 'json',
							data : $("#wordOfMouthForm").serialize(),
							success : function(data) {
								if (data.ret) {
									location.href = "${path}/front/submitThanks";
								} else if(data.msg) {
									alert("该口碑信息已录入,请重新输入！");
								}else{
									alert("数据异常，请联系管理员！");
								}
							},
							error : function(xhr, msg) {
								alert(msg);
							}
						});
					} else {
						alert("请检查输入");
					}

				});

	});
</script>
</head>
<body>
	<div>
		<div data-role="page">
			<div data-role="content" id="main2Content">
				<div
					style="width: 100%;height:60px;font-size:15px;color: #000;line-height: 20px;padding-left: 20px;text-align: left;">
					<div
						style="color:#FFF;background:red;width: 22px;height: 22px;border-radius:11px;line-height:22px;font-size:13px; text-align: center;"
						class="glyphicon glyphicon-map-marker"></div>
					欢迎使用AAA口碑报备系统
				</div>
				<div
					style="width: 100%;height:auto;font-size:15px;display: inline-block;border: 1px solid #CCC;border-bottom:1px dashed #CCC;background:#FFF;text-align: left;">
					<div style="width: 100%;height: 90%;padding:20px 20px 0px 20px;"" >
						<form id="wordOfMouthForm">
							<span class="msg">*</span>口碑姓名:<span class="msg" id="stunamemsg" ></span><input id="stuname" name="stuname" onblur="checkStuname()"/>
							<span class="msg">*</span>口碑手机号:<span class="msg" id="stuphonemsg"></span><input id="stuphone" name="stuphone" onblur="checkStuphone()"/>
							口碑状态:<select name="status" style="font-size:8px;">
		                        <c:forEach items="${wordstatusmap}" var="map">
		                        	<option value="${map.key}">${map.value}</option>
		                        </c:forEach>
		                    </select>
							<span class="msg">*</span>报备人姓名:<span class="msg" id="teanamemsg"></span><input id="teaname" name="teaname" onblur="checkTeaname()"/>
							<span class="msg">*</span>报备人手机号:<span class="msg" id="teaphonemsg"></span><input id="teaphone" name="teaphone" onblur="checkTeaphone()"/>
							备注信息:<textarea rows="4" cols="1" name="remark"></textarea>
						</form>
					</div>
					<!--考题的操作区域-->
					<div data-role="controlgroup" data-type="horizontal" style="padding-left:30px;text-align: center;">
						<a href="#" data-role="button" id="submitQuestions">提交</a> 
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
