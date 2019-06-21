<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/commons/global.jsp"%>
<form  id="formAddArticle" method="post">
	<table width="98%" border="0" align="center" cellpadding="2"
		cellspacing="2" style="border:1px solid #cfcfcf;background:#ffffff;">
		<tr>
			<td height="24" colspan="5">
				<table width="800" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td width="90">&nbsp;文章标题：</td>
						<td width='408'><input name="title" type="text" value="${article.title }" />
							<input name=id type="hidden" value="${article.id}"  />
						</td>
						<td width="90">&nbsp;</td>
						<td></td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td height="24" colspan="5">
				<table width="800" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td width="90">&nbsp;作 者：</td>
						<td width="240"><input name="author" type="text"
							style="width:120px" value="${article.author }" /></td>
						<td width="90"></td>
						<td></td>
					</tr>
				</table></td>
		</tr>
		<tr>
			<td height="24" colspan="5">
				<table width="800" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td width="90">&nbsp;关键字：</td>
						<td width="448"><input type='text' name="keyword"
							id="keyword" style="width:80%" value="${article.keyword }" />
						</td>
						<td>自动获取，手动填写用","分开</td>
					</tr>
				</table>
			</td>
		</tr>

		<tr>

		</tr>
		<tr>
			<td height="28" colspan="2" bgcolor="#F9FCEF">
				<div style='float:left;line-height:28px;'>
					&nbsp;<strong>文章内容：</strong>
				</div></td>
		</tr>
		<tr>
			<td width="100%" height="24" colspan="2">
				<table width="800" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td width="90">&nbsp;附加选项：</td>
						<td><input name="autolitpic" type="checkbox" class="np"
							id="autolitpic" value="1" checked="1" /> 提取第一个图片为缩略图 <input
							type='checkbox' name='needwatermark' value='1' class='np' />
							图片是否加水印</td>
					</tr>
				</table>
			</td>
		</tr>

		<tr id="sss">
			<td width="100%">
				<!-- 富文本编辑器 --> <script type="text/plain" id="myEditorA"
					>
					 
				</script> </td>

		</tr>
	</table>

	<!-- //高级参数 -->
	<table width="98%" border="0" align="center" cellpadding="0"
		cellspacing="0" id="head1" style="margin-top:10px;">
		<tr>
			<td>
				<table border="0" cellpadding="0" cellspacing="0">
					<tr>
						<td width="84" height="24" align="center">&nbsp;<u>高级参数↓</u>
						</td>
					</tr>
				</table></td>
		</tr>
	</table>
	<table width="98%" border="0" align="center" cellpadding="2"
		cellspacing="2" id="adset"
		style="border:1px solid #cfcfcf;background:#ffffff;">
		<tr>
			<td height="24" colspan="4" class="bline">
				<table width="800" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td width="90">&nbsp;发布时间：</td>
						<td width="241"><input name="time" value="${article.time }" id="time"
							type="text" id="pubdate" style="width:120px"> 
							</td>
					</tr>
				</table>
			</td>
		</tr>

	</table>
	<table width="98%" border="0" cellspacing="0" cellpadding="0"
		align="center" bgcolor="#F9FCEF"
		style="border:1px solid #cfcfcf;border-top:none;">
		<tr height="35">
			<td width="17%">&nbsp;</td>
			<td width="83%"><input
				type="button"  id="btnadd" value="添加"/></td>
		</tr>
	</table>


<script type="text/javascript">
	UE.delEditor('myEditorA');
	var editor_aa = UE.getEditor('myEditorA', {
	initialFrameHeight : 500,
	initialFrameWidth : 800,
	});
	var time = new Date();
	// 程序计时的月从0开始取值后+1
	var m = time.getMonth() + 1;
	var t = time.getFullYear() + "-" + m + "-" + time.getDate() + " "
			+ time.getHours() + ":" + time.getMinutes() + ":"
			+ time.getSeconds();
	$("#time").val(t);
	$("#btnadd").click(function(){
		$.ajax({
              type: "POST",
              dataType: "html",
              url: "article/add",
              data: $('#formAddArticle').serialize(),
              success: function(result) {
             	result = $.parseJSON(result);
             	if(result.success){
             	    parent.$.messager.alert('提示', result.msg, '');
                   $('#index_tabs').tabs("close","添加文章");//关闭对应index的tabs  
             	}
              }
           });
	});
</script>
</form>
</body>