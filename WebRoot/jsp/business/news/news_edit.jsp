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
			if($("#N_TITLE").val()==""){
			$("#N_TITLE").tips({
				side:3,
	            msg:'请输入新闻标题',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#N_TITLE").focus();
			return false;
		}
		if($("#N_INTRO").val()==""){
			$("#N_INTRO").tips({
				side:3,
	            msg:'请输入新闻简介',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#N_INTRO").focus();
			return false;
		}
		if($("#N_ANTISTOP").val()==""){
			$("#N_ANTISTOP").tips({
				side:3,
	            msg:'请输入关键词',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#N_ANTISTOP").focus();
			return false;
		}
		if($("#N_SOURCE").val()==""){
			$("#N_SOURCE").tips({
				side:3,
	            msg:'请输入新闻来源',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#N_SOURCE").focus();
			return false;
		}
		if($("#N_SOURCE_URL").val()==""){
			$("#N_SOURCE_URL").tips({
				side:3,
	            msg:'请输入来源链接',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#N_SOURCE_URL").focus();
			return false;
		}
		if($("#N_CAROUSEL").val()==""){
			$("#N_CAROUSEL").tips({
				side:3,
	            msg:'请输入是否轮播',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#N_CAROUSEL").focus();
			return false;
		}
		if($("#N_TOP").val()==""){
			$("#N_TOP").tips({
				side:3,
	            msg:'请输入是否置顶',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#N_TOP").focus();
			return false;
		}
		if($("#N_EXAMINE_STATUS").val()==""){
			$("#N_EXAMINE_STATUS").tips({
				side:3,
	            msg:'请输入审核状态',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#N_EXAMINE_STATUS").focus();
			return false;
		}
		if($("#CHANNEL_ID").val()==""){
			$("#CHANNEL_ID").tips({
				side:3,
	            msg:'请输入频道id',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#CHANNEL_ID").focus();
			return false;
		}
		if($("#SUBTITLE").val()==""){
			$("#SUBTITLE").tips({
				side:3,
	            msg:'请输入内部标题',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#SUBTITLE").focus();
			return false;
		}
		if($("#N_READ_NUMBER").val()==""){
			$("#N_READ_NUMBER").tips({
				side:3,
	            msg:'请输入阅读数',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#N_READ_NUMBER").focus();
			return false;
		}
		if($("#N_COLLECT_NUMBER").val()==""){
			$("#N_COLLECT_NUMBER").tips({
				side:3,
	            msg:'请输入收藏数',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#N_COLLECT_NUMBER").focus();
			return false;
		}
		$("#Form").submit();
		$("#zhongxin").hide();
		$("#zhongxin2").show();
	}
	
</script>
	</head>
<body>
	<form action="news/${msg }.do" name="Form" id="Form" method="post">
		<input type="hidden" name="NEWS_ID" id="NEWS_ID" value="${pd.NEWS_ID}"/>
		<div id="zhongxin">
		<table>
			<tr>
				<td><input type="text" name="N_TITLE" id="N_TITLE" value="${pd.N_TITLE}" maxlength="32" placeholder="这里输入新闻标题" title="新闻标题"/></td>
			</tr>
			<tr>
				<td><input type="text" name="N_INTRO" id="N_INTRO" value="${pd.N_INTRO}" maxlength="32" placeholder="这里输入新闻简介" title="新闻简介"/></td>
			</tr>
			<tr>
				<td><input type="text" name="N_ANTISTOP" id="N_ANTISTOP" value="${pd.N_ANTISTOP}" maxlength="32" placeholder="这里输入关键词" title="关键词"/></td>
			</tr>
			<tr>
				<td><input type="text" name="N_SOURCE" id="N_SOURCE" value="${pd.N_SOURCE}" maxlength="32" placeholder="这里输入新闻来源" title="新闻来源"/></td>
			</tr>
			<tr>
				<td><input type="text" name="N_SOURCE_URL" id="N_SOURCE_URL" value="${pd.N_SOURCE_URL}" maxlength="32" placeholder="这里输入来源链接" title="来源链接"/></td>
			</tr>
			<tr>
				<td><input type="number" name="N_CAROUSEL" id="N_CAROUSEL" value="${pd.N_CAROUSEL}" maxlength="32" placeholder="这里输入是否轮播" title="是否轮播"/></td>
			</tr>
			<tr>
				<td><input type="number" name="N_TOP" id="N_TOP" value="${pd.N_TOP}" maxlength="32" placeholder="这里输入是否置顶" title="是否置顶"/></td>
			</tr>
			<tr>
				<td><input type="number" name="N_EXAMINE_STATUS" id="N_EXAMINE_STATUS" value="${pd.N_EXAMINE_STATUS}" maxlength="32" placeholder="这里输入审核状态" title="审核状态"/></td>
			</tr>
			<tr>
				<td><input type="number" name="CHANNEL_ID" id="CHANNEL_ID" value="${pd.CHANNEL_ID}" maxlength="32" placeholder="这里输入频道id" title="频道id"/></td>
			</tr>
			<tr>
				<td><input type="text" name="SUBTITLE" id="SUBTITLE" value="${pd.SUBTITLE}" maxlength="32" placeholder="这里输入内部标题" title="内部标题"/></td>
			</tr>
			<tr>
				<td><input type="number" name="N_READ_NUMBER" id="N_READ_NUMBER" value="${pd.N_READ_NUMBER}" maxlength="32" placeholder="这里输入阅读数" title="阅读数"/></td>
			</tr>
			<tr>
				<td><input type="number" name="N_COLLECT_NUMBER" id="N_COLLECT_NUMBER" value="${pd.N_COLLECT_NUMBER}" maxlength="32" placeholder="这里输入收藏数" title="收藏数"/></td>
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