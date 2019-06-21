<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/commons/global.jsp"%>
<!DOCTYPE html>
<html>
<c:out value='${content}' escapeXml="false"/>
<head lang="en">
<meta charset="UTF-8">
<!--自适应界面,如果出现,在某些设备出现界面偏小的话,检查一下有没有加入这句 -->
<meta http-equiv="Content-type" name="viewport"
	content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no, width=device-width">
<title>AAA在线在线考试系统</title>
<%@ include file="/commons/frontjs.jsp"%>
<link href="${staticPath }/static/front/css/style1.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" href="${staticPath }/static/jQuery_mobile 1-4-5/jquery.mobile-1.4.5.min.css" type="text/css">
<script type="text/javascript" src="${staticPath}/static/jQuery_mobile 1-4-5/jquery-1.8.3.min.js"></script>
<script type="text/javascript" src="${staticPath}/static/jQuery_mobile 1-4-5/jquery.mobile-1.4.5.min.js"></script>
<style type="text/css">
html,body {
      margin: 0;
      padding: 0;
      width: 100%;
      height: 100%;
  }
.question_title1{
	margin: 0px;
}
.question_info1 {
	height: ;
	line-height: 25px;
	margin: 10px 0px 5px 0px;
	display:block !important;
	
	padding-left: 20px;
    border: 1px solid #CCC;
    cursor:pointer;
}
</style>
 
