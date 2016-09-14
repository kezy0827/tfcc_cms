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
	</head>
<body>
		
<div class="container-fluid" id="main-container">

	<div id="breadcrumbs">
	
	<ul class="breadcrumb">
		<li><i class="icon-home"></i> <a>资讯管理</a><span class="divider"><i class="icon-angle-right"></i></span></li>
		<li class="active"><a>文章分类</a></li>
	</ul><!--.breadcrumb-->
	
	<div id="nav-search">
	</div><!--#nav-search-->
	
	</div><!--#breadcrumbs-->

<div id="page-content" class="clearfix">
						
  <div class="row-fluid">

	<div class="row-fluid">
	
			<!-- 检索  -->
			<form action="channel/list.do" method="post" name="Form" id="Form">
			<table>
				<tr>
					<td>
						<span class="input-icon">
							<input autocomplete="off" id="nav-search-input" type="text" name="field1" value="" placeholder="这里输入关键词" />
							<i id="nav-search-icon" class="icon-search"></i>
						</span>
					</td>
					<%-- <td><input class="span10 date-picker" name="lastLoginStart" id="lastLoginStart" value="${pd.lastLoginStart}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" style="width:88px;" placeholder="开始日期"/></td>
					<td><input class="span10 date-picker" name="lastLoginEnd" id="lastLoginEnd" value="${pd.lastLoginEnd}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" style="width:88px;" placeholder="结束日期"/></td> --%>
					<td style="vertical-align:top;"><button class="btn btn-mini btn-light" onclick="search();"  title="检索"><i id="nav-search-icon" class="icon-search"></i></button></td>
					<%-- <c:if test="${QX.cha == 1 }">
					<td style="vertical-align:top;"><a class="btn btn-mini btn-light" onclick="toExcel();" title="导出到EXCEL"><i id="nav-search-icon" class="icon-download-alt"></i></a></td>
					</c:if> --%>
				</tr>
			</table>
			<!-- 检索  -->
		
		
			<table id="table_report" class="table table-striped table-bordered table-hover">
				
				<thead>
					<tr>
						<!-- <th class="center">
						<label><input type="checkbox" id="zcheckbox" /><span class="lbl"></span></label>
						</th> -->
						<th ></th>
						<th style="width:10%;">文章分类名称</th>
						<th style="width:5%;">权重</th>
						<th style="width:20%;">描述</th>
						<th style="width:7%;">显示</th>
						<th style="width:7%;">文章数</th>
						<th style="width:7%;">链接</th>
						<th style="width:20%;">链接地址</th>
						<th style="width:12%;">创建时间</th>
						<th class="center">操作</th>
					</tr>
				</thead>
										
				<tbody>
					
				<!-- 开始循环 -->	
				<c:choose>
					<c:when test="${not empty varList}">
						<c:if test="${QX.cha == 1 }">
						<c:forEach items="${varList}" var="var" varStatus="vs">
							<tr id="${var.channel_id}">
								<%-- <td class='center' style="width: 30px;">
									<label><input type='checkbox' name='ids' value="${var.channel_id}" /><span class="lbl"></span></label>
								</td> --%>
								<td  class='center' style="width: 30px;"><img id="sign" name="sign" src="/DADCMS/images/add.png" style="width: 20px;height:20px;" onclick="list(${var.channel_id},${vs.index+1},'${var.c_name}')"></td>
										<td>${var.c_name}</td>
										<td>${var.c_weight}</td>
										<td>${var.c_describe}</td>
										<c:if test="${var.c_isweb==1&&var.c_isapp==1}">
											<td>Web、App</td>
										</c:if>
										<c:if test="${var.c_isweb==1&&var.c_isapp!=1}">
											<td>Web</td>
										</c:if>
										<c:if test="${var.c_isweb!=1&&var.c_isapp==1}">
											<td>App</td>
										</c:if>
										<td>${var.newsnum}</td>
										<c:if test="${var.c_isurl==1}">
											<td>是</td>
										</c:if>
										<c:if test="${var.c_isurl!=1}">
											<td>否</td>
										</c:if>
										<td>${var.c_url}</td>
										<td name="c_create_datetime">${fn:substring(var.c_create_datetime, 0, 19)} </td>
										
								<td style="width: 30px;" class="center">
									<div class='hidden-phone visible-desktop btn-group'>
									
										<c:if test="${QX.edit != 1 && QX.del != 1 }">
										<span class="label label-large label-grey arrowed-in-right arrowed-in"><i class="icon-lock" title="无权限"></i></span>
										</c:if>
										<div class="inline position-relative">
										<button class="btn btn-mini btn-info" data-toggle="dropdown"><i class="icon-cog icon-only"></i></button>
										<ul class="dropdown-menu dropdown-icon-only dropdown-light pull-right dropdown-caret dropdown-close">
											<c:if test="${QX.edit == 1 }">
											<li><a style="cursor:pointer;" title="编辑" onclick="edit('${var.channel_id}');" class="tooltip-success" data-rel="tooltip" title="" data-placement="left"><span class="green"><i class="icon-edit"></i></span></a></li>
											</c:if>
											<c:if test="${QX.del == 1 }">
											<li><a style="cursor:pointer;" title="删除" onclick="del('${var.channel_id}');" class="tooltip-error" data-rel="tooltip" title="" data-placement="left"><span class="red"><i class="icon-trash"></i></span> </a></li>
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
					<input id="channel_add" name="channel_add" type="hidden">
					<a class="btn btn-small btn-success" onclick="add()">新增</a>
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
		function add(){
			window.parent.jzts();
			$("#channel_add").val("news");
			$("#Form").submit();
		}
		$("img[name='sign']").toggle(function(){
			$(this).attr("src","/DADCMS/images/sub.png");
		},function(){
			$(this).attr("src","/DADCMS/images/add.png");
		});
		function list(id,index,channe_name){
			//document.form[0].action="channel/list.do?c_parent_channel_id="+id;
			//document.getElementById("Form").action="channel/list.do?c_parent_channel_id="+id";
			//$("#Form").submit();
			//alert(eval(2==2));
			//alert($(".subChannel").html());
			if($(".subChannel_"+id).html()!=null){
				$(".subChannel_"+id).remove();
			}else{
				var url = '<%=basePath%>/channel/list.do?c_parent_channel_id='+id;
				$.post(url,function(data){
					var list = eval(data);
					//alert(list[0].c_isweb);
					var html = "";
					for(var i = 0 ;i<list.length;i++){
						var is_dispaly = '';
						if(list[i].c_isweb==1&&list[i].c_isapp==1){
							is_dispaly="Web、App";
						}else if(list[i].c_isweb==1&&list[i].c_isapp!=1){
							is_dispaly="Web";
						}else{
							is_dispaly="App";
						}
						var c_isurl = list[i].c_isurl;
						switch(c_isurl){
						case 1:c_isurl="是";break;
						case -1:c_isurl="否";
						}
						html +="<tr class=\"subChannel_"+id+"\" id=\"sub"+id+"\">"+
							"<td onclick=\"list("+list[i].channel_id+")\" class='center' style=\"width: 30px;\"></td>"+
									"<td style=\"text-align:center;\">"+list[i].c_name+"</td>"+
									"<td>"+list[i].c_weight+"</td>"+
									"<td>"+list[i].c_describe+"</td>"+
									"<td>"+is_dispaly+"</td>"+
									"<td>"+list[i].newsnum+"</td>"+
									"<td>"+c_isurl+"</td>"+
									"<td>"+list[i].c_url+"</td>"+
									"<td name=\"c_create_datetime\">"+list[i].c_create_datetime+"</td>"+
									"<td style=\"width: 30px;\" >"+
										"<div class=\"inline position-relative\">"+
										"<button class=\"btn btn-mini btn-info\" data-toggle=\"dropdown\"><i class=\"icon-cog icon-only\"></i></button>"+
										"<ul class=\"dropdown-menu dropdown-icon-only dropdown-light pull-right dropdown-caret dropdown-close\">"+
											"<li><a style=\"cursor:pointer;\" title=\"编辑\" onclick=\"edit("+list[i].channel_id+");\" class=\"tooltip-success\" data-rel=\"tooltip\" title=\"\" data-placement=\"left\"><span class=\"green\"><i class=\"icon-edit\"></i></span></a></li>"+
											"<li><a style=\"cursor:pointer;\" title=\"删除\" onclick=\"del("+list[i].channel_id+");\" class=\"tooltip-error\" data-rel=\"tooltip\" title=\"\" data-placement=\"left\"><span class=\"red\"><i class=\"icon-trash\"></i></span> </a></li>"+
										"</ul>"+
										"</div>"+
									"</td>"+
									"</tr>";
					}
					$("#"+id).after(html);
				});
			}
		}
		//删除
		function del(Id){
			bootbox.confirm("确定要删除吗?", function(result) {
				if(result) {
					var url = "<%=basePath%>/channel/delete.do?channel_id="+Id+"&tm="+new Date().getTime();
					$.get(url,function(data){
						if(data=="success"){
							nextPage(${page.currentPage});
						}
					});
				}
			});
		}
		
		//修改
		function edit(Id){
			window.parent.jzts();
			window.location.href='<%=basePath%>/channel/goEdit.do?channel_id='+Id;
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
			
			//隐藏域
			$("#channel_add").val();//清空隐藏域
		});
		
		</script>
		<script type="text/javascript" src="js/jquery.cookie.js"></script>
		
	</body>
</html>

