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
	<li><i class="icon-home"></i> <a>活动管理</a><span class="divider"><i class="icon-angle-right"></i></span></li>
	<li class="active">短信管理</li>
</ul><!--.breadcrumb-->

<div id="nav-search">
</div><!--#nav-search-->

</div><!--#breadcrumbs-->


<div id="page-content" class="clearfix">
						
  <div class="row-fluid">


	<div class="row-fluid">
			<!-- 检索  -->
			<form action="sms/getsmslist.do"  method="post" name="smsForm" id="smsForm">
			<!-- 检索  -->
            <table>
              <tr>
                 <td>
                <span>发送状态:</span>
                <select>
                    <option value='0'>新建未发送</option>
                    <option value='1'>发送成功</option>
                    <option value='2'>发送失败</option>
                </select>
                </td>
                <td>
                  <span>短信类型:</span>
                  <select>
                    <option value='通知'>通知</option>
                    <option value='节日祝福'>节日祝福</option>
                    <option value='宣传推广'>宣传推广</option>
                    <option value='其他'>其他</option>
                  </select>
                </td>
                <td><span>短信标题：</span><input type="text" name="title"/></td>
                <td><input type="submit" value="查询"></td>
              </tr>
              
            </table>
      
			<table id="table_report" class="table table-striped table-bordered table-hover">
				<thead>
					<tr>
						<th>发送时间</th>
						<th>短信类型</th>
						<th>序号</th>
						<th>标题</th>
						<th>发送状态</th>
                        <th>操作员账号</th>
                        <th>姓名</th>
						<th><i class="icon-time hidden-phone"></i>创建时间</th>
						<th><i class="icon-time hidden-phone"></i>更新时间</th>
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
								<td class='center' style="width: 30px;">${vs.index+1}</td>
								<td>${fn:substring(var.activity_title ,0,10)} ...</td>
								<td>${fn:substring(var.venue_public_account_nickname ,0,10)} ...</td>
								<td>${fn:substring(var.ds_content ,0,10)} ...</td>
								
								<!-- 1:付款成功时候 2：活动前一天 3：活动结束 4：已经退款 5... -->
								<c:if test="${var.ds_type == 1}">
										<td>付款成功时候</td>
								</c:if>
								<c:if test="${var.ds_type == 2}">
										<td>活动前一天</td>
								</c:if>
								<c:if test="${var.ds_type == 3}">
										<td>活动结束</td>
								</c:if>
								<c:if test="${var.ds_type == 4}">
										<td>已经退款</td>
								</c:if>
								<td>${var.ds_create_datetime}</td>
								<td>${var.ds_update_datetime}</td>
								<td style="width: 60px;" class="center">
									<div class='hidden-phone visible-desktop btn-group'>
										<c:if test="${QX.edit != 1 && QX.del != 1 }">
										<span class="label label-large label-grey arrowed-in-right arrowed-in"><i class="icon-lock" title="无权限"></i></span>
										</c:if>
										<c:if test="${QX.edit == 1 }">
										<a class='btn btn-mini btn-info' title="编辑" onclick="edit('${var.dictionary_sms_id}');"><i class='icon-edit'></i></a>
										</c:if>
										<c:if test="${QX.del == 1 }">
										 <a class='btn btn-mini btn-danger' title="删除" onclick="del('${var.dictionary_sms_id}');"><i class='icon-trash'></i></a>
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
			 diag.Width = 800;
			 diag.Height = 650;
			 diag.CancelEvent = function(){ //关闭事件
				 if(diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none'){
					 if('${page.currentPage}' == '0'){
						 window.parent.jzts();
						 setTimeout("self.location.reload()",100);
					 }else{
						 nextPage(${page.currentPage});
					 }
				}
				diag.close();
			 };
			 diag.show();
		}
		
		//修改
		function edit(dictionary_sms_id){
			window.parent.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="编辑";
			 diag.URL = 'contestant/goEdit.do?dictionary_sms_id='+dictionary_sms_id;
			 diag.Width = 800;
			 diag.Height = 650;
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
					var url = "link/delete.do?id="+id+"&tm="+new Date().getTime();
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

