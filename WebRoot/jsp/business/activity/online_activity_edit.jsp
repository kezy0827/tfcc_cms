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
	<link rel="stylesheet" href="css/daterangepicker.css" /><!-- 双日历控件 -->
	<link rel="stylesheet" href="jcrop/css/jquery.Jcrop.css" type="text/css" /><!-- 裁剪控件 -->
	 <!-- 下面开始文本编辑器 -->
    <script type="text/javascript" charset="utf-8"  src="ueditor/ueditor.config.js"></script>
	<script type="text/javascript" charset="utf-8"  src="ueditor/ueditor.all.js"></script>
    <script type="text/javascript" charset="utf-8" src="ueditor/lang/zh-cn/zh-cn.js"></script>
    
   <script type="text/javascript" charset="utf-8"  src="jcrop/js/jquery.min.js"></script>     <!-- 裁剪控件 -->
<script type="text/javascript" charset="utf-8"  src="jcrop/js/jquery.Jcrop.js"></script>     <!-- 裁剪控件 -->
	<style type="text/css">
		.text_right{text-align: right;}
	</style>
	<script type="text/javascript">
	//保存
	function update(){
		   document.forms[0].action="activity/update.do";
	       document.forms[0].submit();
	}
	function upload(){
			document.forms[0].action="activity/upload.do";
			document.forms[0].target = 'uploadpushimg'; 
		    document.forms[0].submit();
	}
	function uploadActivityInfo(){
			document.forms[0].action="activity/uploadActivityInfo.do";
			document.forms[0].target = 'uploadpushimg'; 
		    document.forms[0].submit();
	}
	function clearCoords(){
	 	$('#coords input').val('');
		$('#h').css({color:'red'});
		window.setTimeout(function(){
			$('#h').css({color:'inherit'});
		},500);  
	};  
	function excutejcrop() {
		if(confirm("确定进行裁剪工作吗，如果是，本次操作将不能再进行上传图片操作，只能修改本活动！！")){
			jQuery(function($){
				$('#element_id').Jcrop({
					onChange:showCoords,
					onSelect: showCoords,
					onRelease:clearCoords,
					aspectRatio:[1.6],
					minSize: [100,100],
					setSelect: [0, 0, 50, 50] 
				});	
			});  	 
			function showCoords(c){
				$('#a_original_img_left_up').val(c.x);
				$('#a_original_img_right_up').val(c.y);
				$('#a_original_img_left_down').val(c.x2);
				$('#a_original_img_right_down').val(c.y2);
				$('#a_original_img_clip_width').val(c.w);
				$('#a_original_img_clip_height').val(c.h);
				$('#height').val(c.h);   
			 };
			function clearCoords(){
				$('#coords input').val('');
				$('#h').css({color:'red'});
				window.setTimeout(function(){
					$('#h').css({color:'inherit'});
				},500);  
			};  
		}
	}
	</script>
	</head>
<body>
<div class="container-fluid" id="main-container">
	<div id="breadcrumbs">
	<ul class="breadcrumb">		
		<li><i class="icon-home"></i> <a>活动管理</a><span class="divider"><i class="icon-angle-right"></i></span></li>
		<li class="active"><a>活动添加</a><span class="divider"><i class="icon-angle-right"></i></span></li>
	</ul><!--.breadcrumb-->
	<div id="nav-search">
	</div><!--#nav-search-->
	</div><!--#breadcrumbs-->
