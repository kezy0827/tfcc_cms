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
	<li><i class="icon-home"></i> <a>信息管理</a><span class="divider"><i class="icon-angle-right"></i></span></li>
	<li class="active">选手列表</li>
</ul><!--.breadcrumb-->

<div id="nav-search">
</div><!--#nav-search-->

</div><!--#breadcrumbs-->


<div id="page-content" class="clearfix">
						
  <div class="row-fluid">


	<div class="row-fluid">
			<!-- 检索  -->
			<form action="contestant/clistAll.do?activity_id=${activity_id}" method="post" name="userForm" id="userForm">
			<table border='0'>
				<tr>
					<td>
						<span class="input-icon">
							<input autocomplete="off" id="nav-search-input" type="text" name="ac_name"   placeholder="这里输入标题" />
							<i id="nav-search-icon" class="icon-search"></i>
						</span>
					</td>
					<td style="vertical-align:top;"><button class="btn btn-mini btn-light" onclick="search();"><i id="nav-search-icon" class="icon-search"></i></button></td>
				</tr>
			</table>
			<!-- 检索  -->
			<table id="table_report" class="table table-striped table-bordered table-hover">
				<thead>
					<tr>
						<th>序号</th>
						<th>权重</th>
						<th>参赛选手姓名</th>
						<th>选手图片</th>
						<th style="width:50%;">选手介绍</th>
						<th>获得票数</th>
						<th><i class="icon-time hidden-phone"></i>创建时间</th>
						<th class="center">操作</th>
					</tr>
				</thead>
										
				<tbody>
					
				<!-- 开始循环 -->	
				<c:choose>
					<c:when test="${not empty varList}">
						<c:if test="${QX.cha == 1 }">
						<c:forEach items="${varList}" var="var" varStatus="vs">
							<tr>
								<td class='center'>${vs.index+1 }</td>
								<td class='center' style="width: 30px;">${var.ac_weight}</td>
								<td class='center'>${var.ac_name }</td>
								<td style="width:80px;height:60px;"><img alt="" src="${var.activity_contestant_img_http}" style="width:80px;height:60px;"></td>
								<td>${var.ac_introduce}</td>
								<td class='center'><font size="4" color="green">${var.ac_poll}</font></td>
								<td>${fn:substring(var.ac_create_datetime,0,19)}</td>
								<td style="width: 60px;" class="center">
									<div class='hidden-phone visible-desktop btn-group'>
										<c:if test="${QX.edit != 1 && QX.del != 1 }">
										<span class="label label-large label-grey arrowed-in-right arrowed-in"><i class="icon-lock" title="无权限"></i></span>
										</c:if>
										<c:if test="${QX.edit == 1 }">
										<a class='btn btn-mini btn-info' title="编辑" onclick="edit('${var.activity_contestant_id}');"><i class='icon-edit'></i></a>
										</c:if>
										<c:if test="${QX.del == 1 }">
										 <a class='btn btn-mini btn-danger' title="删除" onclick="del('${var.activity_contestant_id}');"><i class='icon-trash'></i></a>
										</c:if>
									</div>
								</td>
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
				<c:if test="${QX.add == 1 }">
				<td style="vertical-align:top;"><a class="btn btn-small btn-success" onclick="add();">新增</a></td>
				</c:if>
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
		<input type="hidden" value="${activity_id}" id="activityid">
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
		
		//新增 contestant/clistAll.do?activity_id=${activity_id}
		function add(){
		 	window.parent.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="新增";
			 diag.URL = 'contestant/goAdd.do?activity_id='+$('#activityid').val();
			 diag.Width = 1200;
			 diag.Height = 950;
			 diag.CancelEvent = function(){ //关闭事件
				 window.location.href="<%=basePath%>contestant/clistAll.do?activity_id=${activity_id}";
				 /* if(diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none'){
					 if('${page.currentPage}' == '0'){
						 window.parent.jzts();
						 setTimeout("self.location.reload()",100);
					 }else{
						 nextPage(${page.currentPage});
					 }
				} */
				diag.close();
			 };
			 diag.show(); 
		}
		
		//修改
		function edit(id){
			window.parent.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="编辑";
			 diag.URL = 'contestant/goEdit.do?id='+id;
			 diag.Width = 1200;
			 diag.Height = 950;
			 diag.CancelEvent = function(){ //关闭事件
				 if(diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none'){
					 nextPage(${page.currentPage});
				}
				diag.close();
			 };
			 diag.show();
		}
		
		//删除
		function del(id){
			bootbox.confirm("确定要删除该记录?", function(result) {
				if(result) {
					var url = "contestant/delete.do?activity_contestant_id="+id;
					$.get(url,function(data){
						if(data=="success"){
							nextPage(${page.currentPage});
						}
					});
				}
			});
		}
		</script>
		
		<script type="text/javascript">
		
		$(function() {
			
			//单选框
			$(".chzn-select").chosen(); 
			$(".chzn-select-deselect").chosen({allow_single_deselect:true}); 
			
			//日期框
			$('.date-picker').datepicker();
			
		});
		
		
		</script>
		
	</body>
</html>

