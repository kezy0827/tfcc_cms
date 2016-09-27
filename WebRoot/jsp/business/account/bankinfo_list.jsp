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
		<li><i class="icon-home"></i> <a>账户管理</a><span class="divider"><i class="icon-angle-right"></i></span></li>
		<li class="active"><a>账户列表</a></li>
	</ul><!--.breadcrumb-->
	
	<div id="nav-search">
	</div><!--#nav-search-->
	
	</div><!--#breadcrumbs-->

<div id="page-content" class="clearfix">
						
  <div class="row-fluid">

	<div class="row-fluid">
	
			<!-- 检索  -->
			<form action="bank/updatestatus.do" method="post" name="Form" id="Form">
			<table >
				<tr>
					<td>
						<span class="input-icon">
							<input autocomplete="off" id="nav-search-input" type="text" name="n_title"  placeholder="收款账户信息" />
							<i id="nav-search-icon" class="icon-search"></i>
						</span>
					</td>
					
				</tr>
			</table>
			<!-- 检索  -->
		
			<table id="table_report" class="table table-striped table-bordered table-hover">
				
				<thead>
					<tr>
						<th class="center">
						</th>
						<th>序号</th>
						<!-- <th>公司名称</th> -->
						<th>姓名</th>
						<th>支付宝账号</th>
						<th>财务对账电话</th>
                        <th>状态</th>
					</tr>
				</thead>
										
				<tbody>
					
				<!-- 开始循环 -->	
				<c:choose>
					<c:when test="${not empty varList}">
						
						<c:forEach items="${varList}" var="var" varStatus="vs">
							<tr>
								<td class='center' style="width: 30px;">
								 <c:if test="${var.status == 1 }">
								 <label><input type='radio' name='id'  value="${var.id}"  checked="checked"/><span class="lbl"></span></label>                                  
                                 </c:if>
                                  <c:if test="${var.status == 0 }">
								 <label><input type='radio' name='id'  value="${var.id}" /><span class="lbl"></span></label>                                  
                                 </c:if>
								</td>
								<td class='center' style="width: 30px;">${vs.index+1}</td>
										<td>${var.compay_name}</td>
										<%-- <td>${var.org_name}</td> --%>
										<td>${var.bankaccno}</td>
										<td>${var.checkphone}</td>
                                        <td>
                                        <c:if test="${var.status==0}">未启用</c:if>
                                        <c:if test="${var.status==1}">已启用</c:if>
                                        </td>
							</tr>
						
						</c:forEach>									
					</c:when>
					<c:otherwise>
						<tr class="main_info">
							<td colspan="100" class="center" >没有相关数据</td>
						</tr>
					</c:otherwise>
				</c:choose>
					
				
				</tbody>
			</table>

         <div style="text-align:center">
            
    		<a class="btn btn-small btn-success" id="save" onclick="save();">切换账号</a>
		    <!-- <a class="btn btn-small btn-success" id="save" onclick="save();">保存</a> -->
		</div>
	</form>
	</div>
	
     
   <form action="bank/addbankinfo.do" method="post" name="Form1" id="Form1">
   <div class="page-header position-relative" style="text-align:center">	
   
  			      <tr>
					<%-- <td><label class="text_right" >公司名称：</label></td>
                    <td>
                        <input type="text" name=compay_name id="compay_name" maxlength="50" value="${pd.compay_name}" />
                    </td> --%>
                    <td><label class="text_right">姓名：</label></td>
					<td><input type="text" name="org_name" id="org_name" value="${pd.org_name}"/>&nbsp;<span style="color:red">*</span></td>
				</tr>
   				<tr>
					<td><label class="text_right" >支付宝账号：</label></td>
                    <td>
                        <input type="text" name=bankaccno id="bankaccno" maxlength="50" value="${pd.bankaccno}" />&nbsp;<span style="color:red">*</span>
                    </td>
                    <td><label class="text_right">财务对账电话：</label></td>
					<td><input type="text" name="checkphone" id="checkphone" maxlength="50" value="${pd.checkphone}"/></td>
				</tr>
				</div>
         <div  style="text-align:center">
				<tr>
                    <!-- <input type="submit" id="submit" name="submitname" onclick="winclose()" value="保存"/> -->
  				   <a  class="btn btn-small btn-success" id="save1" onclick="save1();">保存</a>
              </tr>
       </div>
   </form>
 
 
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
		function save(){
			$("#Form").submit();
		}
		function save1(){
			var   name=$.trim(document.getElementById("org_name").value);
			var   bankaccno=$.trim(document.getElementById("bankaccno").value);
			var  reg = /[a-zA-Z\d+]{6,16}/;
			if(name==""){
				alert("姓名不能为空");
				return false;
			}
			if(bankaccno==""){
				alert("账号不能为空");
                return false;
			}else{
		        if(reg.test(bankaccno)){
		            
	            }else{
	                alert('请输入正确的支付宝账号:手机号/邮箱');
	                return false;
	            };
	        }
			$("#Form1").submit();
			alert("保存成功");
			$("#org_name").val("");
			$("#bankaccno").val("");
			<%-- //window.location.href='<%=basePath%>/bank/addbankifo.do'; --%>
		}
		
		
		
		
		function change(){
			
		    //var	 id=document.getElementById("first").value;
            $("#Form").submit();
            <%-- //window.location.href='<%=basePath%>/bank/addbankifo.do'; --%>
        }
		
		//新增
		function add(){
			window.parent.jzts();
			window.location.href='<%=basePath%>/news/goAdd.do';
		}
		
		
		//修改
		<%-- function edit(Id){
			 window.parent.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="编辑";
			 diag.URL = '<%=basePath%>/news/goEdit.do?NEWS_ID='+Id;
			 diag.Width = 450;
			 diag.Height = 355;
			 diag.CancelEvent = function(){ //关闭事件
				 if(diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none'){
					 nextPage(${page.currentPage});
				}
				diag.close();
			 };
			 diag.show();
		} --%>
		<%-- function edit(id){
			window.parent.jzts();
			window.location.href='<%=basePath%>/news/goEdit.do?news_id='+id;
		} --%>
		</script>
	<script type="text/javascript" src="js/jquery.cookie.js"></script>
		
	</body>
</html>

