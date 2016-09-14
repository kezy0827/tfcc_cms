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
			clearPicInfo();//清空图片坐标及宽高
			document.forms[0].action="contestant/upload.do";
			document.forms[0].target = 'contestant_img_iframe'; 
		    document.forms[0].submit();
	}
	//保存
	function save(){
	if($("#ac_name").val()==""){
			
			$("#ac_name").tips({
				side:3,
	            msg:'请输入选手名称',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#ac_name").focus();
			return false;
		}
		if($("#ac_introduce").val()==""){
			
			$("#ac_introduce").tips({
				side:3,
	            msg:'请输入选手介绍',
	            bg:'#AE81FF',
	            time:2
	        });
			
			$("#ac_introduce").focus();
			return false;
		}
		if($("#ac_poll").val()==""){
			
			$("#ac_poll").tips({
				side:3,
	            msg:'请输入投票数',
	            bg:'#AE81FF',
	            time:2
	        });
			
			$("#ac_poll").focus();
			return false;
		}else{
			var myreg = /^[1-9][0-9]*$/;
			if(!myreg.test($("#ac_poll").val())){
				$("#ac_poll").tips({
					side:3,
		            msg:'格式错误，请输入正整数',
		            bg:'#AE81FF',
		            time:3
		        });
				$("#ac_poll").focus();
				return false;
			}
		}
		if($("#original_img_http").attr("src")==""){
			
			$("#tps").tips({
				side:3,
	            msg:'请上传选手图片',
	            bg:'#AE81FF',
	            time:2
	        });
			
			$("#tps").focus();
			return false;
		}
		if($("#ac_weight").val()==""){
			$("#ac_weight").tips({
				side:3,
	            msg:'请输入权重',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#ac_weight").focus();
			return false;
		}else{
			var myreg = /^[1-9][0-9]*$/;
			if(!myreg.test($("#ac_weight").val())){
				$("#ac_weight").tips({
					side:3,
		            msg:'格式错误，请输入正整数',
		            bg:'#AE81FF',
		            time:3
		        });
				$("#ac_weight").focus();
				return false;
			}
		}
	   document.forms[0].action="contestant/save.do";
       document.forms[0].submit();
		//$("#Form").submit();
		$("#zhongxin").hide();
		$("#zhongxin2").show();
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
				api = $.Jcrop("#original_img_http");
				$('#original_img_http').Jcrop({
					onChange:showCoords,
					onSelect: showCoords,
					onRelease:clearCoords,
					aspectRatio:[1.6],
					minSize: [640,400],
					setSelect: [0, 0, 640, 400] 
				});	
			});  	 
			function showCoords(c){
				$('#ac_cut_img_x1').val(Math.floor(c.x));
				$('#ac_cut_img_y1').val(Math.floor(c.y));
				$('#ac_cut_img_x2').val(Math.floor(c.x2));
				$('#ac_cut_img_y2').val(Math.floor(c.y2));
				$('#ac_cut_img_width').val(c.w);
				$('#ac_cut_img_height').val(c.h);
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
	function removeJcrop(){
		clearPicInfo();
		api.destroy();                //设置为取消裁剪效果
		$("#original_img_http").removeAttr("style");
	}
	//清空图片的坐标及宽高信息
	function clearPicInfo(){
		$('#ac_cut_img_x1').val("");
		$('#ac_cut_img_y1').val("");
		$('#ac_cut_img_x2').val("");
		$('#ac_cut_img_y2').val("");
		$('#ac_cut_img_width').val("");
		$('#ac_cut_img_height').val("");
		$('.a_original_img_clip_width').html("");
		$('.a_original_img_clip_height').html("");
	}
</script>
	</head>
<body>
	<form action="contestant/save.do" name="Form" id="Form" method="post" enctype="multipart/form-data" target="contestant_img_iframe" >
		<input type="hidden" name="activity_contestant_id" id="activity_contestant_id" value="${pd.activity_contestant_id}"/>
		<input type="hidden"  name="activity_id"  id="activity_id"  value="${pd.activity_id}"/>
		<div id="zhongxin">
		<table id="table_report" class="table table-striped table-bordered table-hover">
			<tr>
				<td style="width:30%;">网名:</td>
				<td><input type="text"style="width:90%;" name="ac_name" id="ac_name" value="${pd.ac_name}" maxlength="10" placeholder="这里输入参赛选手名称" title="参赛选手名字名称"/></td>
			</tr>
			<tr>
				<td>选手介绍:</td>
				<td id="nr">
					<textarea  style="width:90%;height:100px" name="ac_introduce" id="ac_introduce" maxlength="100" placeholder="这里输入选手介绍" title="选手介绍">${pd.ac_introduce}</textarea>
				</td>
			</tr>
			<tr>
				<td>投票数:</td>
				<td><input type="text" style="width:90%;" name="ac_poll" id="ac_poll" value="${pd.ac_poll}" placeholder="这里输入投票数" title="投票数"/></td>
			</tr>
			<tr>
				<td>
					图片:
					<input type="hidden"  class="original_img_name" name="original_img_name" value="${pd.ac_original_img_name}"/>
					<input type="hidden"  class="original_img_info" name="original_img_info" value="${pd.imgInfo }"/>
					<input type="hidden"  id="ac_cut_img_x1" name="ac_cut_img_x1" value="${pd.ac_cut_img_x1}">
					<input type="hidden"  id="ac_cut_img_y1" name="ac_cut_img_y1" value="${pd.ac_cut_img_y1}">
					<input type="hidden"  id="ac_cut_img_x2" name="ac_cut_img_x2" value="${pd.ac_cut_img_x2}">
					<input type="hidden"  id="ac_cut_img_y2"  name="ac_cut_img_y2" value="${pd.ac_cut_img_y2}">
					<input type="hidden"  id="ac_cut_img_width"  name="ac_cut_img_width" value="${pd.ac_cut_img_width}">
					<input type="hidden"  id="ac_cut_img_height"  name="ac_cut_img_height" value="${pd.ac_cut_img_height}">
				</td>
				<td>
					<input type="file" id="tps" name="tps" onchange="upload()"/>
					<%-- <c:if test="${pd == null || pd.tp == '' || pd.tp == null }">
					<input type="file" id="tp" name="tp" onchange="upload()"/>
					</c:if>
					<c:if test="${pd != null && pd.tp != '' && pd.tp != null }">
						<a href="TP/${pd.tp}" target="_blank"><img src="TP/${pd.tp}" width="210"/></a>
						<input type="button" class="btn btn-mini btn-danger" value="删除" onclick="delP('${pd.tp}','${pd.activity_contestant_id}');" />
						<input type="text" name="tpz" id="tpz" value="${pd.tp }"/>
					</c:if> --%>
				</td>
			</tr>
			<tr>
				<td>
				预览（注意：取消裁剪后才可以更换图片）当前：宽：<font class="a_original_img_clip_width red"></font>高：<font class="a_original_img_clip_height red"></font><br>
				<a class="btn btn-mini btn-primary" onclick="excutejcrop();">裁剪</a>
				<a class="btn btn-mini btn-danger" onclick="removeJcrop();">取消裁剪</a>
				</td>
				<td><img id="original_img_http"  src="${pd.original_img_http }"></td>
			</tr>
			<tr>
				<td>权重:</td>
				<td>
					<input type="number" name="ac_weight" id="ac_weight"  placeholder="权重(输入数字)" title="权重越大,排列越靠前" value="${pd.ac_weight}"/>
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
		<script type="text/javascript" src="js/jquery.tips.js"></script><!--提示框-->
		
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