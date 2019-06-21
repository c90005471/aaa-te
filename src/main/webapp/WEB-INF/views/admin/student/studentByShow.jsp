<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/global.jsp" %>
<script type="text/javascript">
    
</script>
<div class="easyui-layout" data-options="fit:true,border:false">
    <div data-options="region:'center',border:false" title="" style="overflow: hidden;padding: 3px;">
        <form id="studentEditForm" method="post">
             <table class="grid">
             <tr>
                <td>学号</td>
                <td>${student.stuno}</td>
                <td>姓名</td>
                <td>
                ${student.stuname}
                </td>
            </tr>
             <tr>
                <td>身份证号</td>
                <td>${student.idno}</td>
                <td>手机号</td>
                <td>
                ${student.phone}
                </td>
            </tr>
            <tr>
                <td>教育程度</td>
                <td>${student.degree}</td>
 				<td>毕业院校</td>
                <td>${student.schoolname}</td>           	
           	</tr>
            <tr>               
                <td>专业</td>
                <td>
                ${student.major}
                </td>
                 <td>qq号码</td>
                <td>${student.qq}</td>
            </tr>
            <tr>
                <td>家庭联系</td>
                <td>${student.family_phone}</td>
             	<td>家庭住址</td>
                <td>${student.address}</td>
            </tr>
			<tr>
                <td>班级</td>
                <td>
                	${student.classname}
                </td>
                <td>是否上报考试申请</td>
                <td>
                	${studentCompany.isreporteaxm}
                </td>
            </tr>
             <tr>
                <td>是否参加考试</td>
                <td>
                	${studentCompany.iseaxm}
                </td>
                <td>考试情况</td>
                <td>${studentCompany.eaxmstat}
                </td>
            </tr>
            <tr>
 				<td>是否就业</td>
                <td>${studentCompany.isjob}
                </td>  
                <td>离校时间</td>
                <td>
                	<fmt:formatDate value='${studentCompany.leaschooltime}' pattern='yyyy-MM-dd'/>
                </td>         	
           	</tr>
            <tr>               
                 <td>就业城市</td>
                <td>${studentCompany.companyaddr}</td>
            	<td>城市级别</td>
                <td>${studentCompany.citylev}
                </td>
            </tr>
             <tr>
             	<td>就业企业</td>
                <td>${studentCompany.companyname}</td>
            	<td>岗位</td>
                <td>
                    ${studentCompany.station}
                </td>
            </tr>
            <tr>
                <td>试用期工资</td>
                <td>${studentCompany.prosalary}</td>
             	<td>联系方式</td>
                <td >
                	${studentCompany.xphone}</td>
            </tr>
             <tr>
            	<td>转正工资</td>
                <td>${studentCompany.forsalary}</td>
                <td>就业老师</td>
                <td>
                	${studentCompany.name} 
                </td>
            </tr>
            <tr>
            	<td>补助</td>
                <td>
                	${studentCompany.needs}
                </td>
                <td>就业奖金</td>
                <td >
                	${studentCompany.bonus}
                </td>
            </tr>
            <c:if test="${studentCompany.checkstat!=null && studentCompany.checkstat!='' }">
            	<tr>
	            	<td>审核结果</td>
	            	<td colspan="3">
	            		${studentCompany.checkstat}
	            	</td>
            	</tr>
            </c:if>
            <tr>
            	<td>备注</td>
                <td colspan="3">
                	${studentCompany.remark}
                </td>
            </tr>
            <c:if test="${studentCompany.checkstat!=null && studentCompany.checkstat!=''}">
            	<tr>
	            	<td>审核备注</td>
	            	<td colspan="3">
	            		${studentCompany.auditremark}
	            	</td>
            	</tr>
            </c:if>
            </table>
        </form>
    </div>
</div>