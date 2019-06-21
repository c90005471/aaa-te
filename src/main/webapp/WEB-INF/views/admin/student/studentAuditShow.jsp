<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/global.jsp" %>
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
            <tr>
            	<td>审核结果</td>
            	<td colspan="3">
            		${studentCompany.checkstat}
            	</td>
            </tr>
            <tr>
            	<td>备注</td>
                <td colspan="3">
                	${studentCompany.auditremark}
                </td>
            </tr>
            </table>
        </form>
    </div>
</div>