<script>
	var HH = 0;//时
	var mm = 0;//分
	var ss = 0;//秒
	var timeState = true;//时间状态 默认为true 开启时间
	//var questions= QuestionJosn;
	var questions = "";
	$.ajax({
				type : "POST",
				url : '${path}/front/findExamQuestion',
				data:{paperId:"${paperId}"},
				dataType : 'json',
				async : false,//关闭异步刷新，因为显示所有的题目是第一步
				success : function(data) {
					questions = data;//后台传过来的数据，赋值给全局变量questions
				}
			});
	
	//var itemList = [ "1", "1", "1", "1"];
	var activeQuestion = 0; //当前操作的考题编号
	var questioned = 0; //
	var checkQues = []; //已做答的题的集合
	/*实现计时器*/

	var time = setInterval(function() {
		if (timeState) {
			if (HH == 24)
				HH = 0;
			str = "";
			if (++ss == 60) {
				if (++mm == 60) {
					HH++;
					mm = 0;
				}
				ss = 0;
			}
			str += HH < 10 ? "0" + HH : HH;
			str += ":";
			str += mm < 10 ? "0" + mm : mm;
			str += ":";
			str += ss < 10 ? "0" + ss : ss;
			$(".time").text(str);
		} else {
			$(".time").text(str);
		}
	}, 1000);
	function escape4html(str){
		var sb = "";
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
		//alert(sb);
        return sb; 
	}
	//escape4html("<br>");
	//展示考卷信息
	function showQuestion(id) {
		$(".questioned").text(id + 1);
		questioned = (id + 1) / questions.length;
		if (activeQuestion != undefined) {
			$("#ques" + activeQuestion).removeClass("question_id").addClass(
					"active_question_id");
		}
		activeQuestion = id;
		$(".question").find(".question_info1").remove();
		var question = questions[id];
		//var hiddenStr = question.questionType==0?"":"<input type='hidden' name='id' value='"+question.questionId+"'/>";
		$(".question_title1").html(
				"<strong>第 " + (id + 1) + " 题   </strong>"
						+ escape4html(question.questionTitle));
		var items = question.questionItems.split("~");
		var item = "";
		var itemList = question.items;
		var questionType= question.questionType==0?"radio":"checkbox";
		for ( var i = 0; i < items.length; i++) {
			item = "<li class='question_info1' id='item"
					+ i
					+ "'><input type='"+questionType+"' name='item' value='"+itemList[i]+"'>&nbsp;"
					//+ itemList[i] + "." + items[i] + "</li>";
					+ escape4html(items[i]) + "</li>";
			$(".question").append(item);
			$("#item"+i).click(function(){
				//在swing中onclick不执行,所以使用jquery绑定点击事件
				clickTrim(this,question.questionId);
			});
		}
		$(".question").attr("id", "question" + id);
		$("#ques" + id).removeClass("active_question_id").addClass(
				"question_id");
		for ( var i = 0; i < checkQues.length; i++) {
			if (checkQues[i].id == id) {
				if(questionType=="radio"){
					$("#" + checkQues[i].item).find("input[name='item']").prop("checked",
					"checked");
					$("#" + checkQues[i].item).addClass("clickTrim");
				}else{
					//遍历多选框已选择的选项
					if(checkQues[i].item.length>0){
						var items = checkQues[i].item.split(",");
						for(var m=0;m<items.length;m++){
							$("#" + items[m]).find("input[name='item']").prop("checked","checked");
							$("#" + items[m]).addClass("clickTrim");
						}
					}
				}
				$("#ques" + activeQuestion).removeClass("question_id").addClass("clickQue");
			}
		}
		progress();
	}

	/*答题卡*/
	function answerCard() {
		$(".question_sum").text(questions.length);
		for ( var i = 0; i < questions.length; i++) {
			//var questionId = "<li id='ques"+i+"' onclick='saveQuestionState("+i+ ")' "+"class='questionId'>" + (i + 1) + "</li>";
			var questionId = "<li id='ques"+i+"' class='questionId'>" + (i + 1) + "</li>";
			$("#answerCard ul").append(questionId);
			//在swing中onclick不执行,所以使用jquery添加属性
			$("#ques"+i).attr("onclick","saveQuestionState("+i+")");
		}
	}

	/*选中考题*/
	var Question;
	function clickTrim(source,quesId) {
		var flag = false;//标记单选框  复选框
		var frflag = true;//标记   选择或取消
		var id = source.id;
		var type = $("#" + id).find("input[name='item']").prop("type");
		if(type=="radio"){//单选框
			flag = true;
			$("#" + id).find("input[name='item']").prop("checked", "checked");
			$("#" + id).addClass("clickTrim");
			$("#ques" + activeQuestion).removeClass("question_id").addClass("clickQue");
		}else{//多选框
			if($("#" + id).find("input[name='item']").prop("checked")==true){//取消选中
				$("#" + id).find("input[name='item']").prop("checked", false);
				$("#" + id).removeClass("clickTrim");
				frflag = false;
			}else{
				$("#" + id).find("input[name='item']").prop("checked", "checked");
				$("#" + id).addClass("clickTrim");
				$("#ques" + activeQuestion).removeClass("question_id").addClass("clickQue");
			}
		}
		var ques = 0;
		//从已答过的试题中
		for ( var i = 0; i < checkQues.length; i++) {
			//if (checkQues[i].id == activeQuestion && checkQues[i].item != id) {
			if (checkQues[i].id == activeQuestion) {
				ques = checkQues[i].id;
				if(flag){
					checkQues[i].item = id;//获取当前考题的选项ID
					checkQues[i].type = "0";//标记单选题
				}else{
					checkQues[i].item = addStr(checkQues[i].item,id,frflag);
					checkQues[i].type = "1";//标记多选题
					//checkQues[i].item += ","+id;//获取当前考题的选项ID
					if(checkQues[i].item==undefined||checkQues[i].item.length==0){
						$("#ques" + activeQuestion).removeClass("clickQue");
					}
				}
				checkQues[i].answer = $("#" + id).find("input[name='item']:checked").val();//获取当前考题的选项值
				checkQues[i].quesId = quesId;//存储考题的id
			}
		}
			
		//已答试题集合为空
		if (checkQues.length == 0 || Question != activeQuestion
				&& activeQuestion != ques) {
			var check = {};
			check.id = activeQuestion;//获取当前考题的编号
			if(flag){
				check.item = id;//获取当前考题的选项ID
				check.type = "0";//标记单选题
			}else{
				if(check.item==undefined){
					if(frflag==false){
						check.item = "";//获取当前考题的选项ID
					}else{
						check.item = id;//获取当前考题的选项ID
					}
				}else{
					check.item = addStr(check.item,id,frflag);
					if(frflag==false&&(check.item==undefined||check.item.length==0)){
						$("#ques" + activeQuestion).removeClass("clickQue");
					}
					//check.item += ","+id;//获取当前考题的选项ID
				}
				check.type = "1";//标记多选题
			}
			check.answer = $("#" + id).find("input[name='item']:checked").val();//获取当前考题的选项值
			check.quesId = quesId;//存储考题的id
			checkQues.push(check);
		}
		if(flag){
			$(".question_info1").each(function() {
				var otherId = $(this).attr("id");
				if (otherId != id) {
					$("#" + otherId).find("input[name='item']").prop("checked", false);
					$("#" + otherId).removeClass("clickTrim");
				}
			});
		}
		Question = activeQuestion;
	}
	<%--添加或删除元素--%>
	function addStr(strs,str,flag){
		if(flag){//添加
			if(strs.indexOf(str)<0){
				strs +=","+str;
			}
		}else{//删除
			if(strs.indexOf(","+str)>-1){
				strs = strs.replace(","+str,"");
			}else if(strs.indexOf(str)>-1){
				strs = strs.replace(str,"");
			}
		}
		return strs;
	}
	/*设置进度条*/
	function progress() {
		var prog = ($(".active_question_id").length + 1) / questions.length;
		var pro = $(".progress").parent().width() * prog;
		$(".progres").text((prog * 100).toString().substr(0, 5) + "%");
		$(".progress").animate({
			width : pro,
			opacity : 0.5
		}, 1000);
	}

	/*保存考题状态 已做答的状态*/
	function saveQuestionState(clickId) {
		showQuestion(clickId);
	}

	$(function() {
		$(".middle-top-left").width(
				$(".middle-top").width() - $(".middle-top-right").width());
		$(".progress-left").width($(".middle-top-left").width() - 150);
		progress();

		showQuestion(0);
		answerCard();
		/*alert(QuestionJosn.length);*/
		/*实现进度条信息加载的动画*/
		var str = '';
		/*开启或者停止时间*/
		$(".time-stop").click(function() {
			timeState = false;
			$(this).hide();
			$(".time-start").show();
		});
		$(".time-start").click(function() {
			timeState = true;
			$(this).hide();
			$(".time-stop").show();
		});

		/*收藏按钮的切换*/
		$("#unHeart").click(function() {
			$(this).hide();
			$("#heart").show();
		});
		$("#heart").click(function() {
			$(this).hide();
			$("#unHeart").show();
		});

		/*答题卡的切换*/
		$("#openCard").click(function() {
			$("#closeCard").show();
			$("#answerCard").slideDown();
			$(this).hide();
		});
		$("#closeCard").click(function() {
			$("#openCard").show();
			$("#answerCard").slideUp();
			$(this).hide();
		});

		//提交试卷
		$("#submitQuestions").click(
				function() {
					if ($(".clickQue").length == questions.length) {
						//提交所有的答案
						$.ajax({
							url : "${path}/front/saveExamRecord",
							type : "post",
							dataType : 'json',
							data : {
								id:$("#id").val(),
								//stuphone:$("#stuphone").val(),
								//quesType:$("#quesType").val(),
								checkQues : JSON.stringify(checkQues)
							},
							success : function(data) {
								if (data.ret) {
									//location.href = "${path}/front/thanks?flag=3";
									location.href = "${path}/front/examLogin";
								} else {
									alert("数据异常，请联系管理员！");
								}

							},
							error : function(xhr, msg) {
								alert(msg);
							}
						});
					} else {
						alert("已做答:" + ($(".clickQue").length) + "道题,还有"
								+ (questions.length - ($(".clickQue").length))
								+ "道题未完成");
					}

				});
		//进入上一题
		$("#beforeQuestion").click(
				function() {
					//alert(activeQuestion);
					if ((activeQuestion - 1) != questions.length
							&& (activeQuestion - 1) >= 0)
						showQuestion(activeQuestion - 1);
					showQuestion(activeQuestion);
				});
		//进入下一题
		$("#nextQuestion").click(function() {
			if ((activeQuestion + 1) != questions.length)
				showQuestion(activeQuestion + 1);
			showQuestion(activeQuestion);
			
		});
	});
	
	//禁用鼠标右键
	/*document.oncontextmenu = function(){
	    return false;
	}*/
