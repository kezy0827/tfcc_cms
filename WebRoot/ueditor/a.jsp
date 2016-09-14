<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="title" content="下载">
<meta name="apple-touch-fullscreen" content="YES">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
<!--解决android平台无法自适应-->
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="format-detection" content="telephone=no">
<!--解决ios对5位数字自动识别和添加样式-->
<meta content="email=no" name="format-detection" />
<!--禁止android识别邮箱-->
<meta name="viewport" content="width=device-width">
<!--设备宽度-->
<title>习近平就尼泊尔地震向尼泊尔总统...</title>
<script type="text/javascript"
src="http://115.28.39.196:8383/resources/js/jquery-1.5.min.js"></script>
<style>
ul {
	margin: 0px;
	padding: 0px;
	list-style: none
}

.fl {
	float: left;
}

.fr {
	float: right;
}

.clear {
	clear: both;
}

#cover {
	position: fixed;
	left: 0px;
	top: 0px;
	z-index: 10;
	width: 100%;
	height: 100%;
	background-color: #000;
	opacity: 0.85;
}

#cover p {
	-webkit-background-clip: text;
	-moz-background-clip: text;
	background-clip: text;
	color: transparent;
	float: right;
	margin-right: 40px;
	margin-top: 40px;
	color: #fff;
	font-size: 16px;
	font-family: " Gabriola;
}

#contentid p {
	text-align: left;
}

</style>
<script type="text/javascript">
	function initpage() {
		var ua = navigator.userAgent.toLowerCase();
		if (ua.match(/MicroMessenger/i) == "micromessenger") {
			$('#cover').show();
			$('#url').val(0);
		} else {
			$('#cover').hide();
			initdownloadbtn();
		}
		pageonload();
	}
	function initdownloadbtn() {
		var platform;
		if (navigator.userAgent.match(/(Android)\s+([\d.]+)/)) {
			platform = 'android';
		}
		if (navigator.userAgent.match(/(.*iPhone.*)|(.*iPad.*)/)) {
			platform = 'ios';
		}
		var appLinks = $('#url');
		var open_appstore_timer;
		if (platform == 'ios') {/*连接到iOS store*/
			aurl = "https://itunes.apple.com/cn/app/donga-dong/id966111488?mt=8";
			appLinks.attr('value', aurl);
		} else if (platform == 'android') {
			appLinks.attr('value',
					'http://115.28.39.196:8383/APP/DAD/dongadong.apk');
		} else {
			appLinks.attr('value', 1);
		}
	}
	function pageonload() {
		setTimeout(scrollTo, 0, 0, 0);/*阻止URL条显示*/
		navigator.standalone = false;/*是否从浏览器直接访问webapp，false为否*/
		var p = getPageSize();
		var hh = p[1];
		var ww = p[0]; /*$('#contentid img').width((ww - 40) + "px");		$('#contentid p').css("margin","10px");				 $('#contentid p').css('text-indent','30px'); */
		$("#contentid p:not(:has(img))").css('text-indent', '30px');
	}
	function clickhide() {
		$('#cover').hide();
	}
	function getPageSize() {
		var windowWidth, windowHeight;
		if (self.innerHeight) {/* all   except   Explorer*/
			windowWidth = self.innerWidth;
			windowHeight = self.innerHeight;
		} else {
			if (document.documentElement
					&& document.documentElement.clientHeight) { /*    Explorer   6   Strict   Mode */
				windowWidth = document.documentElement.clientWidth;
				windowHeight = document.documentElement.clientHeight;
			} else {
				if (document.body) { /*   other   Explorers   */
					windowWidth = document.body.clientWidth;
					windowHeight = document.body.clientHeight;
				}
			}
		}
		return new Array(windowWidth, windowHeight);
	}
	function download() {
		var url = $('#url').val();
		if (url == 0) {
			$('#cover').show();
		} else if (url == 1) {
			alert("暂不支持该系统");
		} else {
			window.location.href = $('#url').val();
		}
	}
</script>
</head>
<body onload="initpage()" style="margin:0px;">
	<section data-role="content">
		<article>
			<aside>
				<div style="background-color: #399;">
					<div class="fl">
						<div
							style="height: 60px; line-height: 60px; vertical-align: middle; color: #fff; font-size: 30px; letter-spacing: 5px; margin-left: 10px; font-weight: bold; font-family: '微软雅黑,宋体'">动a动</div>
						<div
							style="height: 20px; margin-left: 50px; font-size: 12px; color: #fff; letter-spacing: 2px;">您身边的运动管家</div>
					</div>
					<div class="fr"
						style="width: 40px; height: 40px; background: url('share/btn_dw.png'); margin: 20px; line-height: 40px; vertical-align: middle; color: #399; font-size: 12px; font-weight: bold; text-align: center;"
						onclick="download()">下载</div>
					<div class="clear"></div>
				</div>
				<p style="height: 24px;font-weight:bold; line-height: 24px; vertical-align: middle; margin: 30px 20px 10px 20px; font-size: 20px;">习近平就总统致電慰問</p>
				<!-- 18个字加三个省略号 -->
				<div style="letter-spacing: 1px;margin: 10px 10px 10px 10px;">
					<p>央视网消息(新闻联播)：
						本台消息：4月25日，习近平主席就尼泊尔当日发生强烈地震向尼泊尔总统亚达夫致慰问电。慰问电全文如下：</p>
					<p>惊悉贵国发生强烈地震，造成重大人员伤亡和财产损失。我谨代表中国政府和人民，并以我个人的名义，对不幸遇难者表示沉痛的哀悼，对遇难者家属和受伤人员表示诚挚的慰问。</p>
					<p>我相信，在总统先生和尼泊尔政府领导下，尼泊尔人民一定能够共克时艰、战胜灾害。在此危急时刻，中国人民坚定同尼泊尔人民站在一起，中方愿向尼方提供一切必要的救灾援助。</p>
					<p>
						<span style="font-size: 36px; text-decoration: none;"><img
							style="width:100%;" title="???.jpg"
							src="http://115.28.39.196:8787/DADCMS/ueditor/jsp/upload1/20150427/88591430115415818.jpg" /></span>
					</p>
				</div>
				<div
					style="height: 30px; line-height: 30px; vertical-align: middle; text-align: center; font-size: 12px; color: #999;">2015-04-27
					11:57:25&nbsp;&nbsp;&nbsp;&nbsp;来源：习近平就尼泊尔地震向尼泊尔总统致慰问电</div>
				<div align="center" style="padding: 10px 0px;">
					<div
						style="background-color: #399; height: 50px; line-height: 50px; vertical-align: middle; color: #fff; font-weight: bold; letter-spacing: 2px; width: 200px;"
						onclick="download()">免费下载动a动</div>
				</div>
				<div id='cover' onclick="clickhide()" style="display: none;">
					<p>
						请先点击&nbsp;右上角<font style="font-size: 35px;">↗</font><br>猛戳"在浏览器中打开"
					</p>
					<div style="clear: both;"></div>
					<div align="center">
						<img alt="" src="image/help.png"
							style="width: 50%; margin-top: 50px;">
					</div>
				</div>
				<input type="hidden" id="url">
			</aside>
		</article>
	</section>
</body>
</html>