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
		<!-- 下拉框 -->
		<link rel="stylesheet" href="css/chosen.css" />
		
		<link rel="stylesheet" href="css/ace.min.css" />
		<link rel="stylesheet" href="css/ace-responsive.min.css" />
		<link rel="stylesheet" href="css/ace-skins.min.css" />
		
		<link rel="stylesheet" href="css/datepicker.css" /><!-- 日期框 -->
		<script type="text/javascript" src="js/jquery-1.7.2.js"></script>
		<script type="text/javascript" src="js/jquery.tips.js"></script>
		
<script type="text/javascript">
	
	
	
	//保存
	function save(){
			if($("#C_NAME").val()==""){
			$("#C_NAME").tips({
				side:3,
	            msg:'请输入频道名称',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#C_NAME").focus();
			return false;
		}
		if($("#C_PARENT_CHANNEL_ID").val()==""){
			$("#C_PARENT_CHANNEL_ID").tips({
				side:3,
	            msg:'请输入上级频道  跟为0',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#C_PARENT_CHANNEL_ID").focus();
			return false;
		}
		if($("#C_TYPE").val()==""){
			$("#C_TYPE").tips({
				side:3,
	            msg:'请输入频道类型 1：新闻频道  2：活动频道',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#C_TYPE").focus();
			return false;
		}
		if($("#C_ISWEB").val()==""){
			$("#C_ISWEB").tips({
				side:3,
	            msg:'请输入是否在web端显示   1:是  -1：否',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#C_ISWEB").focus();
			return false;
		}
		if($("#C_ISAPP").val()==""){
			$("#C_ISAPP").tips({
				side:3,
	            msg:'请输入是否在app端显示   1:是  -1：否',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#C_ISAPP").focus();
			return false;
		}
		if($("#C_WEIGHT").val()==""){
			$("#C_WEIGHT").tips({
				side:3,
	            msg:'请输入权重   展示在网站或app中 该频道的排序',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#C_WEIGHT").focus();
			return false;
		}
		if($("#C_ISURL").val()==""){
			$("#C_ISURL").tips({
				side:3,
	            msg:'请输入是否是连接  1:是  -1：否',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#C_ISURL").focus();
			return false;
		}
		if($("#C_URL").val()==""){
			$("#C_URL").tips({
				side:3,
	            msg:'请输入链接地址',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#C_URL").focus();
			return false;
		}
		if($("#C_DESCRIBE").val()==""){
			$("#C_DESCRIBE").tips({
				side:3,
	            msg:'请输入频道描述',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#C_DESCRIBE").focus();
			return false;
		}
		$("#Form").submit();
		$("#zhongxin").hide();
		$("#zhongxin2").show();
	}
	
</script>
	</head>
<body>
	<form action="channel/${msg }.do" name="Form" id="Form" method="post">
		<input type="hidden" name="CHANNEL_ID" id="CHANNEL_ID" value="${pd.CHANNEL_ID}"/>
		<div id="zhongxin">
		<table>
			<tr>
				<td><input type="text" name="C_NAME" id="C_NAME" value="${pd.C_NAME}" maxlength="10" placeholder="这里输入频道名称" title="频道名称"/></td>
			</tr>
			<tr>
				<td><input type="number" name="C_PARENT_CHANNEL_ID" id="C_PARENT_CHANNEL_ID" value="${pd.C_PARENT_CHANNEL_ID}" maxlength="3" placeholder="这里输入上级频道  跟为0" title="上级频道  跟为0"/></td>
			</tr>
			<tr>
				<td><input type="number" name="C_TYPE" id="C_TYPE" value="${pd.C_TYPE}" maxlength="3" placeholder="这里输入频道类型 1：新闻频道  2：活动频道" title="频道类型 1：新闻频道  2：活动频道"/></td>
			</tr>
			<tr>
				<td><input type="number" name="C_ISWEB" id="C_ISWEB" value="${pd.C_ISWEB}" maxlength="2" placeholder="这里输入是否在web端显示   1:是  -1：否" title="是否在web端显示   1:是  -1：否"/></td>
			</tr>
			<tr>
				<td><input type="number" name="C_ISAPP" id="C_ISAPP" value="${pd.C_ISAPP}" maxlength="2" placeholder="这里输入是否在app端显示   1:是  -1：否" title="是否在app端显示   1:是  -1：否"/></td>
			</tr>
			<tr>
				<td><input type="number" name="C_WEIGHT" id="C_WEIGHT" value="${pd.C_WEIGHT}" maxlength="3" placeholder="这里输入权重   展示在网站或app中 该频道的排序" title="权重   展示在网站或app中 该频道的排序"/></td>
			</tr>
			<tr>
				<td><input type="number" name="C_ISURL" id="C_ISURL" value="${pd.C_ISURL}" maxlength="2" placeholder="这里输入是否是连接  1:是  -1：否" title="是否是连接  1:是  -1：否"/></td>
			</tr>
			<tr>
				<td><input type="text" name="C_URL" id="C_URL" value="${pd.C_URL}"  maxlength="100" placeholder="这里输入链接地址" title="链接地址"/></td>
			</tr>
			<tr>
				<td><input type="text" name="C_DESCRIBE" id="C_DESCRIBE" value="${pd.C_DESCRIBE}" maxlength="50" placeholder="这里输入频道描述" title="频道描述"/></td>
			</tr>
			<tr>
				<td style="text-align: center;">
					<a class="btn btn-mini btn-primary" onclick="save();">保存</a>
					<a class="btn btn-mini btn-danger" onclick="top.Dialog.close();">取消</a>
				</td>
			</tr>
		</table>
		</div>
		
		<div id="zhongxin2" class="center" style="display:none"><br/><br/><br/><br/><br/><img src="images/jiazai.gif" /><br/><h4 class="lighter block green">提交中...</h4></div>
		
	</form>
	
	
		<!-- 引入 -->
		<script type="text/javascript">window.jQuery || document.write("<script src='js/jquery-1.9.1.min.js'>\x3C/script>");</script>
		<script src="js/bootstrap.min.js"></script>
		<script src="js/ace-elements.min.js"></script>
		<script src="js/ace.min.js"></script>
		<script type="text/javascript" src="js/chosen.jquery.min.js"></script><!-- 下拉框 -->
		<script type="text/javascript" src="js/bootstrap-datepicker.min.js"></script><!-- 日期框 -->
		<script type="text/javascript">
		$(window.parent.hangge());
		$(function() {
			
			//单选框
			$(".chzn-select").chosen(); 
			$(".chzn-select-deselect").chosen({allow_single_deselect:true}); 
			
			//日期框
			$('.date-picker').datepicker();
			
		});
		
		</script>
</body>
</html>