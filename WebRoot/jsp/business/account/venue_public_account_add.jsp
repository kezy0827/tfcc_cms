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
	<base href="<%=basePath%>"><!-- jsp文件头和头部 -->
	<%@ include file="../../system/admin/top.jsp"%> 
	<style type="text/css">
	</style>
	</head>
<body>
	<form action="account/goAdd.do" name="Form" id="Form" method="post">
		<input type="hidden" id="activity_id" name="activity_id" value="${pd.activity_id }">
		<div id="zhongxin">
			<table id="table_report" class="table table-striped table-bordered table-hover">
				<thead>
					<tr >
						<th class="center">
							<label><input type="checkbox" id="zcheckbox" /><span class="lbl"></span></label>
						</th>
						<th>编号</th>
						<th>公众号</th>
					</tr>
				</thead>
				<tbody>
				<!-- 开始循环 -->	
					<c:choose>
						<c:when test="${not empty varList}">
							<c:if test="${QX.cha == 1 }">
							<c:forEach items="${varList}" var="var" varStatus="vs">
								<tr>
									<td class='center' style="width: 30px;"><%-- ${var.id}-${var.nickname} --%>
										<label><input type='checkbox' name='account_id_${var.id}' value="${var.id}" /><span class="lbl"></span></label>
									</td>
									<td class='center' style="width: 30px;">${vs.index+1}</td>
									<td>${var.nickname}</td>
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
					<tr>
						<td style="text-align: center;" colspan="4">
							<a class="btn btn-mini btn-primary" onclick="save();">保存</a>
							<a class="btn btn-mini btn-danger" onclick="top.Dialog.close();">取消</a>
						</td>
			   		</tr>
				</tbody>
			</table>
		</div>
		<div id="zhongxin2" class="center" style="display:none"><br/><br/><br/><br/><br/><img src="images/jiazai.gif" /><br/><h4 class="lighter block green">提交中...</h4></div>
		
	</form>
	
	
		<!-- 引入 -->
		<script type="text/javascript">window.jQuery || document.write("<script src='js/jquery-1.9.1.min.js'>\x3C/script>");</script>
		<script src="js/bootstrap.min.js"></script>
		<script src="js/ace-elements.min.js"></script>
		<script src="js/ace.min.js"></script>
		<script type="text/javascript" src="js/chosen.jquery.min.js"></script><!-- 下拉框 -->
		<script type="text/javascript" src="js/bootstrap-datepicker.min.js"></script><!-- 日期框 -->
		<script type="text/javascript">
		$(window.parent.hangge());
		$(function() {
			//单选框
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
		//保存
		function save(){
			document.forms[0].action="activityvenue/save.do";
			document.forms[0].submit();
			/* $("#Form").submit(); */
			$("#zhongxin").hide();
			$("#zhongxin2").show();
		}
		</script>
</body>
</html>