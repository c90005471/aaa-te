<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/global.jsp" %>
<style>
    .tooltip{
        width: 200px;
    }
</style>
<script type="text/javascript">
    var examResultDataGrid;
    $(function() {
        examResultDataGrid = $('#examResultDataGrid').datagrid({
            url : '${path}/examRecord/showExamResultDataGrid?paperId=${paperId}',
            fit : true,
            striped : true,
            rownumbers : true,
            pagination : true,
            singleSelect : true,
            idField : 'id',
            sortName : 'id',
            sortOrder : 'asc',
            pageSize : 20,
            pageList : [ 10, 20, 30, 40, 50, 100],
            onLoadSuccess:function(){
                $(".easyui-tooltip").tooltip({
                    position: 'top',
                    onShow: function(){
                        $(this).tooltip('tip').css({
                            backgroundColor: '#666',
                            color: '#FFFFFF'
                        });
                        var t = $(this);
                        t.tooltip('tip').unbind().bind('mouseover', function () {
                            t.tooltip('show');
                        }).bind('mouseleave', function () {
                            t.tooltip('hide');
                        });
                    }
                })
            },
            columns : [ [ {
                width : '60',
                title : '编号',
                field : 'id',
                sortable : true
            },{
                width : '50',
                title : '题号',
                field : 'tid',
                sortable : true,
            },{
                width : '350',
                title : '题目',
                field : 'topicname',
                sortable : true,
                formatter: showTopic
            },{
                width : '80',
                title : 'A',
                field : 'a',
                formatter: showTopic
            },{
                width : '80',
                title : 'B',
                field : 'b',
                formatter: showTopic
            },{
                width : '80',
                title : 'C',
                field : 'c',
                formatter: showTopic
            },{
                width : '80',
                title : 'D',
                field : 'd',
                formatter: showTopic
            },{
                width : '80',
                title : '正确答案',
                field : 'rightAnswer'
            },{
                width : '80',
                title : '错误人数',
                field : 'number',
                sortable : true
            }] ]
        });
    });
    //显示优化
   function showTopic(value) {
       var nameString = "";
       if(value != null) {
           if(value.length > 20) {
               nameString = value.substring(0, 20) + '...';
           } else {
               nameString = value;
           }
           return '<div class="easyui-tooltip" title="'+value+'">'+nameString+'</div>';
       }else{
           return "";
       }
    }


</script>
<div id="addForm"></div>
<div class="easyui-layout" data-options="fit:true,border:false">
    <div data-options="region:'center',border:false" title="" style="overflow: hidden;padding: 3px;">
        <table id="examResultDataGrid" data-options="fit:true,border:false"></table>
    </div>
</div>