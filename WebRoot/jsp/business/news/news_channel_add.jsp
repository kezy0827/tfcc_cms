<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
			<li><i class="icon-home"></i> <a>资讯管理</a><span class="divider"><i class="icon-angle-right"></i></span></li>
			<li class="active"><a>添加文章分类</a></li>
		</ul><!--.breadcrumb-->
		<div id="nav-search">
		</div><!--#nav-search-->
	</div><!--#breadcrumbs-->

<div id="page-content" class="clearfix">
  <div class="row-fluid">
	<div class="row-fluid">
	<form action="channel/save.do" method="post" name="Form" id="Form">
			<table id="table_report" class="table table-striped table-bordered table-hover">
				<tr>
					<td style="width:20%;"><label class="text_right">文章分类名称：</label></td><td style="width:80%;"><input type="text" name="c_name" id="c_name" maxlength="10" value="${pd.c_name}"><font color="red" size="5">*</font></td>
				</tr>
				<tr>
					<td><label class="text_right">上级分类：</label></td>
					<td>
						<select class="chzn-select" name="c_parent_channel_id" id="c_parent_channel_id" data-placeholder="请选择" style="vertical-align:top;width: 120px;" >
					 		<option style="text-align: center;" value="0">顶级分类</option>
					 		<c:forEach items="${listAll }" var="channel">
					 			<option style="text-align: center;" value="${channel.channel_id}"<c:if test="${channel.channel_id==pd.c_parent_channel_id}">selected="selected"</c:if>>${channel.c_name }</option>
					 		</c:forEach>
					  	</select>
					  	<font color="red" size="5">*</font>
					</td>
				</tr>
				<tr>
					<td><label class="text_right">权重：</label></td><td><input type="text" name="c_weight" id="c_weight" value="${pd.c_weight}"><font color="red" >*(提示：只能输入正整数)</font></td>
				</tr>
				<tr>
					<td><label class="text_right">显示对象：</label></td>
					<td>
						<input type="radio" name="showobj" value="1" checked/><span class="lbl" style="margin-right: 20px;">&nbsp;App</span>
						<input type="radio" name="showobj" value="2" <c:if test="${pd.c_isweb==1&&pd.c_isapp!=1}">checked="checked"</c:if>/><span class="lbl" style="margin-right: 20px;">&nbsp;Web</span>
						<input type="radio" name="showobj" value="3" <c:if test="${pd.c_isapp==1&&pd.c_isweb==1}">checked="checked"</c:if>/><span class="lbl" style="margin-right: 20px;">&nbsp;App&nbsp;和&nbsp;Web</span>
					</td>
				</tr>
				<tr>
					<td><label class="text_right">是否有链接：</label></td>
					<td>
						<input type="radio" name="c_isurl" value="1" <c:if test="${pd.c_isurl!=-1}">checked="checked"</c:if>/><span class="lbl" style="margin-right: 28px;">&nbsp;是</span>
						<input type="radio" name="c_isurl" value="-1" <c:if test="${pd.c_isurl==-1}">checked="checked"</c:if>/><span class="lbl">&nbsp;否</span>
					</td>
				</tr>
				<tr>
					<td><label class="text_right">链接地址：</label></td>
					<td>
						<input type="text" name="c_url" id="c_url" value="${pd.c_url}" maxlength="100"/>
					</td>
				</tr>
				<tr>
					<td><label class="text_right">描述：</label></td>
					<td><textarea rows="8" cols="80" style="width:500px;" maxlength="50" name="c_describe" id="c_describe">${pd.c_describe}</textarea></td>
				</tr>
			</table>
			
		<div class="page-header position-relative">
		<table style="width:100%;">
			<tr>
				<td style="vertical-align:top;">
					<input type="hidden" id="channel_id" name="channel_id" value="${pd.channel_id}">
					<input type="hidden" id="parent_channe_id" name="parent_channe_id" value="${pd.c_parent_channel_id}">
					<input type="hidden" id="c_type" name="c_type" value="1">
					<input type="hidden" id="caozuo" name="caozuo">
					<input type="hidden" id="is_web" name="is_web" value="${pd.c_isweb}">
					<input type="hidden" id="is_app" name="is_app" value="${pd.c_isapp}">
					<input type="hidden" id="is_url" name="is_url" value="${pd.c_isurl}">
					<a class="btn btn-small btn-success" onclick="add('1');">保存</a>
					<a class="btn btn-small btn-success" onclick="add('2');">取消</a>
				</td>
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
		<!--bootstrap.min.js控制id= btn-scroll-up  的功能和样式-->
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
		<script type="text/javascript">
		
		$(window.parent.hangge());
		/**
		* jquery tips 提示插件 jquery.tips.js v0.1beta
		*
		* 使用方法
		* $(selector).tips({   //selector 为jquery选择器
		*  msg:'your messages!',    //你的提示消息  必填
		*  side:1,  //提示窗显示位置  1，2，3，4 分别代表 上右下左 默认为1（上） 可选
		*  color:'#FFF', //提示文字色 默认为白色 可选
		*  bg:'#F00',//提示窗背景色 默认为红色 可选
		*  time:2,//自动关闭时间 默认2秒 设置0则不自动关闭 可选
		*  x:0,//横向偏移  正数向右偏移 负数向左偏移 默认为0 可选
		*  y:0,//纵向偏移  正数向下偏移 负数向上偏移 默认为0 可选
		* })
		*/
		
		//新增
	function add(obj){
		if(obj=="1"){
			$("#caozuo").val("save");
			if($("#c_name").val()==""){
				$("#c_name").tips({
					side:3,
		            msg:'请输入频道名称',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#c_name").focus();
				return false;
			}
			if($("#c_weight").val()==""){
				$("#c_weight").tips({
					side:3,
		            msg:'请输入权重',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#c_weight").focus();
				return false;
			}else{
				var myreg = /^[1-9][0-9]*$/;
				if(!myreg.test($("#c_weight").val())){
					$("#c_weight").tips({
						side:3,
			            msg:'格式错误，请输入正整数',
			            bg:'#AE81FF',
			            time:3
			        });
					$("#c_weight").focus();
					return false;
				}
			}
		}else{
			$("#caozuo").val("cancel");
		}
		window.parent.jzts();
		if($("#channel_id").val()!=""){
			$("#Form").attr("action","channel/edit.do")
		}
		
		$("#Form").submit();
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
		$("input[type='checkbox']").attr("checked",false);//清空默认的单选框值
		/* alert($("#parent_channe_id").val());
		$("#C_PARENT_CHANNEL_ID").val($("#parent_channe_id").val())//选中下拉框
		alert($("#C_PARENT_CHANNEL_ID").val()); */
		if($("#is_web").val()==1&&$("#is_app").val()==1){
			$("input[name='showobj']")[2].attr("checked",true);
		}else if($("#is_web").val()==1){
			$("input[name='showobj']")[1].attr("checked",true);
		}else{
			$("input[name='showobj']")[0].attr("checked",true);
		}
		if($("#is_url").val()==1){
			$("input[name='C_ISURL']")[0].attr("checked",true);
		}else{
			$("input[name='C_ISURL']")[0].attr("checked",true);
		}
		
	});
		
		</script>
		
		<script type="text/javascript" src="js/jquery.cookie.js"></script>
		
	</body>
</html>

