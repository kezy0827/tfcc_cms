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
		<li class="active"><a>订单列表</a></li>
	</ul><!--.breadcrumb-->
	
	<div id="nav-search">
	</div><!--#nav-search-->
	
	</div><!--#breadcrumbs-->

<div id="page-content" class="clearfix">
						
  <div class="row-fluid">

	<div class="row-fluid">
	
			<!-- 检索  -->
			<form action="trade/tradeListPage.do" method="post" name="Form" id="Form">
			<table >
				<tr>
					<!-- <td>
						<span class="input-icon">
							<input autocomplete="off" id="nav-search-input" type="text" name="n_title"  placeholder="这里输入标题" />
							<i id="nav-search-icon" class="icon-search"></i>
						</span>
					</td> -->
                    <td > 
                        <span>系统来源:</span>
                        <select class="chzn-select" name="source_system" id="source_system" data-placeholder="请选择" style="vertical-align:top;width: 120px;">
                            <option style="text-align: center;" value=""  <c:if test="${pd.source_system =='' }">selected='selected'</c:if> >--请选择--</option>
                            <option style="text-align: center;" value="tfcc" <c:if test="${pd.source_system =='tfcc' }">selected='selected'</c:if>>tfcc</option>
                            <option style="text-align: center;" value="商城" <c:if test="${pd.source_system =='商城' }">selected='selected'</c:if>>商城</option>
                        </select>
                    </td>
                    <td ><span>订单号:</span><input class="span20" name="order_no" id="order_no" value="${pd.order_no}" type="text" style="width:200px;" placeholder="订单号"/></td>
					<td ><span>交易开始时间:</span><input class="span10 date-picker" name="startTime" id="startTime" value="${pd.startTime}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" style="width:88px;" placeholder="开始日期"/></td>
					<td ><span>交易结束时间:</span><input class="span10 date-picker" name="endTime" id="endTime" value="${pd.endTime}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" style="width:88px;" placeholder="结束日期"/></td>
					<td > 
						<span>订单状态:</span>
					 	<select class="chzn-select" name="status" id="status" data-placeholder="请选择" style="vertical-align:top;width: 120px;">
					 		<option style="text-align: center;" value=""  <c:if test="${pd.status =='' }">selected='selected'</c:if>>--请选择--</option>
				 			<option style="text-align: center;" value="0" <c:if test="${pd.status =='0' }">selected='selected'</c:if>>未付款</option>
				 			<option style="text-align: center;" value="1" <c:if test="${pd.status =='1' }">selected='selected'</c:if>>已完成</option>
				 			<option style="text-align: center;" value="9" <c:if test="${pd.status =='9' }">selected='selected'</c:if>>已取消</option>
					  	</select>
					</td>
					<!-- <td>是否置顶:<input style="display: block;" type="checkbox"></td> -->
					<td ><button class="btn btn-mini btn-light" onclick="search();"  title="检索"><i id="nav-search-icon" class="icon-search"></i></button></td>
					<%-- <c:if test="${QX.cha == 1 }">
					<td ><a class="btn btn-mini btn-light" onclick="toExcel();" title="导出到EXCEL"><i id="nav-search-icon" class="icon-download-alt"></i></a></td>
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
						<th>序号</th>
						<th>系统来源</th>
						<th style="width:8%;">订单号</th>
						<th>会员姓名</th>
						<th>手机号</th>
						<th>交易数量</th>
						<th>交易金额</th>
                        <th style="width:12%;">购买时间</th>
                        <th style="width:12%;">支付时间</th>
                        <th style="width:12%;">支付账号</th>
						<th>订单状态</th>
