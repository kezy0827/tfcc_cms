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
	<li class="active">转账日志管理</li>
</ul><!--.breadcrumb-->

<div id="nav-search">
</div><!--#nav-search-->

</div><!--#breadcrumbs-->


<div id="page-content" class="clearfix">
						
  <div class="row-fluid">


	<div class="row-fluid">
			<!-- 检索  -->
			<form action="interfaceLog/listPageLog.do" method="post" name="form" id="form">
			
			
			
			<table>
				<tr>
					<td>
						<span class="input-icon">
							<input autocomplete="off" id="nav-search-input" type="text" name="log_titile" value="" placeholder="输入日志标题" />
							<i id="nav-search-icon" class="icon-search"></i>
						</span>
					</td>
		
					<td><input class="span10 date-picker" name="startTime" id="startTime" value="" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" style="width:88px;" placeholder="起始日期"/></td>
					<td><input class="span10 date-picker" name="endTime" id="endTime" value="" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" style="width:88px;" placeholder="结束日期"/></td> 
					<td style="vertical-align:top;width:200px;"> 
						转账日志类型:
					 	<select class="chzn-select" name="log_type" id="log_type" data-placeholder="请选择" style="vertical-align:top;width: 120px;">
					 		<option style="text-align:center;" value="">--全部--</option>
					 		<option style="text-align:center;" value="1">转账申请</option>
					 		<option style="text-align:center;" value="2">转账回调</option>
					  	</select>
					</td>
					<td style="vertical-align:top;width:200px;"> 
						转账日志状态:
					 	<select class="chzn-select" name="log_status" id="log_status" data-placeholder="请选择" style="vertical-align:top;width: 120px;">
					 		<option style="text-align:center;" value="">--全部--</option>
					 		<option style="text-align:center;" value="1">成功</option>
					 		<option style="text-align:center;" value="0">失败</option>
					 		<option style="text-align:center;" value="2">转账中</option>
					  	</select>
					</td>
					<td style="vertical-align:top;width:200px;"> 
						系统来源:
					 	<select class="chzn-select" name="syscode" id="syscode" data-placeholder="请选择" style="vertical-align:top;width: 120px;">
					 		<option style="text-align:center;" value="">--全部--</option>
					 		<option style="text-align:center;" value="tfcc">tfcc</option>
					 		<option style="text-align:center;" value="商城">商城</option>
					  	</select>
					</td>
					<!-- <td>是否置顶:<input style="display: block;" type="checkbox"></td> -->
					<td style="vertical-align:top;">
                        <button class="btn btn-mini btn-light" onclick="search();"  title="检索"><i id="nav-search-icon" class="icon-search"></i></button>
                          <c:if test="${QX.cha == 1 }">
                            <a class="btn btn-mini btn-light" onclick="toExcel();" title="导出到EXCEL"><i id="nav-search-icon" class="icon-download-alt"></i></a>
                          </c:if>
                        <input class="btn btn-mini btn-light" type="button" onclick="clearValue()" value="重置"></input>
                    </td>
				</tr> 
			</table>
			
			<!-- 检索  -->
			<table id="table_report" class="table table-striped table-bordered table-hover">
				<thead>
					<tr>
						<th>序号</th>
						<th>系统来源</th>
						<th>日志标题</th>
						<th>日志内容</th>
						<th>转账类型</th>
						<th>转账状态</th>
                        <th>创建时间</th>
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
								<td class='center' style="width: 30px;">${var.syscode}</td>	
								<td class='center' style="width: 30px;">${var.log_titile}</td>	
								<td class='center' style="width: 100px;">${var.log_content}</td>	
<%-- 								<td>${var.log_push_id}</td> --%>
								
								<!--转账日志类型：1-转账申请2-转账回调 -->
								<td> 
								<c:if test="${var.log_type == 1}">转账申请</c:if>
								<c:if test="${var.log_type == 2}">转账回调</c:if>
								</td>					
								<!--转账日志状态 1： 2：别名 3：reid 4:所有  -->
								<td>
								<c:if test="${var.log_status == 1}">成功</c:if>
								<c:if test="${var.log_status == 0}">失败</c:if>
								<c:if test="${var.log_status == 2}">转账中</c:if>
								</td>
								<td>${var.create_time}</td>
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
			$("#form").submit();
		}
		function clearValue(){
            $("input").not("input[type='button']").val("");
            setChosenValue('log_type','');
            setChosenValue('log_status','');
            setChosenValue('syscode','');
        }
		function setChosenValue(selector,value){
            var selectObj = $("#"+selector);
            selectObj.parent().children().remove('div');
            selectObj.removeClass();
            $("#"+selector).val(value); 
            selectObj.addClass("chzn-select");  
            selectObj.chosen();
        }
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

