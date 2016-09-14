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
		<base href="<%=basePath%>">
		
		<meta charset="utf-8" />
		<title></title>
		
		<meta name="description" content="overview & stats" />
		<meta name="viewport" content="width=device-width, initial-scale=1.0" />
		<link href="css/bootstrap.min.css" rel="stylesheet" />
		<link href="css/bootstrap-responsive.min.css" rel="stylesheet" />
		<link rel="stylesheet" href="css/font-awesome.min.css" />
		<!--[if IE 7]><link rel="stylesheet" href="css/font-awesome-ie7.min.css" /><![endif]-->
		<!--[if lt IE 9]><link rel="stylesheet" href="css/ace-ie.min.css" /><![endif]-->
		<!-- 单选框 -->
		<link rel="stylesheet" href="css/chosen.css" />
		
		<link rel="stylesheet" href="css/ace.min.css" />
		<link rel="stylesheet" href="css/ace-responsive.min.css" />
		<link rel="stylesheet" href="css/ace-skins.min.css" />
		
		<link rel="stylesheet" href="css/datepicker.css" /><!-- 日期框 -->
		<link rel="stylesheet" href="jcrop/css/jquery.Jcrop.css" type="text/css" /><!-- 裁剪控件 -->
		<script type="text/javascript" src="js/jquery-1.7.2.js"></script>
		<!--提示框-->
		<script type="text/javascript" src="js/jquery.tips.js"></script>
		
		
		   <script type="text/javascript" charset="utf-8"  src="jcrop/js/jquery.min.js"></script>     <!-- 裁剪控件 -->
<script type="text/javascript" charset="utf-8"  src="jcrop/js/jquery.Jcrop.js"></script>     <!-- 裁剪控件 -->

