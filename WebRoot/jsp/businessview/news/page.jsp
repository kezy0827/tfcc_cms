<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'MyJsp.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

  </head>
  
  <body>
	<ul>
		<li><a>共<font color=red>20</font>条</a></li>
		<li><input type="number" value="" id="toGoPage" style="width:50px;text-align:center;float:left" placeholder="页码" /></li>
		<li style="cursor:pointer;"><a onclick="toTZ();" class="btn btn-mini btn-success">跳转</a></li>
		<li><a>首页</a></li>
		<li><a>上页</a></li>
		<li><a><font color='#808080'>1</font></a></li>
		<li style="cursor:pointer;"><a onclick="nextPage(2)">2</a></li>
		<li style="cursor:pointer;"><a onclick="nextPage(2)">下页</a></li>
		<li style="cursor:pointer;"><a onclick="nextPage(2)">尾页</a></li>
		<li><a>第1页</a></li>
		<li><a>共2页</a></li>
		<li>
			<select title='显示条数' style="width:55px;float:left;" onchange="changeCount(this.value)">
				<option value='10'>10</option>
				<option value='10'>10</option>
				<option value='20'>20</option>
				<option value='30'>30</option>
				<option value='40'>40</option>
				<option value='50'>50</option>
				<option value='60'>60</option>
				<option value='70'>70</option>
				<option value='80'>80</option>
				<option value='90'>90</option>
				<option value='99'>99</option>
			</select>
		</li>
	</ul>
	<script type="text/javascript">
		function nextPage(page) {
			window.parent.jzts();
			if (true && document.forms[0]) {
				var url = document.forms[0].getAttribute("action");
				if (url.indexOf('?') > -1) {
					url += "&currentPage=";
				} else {
					url += "?currentPage=";
				}
				url = url + page + "&showCount=10";
				document.forms[0].action = url;
				document.forms[0].submit();
			} else {
				var url = document.location + '';
				if (url.indexOf('?') > -1) {
					if (url.indexOf('currentPage') > -1) {
						var reg = /currentPage=\d*/g;
						url = url.replace(reg, 'currentPage=');
					} else {
						url += "&currentPage=";
					}
				} else {
					url += "?currentPage=";
				}
				url = url + page + "&showCount=10";
				document.location = url;
			}
		}
		function changeCount(value) {
			window.parent.jzts();
			if (true && document.forms[0]) {
				var url = document.forms[0].getAttribute("action");
				if (url.indexOf('?') > -1) {
					url += "&currentPage=";
				} else {
					url += "?currentPage=";
				}
				url = url + "1&showCount=" + value;
				document.forms[0].action = url;
				document.forms[0].submit();
			} else {
				var url = document.location + '';
				if (url.indexOf('?') > -1) {
					if (url.indexOf('currentPage') > -1) {
						var reg = /currentPage=\d*/g;
						url = url.replace(reg, 'currentPage=');
					} else {
						url += "1&currentPage=";
					}
				} else {
					url += "?currentPage=";
				}
				url = url + "&showCount=" + value;
				document.location = url;
			}
		}
		function toTZ() {
			var toPaggeVlue = document.getElementById("toGoPage").value;
			if (toPaggeVlue == '') {
				document.getElementById("toGoPage").value = 1;
				return;
			}
			if (isNaN(Number(toPaggeVlue))) {
				document.getElementById("toGoPage").value = 1;
				return;
			}
			nextPage(toPaggeVlue);
		}
	</script>
</body>
</html>