<!-- 						<th>收款公司银行账户</th> -->
						<th>审核</th>
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
									<label><input type='checkbox' name='ids' value="${var.news_id}" /><span class="lbl"></span></label>
								</td> --%>
								<td class='center' style="width: 30px;">${vs.index+1}</td>
								<td>${var.source_system }</td>
								<td>${var.order_no }</td>
								<td>${var.real_name }</td>
								<td>${var.phone }</td>
								<td>${var.txnum}</td>
								<td>${var.txamnt}</td>
								<td>${fn:substring(var.txdate,0,19)}</td>
								<td>${fn:substring(var.pay_time,0,19)}</td>
                                <td>${var.payno}</td>
								<td>
									<c:if test="${var.status == 0}">未付款</c:if>
									<c:if test="${var.status == 1}">已完成</c:if>
									<c:if test="${var.status == 9}">已取消</c:if>
								</td>
								<td>
                                    <c:choose>
                                        <c:when test="${var.status == 0 }"><a href="javascript:updateStatus('${var.id }','1')">通过</a>&nbsp;|&nbsp;<a href="javascript:updateStatus('${var.id }','9')">不通过</a></c:when>
                                        <c:otherwise>已审核</c:otherwise>
                                    </c:choose>
                                </td>
								<td style="width: 30px;" class="center">
									<div class='hidden-phone visible-desktop btn-group'>
										<c:if test="${QX.edit != 1}">
										<span class="label label-large label-grey arrowed-in-right arrowed-in"><i class="icon-lock" title="无权限"></i></span>
										</c:if>
										<div class="inline position-relative">
										<button class="btn btn-mini btn-info" data-toggle="dropdown"><i class="icon-cog icon-only"></i></button>
										<ul class="dropdown-menu dropdown-icon-only dropdown-light pull-right dropdown-caret dropdown-close">
											<c:if test="${QX.edit == 1 }">
                                              <c:if test="${var.status == 0 }">
                                                  <li><a style="cursor:pointer;" title="编辑" onclick="toEdit('${var.id}');" class="tooltip-success" data-rel="tooltip" title="" data-placement="left"><span class="green"><i class="icon-edit"></i></span></a></li>
                                              </c:if>
											  <c:if test="${var.status != 0 }">
                                                  <li><a style="cursor:pointer;" title="查看" onclick="toEdit('${var.id}');" class="tooltip-success" data-rel="tooltip" title="" data-placement="left"><span class="green"><i class="icon-search"></i></span></a></li>
                                              </c:if>
											</c:if>
											<c:if test="${QX.del == 1 }">
											<li><a style="cursor:pointer;" title="删除" onclick="del('${var.id}');" class="tooltip-error" data-rel="tooltip" title="" data-placement="left"><span class="red"><i class="icon-trash"></i></span> </a></li>
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
        <script type="text/javascript" src="js/jquery.cookie.js"></script>
		<script type="text/javascript">
		
	
		$(window.parent.hangge());
		//检索
		function search(){
			window.parent.jzts();
			$("#Form").submit();
		}
		
		function updateStatus(id,status){
			$.post('<%=basePath%>/trade/updateStatus.do',{'id':id,'status':status},function(data){
                if(data.success){
                	window.location.reload();
                }else{
                	bootbox.alert(data.message);
                }
            });
		}
		function toEdit(id){
			window.parent.jzts();
			window.location.href='<%=basePath%>/trade/toEdit.do?id='+id;
		}
		function del(id){
			$.post('<%=basePath%>/trade/del.do',{'id':id},function(data){
				if(data.success){
					window.location.reload();
				}else{
					bootbox.alert(data.message);
				}
			});
        }
		
	    $(function() {
            
            //下拉框
            $(".chzn-select").chosen(); 
            $(".chzn-select-deselect").chosen({allow_single_deselect:true}); 
            
            //日期框
            $('.date-picker').datepicker();
            
            //复选框
            /* $('table th input:checkbox').click(function(){
                var that = this;
                $(this).closest('table').find('tr > td:first-child input:checkbox')
                .each(function(){
                    this.checked = that.checked;
                    $(this).closest('tr').toggleClass('selected');
                });
                    
            }); */
            
        });
        <%-- //导出excel
        function toExcel(){
            window.location.href='<%=basePath%>/trade/excel.do';
        } --%>
//         testTriger();
        function testTriger(){
        	alert(132)
        	$.post("<%=basePath%>/trade/testTriger.do",function(data){
        		alert(data.message);
        	});
        }
		</script>
		
	</body>
</html>

