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
	<style type="text/css">
	</style> 
	</head> 
<body>
<div class="container-fluid" id="main-container">
<div id="breadcrumbs">
<ul class="breadcrumb">
	<li><i class="icon-home"></i> <a>日志管理</a><span class="divider"><i class="icon-angle-right"></i></span></li>
	<li class="active">推送管理</li>
</ul><!--.breadcrumb-->

<div id="nav-search">
</div><!--#nav-search-->

</div><!--#breadcrumbs-->


<div id="page-content" class="clearfix">
						
  <div class="row-fluid">


	<div class="row-fluid">
			<!-- 检索  -->
			<form action="logpush/logPushListAll.do" method="post" name="logPushForm" id="logPushForm">
			
			
			
			<table>
				<tr>
					<td>
						<span class="input-icon">
							<input autocomplete="off" id="nav-search-input" type="text" name="lp_content" value="" placeholder="输入推送内容" />
							<i id="nav-search-icon" class="icon-search"></i>
						</span>
					</td>
		
					<td><input class="span10 date-picker" name="lp_create_start_datetime" id="lp_create_start_datetime" value="" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" style="width:88px;" placeholder="起始日期"/></td>
					<td><input class="span10 date-picker" name="lp_create_end_datetime" id="lp_create_end_datetime" value="" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" style="width:88px;" placeholder="结束日期"/></td> 
					<td style="vertical-align:top;width:200px;"> 
						设备类型:
					 	<select class="chzn-select" name="lp_device_type" id="lp_device_type" data-placeholder="请选择" style="vertical-align:top;width: 120px;">
					 		<option style="text-align:center;" value="">--全部--</option>
					 		<option style="text-align:center;" value="1">IOS</option>
					 		<option style="text-align:center;" value="2">Android</option>
					 		<option style="text-align:center;" value="3">其他</option>
					 		<option style="text-align:center;" value="4">Android和IOS</option>
					 		<option style="text-align:center;" value="5">..</option>
					  	</select>
					</td>
					<td style="vertical-align:top;width:200px;"> 
						内容类型:
					 	<select class="chzn-select" name="lp_type" id="lp_type" data-placeholder="请选择" style="vertical-align:top;width: 120px;">
					 		<option style="text-align:center;" value="">--全部--</option>
					 		<option style="text-align:center;" value="1">资讯</option>
					 		<option style="text-align:center;" value="2">优惠活动</option>
					 		<option style="text-align:center;" value="3">活动通知</option>
					 		<option style="text-align:center;" value="4">公众号推送</option>
					  	</select>
					</td>
					<td style="vertical-align:top;width:200px;"> 
						推送类型:
					 	<select class="chzn-select" name="lp_push_type" id="lp_push_type" data-placeholder="请选择" style="vertical-align:top;width: 120px;">
					 		<option style="text-align:center;" value="">--全部--</option>
					 		<option style="text-align:center;" value="1">标签</option>
					 		<option style="text-align:center;" value="2">别名</option>
					 		<option style="text-align:center;" value="3">reid</option>
					 		<option style="text-align:center;" value="4">所有</option>
					  	</select>
					</td>
					<td>
							<input autocomplete="off" id="nav-search-input" type="text" name="lp_push_type_obj" value="" placeholder="输入推送类型对象" />
					</td>
					</tr>
					<tr>
					<td>
							<input autocomplete="off" id="nav-search-input" type="text" name="lp_push_code" value="" placeholder="输入返回码" />
					</td>
					<td style="vertical-align:top;width:200px;" colspan="2"> 
						推送状态:
					 	<select class="chzn-select" name="lp_status" id="lp_status" data-placeholder="请选择" style="vertical-align:top;width: 120px;">
					 		<option style="text-align:center;" value="">--全部--</option>
					 		<option style="text-align:center;" value="1">成功</option>
					 		<option style="text-align:center;" value="-1">失败</option>
					  	</select>
					</td>
					<td style="vertical-align:top;width:200px;" colspan="1"> 
						是否重发:
					 	<select class="chzn-select" name="lp_is_resend" id="lp_is_resend" data-placeholder="请选择" style="vertical-align:top;width: 120px;">
					 		<option style="text-align:center;" value="">--全部--</option>
					 		<option style="text-align:center;" value="1">是</option>
					 		<option style="text-align:center;" value="-1">否</option>
					  	</select>
					</td>
					<!-- <td>是否置顶:<input style="display: block;" type="checkbox"></td> -->
					<td style="vertical-align:top;"><button class="btn btn-mini btn-light" onclick="search();"  title="检索"><i id="nav-search-icon" class="icon-search"></i></button></td>
				</tr> 
			</table>
			
			<!-- 检索  -->
			<table id="table_report" class="table table-striped table-bordered table-hover">
				<thead>
					<tr>
						<th>序号</th>
						<th>内容类型</th>
						<th>推送类型</th>
						<th>推送类型对象</th>
						<th>推送内容</th>
						<th>第三方返回码</th>
						<th>第三方返回内容</th>
						<th>推送状态</th>
						<th>失败是否需要重发</th>
						<th><i class="icon-time hidden-phone"></i>创建时间</th>
						<th>设备种类</th>			
					</tr>
				</thead>
				<tbody>
				<!-- 开始循环 -->	
				<c:choose>
					<c:when test="${not empty varList}">
						<c:if test="${QX.cha == 1 }">
						<c:forEach items="${varList}" var="var" varStatus="vs">
							<tr>
								<!-- <td class='center' style="width: 30px;">${vs.index+1}</td> -->	
								<td>${var.log_push_id}</td>
								
								<!--内容类型 1:资讯 2：优惠活动 3：活动通知  4：公众号推送 -->
								<td> 
								<c:if test="${var.lp_type == 1}">资讯	</c:if>
								<c:if test="${var.lp_type == 2}">优惠活动</c:if>
								<c:if test="${var.lp_type == 3}">活动通知</c:if>
								<c:if test="${var.lp_type == 4}">公众号推送	</c:if>
								</td>					
								<!--推送类型 1：标签 2：别名 3：reid 4:所有  -->
								<td>
								<c:if test="${var.lp_push_type == 1}">标签</c:if>
								<c:if test="${var.lp_push_type == 2}">别名</c:if>
								<c:if test="${var.lp_push_type == 3}">reid</c:if>
								<c:if test="${var.lp_push_type == 4}">所有</c:if>
								</td>
								<td>${var.lp_push_type_obj}</td>
								<td>${var.lp_content}</td>
								<td>${var.lp_push_code}</td>
								<td>${var.lp_push_msg}</td>
								
								<!-- 1:成功 -1：失败   -->
								<td>
								<c:if test="${var.lp_status == 1}">
										<font color="green">成功</font>
								</c:if>
								<c:if test="${var.lp_status == -1}">
										<font color="red">失败</font>
								</c:if>
								</td>
								
								<!-- 1:是 -1：否   -->
								<td>
								<c:if test="${var.lp_is_resend == 1}">是</c:if>
								<c:if test="${var.lp_is_resend == -1}">否</c:if>
								</td>
								
								<td>${var.lp_create_datetime}</td>
								
								<!-- 1:IOS 2：Android 3：其他 4：android和ios 5:.. -->
								<td>
								<c:if test="${var.lp_device_type == 1}">IOS</c:if>
								<c:if test="${var.lp_device_type == 2}">Android</c:if>
								<c:if test="${var.lp_device_type == 3}">其他</c:if>
								<c:if test="${var.lp_device_type == 4}">android和ios</c:if>
								<c:if test="${var.lp_device_type == 5}">..</c:if>
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
				<%-- <td style="vertical-align:top;">
					<c:if test="${QX.add == 1 }">
					<a class="btn btn-small btn-success" onclick="add();">新增</a>
					</c:if>
				</td> --%>
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
		<script type="text/javascript">window.jQuery || document.write("<script src='js/jquery-1.9.1.min.js'>\x3C/script>");</script>
		<script src="js/bootstrap.min.js"></script>
		<script src="js/ace-elements.min.js"></script>
		<script src="js/ace.min.js"></script>
		
		<script type="text/javascript" src="js/chosen.jquery.min.js"></script><!-- 下拉框 -->
		<script type="text/javascript" src="js/bootstrap-datepicker.min.js"></script><!-- 日期框 -->
		<script type="text/javascript" src="js/bootbox.min.js"></script><!-- 确认窗口 -->
		<!-- 引入 -->
		<script type="text/javascript" src="js/jquery.tips.js"></script><!--提示框-->
		<script type="text/javascript">
		
		$(window.parent.hangge());
		
		//检索
		function search(){
			$("#logPushForm").submit();
		}
		
		
		</script>
		
		<script type="text/javascript">
		
		$(function() {
			
			//下拉框
			$(".chzn-select").chosen(); 
			$(".chzn-select-deselect").chosen({allow_single_deselect:true}); 
			
			//日期框
			$('.date-picker').datepicker();
			
			//复选框
			$('table th input:checkbox').on('click' , function(){
				var that = this;
				$(this).closest('table').find('tr > td:first-child input:checkbox')
				.each(function(){
					this.checked = that.checked;
					$(this).closest('tr').toggleClass('selected');
				});
					
			});
			
		});
		
		
		</script>
		<script type="text/javascript" src="js/jquery.cookie.js"></script>
	</body>
</html>

