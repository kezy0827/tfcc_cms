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
		
<div class="container-fluid" id="main-container">	

	<div id="breadcrumbs">
	
	<ul class="breadcrumb">
		<li><i class="icon-home"></i> <a>活动管理</a><span class="divider"><i class="icon-angle-right"></i></span></li>
		<li class="active"><a>线下活动</a></li>
	</ul><!--.breadcrumb-->
	
	<div id="nav-search">
	</div><!--#nav-search-->
	
	</div><!--#breadcrumbs-->

<div id="page-content" class="clearfix">
						
  <div class="row-fluid">

	<div class="row-fluid">
	
			<!-- 检索  -->
			<form action="activity/offlinelist.do" method="post" name="Form" id="Form">
			<table >
				<tr>
					<td>
						<span class="input-icon">
							<input autocomplete="off" id="nav-search-input" type="text" name="a_title" value="" placeholder="这里输入标题" />
							<i id="nav-search-icon" class="icon-search"></i>
						</span>
					</td>
					<td><input class="span10 date-picker" name="a_activity_start_datetime" id="lastLoginStart" value="" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" style="width:100px;" placeholder="活动开始日期"/></td>
					<td><input class="span10 date-picker" name="a_activity_end_datetime" id="lastLoginEnd" value="" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" style="width:100px;" placeholder="活动结束日期"/></td>
					<td style="vertical-align:top;width:200px;"> 
						活动状态:
					 	<select class="chzn-select" name="a_status" id="a_status" data-placeholder="请选择" style="vertical-align:top;width: 120px;">
					 		<option style="text-align:center;" value="">--全部活动--</option>
					 		<option style="text-align:center;" value="1">报名未开始</option>
					 		<option style="text-align:center;" value="2">报名进行中</option>
					 		<option style="text-align:center;" value="3">报名已结束</option>
					 		<option style="text-align:center;" value="4">活动结束</option>
					  	</select>
					</td> 
					<!-- <td>是否置顶:<input style="display: block;" type="checkbox"></td> -->
					<td style="vertical-align:top;"><button class="btn btn-mini btn-light" onclick="search();"  title="检索"><i id="nav-search-icon" class="icon-search"></i></button></td>
					<%-- <c:if test="${QX.cha == 1 }">
					<td style="vertical-align:top;"><a class="btn btn-mini btn-light" onclick="toExcel();" title="导出到EXCEL"><i id="nav-search-icon" class="icon-download-alt"></i></a></td>
					</c:if> --%>
				</tr>
			</table>
			<!-- 检索  -->
			<table id="table_report" class="table table-striped table-bordered table-hover">
				<thead>
					<tr >
						<!-- <th class="center">
						<label><input type="checkbox" id="zcheckbox" /><span class="lbl"></span></label>
						</th> -->
						<th>编号</th>
						<th>活动主题</th>
						<th>活动场馆</th>
						<th>报名发起时间</th>
						<th>报名结束时间</th>
						<th>主办方</th>
						<th>费用</th>
						<th>电话号码</th>
						<th>活动开始时间</th>
						<th>活动结束时间</th>
						<th>活动地点</th>
						<th>报名人数</th>
						<th>活动状态</th>
						<th>发布人</th>
						<th>创建时间</th>
						<th>更新时间</th>
						<th>轮播</th>
						<th>短信提醒</th>
						<th>场馆或用户</th>
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
								<%-- <td class='center' style="width: 30px;">
									<label><input type='checkbox' name='ids' value="${var.activity_id}" /><span class="lbl"></span></label>
								</td> --%>
								<td class='center' style="width: 30px;">${vs.index+1}</td>
								<td>${var.a_title}</td>
								<td>${var.a_activity_venue_name}</td>
								<td>${fn:substring(var.a_apply_start_datetime,0,10)}</td>
								<td>${fn:substring(var.a_apply_end_datetime,0,10)}</td>
								<td>${var.a_sponsor_venue_name}</td>
								<td>${var.a_entry_fee}</td>
								<td>${var.a_phone}</td>
								<td>${fn:substring(var.a_activity_start_datetime,0,10)}</td>
								<td>${fn:substring(var.a_activity_end_datetime,0,10)}</td>
								<td>${var.a_address}</td>
								<td>${var.a_apply_number}</td>
								<td>
									<c:if test="${pd.systemTime<var.a_apply_start_datetime}">报名未开始</c:if>
									<c:if test="${pd.systemTime>=var.a_apply_start_datetime&&pd.systemTime<var.a_apply_end_datetime}">报名进行中</c:if>
									<c:if test="${pd.systemTime>=var.a_apply_end_datetime&&pd.systemTime<var.a_activity_end_datetime}">报名已结束</c:if>
									<c:if test="${pd.systemTime>=var.a_activity_end_datetime}">活动已结束</c:if>
								</td>
								<td>${var.a_operating_user}</td>
								<td>${fn:substring(var.a_create_datetime,0,10)}</td>
								<td>${fn:substring(var.a_update_datetime,0,10)}</td>
								<c:if test="${var.a_carousel == -1}">
									<td>否</td>
								</c:if>
								<c:if test="${var.a_carousel == 1}">
									<td>是</td>
								</c:if>
								 <td><a href="dictionarysms/dlistAll.do?activity_id=${var.activity_id}" >短信</a></td>
								<td>
									 <c:choose>
										 <c:when test="${var.a_apply_number > 0&&var.a_is_submit_alert_html==2}">   
											<a href="useractivityapply/list.do?activity_id=${var.activity_id}" >报名用户列表</a>
										 </c:when> 
									     <c:otherwise>   
											<a href="activityvenue/list.do?activity_id=${var.activity_id}" >多场馆列表</a>
									     </c:otherwise> 
									</c:choose> 
									<%-- <c:if test="${var.a_apply_number == 0}"><a href="activityvenue/list.do?activity_id=${var.activity_id}" >多场馆列表</a></c:if>
									<c:if test="${var.a_apply_number > 0}"><a href="useractivityapply/list.do?activity_id=${var.activity_id}" >报名用户列表</a></c:if> --%>
								</td>
								<td style="width: 30px;" class="center">
									<div class='hidden-phone visible-desktop btn-group'>
										<c:if test="${QX.edit != 1 && QX.del != 1 }">
										<span class="label label-large label-grey arrowed-in-right arrowed-in"><i class="icon-lock" title="无权限"></i></span>
										</c:if>
										<div class="inline position-relative">
										<button class="btn btn-mini btn-info" data-toggle="dropdown"><i class="icon-cog icon-only"></i></button>
										<ul class="dropdown-menu dropdown-icon-only dropdown-light pull-right dropdown-caret dropdown-close">
											<c:if test="${QX.edit == 1 }">
											<li><a style="cursor:pointer;" title="编辑" onclick="edit('${var.activity_id}');" class="tooltip-success" data-rel="tooltip" title="" data-placement="left"><span class="green"><i class="icon-edit"></i></span></a></li>
											</c:if>
											<c:if test="${QX.del == 1 }">
											<li><a style="cursor:pointer;" title="删除" onclick="del('${var.activity_id}');" class="tooltip-error" data-rel="tooltip" title="" data-placement="left"><span class="red"><i class="icon-trash"></i></span> </a></li>
											</c:if>
										</ul>
										</div>
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
				<td style="vertical-align:top;">
					<c:if test="${QX.add == 1 }">
					<a class="btn btn-small btn-success" onclick="add();">新增</a>
					</c:if>
					<%-- <c:if test="${QX.del == 1 }">
					<a class="btn btn-small btn-danger" onclick="makeAll('确定要删除选中的数据吗?');" title="批量删除" ><i class='icon-trash'></i></a>
					</c:if> --%>
				</td>
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
			window.parent.jzts();
			$("#Form").submit();
		}
		
		//新增
		<%-- function add(){
			 window.parent.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="新增";
			 diag.URL = '<%=basePath%>/news/goAdd.do';
			 diag.Width = 450;
			 diag.Height = 355;
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
		} --%>
		function add(){
			window.parent.jzts();
			window.location.href='<%=basePath%>/activity/Offline_goAdd.do';
		}
		
		//删除
		function del(Id){
			bootbox.confirm("确定要删除吗?", function(result) {
				if(result) {
					var url = "<%=basePath%>/activity/delete.do?activity_id="+Id+"&tm="+new Date().getTime();
					$.post(url,function(data){
						if(data=="success"){
							nextPage(${page.currentPage});
						}
					});
				}
			});
		}
		
	 
		function edit(id){
		    window.parent.jzts();
		    window.location.href='<%=basePath%>/activity/offline_goEdit.do?activity_id='+id;
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
		
		
		//批量操作
		function makeAll(msg){
			bootbox.confirm(msg, function(result) {
				if(result) {
					var str = '';
					for(var i=0;i < document.getElementsByName('ids').length;i++)
					{
						  if(document.getElementsByName('ids')[i].checked){
						  	if(str=='') str += document.getElementsByName('ids')[i].value;
						  	else str += ',' + document.getElementsByName('ids')[i].value;
						  }
					}
					if(str==''){
						bootbox.dialog("您没有选择任何内容!", 
							[
							  {
								   "label" : "关闭",
								   "class" : "btn-small btn-success",
								   "callback": function() {
									//Example.show("great success");
									}
								}
							 ]
						);
						
						$("#zcheckbox").tips({
							side:3,
				            msg:'点这里全选',
				            bg:'#AE81FF',
				            time:8
				        });
						
						return;
					}else{
						if(msg == '确定要删除选中的数据吗?'){
							$.ajax({
								type: "POST",
								url: '<%=basePath%>/news/deleteAll.do?tm='+new Date().getTime(),
						    	data: {DATA_IDS:str},
								dataType:'json',
								//beforeSend: validateData,
								cache: false,
								success: function(data){
									 $.each(data.list, function(i, list){
											nextPage(${page.currentPage});
									 });
								}
							});
						}
					}
				}
			});
		}
		
		/* function  venueList(){
			 window.parent.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="新增";
			 diag.URL = 'account/accountlist.do';
			 diag.Width = 400;
			 diag.Height = 600;
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
		} */
		//导出excel
		<%-- function toExcel(){
			window.location.href='<%=basePath%>/news/excel.do';
		} --%>
		</script>
		<script type="text/javascript" src="js/jquery.cookie.js"></script>
	</body>
</html>