<div id="page-content" class="clearfix">
  <div class="row-fluid">
	<div class="row-fluid">
	<form name="Form" id="Form" method="post" enctype="multipart/form-data"  target="uploadpushimg" >
			<input type="hidden" value="${pd.activity_id}" name="activity_id">
			<table id="table_report" class="table table-striped table-bordered table-hover">
				<tr>
					<td style="width:15%;"><label class="text_right">活动标题：</label></td>
					<td style="width:35%;"><input type="text" name="a_title" id="a_title"  value="${pd.a_title}"></td>
					<td style="width:15%;"><label class="text_right">活动介绍：</label></td>
					<td style="width:35%;"><textarea rows="5" cols="80" style="width:80%;" name="a_introduce" id="a_introduce" >${pd.a_introduce}</textarea></td>
				</tr>
				<tr>
					<td><label class="text_right">活动规则：</label></td>
					<td><textarea rows="5" cols="80" style="width:80%;" name="a_rule" id="a_rule">${pd.a_rule}</textarea></td>
					<td><label class="text_right">活动公告：</label></td>
					<td><textarea rows="5" cols="80" style="width:80%;" name="a_notice" id="a_notice">${pd.a_notice}</textarea></td>
				</tr>
				<tr>
					<td><label class="text_right">投票时间：</label></td>
					<td>
						 <div class="control-group">
								<div class="input-prepend">
									<span class="add-on"><i class="icon-calendar"></i></span>
									<input class="span11" type="text" name="date-range-picker" id="id-date-range-picker-1"  value=" ${pd.date_picker}"/>
								</div>
						 </div>
					</td>
					<td><label class="text_right">是否轮播：</label></td>
					<td>
						<c:if test="${pd.a_carousel == 1}">
							<input type="radio" name="a_carousel" value="1"  checked="checked"/><span class="lbl" style="margin-right: 20px;">&nbsp;是</span>
							<input type="radio" name="a_carousel" value="-1" /><span class="lbl" style="margin-right: 20px;">&nbsp;否</span>
						</c:if>
						 <c:if test="${pd.a_carousel == -1}">
							<input type="radio" name="a_carousel" value="1" /><span class="lbl" style="margin-right: 20px;">&nbsp;是</span>
							<input type="radio" name="a_carousel" value="-1"   checked="checked"/><span class="lbl" style="margin-right: 20px;">&nbsp;否</span>
						</c:if>
					</td>
				</tr>
				<tr>
					<td><label class="text_right">web端：</label></td>
				    <td colspan="3">
	                    <input type="text" name="editorHidden" id="editorHidden" value=""/>
	                    <script id="editorContent"  name="editorContent" type="text/plain" style="width:600px;height:200px;">${pd.a_html}</script>
						<script type="text/javascript">
						    var ue = UE.getEditor('editorContent',{
						  		//这里填写初始化参数，只能初始化前台，不能初始化后台参数,后台参数初始化时候需修改  ueditor/config.json文件
						  	});
						  	function setValue(){
						  		$("#editorHidden").attr('value', UE.getEditor('editorContent').getContent());
						  	 
						  	}
						</script>
						<input type="text"  id="a_original_img_left_up" name="a_original_img_left_up"   value=" ${pd.a_original_img_left_up}">
						<input type="text"  id="a_original_img_left_down" name="a_original_img_left_down"  value=" ${pd.a_original_img_left_down}">
						<input type="text"  id="a_original_img_right_up" name="a_original_img_right_up"  value=" ${pd.a_original_img_right_up}">
						<input type="text"  id="a_original_img_right_down"  name="a_original_img_right_down"  value=" ${pd.a_original_img_right_down}">
						<input type="text"  id="a_original_img_clip_width"  name="a_original_img_clip_width"  value=" ${pd.a_original_img_clip_width}">
						<input type="text"  id="a_original_img_clip_height"  name="a_original_img_clip_height"  value=" ${pd.a_original_img_clip_height}">
                    </td>
				</tr>
				<tr>
					<td>
						<label class="text_center">场馆详情图上传：(规格225*360)</label>
						<input type="text" class="activityinfoimgname" name="activityinfoimgname" >
					</td>
				    <td colspan="3">
	                      <div class="widget-main">
	                    	<input type="file"  name="activityInfoFile"  onchange="uploadActivityInfo()" />
					      </div>
					       <img id="showActivityInfo"  src="${pd.activity_id_width225_height360}">
                    </td>
				</tr>
				<tr>
					<td>
						<label class="text_center">原图上传：(请尽量最大化原图比例)</label>
						<input type="text" class="activityimgname" name="a_original_img_name"  value=" ${pd.a_original_img_name}">
						<a class="btn btn-mini btn-primary" onclick="excutejcrop();">裁剪操作</a>
					</td>
				    <td colspan="3">
	                    <div class="widget-main">
	                    	<input type="file" id="tp" name="tp"  onchange="upload()"/>
					   </div>
					   <img id="element_id"  src="${pd.activity_id_width_height}">
                    </td>
				</tr>
				<tr>
					<td style="text-align: center;" colspan="4">
						<a class="btn btn-mini btn-primary" onclick="update();">保存</a>
						<a class="btn btn-mini btn-danger" onclick="excutejcrop() ;">取消</a>
					</td>
			    </tr>
			</table>
			<iframe name="uploadpushimg"  width="0" height="0" id="iframeid"> </iframe> 
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
		<script type="text/javascript" src="js/date.js"></script><!--双日历控件-->
		<script type="text/javascript" src="js/daterangepicker.min.js"></script><!--双日历控件-->
		<script type="text/javascript">
		$(window.parent.hangge());
		$('#id-date-range-picker-1').daterangepicker();//双日历控件
		$('#id-input-file-1 , #id-input-file-2').ace_file_input({
				no_file:'No File ...',
				btn_choose:'Choose',
				btn_change:'Change',
				droppable:false,
				onchange:null,
				thumbnail:false //| true | large
				//whitelist:'gif|png|jpg|jpeg'
				//blacklist:'exe|php'
				//onchange:''
				//
		});
		//上传
			$('#tp').ace_file_input({
				no_file:'请选择图片 ...',
				btn_choose:'选择',
				btn_change:'更改',
				droppable:false,
				onchange:null,
				thumbnail:false //| true | large
				//whitelist:'gif|png|jpg|jpeg'
				//blacklist:'exe|php'
				//onchange:''
				//
			});
		</script>
		<script type="text/javascript" src="js/jquery.cookie.js"></script>
	</body>
</html>