<script type="text/javascript">
	function upload(){
			document.forms[0].action="contestant/upload.do";
			document.forms[0].target = 'contestant_img_iframe'; 
		    document.forms[0].submit();
	}


	//保存
	function save(){
	/* 	if($("#stiename").val()==""){
			
			$("#stiename").tips({
				side:3,
	            msg:'输入网站名称',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#stiename").focus();
			return false;
		}
		if($("#content").val()==""){
			
			$("#nr").tips({
				side:3,
	            msg:'输入内容',
	            bg:'#AE81FF',
	            time:2
	        });
			
			$("#content").focus();
			return false;
		}
		
		 */
		  document.forms[0].action="contestant/update.do";
	       document.forms[0].submit();
		//$("#Form").submit();
		//$("#zhongxin").hide();
		//$("#zhongxin2").show();
	}
	
	//删除图片
	function delP(tpurl,id){
		 if(confirm("确定要删除图片？")){
			var url = "link/deltp.do?tpurl="+tpurl+"&id="+id+"&guid="+new Date().getTime();
			$.get(url,function(data){
				if(data=="success"){
					alert("删除成功!");
					document.location.reload();
				}
			});
		} 
	}
	
	function excutejcrop() {
		if(confirm("确定进行裁剪工作吗，如果是，本次操作将不能再进行上传图片操作，只能修改本活动！！")){
			jQuery(function($){
				$('#original_img_http').Jcrop({
					onChange:showCoords,
					onSelect: showCoords,
					onRelease:clearCoords,
					aspectRatio:[1.6],
					minSize: [100,100],
					setSelect: [0, 0, 50, 50] 
				});	
			});  	 
			function showCoords(c){
				$('#ac_clip_img_left_up').val(c.x);
				$('#ac_clip_img_right_up').val(c.y);
				$('#ac_clip_img_left_down').val(c.x2);
				$('#ac_clip_img_right_down').val(c.y2);
				$('#ac_clip_img_width').val(c.w);
				$('#ac_clip_img_height').val(c.h);
				$('.a_original_img_clip_width').html(Math.round(c.w));
				$('.a_original_img_clip_height').html(Math.round(c.h));
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
	<form action="contestant/update.do" name="Form" id="Form" method="post" enctype="multipart/form-data" target="contestant_img_iframe" >
		<input type="hidden" name="activity_contestant_id" id="activity_contestant_id" value="${pd.activity_contestant_id}"/>
		<input type="hidden"  name="activity_id"  id="activity_id"  value="${activity_id}"/>
		<div id="zhongxin">
		<table id="table_report" class="table table-striped table-bordered table-hover">
			<tr>
				<td>网名:</td>
				<td><input type="text"style="width:95%;" name="ac_name" id="ac_name" value="${pd.ac_name}" placeholder="这里输入参赛选手名称" title="参赛选手名字名称" /></td>
			</tr>
			<tr>
				<td>选手介绍:</td>
				<td id="nr">
					<textarea  style="width:90%;height:100px" name="ac_introduce">${pd.ac_introduce}</textarea>
				</td>
			</tr>
			<tr>
				<td>投票数:</td>
				<td><input type="text" style="width:95%;" name="ac_poll" id="ac_poll" value="${pd.ac_poll}" placeholder="这里输入投票数" title="投票数"/></td>
			</tr>
			<tr>
				<td>
					图片:
					<input type="hidden"  class="original_img_name" name="original_img_name"  value="${pd.original_img_name}"/>
					<input type="hidden"  class="original_img_info" name="original_img_info"/>
					<input type="hidden"  id="ac_clip_img_left_up" name="ac_clip_img_left_up" value="${pd.ac_clip_img_left_up}">
					<input type="hidden"  id="ac_clip_img_left_down" name="ac_clip_img_left_down" value="${pd.ac_clip_img_left_down}">
					<input type="hidden"  id="ac_clip_img_right_up" name="ac_clip_img_right_up" value="${pd.ac_clip_img_right_up}">
					<input type="hidden"  id="ac_clip_img_right_down"  name="ac_clip_img_right_down" value="${pd.ac_clip_img_right_down}">
					<input type="hidden"  id="ac_clip_img_width"  name="ac_clip_img_width" value="${pd.ac_clip_img_width}">
					<input type="hidden"  id="ac_clip_img_height"  name="ac_clip_img_height" value="${pd.ac_clip_img_height}">
				</td>
				<td>
					<%-- <c:if test="${pd == null || pd.ac_original_img_name == '' || pd.ac_original_img_name == null }"> --%>
						<input type="file" id="activityContestantImgFile" name="activityContestantImgFile" onchange="upload()"/>
					<%-- </c:if>
					<c:if test="${pd != null && pd.ac_original_img_name != '' && pd.ac_original_img_name != null }">
						<a href="TP/${pd.ac_original_img_name}" target="_blank"><img src="TP/${pd.ac_original_img_name}" width="210"/></a>
						<input type="button" class="btn btn-mini btn-danger" value="删除" onclick="delP('${pd.ac_original_img_name}','${pd.activity_contestant_id}');" />
						<input type="text" name="tpz" id="tpz" value="${pd.ac_original_img_name }"/>
					</c:if> --%>
				</td>
			</tr>
			<tr>
				<td>
				预览（注意：取消裁剪后才可以更换图片）当前：宽：<font class="a_original_img_clip_width red"></font>高：<font class="a_original_img_clip_height red"></font><br>
				<a class="btn btn-mini btn-primary" onclick="excutejcrop();">裁剪</a>
				<a class="btn btn-mini btn-danger" onclick="excutejcrop();">取消裁剪</a>
				</td>
				<td><img id="original_img_http"  src="${pd.original_img_http}" ></td>
			</tr>
			<tr>
				<td>权重:</td>
				<td>
					<input type="number" name="ac_weight" id="ac_weight"  placeholder="权重(输入数字)" title="权重越大,排列越靠前" value="${pd.ac_weight}">
				</td>
			</tr>
			<tr>
				<td class="center" colspan="2">
					<a class="btn btn-mini btn-primary" onclick="save();">保存</a>
					<a class="btn btn-mini btn-danger" onclick="top.Dialog.close();">取消</a>
				</td>
			</tr>
		</table>
		</div>
		<div id="zhongxin2" class="center" style="display:none"><br/><br/><br/><br/><br/><img src="images/jiazai.gif" /><br/><h4 class="lighter block green">提交中...</h4></div>
		
		
		<iframe name="contestant_img_iframe"  width="0" height="0" id="contestant_img_iframe_id"> </iframe> 
	</form>
		<!-- 引入 -->
		<script type="text/javascript">window.jQuery || document.write("<script src='js/jquery-1.9.1.min.js'>\x3C/script>");</script>
		<script src="js/bootstrap.min.js"></script>
		<script src="js/ace-elements.min.js"></script>
		<script src="js/ace.min.js"></script>
		<script type="text/javascript" src="js/chosen.jquery.min.js"></script><!-- 单选框 -->
		<script type="text/javascript" src="js/bootstrap-datepicker.min.js"></script><!-- 日期框 -->
		
		<!-- 编辑框-->
		<script type="text/javascript" charset="utf-8">window.UEDITOR_HOME_URL = "<%=path%>/ueditor/";</script>
		<script type="text/javascript" charset="utf-8" src="ueditor/ueditor.config.js"></script>
		<script type="text/javascript" charset="utf-8" src="ueditor/ueditor.all.js"></script>
		<!-- 编辑框-->
		
		<script type="text/javascript">
		$(window.parent.hangge());
		$(function() {
			
			//单选框
			$(".chzn-select").chosen(); 
			$(".chzn-select-deselect").chosen({allow_single_deselect:true}); 
			
			//日期框
			$('.date-picker').datepicker();
			
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
			
		});
		
		function reurl(){ 
			UE.getEditor('content');
			} 
		setTimeout('reurl()',500);
		</script>
	
</body>
</html>