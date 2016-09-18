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
		.text_right{text-align: right;}
	</style>
	</head>
<body>
		
<div class="container-fluid" id="main-container">

	<div id="breadcrumbs">
	
	<ul class="breadcrumb">		
		<li><i class="icon-home"></i> <a>订单管理</a><span class="divider"><i class="icon-angle-right"></i></span></li>
		<li class="active"><a>订单列表</a><span class="divider"><i class="icon-angle-right"></i></span></li>
		<li class="active"><a>订单审核</a></span></li>
	</ul><!--.breadcrumb-->
	
	<div id="nav-search">
	</div><!--#nav-search-->
	
	</div><!--#breadcrumbs-->

<div id="page-content" class="clearfix">
						
  <div class="row-fluid">

	<div class="row-fluid">
	<form action="trade/edit.do" method="post" name="Form" id="Form" >
			<table id="table_report" class="table table-striped table-bordered table-hover">
				<tr>
					<td style="width:20%;"><label class="text_right"><font style="text-align: center;">系统来源：</font></label></td>
					<td style="width:30%;">${pd.source_system}</td>
					<td style="width:20%;"><label class="text_right"><font style="text-align: center;">订单号：</font></label></td>
					<td style="width:30%;">${pd.order_no}</td>
				</tr>
				<tr>
					<td style="width:20%;"><label class="text_right"><font style="text-align: center;">交易类型：</font></label></td>
					<td style="width:30%;"><c:if test="${pd.txtype == 1}">买入</c:if></td>
					<td style="width:20%;"><label class="text_right">交易币种：</label></td>
					<td style="width:30%;"><c:if test="${pd.cuy_type == 1}">tfcc</c:if></td>
				</tr>
				<tr>
					<td><label class="text_right">交易数量：</label></td>
					<td>${pd.txnum }</td>
					<td><label class="text_right">交易金额：</label></td>
					<td>${pd.txamnt }</td>
				</tr>
				<tr>
					<td><label class="text_right">交易时间：</label></td>
					<td>${fn:substring(pd.txdate,0,19)}</td>
					<td><label class="text_right">支付时间：</label></td>
					<td>${fn:substring(pd.pay_time,0,19)}</td>
				</tr>
				<tr>
					<td><label class="text_right">审核状态：</label></td>
                    <td>
                          <%-- <c:if test="${pd.status==0 }">待审核</c:if>
                          <c:if test="${pd.status==1 }">通过</c:if>
                          <c:if test="${pd.status==9 }">未通过</c:if> --%>
                          <select class="chzn-select" name="status" id="status" data-placeholder="请选择" style="vertical-align:top;width: 120px;" >
                            <option style="text-align: center;" value="0" <c:if test="${pd.status==0 }">selected="selected"</c:if>>待审核</option>
                            <option style="text-align: center;" value="1" <c:if test="${pd.status==1 }">selected="selected"</c:if>>通过</option>
                            <option style="text-align: center;" value="9" <c:if test="${pd.status==9 }">selected="selected"</c:if>>未通过</option>
                          </select>
                    </td>
                    <td><label class="text_right" >收款公司名称：</label></td>
                    <td>
                        <input type="text" name="revorgname" id="revorgname" maxlength="100" value="${pd.revorgname}"/>
                    </td>
				</tr>
				<tr>
					<td><label class="text_right">收款公司银行账户：</label></td>
					<td><input type="text" name="revbankaccno" id="revbankaccno" value="${pd.revbankaccno}"/></td>
					<td><label class="text_right">收款公司开户行：</label></td>
					<td><textarea rows="5" cols="80" style="width:80%;" maxlength="100" name="revbankdepname" id="revbankdepname">${pd.revbankdepname}</textarea></td>
				</tr>
				<tr>
					<td><label class="text_right"><b>审核意见：</b></label></td>
				    <td colspan="3">
                        <textarea rows="8"  name="reason" id="reason" style="width:427px;">${pd.reason }</textarea>
				    </td>
				</tr>
                <tr>
					<td style="vertical-align:top;" colspan="4"  align="center" >
						<c:if test="${pd.status == 0 }"><a class="btn btn-small btn-success" onclick="save();">保存</a></c:if> 
						<a class="btn btn-small btn-success" href="javascript:history.back()">返回</a>
					</td>
				</tr>
			</table>
            <!--隐藏域 -->
            <input type="hidden" name="id" id="id" value="${pd.id }">
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
		
		//新增
    	function save(){
  			if($("#status").val()==0){
  				$("#status").tips({
  					side:3,
  		            msg:'请修改订单状态',
  		            bg:'#AE81FF',
  		            time:3
  		        });
  				$("#status").focus();
  				return false;
  			}
    		window.parent.jzts();
    		$("#Form").submit();
    	}
    	$(function() {
    		//下拉框
    		$(".chzn-select").chosen(); 
    		$(".chzn-select-deselect").chosen({allow_single_deselect:true}); 
    		
    		//日期框
    		$('.date-picker').datepicker();
    	});
		</script>
		<script type="text/javascript" src="js/jquery.cookie.js"></script>
		
	</body>
</html>

