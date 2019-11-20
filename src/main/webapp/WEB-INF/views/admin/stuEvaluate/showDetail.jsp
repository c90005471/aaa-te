<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/global.jsp" %>
<script type="text/javascript">
var stuPlanDetailDataGrid;
    $(function() {
        stuPlanDetailDataGrid = $('#stuPlanDetailDataGrid').datagrid({
        url : '${path}/stuEvaluate/detailPage?planid=${planid}&classid=${classid}',
        striped : true,
        rownumbers : true,
        pagination : true,
        singleSelect : true,
        idField : 'stuno',
        sortName : 'stuno',
        fitColumns:true,
        sortOrder : 'asc',
        pageSize : 20,
        pageList : [ 10, 20, 30, 40, 50, 100, 200, 300, 400, 500],
        columns : [ [ {
            title : '学号',
            width:20,
            field : 'stuno',
            sortable : true
        }, 
        {
            title : '姓名',
             width:20,
            field : 'stuname',
        }
        , 
        {
            title : '章节名称',
            width:80,
            field : 'course_name'
        } , 
        {
            title : '章节id',
             width:20,
            field : 'topicid',
            hidden:true
        },
        {
            title : '掌握程度',
             width:20,
            field : 'floor',
           formatter : function(value, row, index) {
                switch (row.score) {
                    case 1:
                        return '差';
                    case 2:
                        return '较差';
                    case 3:
                        return '一般';
                    case 4:
                        return '好';
                    case 5:
                        return '很好';
                }
            }
        }, {
            title : '分数',
            field : 'score',
            hidden:true
          
        }
        , 
        {
            field : 'action',
             width:30,
            title : '评价状态',
            formatter : function(value, row, index) {
            var str;
                if(row.score!=null){
                	str="已评价";
                }else
                {
                	str="未评价";
                }
                return str;
            }
        } ] ],
  /*       onLoadSuccess:function(data){
            $('.stuPlan-easyui-linkbutton-edit').linkbutton({text:'编辑'});
            $('.stuPlan-easyui-linkbutton-del').linkbutton({text:'删除'});
        }, */
        });
        
    });
</script>
<div class="easyui-layout" data-options="fit:true,border:false">
    <div data-options="region:'center',border:false" title="" style="overflow: hidden;padding: 3px;">
        <table id="stuPlanDetailDataGrid" data-options="fit:true,border:false"></table>
    </div>
</div>