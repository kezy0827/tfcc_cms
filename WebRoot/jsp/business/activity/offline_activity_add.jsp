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
			if($("#a_activity_venue_name").val()==""){
				$("#a_activity_venue_name").tips({
					side:3,
		            msg:'请添加活动场馆',
		            bg:'#AE81FF',
		            time:3
		        });
				$("#a_activity_venue_name").focus();
				return false;
			}
			if($("#a_apply_start_datetime").val()==""){
				$("#a_apply_start_datetime").tips({
					side:3,
		            msg:'请输入报名开始时间',
		            bg:'#AE81FF',
		            time:3
		        });
				$("#a_apply_start_datetime").focus();
				return false;
			}
			if($("#a_apply_end_datetime").val()==""){
				$("#a_apply_end_datetime").tips({
					side:3,
		            msg:'请输入报名结束时间',
		            bg:'#AE81FF',
		            time:3
		        });
				$("#a_apply_end_datetime").focus();
				return false;
			}
			if($("#a_activity_start_datetime").val()==""){
				$("#a_activity_start_datetime").tips({
					side:3,
		            msg:'请输入活动开始时间',
		            bg:'#AE81FF',
		            time:3
		        });
				$("#a_activity_start_datetime").focus();
				return false;
			}
			if($("#a_activity_end_datetime").val()==""){
				$("#a_activity_end_datetime").tips({
					side:3,
		            msg:'请输入活动结束时间',
		            bg:'#AE81FF',
		            time:3
		        });
				$("#a_activity_end_datetime").focus();
				return false;
			}
			if($("#a_entry_fee").val()==""){
				$("#a_entry_fee").tips({
					side:3,
		            msg:'请输入费用',
		            bg:'#AE81FF',
		            time:3
		        });
				$("#a_entry_fee").focus();
				return false;
			}else{
				var myreg = /^(([1-9]\d*)|0)(\.\d{2})?$/;
				if(!myreg.test($("#a_entry_fee").val())){
					$("#a_entry_fee").tips({
						side:3,
			            msg:'费用格式错误',
			            bg:'#AE81FF',
			            time:3
			        });
					$("#a_entry_fee").focus();
					return false;
				}
			}
			if($("#a_sponsor_venue_name").val()==""){
				$("#a_sponsor_venue_name").tips({
					side:3,
		            msg:'请输入主办方',
		            bg:'#AE81FF',
		            time:3
		        });
				$("#a_sponsor_venue_name").focus();
				return false;
			}
			if($("#a_phone").val()==""){
				$("#a_phone").tips({
					side:3,
		            msg:'输入手机号',
		            bg:'#AE81FF',
		            time:3
		        });
				$("#a_phone").focus();
				return false;
			}else{
				var myreg = /^(((13[0-9]{1})|159)+\d{8})$/;
				if($("#a_phone").val().length != 11 && !myreg.test($("#a_phone").val())){
					$("#a_phone").tips({
						side:3,
			            msg:'手机号格式不正确',
			            bg:'#AE81FF',
			            time:3
			        });
					$("#a_phone").focus();
					return false;
				}
			}
			if($("#a_address_longitude").val() == ""){
				$("#a_address_longitude").tips({
					side:3,
		            msg:'经度不能为空',
		            bg:'#AE81FF',
		            time:3
		        });
				$("#a_address_latitude").focus();
				return false;
			}else{
				 var regTel =/^-?((0|[1-9]\d?|1[1-7]\d)(\.\d{1,10})?|180(\.0{1,10})?)?$/; //精度验证正则表达式
				 if(!regTel.test($("#a_address_longitude").val())){
					$("#a_address_longitude").tips({
						side:3,
			            msg:'经度格式错误',
			            bg:'#AE81FF',
			            time:3
			        });
					$("#a_address_longitude").focus();
					return false;
				 }
			}
			
			if($("#a_address_latitude").val() == ""){
				$("#a_address_latitude").tips({
					side:3,
		            msg:'纬度不能为空',
		            bg:'#AE81FF',
		            time:3
		        });
				$("#a_address_latitude").focus();
				return false;
			}else{
				var longitudereg = /^-?((0|[1-8]\d|)(\.\d{1,7})?|90(\.0{1,7})?)?$/;
				if(!longitudereg.test($("#a_address_latitude").val())){
					$("#a_address_latitude").tips({
						side:3,
			            msg:'纬度格式错误',
			            bg:'#AE81FF',
			            time:3
			        });
					$("#a_address_latitude").focus();
					return false;
				}
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
			$("#Form").removeAttr("enctype");
			$("#Form").removeAttr("target");
		   document.forms[0].action="activity/offline_save.do";
	       document.forms[0].submit();
	}
	function upload(obj){
		clearPicInfo();
		var filename = $(obj).attr('name');
		var imgname =$("input[type='file'][name='tp']").val();
		if(imgname==""){
			alert("请选择文件！");
			return;
		}
		document.forms[0].action="activity/upload.do";
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
				api = $.Jcrop("#element_id");
				$("#element_id").Jcrop({
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
		$("#Form").attr("action","activity/offlinelist.do");
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
					<td style="width:15%;"><label class="text_right">活动主题：</label></td>
					<td style="width:35%;"><input type="text" name="a_title" id="a_title"  value="${pd.a_title }" maxlength="30"><font color="red" size="5">*</font></td>
					<td style="width:15%;"><label class="text_right">活动场馆：</label></td>
					<%-- <td style="width:35%;"><input type="text" id="a_activity_venue_name" name="a_activity_venue_name" onclick="venueList();" value="${pd.a_activity_venue_name }"><font color="red" size="5">*</font></td> --%>
					<td style="width:35%;">
						<select class="chzn-select" name="a_activity_venue_name" id="a_activity_venue_name" data-placeholder="请选择" style="vertical-align:top;width: 220px;">
							<c:forEach items="${varList }" var="account">
					 			<option style="text-align: center;" value="${account.id}_${account.nickname }" <c:if test="${account.id==pd.a_activity_venue_id}">selected="selected"</c:if>>${account.nickname }</option>
					 		</c:forEach>
					  	</select>
					  	<font color="red" size="5">*</font>
					 </td>
				</tr>
				<tr>
					<td><label class="text_right">报名发起时间：</label></td>
					<td><input class="span10 date-picker" style="width:58%;" name="a_apply_start_datetime" id="a_apply_start_datetime" value="${fn:substring(pd.a_apply_start_datetime,0,10) }" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" style="width:88px;" placeholder="报名发起时间"/><font color="red" size="5">*</font></td>
					<td><label class="text_right">是否需要线上支付：</label></td>
					<td><input type="radio" name="a_ispay" value="1" <c:if test="${pd.a_ispay!=-1 }">checked="checked"</c:if>/><span class="lbl" style="margin-right: 20px;">&nbsp;是</span>
						<input type="radio" name="a_ispay" value="-1" <c:if test="${pd.a_ispay==-1 }">checked="checked"</c:if>/><span class="lbl" >&nbsp;否</span>
						<font id="n_carousel" color="red" size="5">*</font>
					</td>
				</tr>
				<tr>
					<td><label class="text_right">报名结束时间：</label></td>
					<td><input class="span10 date-picker" style="width:58%;" name="a_apply_end_datetime" id="a_apply_end_datetime" value="${fn:substring(pd.a_apply_end_datetime,0,10) }" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" style="width:88px;" placeholder="报名结束时间"/><font color="red" size="5">*</font></td>
					<td><label class="text_right">费用：</label></td>
					<td>
						<input type="text" id="a_entry_fee" name="a_entry_fee" value="${pd.a_entry_fee }"/><font color="red"  size="5">*</font>
					</td>
				</tr>
				<tr>
					<td><label class="text_right">活动开始时间：</label></td>
					<td><input class="span10 date-picker" style="width:58%;" name="a_activity_start_datetime" id="a_activity_start_datetime" value="${fn:substring(pd.a_activity_start_datetime,0,10) }" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" style="width:88px;" placeholder="活动开始时间"/><font color="red" size="5">*</font></td>
					<td><label class="text_right">主办方：</label></td>
					<td>
						<input type="text" id="a_sponsor_venue_name" name="a_sponsor_venue_name" value="${pd.a_sponsor_venue_name }"/><font color="red" size="5">*</font>
					</td>
				</tr>
				<tr>
					<td><label class="text_right">活动结束时间：</label></td>
					<td><input class="span10 date-picker" style="width:58%;" name="a_activity_end_datetime" id="a_activity_end_datetime" value="${fn:substring(pd.a_activity_end_datetime,0,10) }" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" style="width:88px;" placeholder="活动结束时间"/><font color="red" size="5">*</font></td>
					<td><label class="text_right">电话号码：</label></td>
					<td>
						<input type="text" id="a_phone" name="a_phone" value="${pd.a_phone }"/><font color="red" size="5">*</font>
					</td>
				</tr>
				<tr>
					<td><label class="text_right">活动地址：</label></td>
					<td colspan="3">
						<select  style="vertical-align:top;width: 220px;" data-placeholder="请选择" id="a_province_id" name="a_province_id" onchange="getCity()"  ></select> 
						<select  style="vertical-align:top;width: 220px;" id="a_city_id" name="a_city_id" onchange="getDistrict()" ></select> 
						<select  style="vertical-align:top;width: 220px;" id="a_country_id" name="a_country_id" ></select>
						<font color="red" size="5">*</font>
					</td>
				</tr>
				<tr>
					<td><label class="text_right">详细地址：</label></td>
					<td colspan="3">
						<input type="text" id="a_address" name="a_address" style="width:70%" maxlength="30" value="${pd.a_address }">
					</td>
				</tr>
				<tr>
					<td colspan="2" align="center">
						<span style="width:30%;">经度：<input type="text" id="a_address_longitude" name="a_address_longitude" value="${pd.a_address_longitude }"><font color="red" size="5">*</font></span>
						<span style="width:30%;margin-left: 20px;">纬度：<input type="text" id="a_address_latitude" name="a_address_latitude" value="${pd.a_address_latitude }"><font color="red" size="5">*</font></span>
					</td>
					<td><label class="text_right">是否轮播：</label></td>
					<td><input type="radio" name="a_carousel" value="1" <c:if test="${pd.a_carousel!=-1 }">checked="checked"</c:if>/><span class="lbl" style="margin-right: 20px;">&nbsp;是</span>
						<input type="radio" name="a_carousel" value="-1" <c:if test="${pd.a_carousel==-1 }">checked="checked"</c:if>/><span class="lbl" >&nbsp;否</span>
					</td>
				</tr>
				<tr>
					<td><label class="text_right">活动介绍：</label></td>
				    <td colspan="3" >
				    	<textarea rows="5" style="width:80%;" cols="50" name="a_introduce" id="a_introduce"  maxlength="100">${pd.a_introduce }</textarea>
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
						<label class="text_center;" style="color: red">原图上传：(请上传640*400以上图片)</label><br>
						<input type="hidden" class="activityimgname" name="a_original_img_name" value="${pd.a_original_img_name }">
						<input type="hidden" class="imgInfo" name="imgInfo" value="${pd.imgInfo }">
						<a id="jcrop" class="btn btn-mini btn-primary" style="width:215px;text-align: center;margin-left: 0px;" onclick="excutejcrop();">裁&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;剪</a>
						<a id="nojcrop" class="btn btn-mini btn-primary" style="display:none;width:215px;" onclick="removeJcrop();">取&nbsp;&nbsp;消&nbsp;&nbsp;裁&nbsp;&nbsp;剪</a>
					</td>
				    <td colspan="3">
	                    <div class="widget-main">
	                    	<input type="file" id="tp" name="tp"  onchange="upload()"/>
					   </div>
					   <img id="element_id"  src="${pd.http_img }">
                    </td>
				</tr>
				<tr>
					<td style="text-align: center;" colspan="4">
						<input type="hidden" id="activity_id" name="activity_id" value="${pd.activity_id }">
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
		$(function() {
			//下拉框
			$(".chzn-select").chosen(); 
			$(".chzn-select-deselect").chosen({allow_single_deselect:true}); 
			//日期框
			$('.date-picker').datepicker();
			//获取省
			getProvince();
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
			
			//获取市
			function getCity(){
				var id = $("#a_province_id option:selected").val()
				var url = "<%=basePath%>/util/getCityList.do?parentid="+id+"&tm="+new Date().getTime();
				$.post(url,function(data){
					//var str = JSON.stringify(data);
					//alert(str);
					var list = eval(data);
					var html = "";
					for(var i = 0 ;i<list.length;i++){
						var cityName = list[i].MC;
						var cityId = list[i].ID;
						html +="<option value=\""+cityId+"\">"+cityName+"</option>"
					}
					$("#a_city_id").html("").append(html);
					$("#a_city_id").val(${pd.a_city_id});
					getDistrict();
					//nextPage(${page.currentPage});
					
				});
				
			}
			//获取区
			function getDistrict(){
				var id = $("#a_city_id option:selected").val()
				var url = "<%=basePath%>/util/getCityList.do?parentid="+id+"&tm="+new Date().getTime();
				$.post(url,function(data){
					//var str = JSON.stringify(data);
					//alert(str);
					var list = eval(data);
					var html = "";
					for(var i = 0 ;i<list.length;i++){
						var cityName = list[i].MC;
						var cityId = list[i].ID;
						html +="<option value=\""+cityId+"\">"+cityName+"</option>"
					}
					$("#a_country_id").html("").append(html);
					$("#a_country_id").val(${pd.a_country_id});
					//nextPage(${page.currentPage});
				});
			}
			function getProvince(){
				var id = 1;
				var url = "util/getCityList.do?parentid="+id;
				 $.post(url,function(data){
					//alert(typeof(data));
					/* var str = JSON.stringify(data);
					alert("str="+str) */
					//alert(eval("("+data+")"));
					//var list = data.list;
					var list = eval(data);
					//alert(list)
					var html = "";
					for(var i = 0 ;i<list.length;i++){
						var cityName = list[i].MC;
						var cityId = list[i].ID;
						html +="<option value=\""+cityId+"\">"+cityName+"</option>"
					}
					$("#a_province_id").html("").append(html);
					$("#a_province_id").val(${pd.a_province_id});
					getCity();
				}); 
			}
		</script>
		<script type="text/javascript" src="js/jquery.cookie.js"></script>
	</body>
</html>

