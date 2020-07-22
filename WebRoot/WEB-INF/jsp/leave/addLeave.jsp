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
    <title>新增请假记录</title>
    <link rel="stylesheet" href="http://cdn.bootcss.com/bootstrap/3.3.0/css/bootstrap.min.css">
  </head>
  
  <body style="background:#EEEEEE">
    <!-- 头部导航条 -->
 	<%@ include file="/static/common/header.jsp" %>
 	<!-- 左侧导航栏 -->
	<%@ include file="/static/common/left.jsp" %>
	<div id="divDom" style="font-size:17px;width:1200px;height:750px;;position: absolute;top:50px;left:300px;">
  			<h1 style="margin-left:410px;">新增请假记录</h1>
  			<br/>
  			<form>
			  <div class="form-group" style="margin-left:255px;">
			    <label for="exampleInputPassword1">请假员工:</label>
			    <select id="personId" class="form-control" style="width:500px;">
			    	<option value="0">请选择</option>
			    	<c:forEach var="person" items="${requestScope.personList }">
			    			<option value="${person.pId }">${person.pName}</option>
			    	</c:forEach>
			    </select>
			  </div>
			  <div class="form-group" style="margin-left:255px;">
			    <label for="exampleInputEmail1">请假起始日:</label>
			    <input type="text" style="width:500px;" class="form-control" id="leaveStart"  placeholder="leaveStart">
			  </div>
			  <div class="form-group" style="margin-left:255px;">
			    <label for="exampleInputPassword1">请假结束日:</label>
			    <input type="text" style="width:500px;" class="form-control" id="leaveEnd"  placeholder="leaveEnd">
			  </div>
			  <div class="form-group" style="margin-left:255px;">
			    <label for="exampleInputPassword1">请假原因:</label>
			    <select id="leaveType" class="form-control" style="width:500px;">
			    	<option value="0">请选择</option>
			    	<c:forEach var="leaveType" items="${requestScope.leaveType }">
			    		<option value="${leaveType.lId }">${leaveType.lName}</option>
			    	</c:forEach>
			    </select>
			  </div>
			  <br/><br/>
			  <button style="margin-left:400px;" type="button" class="btn btn-primary" id="addLeave" onclick="addLeave()">添加记录</button>
  			  <button style="margin-left:20px;" type="button" class="btn btn-primary" id="clear" >重置</button>
  			  <button style="margin-left:20px;" type="button" class="btn btn-primary" id="back">后退</button>
			</form>
  	</div>
  	<input type="hidden" id="currentPage" value="${currentPage}"/>
	<!-- 底部导航条 -->
	<%@ include file="/static/common/footer.jsp"  %>
   	<script type="text/javascript" src="<%=path %>/static/js/bootstrap.js"></script>
   	<script type="text/javascript">
   	//新增请假记录
   		$("#addLeave").click(function(){
   			//用户输入
   			var pId = $("#personId").val();
   			var leaveStart = $("#leaveStart").val();
   			var leaveEnd = $("#leaveEnd").val();
   			var leaveType = $("#leaveType").val();
   			var $zDate = /^(19[0-9]2|200[0-9]|201[0-9]|2020)-([1-9]|1[0-2])-([1-9]|1[0-9]|2[0-9]|3[0-1])$/;
   			//非空判断
   			if(pId == "0"){
   				alert("请选择请假员工!");
   				return;
   			}
   			if(leaveStart == ""){
   				alert("请假起始日不能为空!");
   				return;
   			}
   			if($zDate.test(leaveStart) == false){
   				alert("请假起始日格式错误!yyyy-MM-dd!");
   				return;
   			}
   			if(leaveEnd == ""){
   				alert("请假结束日不能为空!");
   				return;
   			}
   			if($zDate.test(leaveEnd) == false){
   				alert("请假结束日格式错误!yyyy-MM-dd!");
   				return;
   			}
   			if(leaveType == "0"){
   				alert("请假原因不能为空!");
   				return;
   			}
   			var ise = {
   				"leaveStart":leaveStart,
   				"leaveEnd":leaveEnd,
   				"pId":pId,
   				"leaveType":leaveType
   			}
   			//使用ajax
   			$.ajax({
   				url		:		"<%=path%>/spring/leave/addLeave",
   				method	:		"post",
   				data	:		ise,
   				success	:		function(data){
   					var json = eval('('+data+')');
   					if(json.status == 1){
   						alert(json.message);
   						location.href="<%=path%>/spring/leave/index";
   					}else{
   						alert(json.message);
   						location.href="<%=path%>/spring/leave/index";
   					}
   				}
   			});
   		});
   		//重置按钮
		$("#clear").click(function(){
			location.reload();
		});
		//后退按钮点击事件
   		$("#back").click(function(){
   			history.back();
   		});
   	</script>
  </body>
</html>
