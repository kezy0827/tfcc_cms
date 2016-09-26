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
	 <!-- 下面开始文本编辑器 -->
    <script type="text/javascript" charset="utf-8"  src="ueditor/ueditor.config.js"></script>
	<script type="text/javascript" charset="utf-8"  src="ueditor/ueditor.all.js"></script>
    <script type="text/javascript" charset="utf-8" src="ueditor/lang/zh-cn/zh-cn.js"></script>
	<style type="text/css">
		.text_right{text-align: right;}
	</style>
	</head>
<body>
		
<div class="container-fluid" id="main-container">

	<div id="breadcrumbs">
	
	<ul class="breadcrumb">		
		<li><i class="icon-home"></i> <a>资讯管理</a><span class="divider"><i class="icon-angle-right"></i></span></li>
		<li class="active"><a>文章列表</a><span class="divider"><i class="icon-angle-right"></i></span></li>
		<li class="active"><a>添加文章</a></span></li>
	</ul><!--.breadcrumb-->
	
	<div id="nav-search">
	</div><!--#nav-search-->
	
	</div><!--#breadcrumbs-->

<div id="page-content" class="clearfix">
						
  <div class="row-fluid">

	<div class="row-fluid">
	<form action="news/save.do" method="post" name="Form" id="Form">
			<table id="table_report" class="table table-striped table-bordered table-hover">
				<tr>
					<td style="width:15%;"><label class="text_right">首页标题：</label></td>
					<td style="width:35%;"><input type="text" name="n_title" id="n_title" value="${pd.n_title}"></td>
					<td style="width:15%;"><label class="text_right">内页标题：</label></td>
					<td style="width:35%;"><input type="text" name="n_subtitle" id="n_subtitle" value="${pd.n_subtitle}"></td>
				</tr>
				<tr>
					<td><label class="text_right">文章分类：</label></td>
					<td>
						<select class="chzn-select" name="channel_id" id="channel_id" data-placeholder="请选择" style="vertical-align:top;width: 120px;" >
					 		<option style="text-align: center;">--请选择--</option>
					 		<c:forEach items="${listAll }" var="channel">
					 			<option style="text-align: center;" value="${channel.channel_id}" <c:if test="${channel.channel_id==pd.channel_id }">selected="selected"</c:if>>${channel.c_name }</option>
					 		</c:forEach>
					  	</select>
					</td>
					<td><label class="text_right">关键词：</label></td>
					<td><input type="text" name="n_antistop" id="n_antistop" value="${pd.n_antistop}"></td>
				</tr>
				<tr>
					<td><label class="text_right">文章来源：</label></td>
					<td><input type="text" name="n_source" id="n_source" value="${pd.n_source}"></td>
					<td><label class="text_right">审核状态：</label></td>
					<td>
						<select class="chzn-select" name="n_examine_status" id="n_examine_status" data-placeholder="请选择" style="vertical-align:top;width: 120px;" >
					 		<option style="text-align: center;" value="1" <c:if test="${pd.n_examine_status==1 }">selected="selected"</c:if>>通过</option>
					 		<option style="text-align: center;" value="0" <c:if test="${pd.n_examine_status==0 }">selected="selected"</c:if>>待审核</option>
					 		<option style="text-align: center;" value="-1" <c:if test="${pd.n_examine_status==-1 }">selected="selected"</c:if>>未通过</option>
					  	</select>
					</td>
				</tr>
				<tr>
					<td><label class="text_right">轮播：</label></td>
					<td>
						<input type="radio" name="n_carousel" value="1" <c:if test="${pd.n_carousel==1 }">checked="checked"</c:if>/><span class="lbl" style="margin-right: 20px;">&nbsp;是</span>
						<input type="radio" name="n_carousel" value="-1" <c:if test="${pd.n_carousel==-1 }">checked="checked"</c:if>/><span class="lbl" style="margin-right: 20px;">&nbsp;否</span>
					</td>
					<td><label class="text_right">置顶：</label></td>
					<td>
						<input type="radio" name="n_top" value="1" <c:if test="${pd.n_carousel==1 }">checked="checked"</c:if>/><span class="lbl" style="margin-right: 28px;">&nbsp;是</span>
						<input type="radio" name="n_top" value="-1" <c:if test="${pd.n_carousel==-1 }">checked="checked"</c:if>/><span class="lbl">&nbsp;否</span>
					</td>
				</tr>
				<tr>
					<td><label class="text_right">来源链接：</label></td>
					<td>
						<input type="text" name="n_source_url" id="n_source_url" value="${pd.n_source_url}"/>
					</td>
					<td><label class="text_right">文章简介：</label></td>
					<td><textarea rows="5" cols="80" style="width:80%;" name="n_intro" id="n_intro">${pd.n_intro}</textarea></td>
				</tr>
				<tr>
					<td><label class="text_right">内容：</label></td>
				    <td colspan="3">
	                    <input type="hidden" name="editorHidden" id="editorHidden" value="开始的"/>
	                    <script id="editorContent" name="editorContent" type="text/plain" style="width:600px;height:200px;">${pd.nd_content }</script>
						<script type="text/javascript">
						    var ue = UE.getEditor('editorContent',{
						  		//这里填写初始化参数，只能初始化前台，不能初始化后台参数,后台参数初始化时候需修改  ueditor/config.json文件
						  	});
						  	function setValue(){
						  		$("#editorHidden").attr('value', UE.getEditor('editorContent').getContent());
						  		/* alert(UE.getEditor('editorContent').getContent()); */
						  	}
						</script>
                    </td>
				</tr>
			</table>
			
		<div class="page-header position-relative">
		<table style="width:100%;">
			<tr>
				<td style="vertical-align:top;">
					<input type="hidden" id="news_id" name="news_id" value="${pd.news_id}">
					<input type="hidden" id="caozuo" name="caozuo">
					<input type="hidden" id="n_img_width" name="n_img_width" value="${pd.n_img_width}">
					<input type="hidden" id="n_img_height" name="n_img_height" value="${pd.n_img_height}">
					<input type="hidden" id="n_img_size" name="n_img_size" value="${pd.n_img_size}">
					<input type="hidden" id="n_img_name" name="n_img_name" value="${pd.n_img_name}">
					<a class="btn btn-small btn-success" onclick="add('1');">保存</a>
					<a class="btn btn-small btn-success" onclick="add('2');">取消</a>
				</td>
			</tr>
		</table>
		</div>
		</form>
	</div>
 	<div style="width:200px;height:200px;position:absolute;left:850px;top:380px;padding:10px;">
        	<form   id="imgform" target="aaa" method="post" enctype="multipart/form-data">
        	上传缩略图：<p style="color: red;">请选用：640*240的图片</p>
	        <input type="file" id="tp" name="tp" onchange="uploadimg(this)">
	        <img id="newsimgid" src="${http_img_url}"  width="640px" height="240px" style="margin-top:10px;">
	        </form>
     </div>
 	<iframe class="hide" name="aaa"></iframe>
 
 
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
			}
		}else{
			$("#caozuo").val("cancel");
		}
		window.parent.jzts();
		/* if($("#news_id").val()!=""){
			$("#Form").attr("action","news/edit.do")
		} */
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
		//判断上传的图片格式、大小是否正确，若不正确弹出提示信息
		/* if(${pdfile.msg}!=null||${pdfile.msg}!=""){
			alert((${pdfile.msg});
		} */
	});
	function uploadimg(obj){
		var filename = $(obj).attr('name');
		var imgname =$("input[type='file'][name='tp']").val();
		if(imgname==""){
			alert("请选择文件！");
			return;
		}
		var imgform  = $('#imgform')[0];
		imgform.action="news/upload.do?filename="+filename+"&imgname="+imgname+"&news_id="+$("input[id='news_id']").val();
		imgform.submit();
		<%-- var url = "<%=basePath%>/news/upload.do?filename="+filename+"&imgname="+imgname+"&news_id="+$("input[id='news_id']").val();
		$.post(url,function(data){
			/* if(data=="success"){
				nextPage(${page.currentPage});
			} */
			alert(data);
			nextPage(${page.currentPage});
		}); --%>
	}
		</script>
		
		<script type="text/javascript" src="js/jquery.cookie.js"></script>
		
	</body>
</html>

