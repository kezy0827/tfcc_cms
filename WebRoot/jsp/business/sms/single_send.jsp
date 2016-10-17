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
        <style type="text/css">
          ul li{
              float: left;
              margin-left: 20px;
              list-style-type:none;
          }
          .right{text-align: right}
          textarea{
            width: 500px;
            height: 200px;
          }
      </style>
	</head>
<body>
<div class="container-fluid" id="main-container">
  <div id="breadcrumbs">
    <ul class="breadcrumb">
        <li><i class="icon-home"></i> <a>短信管理</a><span class="divider"><i class="icon-angle-right"></i></span></li>
        <li class="active">短信发送</li>
    </ul><!--.breadcrumb-->
  
    <div id="nav-search">
    </div><!--#nav-search-->
  
  </div><!--#breadcrumbs-->
  
  <div id="page-content" class="clearfix">
                        
  <div class="row-fluid">
  <form id="form" action="sms/toSingleSend.do" method="POST" name="Form" id="Form">
    <input type="hidden" id="send_type" name="send_type" value="1"/>
    <input type="hidden" id="id" name="id" value="${pd.id }"/>
		<div id="zhongxin">
		<table id="table_report" class="table table-striped table-bordered table-hover">
			<tr>
                <td width="20%"><label class="right">短信类型:</label></td>
				<td>
                  <select class="chzn-select" data-placeholder="请选择" style="vertical-align:top;width: 120px;" name="sms_type" id="sms_type" <c:if test="${not empty pd.id }">disabled="disabled"</c:if>   >              
                    <option value='1' <c:if test="${pd.sms_type==1 }">selected="selected"</c:if>>通知</option>
                    <option value='2' <c:if test="${pd.sms_type==2 }">selected="selected"</c:if>>节日祝福</option>
                    <option value='3' <c:if test="${pd.sms_type==3 }">selected="selected"</c:if>>宣传推广</option>
                    <option value='4' <c:if test="${pd.sms_type==4 }">selected="selected"</c:if>>其他</option>
                  </select>
                  <font color="red" >*</font>
                </td>
            </tr>
            <c:if test="${not empty pd.sms_status }">
              <tr>
                  <td width="20%"><label class="right">短信状态:</label></td>
                  <td>
                    <c:if test="${pd.sms_status==0 }"><font color="red">发送失败</font></c:if>
                    <c:if test="${pd.sms_status==1 }"><font color="green">发送成功</font></c:if>
                    <c:if test="${pd.sms_status==2 }">..正在发送</c:if>
                  </td>
              </tr>
            </c:if>
             <tr>
                <td ><label class="right">短信标题:</label></td>
                <td><input type="type"  name="title"  id="title"  value="${pd.title }" <c:if test="${not empty pd.id }">disabled="disabled"</c:if> maxlength="20"/><font color="red" >*</font></td>
            </tr>
            <tr>
                <td ><label class="right">短信内容:</label></td>
                <td>
                    <textarea name="content"  id="content" <c:if test="${not empty pd.id and pd.sms_status!=0}">disabled="disabled"</c:if> maxlength="200">${pd.content }</textarea><font color="red" >*</font>&nbsp;&nbsp;&nbsp;&nbsp;
                    <c:if test="${empty pd.id or pd.sms_status==0 }"><input type="button" onclick="sendSms(this)" class="btn btn-primary" value="发送"></input></c:if>
                </td>
			</tr>
			<%-- <tr>
                <td ><label class="right">发送范围:</label></td>
				<td>
					<ul class="radio">
                        <li><label><input type="radio" name="user_type" id="single" checked="checked"/><span class="lbl">&nbsp;单个发送</span></label></li>
                        <li><label><input type="radio" name="user_type" class="serach" id="all" value="" <c:if test="${pd.user_type=='' }">checked="checked"</c:if>/><span class="lbl">&nbsp;全部</span></label></li>
                        <li><label><input type="radio" name="user_type" class="serach" id="general"  value="1" <c:if test="${pd.user_type=='1' }">checked="checked"</c:if>/><span class="lbl">&nbsp;普通会员</span></label></li>
                        <li><label><input type="radio" name="user_type" class="serach" id="invest" value="4" <c:if test="${pd.user_type=='4' }">checked="checked"</c:if>/><span class="lbl">&nbsp;投资公司</span></label></li>
                        
                    </ul>
				</td>
			</tr> --%>
			<tr id="phoneDisplay" >
                <td ><label class="right">手机号:</label><label class="right"><font color="red" >（多个手机号，中间请用英文逗号隔开）</font></label></td>
				<td>
					<textarea rows="5" cols="250" name="phone" id="phone" <c:if test="${not empty pd.id and pd.sms_status!=0}">disabled="disabled"</c:if>>${pd.phone }</textarea><font color="red" >*</font>
				</td>
			</tr>
		</table>
       <c:if test="${empty pd.sms_status or pd.sms_status == '0'}">
        <div class="row-fluid" id="vipDisplay" >
            <table id="table_report" class="table table-striped table-bordered table-hover">
                <thead>
                    <tr>
                        <th class="center">
                        <label><input type="checkbox" id="zcheckbox" /><span class="lbl"></span></label>
                        </th>
                        <th>序号</th>
                        <th>会员类型</th>
                        <th>手机号</th>
                        <th>会员名称</th>
                        <th>身份证号</th>
                        <th><i class="icon-time hidden-phone"></i>注册时间</th>
                        <th><i class="icon-time hidden-phone"></i>推介人手机号</th>
                        <th><i class="icon-time hidden-phone"></i>推介人姓名</th>
                    </tr>
                </thead>
                <tbody id="tbody">
                <!-- 开始循环 -->   
                <c:choose>
                    <c:when test="${not empty varList}">
                        <c:if test="${QX.cha == 1 }">
                        <c:forEach items="${varList}" var="var" varStatus="vs">
                            <tr>
                               <td class='center' style="width: 30px;">
                                    <label><input type='checkbox' name='ids' value="${var.phone }"/><span class="lbl"></span></label>
                                </td>
                                <td class='center' style="width: 30px;">${vs.index+1}</td>
                                <td><c:if test="${var.user_type == 1}">普通会员</c:if><c:if test="${var.user_type == 4}">投资机构</c:if> </td>
                                <td>${var.phone }</td>
                                <td>${var.real_name}</td>
                                <td>${var.idno}</td>
                                <td>${var.create_time}</td>
                                <td>${var.ref_phone}</td>
                                <td>${var.ref_real_name}</td>
                            </tr>
                        </c:forEach>
                        </c:if>
                        <c:if test="${QX.cha == 0 }">
                            <tr>
                                <td colspan="100" class="center">您无权查看</td>
                            </tr>
                        </c:if>
                    </c:when>
                    <c:otherwise>
                        <tr class="main_info">
                            <td colspan="100" class="center" >没有相关数据</td>
                        </tr>
                    </c:otherwise>
                </c:choose>
                </tbody>
            </table>
            <div class="page-header position-relative"> 
              <table style="width:100%;">
                  <tr>
                      <td style="vertical-align:top;">
                         <%--  <c:if test="${QX.add == 1 }">
                          <a class="btn btn-small btn-success" onclick="add();">新增</a>
                          </c:if>
                          <c:if test="${QX.del == 1 }">
                          <a class="btn btn-small btn-danger" onclick="makeAll('确定要删除选中的数据吗?');" title="批量删除" ><i class='icon-trash'></i></a>
                          </c:if> --%>
                      </td>
                      <td style="vertical-align:top;"><div class="pagination" style="float: right;padding-top: 0px;margin-top: 0px;">${page.pageStr}</div></td>
                  </tr>
              </table>
              </div>
            <!-- <div id="pageDisplay"></div> -->
        </div>
        </c:if>
        </form>
        </div>
		<div id="zhongxin2" class="center" style="display:none"><br/><br/><br/><br/><br/><img src="images/jiazai.gif" /><br/><h4 class="lighter block green">提交中...</h4></div>
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
		<script type="text/javascript" src="js/chosen.jquery.min.js"></script><!-- 单选框 -->
		<script type="text/javascript" src="js/bootstrap-datepicker.min.js"></script><!-- 日期框 -->
       <script type="text/javascript" src="js/bootbox.min.js"></script><!-- 确认窗口 -->
		
		<script type="text/javascript">
    		$(window.parent.hangge());
    		$(function() {
    			//日期框
    			$('.date-picker').datepicker();
    			
                //下拉框
                $(".chzn-select").chosen(); 
                $(".chzn-select-deselect").chosen({allow_single_deselect:true}); 
                
                //复选框
                $('table th input:checkbox').on('click' , function(){
                    var that = this;
                    $(this).closest('table').find('tr > td:first-child input:checkbox')
                    .each(function(){
                        this.checked = that.checked;
                        $(this).closest('tr').toggleClass('selected');
                    });
                        
                });
                
            });
		</script>
        <script type="text/javascript">
            //保存
            function sendSms(obj){
             if($.trim($("#sms_type").val())==""){
                    $("#sms_type").tips({
                        side:3,
                        msg:'请输入短信类型',
                        bg:'#AE81FF',
                        time:2
                    });
                    $("#sms_type").focus();
                    return false;
                }
            
                if($.trim($("#title").val())==""){
                    
                    $("#title").tips({
                        side:3,
                        msg:'请输入标题',
                        bg:'#AE81FF',
                        time:2
                    });
                    
                    $("#title").focus();
                    return false;
                }
                if($.trim($("#content").val())==""){
                    
                    $("#content").tips({
                        side:3,
                        msg:'请输入内容',
                        bg:'#AE81FF',
                        time:2
                    });
                    $("#content").focus();
                    return false;
                }
                
                if($.trim($("#phone").val())==""){
                    
                    $("#phone").tips({
                        side:3,
                        msg:'请输入电话号',
                        bg:'#AE81FF',
                        time:2
                    });
                    $("#phone").focus();
                    return false;
                }
                var reg = /^(1\d{10}(,)?)+$/;
                if(!reg.test($("#phone").val())){
                     $("#phone").tips({
                         side:3,
                         msg:'电话号输入格式有误！',
                         bg:'#AE81FF',
                         time:2
                     });
                     $("#content").focus();
                     return false;
                }
                var click = $(obj).attr("click");
                $(obj).removeAttr("click");
                var sms_type = $.trim($("#sms_type").val());
                var title = $.trim($("#title").val());
                var content = $.trim($("#content").val());
                var phone = $.trim($("#phone").val());
                var id=$("#id").val();
                var url = "sms/sendSms.do";
                var data = {smsType:sms_type,title:title,content:content,phone:phone,id:id};
                $("#zhongxin").hide();
                $("#zhongxin2").show();
                $.post(url,data,function(data){
                	$("#zhongxin").show();
                    $("#zhongxin2").hide();
              		alert(data.message);
              		if(data.success){
              			window.location.reload();
              		}else{
              			$(obj).attr("click",click);
              		}
                });
               
                //$("#zhongxin").hide();
                //$("#zhongxin2").show();
            }
           /*  var showcnt =10; //每页页数初始值
            var currentPage = 1;
            $(".radio li input[type='radio']").each(function(){
            	$(this).on("click",function(){
                    if($(this).attr("id")=="single"){
                          $("#vipDisplay").hide();
                    }else{
                    	$("#vipDisplay").show();
                        $("#form").submit();
//                         reload_table(currentPage,showcnt);
                    }
                });
            }); */
            $("input[name='ids']").each(function(){
            	$(this).on("click",function(){
            		var phone = $("#phone").text();
            		if($(this).attr("checked")){
            			phone += $.trim($(this).val())+",";
            			$("#phone").text(phone);
            		}else{
            			phone = phone.replace($(this).val()+",","");  
            			$("#phone").text(phone);
            		}
            	});
            	
            });
                $("#zcheckbox").on("click",function(){
                	var phone = "";
                    if($(this).attr("checked")){
                    	$("input[name='ids']").each(function(){
                              phone += $.trim($(this).val())+",";
                              $("#phone").text(phone);
                        });
                    }else{
                        $("#phone").text('');
                    }
                });
            /* function reload_table(currentPage,showCount){
            	var url = "sms/listPageVip.do";
            	$.get(url,{'user_type':user_type},function(data){
            		$("#tbody").html("");
            		var list = data.data.list;
            		if(list!=null&&list.length!=0){
            			var str = "";
            			for(var i=0;i<list.length;i++){
            				str += '<tr>'+
            				'<td class="center" style="width: 30px;">'+
                            '<label><input type="checkbox" name="ids" value="'+list[i].phone+'" /><span class="lbl"></span></label>'+
                            '</td>'+
                            '<td class="center" style="width: 30px;">'+(i+1)+'</td>'+
                            '<td>'+(list[i].user_type=="1"?"普通会员":list[i].user_type=="4"?"投资机构":"其他")+'</td>'+
                            '<td>'+list[i].phone+'</td>'+
                            '<td>'+list[i].real_name+'</td>'+
                            '<td>'+list[i].idno+'</td>'+
                            '<td>'+list[i].create_time+'</td>'+
                            '<td>'+list[i].ref_phone+'</td>'+
                            '<td>'+list[i].ref_real_name+'</td>'+
                            '</tr>';
            			}
            			var pageStr = '<div class="page-header position-relative">'+   
                              		        '<table style="width:100%;">'+   
                                                '<tr>'+   
                                                    '<td style="vertical-align:top;"><div class="pagination" style="float: right;padding-top: 0px;margin-top: 0px;">'+data.data.ajaxPage.pageStr+'</div></td>'+   
                                                '</tr>'+   
                                            '</table>'+   
                                      '</div>';
            			$("#tbody").html(str);
            			$("#pageDisplay").html(pageStr);
            		}else{
            			str =   '<tr class="main_info">'+
            			           '<td colspan="100" class="center" >没有相关数据</td>'+
                    			'</tr>';
            			$("#tbody").html(str);
            		}
            	});
            } */
        </script>
	
</body>
</html>