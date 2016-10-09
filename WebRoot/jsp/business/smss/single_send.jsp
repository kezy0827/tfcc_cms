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
		
		<script type="text/javascript" src="js/jquery-1.7.2.js"></script>
		<!--提示框-->
		<script type="text/javascript" src="js/jquery.tips.js"></script>
<script type="text/javascript">
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
		$("#Form").submit();
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
</script>
	</head>
<body>
	<form action="dictionarysms/save.do" name="Form" id="Form" method="post" enctype="multipart/form-data">
		<input type="hidden" name="id" id="id" value="${pd.activity_contestant_id}"/>
		<input type="hidden"  name="activity_id"  id="activity_id"  value="${activity_id}"/>
		<div id="zhongxin">
		<table id="table_report" class="table table-striped table-bordered table-hover">
			<tr>
				<td>
                  <span>短信类型:</span>
                  <select>
                    <option value='通知'>通知</option>
                    <option value='节日祝福'>节日祝福</option>
                    <option value='宣传推广'>宣传推广</option>
                    <option value='其他'>其他</option>
                  </select>
                </td>
            </tr>
             <tr>
                <td><span>标题:</span><input type="type"  name="title"  id="title_id"  value=""/></td>
            </tr>
            <tr>
                <td><span>短信内容:</span><input type="type"  name="content"  id="content_id" style="width:90%;height:100px" value=""/></td>
			</tr>
			<tr>
				
				<td id="nr">
                    <span>内容:</span>
					<textarea  style="width:90%;height:100px" name="ds_content"></textarea>
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