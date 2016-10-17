<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html lang="en">
	<head>
	<base href="<%=basePath%>">

	<!-- jsp文件头和头部 -->
	<%@ include file="../../system/admin/top.jsp"%> 
	</head> 
<body>
<div class="container-fluid" id="main-container">
<div id="breadcrumbs">
<ul class="breadcrumb">
	<li><i class="icon-home"></i> <a>短信管理</a><span class="divider"><i class="icon-angle-right"></i></span></li>
	<li class="active">短信管理</li>
</ul><!--.breadcrumb-->

<div id="nav-search">
</div><!--#nav-search-->

</div><!--#breadcrumbs-->


<div id="page-content" class="clearfix">
						
  <div class="row-fluid">


	<div class="row-fluid">
			<!-- 检索  -->
			<form action="sms/listPageRecycle.do"  method="post" name="smsForm" id="smsForm">
			<!-- 检索  -->
            <table>
              <tr>
                <td>
                  <span>短信类型:</span>
                  <select class="chzn-select" data-placeholder="请选择" style="vertical-align:top;width: 120px;" name="sms_type" id="sms_type">
                    <option value=''>--请选择--</option>
                    <option value='1'>通知</option>
                    <option value='2'>节日祝福</option>
                    <option value='3'>宣传推广</option>
                    <option value='4'>其他</option>
                  </select>
                </td>
                <td><span>短信标题：</span><input type="text" name="title" maxlength="50" placeholder="请输入短信标题"/></td>
                <td><span>操作员账号：</span><input type="text" name="operator_accno" id="operator_accno" maxlength="20" placeholder="请输入操作员账号"/></td>
                <td><span>操作员姓名：</span><input type="text" name="operator_name" id="operator_name" maxlength="20" placeholder="请输入操作员姓名"/></td>
                <td><button class="btn btn-mini btn-light" onclick="search();"  title="检索"><i id="nav-search-icon" class="icon-search"></i></button></td>
              </tr>
              
            </table>
      
			<table id="table_report" class="table table-striped table-bordered table-hover">
				<thead>
					<tr>
                        <th>序号</th>
						<th>发送时间</th>
						<th>短信类型</th>
						<th>标题</th>
						<th>发送状态</th>
                        <th>操作员账号</th>
                        <th>姓名</th>
                        <th>操作</th>
					</tr>
				</thead>
				<tbody>
				<!-- 开始循环 -->	
				<c:choose>
					<c:when test="${not empty varList}">
						<c:if test="${QX.cha == 1 }">
						<c:forEach items="${varList}" var="var" varStatus="vs">
							<tr>
								<td class='center' style="width: 30px;">${vs.index+1}</td>
								<td><fmt:formatDate value="${var.send_time }" type="both"/></td>
								<td>
                                    <c:if test="${var.sms_type == 1}">通知</c:if>
                                    <c:if test="${var.sms_type == 2}">节日祝福</c:if>
                                    <c:if test="${var.sms_type == 3}">宣传推广</c:if>
                                    <c:if test="${var.sms_type == 4}">其他</c:if>
                                </td>
								<td><a href="<%=basePath%>/sms/toEditSmsSend.do?id=${var.id}">${var.title}</a></td>
								<td>
                                     <c:if test="${var.sms_status == 0}"><font color="red">发送失败</font></c:if>
                                     <c:if test="${var.sms_status == 1}"><font color="green">发送成功</font></c:if>
                                     <c:if test="${var.sms_status == 2}">..正在发送</c:if> 
                                </td>
								<td>${var.operator_accno}</td>
								<td>${var.operator_name}</td>
								<td><a href="<%=basePath%>/sms/toEditSmsSend.do?id=${var.id}">修改</a>&nbsp;|&nbsp;<a href="javascript:reSend(${var.id},this)">重新发送</a></td>
							</tr>
						</c:forEach>
						</c:if>
						<c:if test="${QX.cha == 0 }">
							<tr>
								<td colspan="100" class="center">您无权查看</td>
							</tr>
						</c:if>
					</c:when>
					<c:otherwise>
						<tr class="main_info">
							<td colspan="100" class="center" >没有相关数据</td>
						</tr>
					</c:otherwise>
				</c:choose>
				</tbody>
			</table>
		<div class="page-header position-relative">
		<table style="width:100%;">
			<tr>
				<%-- <c:if test="${QX.add == 1 }">
				<td style="vertical-align:top;"><a class="btn btn-small btn-success" onclick="add();">新增</a></td>
				</c:if> --%>
				<td style="vertical-align:top;"><div class="pagination" style="float: right;padding-top: 0px;margin-top: 0px;">${page.pageStr}</div></td>
			</tr>
		</table>
		</div>
		</form>
	</div>
	<!-- PAGE CONTENT ENDS HERE -->
  </div><!--/row-->
	
</div><!--/#page-content-->
</div><!--/.fluid-container#main-container-->
		<!-- 返回顶部  -->
		<a href="#" id="btn-scroll-up" class="btn btn-small btn-inverse">
			<i class="icon-double-angle-up icon-only"></i>
		</a>
		
		<!-- 引入 -->
		<script src="1.9.1/jquery.min.js"></script>
		<script type="text/javascript">window.jQuery || document.write("<script src='js/jquery-1.9.1.min.js'>\x3C/script>");</script>
		<script src="js/bootstrap.min.js"></script>
		<script src="js/ace-elements.min.js"></script>
		<script src="js/ace.min.js"></script>
		
		<script type="text/javascript" src="js/chosen.jquery.min.js"></script><!-- 单选框 -->
		<script type="text/javascript" src="js/bootstrap-datepicker.min.js"></script><!-- 日期框 -->
		<script type="text/javascript" src="js/bootbox.min.js"></script><!-- 确认窗口 -->
		<!-- 引入 -->
		
		<script type="text/javascript">
		
		$(window.parent.hangge());
		
		//检索
		function search(){
			$("#Form").submit();
		}
		</script>
		
		<script type="text/javascript">
		
		$(function() {
			
			//复选框
			$(".chzn-select").chosen(); 
			$(".chzn-select-deselect").chosen({allow_single_deselect:true}); 
			
			//日期框
			$('.date-picker').datepicker();
			
		});
		function reSend(id,obj){
			bootbox.confirm("是否确认重新发送？", function (result) {  
                if(result) {  
                	var href = $(obj).attr("href");
                	$(obj).removeAttr("href");
                	
                	var diag = new Dialog();
                    diag.Width = 300;
                    diag.Height = 150;
//                     diag.Title = "内容页为html代码的窗口";
                    diag.InnerHtml='<div style="text-align:center;color:red;font-size:14px;background:#fff;height:150px;"><img src="images/jiazai.gif" /><br/><h4 class="lighter block green">提交中...</h4></div>'
                    diag.show();
                    var url = "<%=basePath%>/sms/reSend.do";
                    $.post(url,{'id':id},function(data){
                    	diag.hide();
                    	if(data.success){
                    		window.location.reload();
                    	}else{
                    		bootbox.alert(data.message);
                    	}
                    	$(obj).attr("href",href);
                    });
                }
             });  
		}
		
		</script>
		
	</body>
</html>

