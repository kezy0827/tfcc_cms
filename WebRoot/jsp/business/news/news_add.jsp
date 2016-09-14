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
	<link rel="stylesheet" href="jcrop/css/jquery.Jcrop.css" type="text/css" /><!-- 裁剪控件 -->
	<!-- <link rel="stylesheet" href="ueditor/themes/default/css/ueditor.css" type="text/css"/> -->
	<script type="text/javascript" charset="utf-8"  src="jcrop/js/jquery.min.js"></script>     <!-- 裁剪控件 -->
	<script type="text/javascript" charset="utf-8"  src="jcrop/js/jquery.Jcrop.js"></script>     <!-- 裁剪控件 -->
	 <!-- 下面开始文本编辑器 -->
	<script type="text/javascript" charset="utf-8"  src="jscolor/jscolor.js"></script>
	<script type="text/javascript" charset="utf-8"  src="ueditor/ueditor.config.js"></script>
	<script type="text/javascript" charset="utf-8"  src="ueditor/ueditor.all.js"></script>
	<!-- <script type="text/javascript" charset="utf-8"  src="ueditor/myplugins/base.js"></script> -->
	<!-- <script type="text/javascript" charset="utf-8"  src="ueditor/myplugins/jiacu.js"></script> -->
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
	<form action="news/save.do" method="post" name="Form" id="Form" >
			<table id="table_report" class="table table-striped table-bordered table-hover">
				<tr>
					<td style="width:20%;"><label class="text_right"><font style="text-align: center;">首页标题：</font></label></td>
					<td style="width:30%;"><input type="text" name="n_title" id="n_title" maxlength="30" value="<c:out value="${pd.n_title}"/>"><font color="red" size="5">*</font></td>
					<td style="width:20%;"><label class="text_right" maxlength="30">内页标题：</label></td>
					<td style="width:30%;"><input type="text" name="n_subtitle" id="n_subtitle" value="${pd.n_subtitle}"></td>
				</tr>
				<tr>
					<td><label class="text_right">文章分类：</label></td>
					<td>
						<select class="chzn-select" name="channel_id" id="channel_id" data-placeholder="请选择" style="vertical-align:top;width: 120px;" >
					 		<c:forEach items="${listAll }" var="channel">
					 			<option style="text-align: center;" value="${channel.channel_id}" <c:if test="${channel.channel_id==pd.channel_id }">selected="selected"</c:if>>${channel.c_name }</option>
					 		</c:forEach>
					  	</select>
					  	<font color="red" size="5">*</font>
					</td>
					<td><label class="text_right">关键词：</label></td>
					<td><input type="text" name="n_antistop" id="n_antistop" maxlength="50" value="${pd.n_antistop}"></td>
				</tr>
				<tr>
					<td><label class="text_right">文章来源：</label></td>
					<td><input type="text" name="n_source" id="n_source" value="${pd.n_source}" maxlength="25"></td>
					<td><label class="text_right">审核状态：</label></td>
					<td>
						<select class="chzn-select" name="n_examine_status" id="n_examine_status" data-placeholder="请选择" style="vertical-align:top;width: 120px;" >
					 		<option style="text-align: center;" value="1" <c:if test="${pd.n_examine_status==1 }">selected="selected"</c:if>>通过</option>
					 		<option style="text-align: center;" value="0" <c:if test="${pd.n_examine_status==0 }">selected="selected"</c:if>>待审核</option>
					 		<option style="text-align: center;" value="-1" <c:if test="${pd.n_examine_status==-1 }">selected="selected"</c:if>>未通过</option>
					  	</select>
					  	<font color="red" size="5">*</font>
					</td>
				</tr>
				<tr>
					<td><label class="text_right">轮播：</label></td>
					<td>
						<input type="radio" name="n_carousel" value="1" <c:if test="${pd.n_carousel!=-1 }">checked="checked"</c:if>/><span class="lbl" style="margin-right: 20px;">&nbsp;是</span>
						<input type="radio" name="n_carousel" value="-1" <c:if test="${pd.n_carousel==-1 }">checked="checked"</c:if>/><span class="lbl" >&nbsp;否</span>
						<font id="n_carousel" color="red" size="5">*</font>
					</td>
					<td><label class="text_right">置顶：</label></td>
					<td>
						<input type="radio" name="n_top" value="1" <c:if test="${pd.n_top!=-1 }">checked="checked"</c:if>/><span class="lbl" style="margin-right: 20px;">&nbsp;是</span>
						<input type="radio" name="n_top" value="-1" <c:if test="${pd.n_top==-1 }">checked="checked"</c:if>/><span class="lbl">&nbsp;否</span>
						<font id="n_top" color="red" size="5">*</font>
					</td>
				</tr>
				<tr>
					<td><label class="text_right" >来源链接：</label></td>
					<td>
						<input type="text" name="n_source_url" id="n_source_url" maxlength="100" value="${pd.n_source_url}"/>
					</td>
					<td><label class="text_right">文章简介：</label></td>
					<td><textarea rows="5" cols="80" style="width:80%;" maxlength="100" name="n_intro" id="n_intro">${pd.n_intro}</textarea></td>
				</tr>
				<tr>
					<td><label class="text_right"><b>内容：</b></label></td>
				    <td colspan="3">
				    <input type="radio" name="cardnamecolor" value="#000000" onclick="clickcolor(this)" class="absolute" style="left:0px;top:14px;">
	                   <!--  <input type="hidden" name="editorHidden" id="editorHidden"/> -->
	                    <script id="editorContent" name="editorContent" type="text/plain" style="width:600px;height:200px;">${pd.n_news_data_list }</script>
						<script type="text/javascript">
						    var ue = UE.getEditor('editorContent',{
						  		//这里填写初始化参数，只能初始化前台，不能初始化后台参数,后台参数初始化时候需修改  ueditor/config.json文件
						  		/* toolbars: [[
							            'fullscreen', 'source', '|', 'undo', 'redo', '|',
							            'bold', 'italic', 'underline', 'superscript', 'subscript', 'removeformat', 'pasteplain', '|', 'forecolor', 'backcolor', 'selectall', 'cleardoc', '|',
							            'rowspacingtop', 'rowspacingbottom', 'lineheight', '|',
							            'customstyle', 'paragraph', 'fontfamily', 'fontsize', '|',
							            'directionalityltr', 'directionalityrtl', 'indent', '|',
							            'justifyleft', 'justifycenter', 'justifyright', 'justifyjustify', '|', 'touppercase', 'tolowercase', '|',
							            'link', 'unlink', 'anchor', '|', 'imagenone', 'imageleft', 'imageright', 'imagecenter', '|',
							            'simpleupload', 'insertimage', 'emotion', 'scrawl', 'insertvideo', 'music', 'attachment', 'map', 'background', '|',
							            'date', 'time', 'spechars', 'snapscreen', 'wordimage', '|',
							            'print', 'preview', 'searchreplace', 'help']] */
						  	});
						  	/*function setValue(){
						  		$("#editorHidden").attr('value', UE.getEditor('editorContent').getContent());
						  		alert(UE.getEditor('editorContent').getContent());
						  	} */
						</script>
						<input type="hidden" id="news_id" name="news_id" value="${pd.news_id}">
						<input type="hidden" id="caozuo" name="caozuo">
						<input type="hidden" id="n_img_width" name="n_img_width" value="${pd.n_img_width}">
						<input type="hidden" id="n_img_height" name="n_img_height" value="${pd.n_img_height}">
						<input type="hidden" id="n_img_size" name="n_img_size" value="${pd.n_img_size}">
						<input type="hidden" id="n_img_name" name="n_img_name" value="${pd.n_img_name}">
						<input type="hidden"  id="n_cut_img_x1" name="n_cut_img_x1" value="${pd.n_cut_img_x1}">
						<input type="hidden"  id="n_cut_img_y1" name="n_cut_img_y1" value="${pd.n_cut_img_y1}">
						<input type="hidden"  id="n_cut_img_x2" name="n_cut_img_x2" value="${pd.n_cut_img_x2}">
						<input type="hidden"  id=n_cut_img_y2 name="n_cut_img_y2" value="${pd.n_cut_img_y2}">
                    </td>
				</tr>
				<!-- <tr>
					<td><label class="text_right">内容：</label></td>
				    <td colspan="3">
				    	<p>
				    		<a href="javascript:undo()">撤销&nbsp;&nbsp;|</a>
				    		<a href="javascript:redo()">重做&nbsp;&nbsp;|</a>
				    		<a href="javascript:insertImg()">插入图片&nbsp;&nbsp;|</a>
				    		<a href="javascript:bold()">加粗&nbsp;&nbsp;|</a>
				    		<a href="javascript:italic()">斜体&nbsp;&nbsp;|</a>
				    		<a href="javascript:underline()">下划线&nbsp;&nbsp;|</a>
				    		<a href="javascript:sup()">上标&nbsp;&nbsp;|</a>
				    		<a href="javascript:sub()">下标</a>
				    	</p>
				    	<p>
				    		<a href="javascript:indent()">首航缩进&nbsp;|</a>
				    		<a href="javascript:left()">居左&nbsp;|</a>
				    		<a href="javascript:center()">居中&nbsp;|</a>
				    		<a href="javascript:right()">居右</a>
				    		<span onclick="right()">
				    			<select style="width:119px;">
				    				<option>段落</option>
				    				<option style="font-size: 2em; margin: .67em 0">标题1</option>
				    				<option style="font-size: 1.5em; margin: .75em 0"><h2>标题2</h2></option>
				    				<option style="font-size: 1.17em; margin: .83em 0"><h3>标题3</h3></option>
				    				<option style="font-size: 14px;"><h4>标题4</h4></option>
				    				<option style="font-size: .83em; margin: 1.5em 0"><h5>标题5</h5></option>
				    				<option style="font-size: .75em; margin: 1.67em 0"><h6>标题6</h6></option>
				    			</select>
				    		</span>
				    		<span>
				    			<select style="width:119px;font-size:14px;">
				    				<option style="font-family: 宋体,SimSun;">字体</option>
				    				<option style="font-family: 宋体,SimSun;">宋体</option>
				    				<option style="font-family: 微软雅黑,Microsoft YaHei;">微软雅黑</option>
				    				<option style="font-family: 楷体,楷体_GB2312, SimKai;">楷体</option>
				    				<option style="font-family: 黑体, SimHei;">黑体</option>
				    				<option style="font-family: 隶书, SimLi;">隶书</option>
				    			</select>
				    		</span>
				    		<span>
				    			<select  id="font_size" style="width:119px;" onchange="fontSize(this);" >
				    				<option style="font-size:14px;">字号</option>
				    				<option style="font-size: 10px;">10px</option>
				    				<option style="font-size: 11px;">11px</option>
				    				<option style="font-size: 12px;">12px</option>
				    				<option style="font-size: 14px;">14px</option>
				    				<option style="font-size: 16px;">16px</option>
				    				<option style="font-size: 18px;">18px</option>
				    				<option style="font-size: 20px;">20px</option>
				    				<option style="font-size: 24px;">24px</option>
				    			</select>
				    		</span>
				    	</p>
				    	<textarea id="content" rows="8" cols="40" maxlength="1000" style="width: 600px;height:300px;"></textarea>
				    </td>
				</td> -->
				<tr>
					<td rowspan="2">
						<label class="text_center;" style="color: red">原图上传：(请上传640*400以上图片)</label><br>
						<input type="file" id="tp" name="tp" onchange="uploadimg(this)"><br><br>
						<a id="jcrop" class="btn btn-mini btn-primary" style="width:215px;text-align: center;margin-left: 0px;" onclick="excutejcrop();">裁&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;剪</a>
						<a id="nojcrop" class="btn btn-mini btn-primary" style="display:none;width:215px;" onclick="removeJcrop();">取&nbsp;&nbsp;消&nbsp;&nbsp;裁&nbsp;&nbsp;剪</a>
					</td>
				    
				</tr>
				<tr>
					<td colspan="3">
					    <img id="newsimgid" src="${http_img_url}" >
	                </td>
				</tr>
				<tr>
					<td style="vertical-align:top;">
						<a class="btn btn-small btn-success" onclick="add('1');">保存</a>
						<a class="btn btn-small btn-success" onclick="add('2');">取消</a>
					</td>
				</tr>
			</table>
		</form>
	</div>
 	<!-- <div style="position:absolute;left:100px;top:730px;padding:10px;">
        	<form   id="imgform" target="aaa" method="post" enctype="multipart/form-data">
	        <input type="file" id="tp" name="tp" onchange="uploadimg(this)">
	         <img id="newsimgid" src="${http_img_url}" >
	        </form>
     </div> -->
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
			alert(UE.getEditor('editorContent').getContent());
		if(obj=="1"){
			$("#caozuo").val("save");
			if($("#n_title").val()==""){
				$("#n_title").tips({
					side:3,
		            msg:'请输入文章名称',
		            bg:'#AE81FF',
		            time:3
		        });
				$("#n_title").focus();
				return false;
			}
			var item = $("input[name='n_carousel']:radio:checked"); 
			var len=item.length;
			if(len==0){
				$("#n_carousel").tips({
					side:3,
		            msg:'必选',
		            bg:'#AE81FF',
		            time:3
		        });
				$("#n_carousel").focus();
				return false;
			}
			var item = $("input[name='n_top']:radio:checked"); 
			var len=item.length;
			if(len==0){
				$("#n_top").tips({
					side:3,
		            msg:'必选',
		            bg:'#AE81FF',
		            time:3
		        });
				$("#n_top").focus();
				return false;
			}
			if(UE.getEditor('editorContent').getContent()==""){
				$("#editorContent").tips({
					side:3,
		            msg:'请输入内容',
		            bg:'#AE81FF',
		            time:3
		        });
				$("#editorContent").focus();
				return false;
			}
			if($("#newsimgid").attr("src")==""){
				$("#tp").tips({
					side:3,
		            msg:'请上传首图',
		            bg:'#AE81FF',
		            time:3
		        });
				$("#tp").focus();
				return false;
			}
		}else{
			$("#caozuo").val("cancel");
		}
		window.parent.jzts();
		$("#Form").attr("action","news/save.do");
		$("#Form").removeAttr("target");
		$("#Form").removeAttr("enctype");
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
		clearPicInfo();
		var filename = $(obj).attr('name');
		var imgname =$("input[type='file'][name='tp']").val();
		if(imgname==""){
			alert("请选择文件！");
			return;
		}
		$('#Form').attr("target","aaa");
		$('#Form').attr("enctype","multipart/form-data");
		var form  = document.getElementById("Form");
		form.action="news/upload.do?filename="+filename+"&imgname="+imgname+"&news_id="+$("input[id='news_id']").val();
		form.submit();
		/* var imgform  = $('#imgform')[0];
		imgform.action="news/upload.do?filename="+filename+"&imgname="+imgname+"&news_id="+$("input[id='news_id']").val();
		imgform.submit(); */
	}
	function excutejcrop() {
		if($("#newsimgid").attr("src")==""){
			$("#tp").tips({
				side:3,
	            msg:'请上传首图',
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
				api = $.Jcrop("#newsimgid");
				 $('#newsimgid').Jcrop({
					onChange:showCoords,
					onSelect: showCoords,
					onRelease:clearCoords,
					aspectRatio:[1.6],
					minSize: [640,400],
					setSelect: [0, 0, 640, 400] 
				});	
			});  	 
			function showCoords(c){
				$('#n_cut_img_x1').val(c.x);
				$('#n_cut_img_y1').val(c.y);
				$('#n_cut_img_x2').val(c.x2);
				$('#n_cut_img_y2').val(c.y2);
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
		$("#newsimgid").removeAttr("style");
	}
	//清空图片的坐标及宽高信息
	function clearPicInfo(){
		$('#n_cut_img_x1').val("");
		$('#n_cut_img_y1').val("");
		$('#n_cut_img_x2').val("");
		$('#n_cut_img_y2').val("");
	}
		</script>
		<script type="text/javascript" src="js/jquery.cookie.js"></script>
		
	</body>
</html>

