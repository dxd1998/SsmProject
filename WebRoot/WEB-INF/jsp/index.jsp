<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    <title>员工管理系统</title>
    <link rel="stylesheet" href="http://cdn.bootcss.com/bootstrap/3.3.0/css/bootstrap.min.css">
  	<style type="text/css">
  		#divDom li{
  			list-style-type: none;
  			display: inline-block;
  		}
  		h2{
  			display: inline-block;
  		}
  	</style>
  </head>
  
  <body style="background:#EEEEEE;height:1000px;">
  	<!-- 头部导航条 -->
  	<%@ include file="/static/common/header.jsp" %>
  	<!-- 左侧导航栏 -->
	<%@ include file="/static/common/left.jsp" %>
	<!-- 快捷标签 -->	
	<div id="divDom" style="position: absolute;left:350px; top:70px;display:inline-block;">
		<button type="button" class="btn btn-info" id="updateLabel">修改快捷标签</button><br/>
		<h2><span class="label label-success">快捷标签:</span></h2>
		&nbsp;&nbsp;&nbsp;&nbsp;
		<c:forEach var="label" items="${sessionScope.labelList}" varStatus="status">
			<!-- 记录所有已存标签 -->
			<input type="hidden" name="labelId" value="${label.powerId }"/>
			<span class="label" style="font-size:16px;">${label.powerName}</span>
			<c:if test="${(status.index+1)%4 == 0 }">
				<br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			</c:if>
		</c:forEach>
	</div>
	<div id="divDom2" style="display:none;position: absolute;left:900px;top:80px;">
			<h4><span class="label label-success">拥有的权限:</span></h4>
			<c:forEach var="power1" items="${sessionScope.loginUser.powerList }" varStatus="status">
	   			<c:forEach var="power2" items="${power1.childPower }">
	   				<label class="checkbox-inline" style="display:inline-block;">
 						<input type="checkbox" name="power1" value="${power2.powerId}"/>${power2.powerDesc}
 					</label>
	   			</c:forEach>
	   		</c:forEach><br/>
	   		<button type="button" class="btn btn-warning" style="margin-left:450px;" id="saveUpdate">修改</button>
	</div>
	<br/><br/><br/>
	<!-- 轮播图 -->
	<div id="carousel-example-generic" class="carousel slide"
		data-ride="carousel" style="height:620px;width:1100px;position: absolute;
		left:350px;top:200px;">
		<!-- Indicators -->
		<ol class="carousel-indicators">
			<li data-target="#carousel-example-generic" data-slide-to="0"
				class="active"></li>
			<li data-target="#carousel-example-generic" data-slide-to="1"></li>
			<li data-target="#carousel-example-generic" data-slide-to="2"></li>
		</ol>
		<!-- Wrapper for slides -->
		<div class="carousel-inner" role="listbox">
			<div class="item active">
				<img src="<%=path %>/static/img/2000972.jpg" alt="...">
			</div>
			<div class="item">
				<img src="<%=path %>/static/img/wallpaper.png" alt="...">
			</div>
			<div class="item">
				<img src="<%=path %>/static/img/plief.jpg" alt="...">
			</div>
		</div>
		<!-- Controls -->
		<a class="left carousel-control" href="#carousel-example-generic"
			role="button" data-slide="prev"> <span
			class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span> <span
			class="sr-only">Previous</span>
		</a> <a class="right carousel-control" href="#carousel-example-generic"
			role="button" data-slide="next"> <span
			class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
			<span class="sr-only">Next</span>
		</a>
	</div>


	<!-- 底部导航条 -->
	<%@ include file="/static/common/footer.jsp"  %>
    <script type="text/javascript" src="<%=path %>/static/js/bootstrap.js"></script>
    <script type="text/javascript">
    //显示标签修改
    	$("#updateLabel").click(function(){
    		$("#divDom2").toggle("slow");
    	});
    	//获得所有标签
    	var labelDom = $("input:hidden[name='labelId']");
    	var array = new Array();
    	//遍历标签
    	$.each(labelDom,function(j,label){
    		array.push($(label).val());
    	});
    	//回显至多选按钮
    	var checkBoxAll = $("input:checkbox[name='power1']");
    	$.each(checkBoxAll,function(j,checkbox){
    		//循环数组
    		for(var i=0;i<array.length;i++){
    			var checkboxValue = $(checkbox).val();
    			if(array[i] == checkboxValue){
    				$(checkbox).attr("checked",true);
    			}
    		}
    	});
    	//保存修改按钮
    	$("#saveUpdate").click(function(){
    		//获得当前登录名和密码
    		var pLoginName = '${sessionScope.loginUser.pLoginName}';
    		var pPassword  = '${sessionScope.loginUser.pPassword}';
    		var pId = '${sessionScope.loginUser.pId}';
    		var checkBoxAll = $("input:checkbox[name='power1']:checked");
    		var array1 = new Array();
    		$.each(checkBoxAll,function(j,checkbox){
	    		array1.push($(checkbox).val());
    		});
    		//使用ajax
    		$.ajax({
    			url			:		"<%=path%>/spring/label/saveLabel",
    			method		:		"post",
    			traditional	:		true,
    			data		:		{"labels":array1,"pId":pId},
    			success		:		function(data){
    				var json = eval('('+data+')');
    				if(json.status == 1){
    					alert(json.message);
    					//重新加载
    					location.href="<%=path%>/spring/login/checkLogin?pLoginName="+pLoginName+"&pPassword="+pPassword+"&flag=1";
    				}else{
    					alert(json.message);
    				}
    			}
    		});
    	});
    	
    </script>
  </body>
  
</html>
