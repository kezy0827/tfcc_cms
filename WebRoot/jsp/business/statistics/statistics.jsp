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
		<li><i class="icon-home"></i> <a>网站统计</a><span class="divider"><i class="icon-angle-right"></i></span></li>
		<li class="active"><a>网站统计</a><span class="divider"></span></li>
	</ul><!--.breadcrumb-->
        <div class="row-fluid">
    <div class="span4">
        <div class="widget-box pricing-box">
            <div class="widget-header header-color-dark">
                <h5 class="bigger lighter">会员信息</h5>
            </div>
            <div class="widget-body">
                <div class="widget-main">
                    <ul class="unstyled spaced2">
                        <li><i class="icon-ok green"></i> 注册总人数 ：${registerNum.totalNum }</li>
                        <li><i class="icon-ok green"></i> 今日新增 :${registerNum.todayNum }</li>
                    </ul>
                    <hr />
                </div>
            </div>
        </div>
    </div>
    <div class="span4">
        <div class="widget-box pricing-box">
            <div class="widget-header header-color-orange">
                <h5 class="bigger lighter">购买SAN</h5>
            </div>
            <div class="widget-body">
                <div class="widget-main">
                    <ul class="unstyled spaced2">
                        <li><i class="icon-ok green"></i> 今日购买量 :${buySAN.todayBuyNum }</li>
                        <li><i class="icon-ok green"></i> 今日订单数 :${buySAN.todayOrderNum }</li>
                        <li><i class="icon-ok green"></i> 累计购买量 :${buySAN.BuyNum }</li>
                        <li><i class="icon-ok green"></i> 累计订单数 :${buySAN.orderNum }</li>
                    </ul>
                    <hr />
                </div>
            </div>
        </div>
    </div>
    <div class="span4">
        <div class="widget-box pricing-box">
            <div class="widget-header header-color-blue">
                <h5 class="bigger lighter">转账SAN</h5>
            </div>
            <div class="widget-body">
                <div class="widget-main">
                    <ul class="unstyled spaced2">
                        <li><i class="icon-ok green"></i> 今日转出 ：${zZSAN.todayOutAmnt }</li>
                        <li><i class="icon-ok green"></i> 累计转出 ：${zZSAN.outAmnt }</li>
                        <li><i class="icon-ok green"></i> 已冻结：${zZSAN.frozeAmnt } </li>
                    </ul>
                    <hr />
                </div>
            </div>
        </div>
    </div>
    
</div>
 <div class="row-fluid">
    <div class="span4">
        <div class="widget-box pricing-box">
            <div class="widget-header header-color-green">
                <h5 class="bigger lighter">奖励</h5>
            </div>
            <div class="widget-body">
                <div class="widget-main">
                    <ul class="unstyled spaced2">
                        <li><i class="icon-ok green"></i> 今日发放 :${reward.todayReward }</li>
                        <li><i class="icon-ok green"></i> 累计发放 :${reward.totalReward } </li>
                    </ul>
                    <hr />
                </div>
            </div>
        </div>
    </div>
    <div class="span4">
        <div class="widget-box pricing-box">
            <div class="widget-header header-color-pink">
                <h5 class="bigger lighter">SAN额度</h5>
            </div>
            <div class="widget-body">
                <div class="widget-main">
                    <ul class="unstyled spaced2">
                        <li><i class="icon-ok green"></i> 系统发行总量 :${sysSAN.credit_limit }</li>
                        <li><i class="icon-ok green"></i> 当前会员账户总额 :${sysSAN.total_amnt }</li>
                    </ul>
                    <hr />
                </div>
            </div>
        </div>
    </div>
    </div>
	</div><!--#breadcrumbs-->

<div id="page-content" class="clearfix">
						
  <div class="row-fluid">

	<div class="row-fluid">
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
		<script type="text/javascript">
		  $(window.parent.hangge());
		</script>
	</body>
</html>