</script>

</head>
<body>
	<div>
		<div data-role="page">
			<div class="middle-top" data-role="header" data-theme="b" data-position="fixed">
				<div class="middle-top-left pull-left" style="height: 100%;padding-left: 20px;;background:#232C31;color:#FFF;">
					<div class="text-center pull-left progress-left" style="border: 1px solid #A2C69A;background:#FFF;border-radius:10px;line-height:20px;height:20px;margin:15px 0px 15px 0px;font-size: 11px;position:relative;">
						<div class="progress pull-left" style="background: #609E53;width: 0px;height:18px;position:absolute;left: 0px;"></div>
						<div class="pro-text" style="left: 0px;color: #609E53;position:absolute;top:0px;width:100%;">
							已完成<span class="progres"></span>
						</div>
					</div>
					<div class="pull-left" style=" width:100px;line-height:20px;height:20px;margin:15px;font-size:12px;">
						<!--已做答的数量和考题总数-->
						当前<span class="questioned"></span>题/共<span class="question_sum"></span>题
					</div>
				</div>
				<div class="middle-top-right text-center pull-left" style="width:30%; height: 100%;border-left: 1px solid red;position: absolute;right: 0px;">
					<div class="stop pull-left" style="width: 30px; height: 100%;padding: 10px;">
						<a href="javascript:void(0);" class="text-center" style="color: #FE6547;">
							<div class="time-stop glyphicon" title="暂停"
								style="width:20px;height: 20px;line-height:20px; border-radius:10px;border: 1px solid #FE6547;"></div>
							<div class="time-start glyphicon" title="开始"
								style="width:20px;height: 20px;line-height:20px;border-radius:10px;border: 1px solid #FE6547;display:none;"></div>
						</a>
					</div>
					<div class="pull-left" style="width: 60px; height: 100%;padding: 10px 0px 10px 0px;margin-right:5px;">
						<div class="time" style="height: 20px;line-height:20px; border-radius:15px;font-size:15px;color:#FFF;">
						</div>
					</div>
				</div>
			</div>
			<div data-role="content" id="main2Content">
				<div
					style="width: 100%;height: 40px;font-size:15px;color: #000;line-height: 20px;padding-left: 20px;text-align: left;">
					<div
						style="color:#FFF;background: red;width: 22px;height: 22px;border-radius:11px;line-height:22px;font-size:13px; text-align: center;"
						class="glyphicon glyphicon-map-marker"></div>
					欢迎同学，请你对下面测试题做出选择！
					<input  type="hidden" id="id" name="id" value="${id}"/>
				</div>
				<div
					style="text-align: left;width: 100%;height:auto;font-size:15px;display: inline-block;border: 1px solid #CCC;border-bottom:1px dashed #CCC;background:#FFF;">
					<div style="width: 100%;height: 90%;padding:10px 20px 0px 20px;">
						<!--试题区域-->
						<ul class="question" id="" name="" style="line-height: 22px;">
							<li class="question_title1" height=""></li>
						</ul>
					</div>
					<!--考题的操作区域-->
					<div data-role="controlgroup" data-type="horizontal" style="margin-left:30px;text-align: center;">
					　       <a href="#" data-role="button"  id="beforeQuestion">上一题</a>
					　       <a href="#" data-role="button"  id="submitQuestions">提交</a>
					　       <a href="#" data-role="button"  id="nextQuestion">下一题</a>
					</div>
				</div>
				<div
					style="width: 100%;height:auto;display: inline-block;border: 1px solid #CCC;border-top:none;background:#FFF;">
					<div style="width: 100%;padding:20px;">
						<div class="panel-default">
							<div class="panel-heading" class="panel-heading" id="closeCard"
								style="color: #DCE4EC;font-size: 15px;display: none;background: none;">
								<span>收起答题卡</span> 
<%--								<span class="glyphicon glyphicon-chevron-up"></span>--%>
							</div>
							<div class="panel-heading" id="openCard"
								style="font-size: 15px;background: none;">
								<span>展开答题卡</span> 
<%--								<span class="glyphicon glyphicon-chevron-down"></span>--%>
							</div>
							<div id="answerCard" style="display: none;">
								<div class="panel-body form-horizontal" style="padding: 0px;">
									<ul class="list-unstyled"></ul>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
