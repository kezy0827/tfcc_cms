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
	function save(){
			if($("#a_title").val()==""){
				$("#a_title").tips({
					side:3,
		            msg:'请输入活动标题',
		            bg:'#AE81FF',
		            time:3
		        });
				$("#a_title").focus();
				return false;
			}
			if($("#a_introduce").val()==""){
				$("#a_introduce").tips({
					side:3,
		            msg:'请输入活动介绍',
		            bg:'#AE81FF',
		            time:3
		        });
				$("#a_introduce").focus();
				return false;
			}
			if($("#a_rule").val()==""){
				$("#a_rule").tips({
					side:3,
		            msg:'请输入活动规则',
		            bg:'#AE81FF',
		            time:3
		        });
				$("#a_rule").focus();
				return false;
			}
			if($("#a_notice").val()==""){
				$("#a_notice").tips({
					side:3,
		            msg:'请输入活动公告',
		            bg:'#AE81FF',
		            time:3
		        });
				$("#a_notice").focus();
				return false;
			}
			if($("#id-date-range-picker-1").val()==""){
				$("#id-date-range-picker-1").tips({
					side:3,
		            msg:'请输入投票时间',
		            bg:'#AE81FF',
		            time:3
		        });
				$("#id-date-range-picker-1").focus();
				return false;
			}
			if($("#showActivityInfo").attr("src")==""){
				$("#activityInfoFile").tips({
					side:3,
		            msg:'请上传场馆详情图',
		            bg:'#AE81FF',
		            time:3
		        });
				$("#activityInfoFile").focus();
				return false;
			}
			if($("#element_id").attr("src")==""){
				$("#tp").tips({
					side:3,
		            msg:'请上活动首图',
		            bg:'#AE81FF',
		            time:3
		        });
				$("#tp").focus();
				return false;
			}
			$("#Form").removeAttr("target")
			$("#Form").removeAttr("enctype")
		   document.forms[0].action="activity/save.do";
	       document.forms[0].submit();
	}
	function upload(){
		clearPicInfo();
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
		if($("#element_id").attr("src")==""){
			$("#tp").tips({
				side:3,
	            msg:'请上传活动首图',
	            bg:'#AE81FF',
	            time:3
	        });
			$("#tp").focus();
			return false;
		}
		if(confirm("确定进行裁剪工作吗，如果是，本次操作将不能再进行上传图片操作，只能修改本活动！！")){
			$("#jcrop").css("display","none");
			$("#nojcrop").css("display","block");
			jQuery(function($){
				$('#element_id').Jcrop({
					onChange:showCoords,
					onSelect: showCoords,
					onRelease:clearCoords,
					aspectRatio:[1.6],
					minSize: [640,400],
					setSelect: [0, 0, 640, 400] 
				});	
			});  	 
			function showCoords(c){
				$('#a_cut_img_x1').val(c.x);
				$('#a_cut_img_y1').val(c.y);
				$('#a_cut_img_x2').val(c.x2);
				$('#a_cut_img_y2').val(c.y2);
				$('#a_cut_img_width').val(c.w);
				$('#a_cut_img_height').val(c.h);
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
	function removeJcrop(){
		$("#nojcrop").css("display","none");
		$("#jcrop").css("display","block");
		clearPicInfo();
		api.destroy();                //设置为取消裁剪效果
		$("#element_id").removeAttr("style");
	}
	function clearPicInfo(){
		$("#a_cut_img_x1").val("");
		$("#a_cut_img_y1").val("");
		$("#a_cut_img_x2").val("");
		$("#a_cut_img_y2").val("");
		$("#a_cut_img_width").val("");
		$("#a_cut_img_height").val("");
	}
	function cancel(){
		$("#Form").removeAttr("target");
		$("#Form").attr("action","activity/onlinelist.do");
		$("#Form").submit();
		/* document.forms[0].action="activity/onlinelist.do";
	    document.forms[0].submit(); */
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
			<table id="table_report" class="table table-striped table-bordered table-hover">
				<tr>
					<td style="width:15%;"><label class="text_right">活动标题：</label></td>
					<td style="width:35%;"><input type="text" name="a_title" id="a_title"  maxlength="30" value="${pd.a_title}"><font color="red" size="5">*</font></td>
					<td style="width:15%;"><label class="text_right">活动介绍：</label></td>
					<td style="width:35%;"><textarea rows="5" cols="80" style="width:80%;" name="a_introduce" maxlength="100" id="a_introduce">${pd.a_introduce}</textarea><font color="red" size="5">*</font></td>
				</tr>
				<tr>
					<td><label class="text_right">活动规则：</label></td>
					<td><textarea rows="5" cols="80" style="width:80%;" name="a_rule" id="a_rule" maxlength="100">${pd.a_rule}</textarea><font color="red" size="5">*</font></td>
					<td><label class="text_right">活动公告：</label></td>
					<td><textarea rows="5" cols="80" style="width:80%;" name="a_notice" id="a_notice" maxlength="100">${pd.a_notice}</textarea><font color="red" size="5">*</font></td>
				</tr>
				<tr>
					<td><label class="text_right">投票时间：</label></td>
					<td>
						 <div class="control-group">
								<div class="input-prepend">
									<span class="add-on"><i class="icon-calendar"></i></span>
									<input class="span11" type="text" name="date-range-picker" id="id-date-range-picker-1" value="${pd.date_picker}"/>
									<font color="red" size="5">*</font>
								</div>
						 </div>
					</td>
					<td><label class="text_right">是否轮播：</label></td>
					<td>
						<input type="radio" name="a_carousel" value="1" <c:if test="${pd.a_carousel!=-1 }">checked="checked"</c:if> /><span class="lbl" style="margin-right: 20px;">&nbsp;是</span>
						<input type="radio" name="a_carousel" value="-1" <c:if test="${pd.a_carousel==-1 }">checked="checked"</c:if>/><span class="lbl" style="margin-right: 20px;">&nbsp;否</span>
					</td>
				</tr>
				<tr>
					<td><label class="text_right">内容：</label></td>
				    <td colspan="3">
	                    <input type="hidden" name="editorHidden" id="editorHidden" value="施工"/>
	                     <script id="editorContent" name="editorContent" type="text/plain" style="width:600px;height:200px;">${pd.a_html}</script>
						<script type="text/javascript">
						    var ue = UE.getEditor('editorContent',{
						  		//这里填写初始化参数，只能初始化前台，不能初始化后台参数,后台参数初始化时候需修改  ueditor/config.json文件
						  	});
						  	function setValue(){
						  		$("#editorHidden").attr('value', UE.getEditor('editorContent').getContent());
						  		/* alert(UE.getEditor('editorContent').getContent()); */
						  	}
						</script>
						<input type="hidden"  id="a_cut_img_x1" name="a_cut_img_x1" value="${pd.a_cut_img_x1 }">
						<input type="hidden"  id="a_cut_img_y1" name="a_cut_img_y1" value="${pd.a_cut_img_y1 }">
						<input type="hidden"  id="a_cut_img_x2" name="a_cut_img_x2" value="${pd.a_cut_img_x2 }">
						<input type="hidden"  id="a_cut_img_y2"  name="a_cut_img_y2" value="${pd.a_cut_img_y2 }">
						<input type="hidden"  id="a_cut_img_width"  name="a_cut_img_width" value="${pd.a_cut_img_width }">
						<input type="hidden"  id="a_cut_img_height"  name="a_cut_img_height" value="${pd.a_cut_img_height }">
                    </td>
				</tr>
				<tr>
					<td>
						<label class="text_center">场馆详情图上传：(规格225*360)</label>
						<input type="text" class="activityinfoimgname" name="activityinfoimgname">
					</td>
				    <td colspan="3">
	                    <div class="widget-main">
	                    	<input type="file"  name="activityInfoFile" id="activityInfoFile" onchange="uploadActivityInfo()"/>
					   </div>
					   <div>
					   		<img id="showActivityInfo" name="showActivityInfo" src="${pd.activity_id_width225_height360}">
					   </div>
                    </td>
				</tr>
				
				<tr>
					<td>
						<label class="text_center">原图上传：(请尽量最大化原图比例)</label>
						<input type="hidden" class="activityimgname" name="a_original_img_name"  value="${pd.a_original_img_name}">
						<input type="hidden" class="imgInfo" name="imgInfo" value="${pd.imgInfo }">
						<a id="jcrop" class="btn btn-mini btn-primary" style="width:215px;text-align: center;margin-left: 0px;" onclick="excutejcrop();">裁&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;剪</a>
						<a id="nojcrop" class="btn btn-mini btn-primary" style="display:none;width:215px;" onclick="removeJcrop();">取&nbsp;&nbsp;消&nbsp;&nbsp;裁&nbsp;&nbsp;剪</a>
						<!-- <a class="btn btn-mini btn-primary" onclick="excutejcrop();">裁剪操作</a> -->
					</td>
				    <td colspan="3">
	                    <div class="widget-main">
	                    	<input type="file" id="tp" name="tp"  onchange="upload()"/>
							<%-- <c:if test="${pd == null || pd.stieurl == '' || pd.stieurl == null }">
							<input type="file" id="tp" name="tp"  onchange="upload()"/>
							</c:if>
							<c:if test="${pd != null && pd.stieurl != '' && pd.stieurl != null }">
								<a href="TP/${pd.stieurl}" target="_blank"><img src="TP/${pd.stieurl}" width="210"/></a>
								<input type="button" class="btn btn-mini btn-danger" value="删除" onclick="delP('${pd.stieurl}','${pd.id}');" />
								<input type="hidden" name="tpz" id="tpz" value="${pd.stieurl }"/>
							</c:if> --%>
					   </div>
					   <img id="element_id"  src="${pd.activity_id_width_height}">
                    </td>
				</tr>
				<tr>
					<td style="text-align: center;" colspan="4">
						<input type="hidden" name="activity_id" id="activity_id" value="${pd.activity_id}" >
						<a class="btn btn-mini btn-primary" onclick="save();">保存</a>
						<a class="btn btn-mini btn-danger" onclick="cancel();">取消</a>
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

