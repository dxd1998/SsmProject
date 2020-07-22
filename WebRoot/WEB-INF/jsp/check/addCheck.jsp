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
    <title>新增考勤记录</title>
     <link rel="stylesheet" href="http://cdn.bootcss.com/bootstrap/3.3.0/css/bootstrap.min.css">
  </head>
  
  <body>
  	<!-- 头部导航条 -->
 	<%@ include file="/static/common/header.jsp" %>
 	<!-- 左侧导航栏 -->
	<%@ include file="/static/common/left.jsp" %>
	<div id="divDom" style="font-size:17px;width:1200px;height:750px;;position: absolute;top:50px;left:300px;">
  			<h1 style="margin-left:410px;">新增考勤记录</h1>
  			<br/>
  			<form>
			  <div class="form-group" style="margin-left:255px;">
			    <label for="exampleInputPassword1">考勤员工:</label>
			    <select id="personId" class="form-control" style="width:500px;">
			    	<option value="0">请选择</option>
			    	<c:forEach var="person" items="${requestScope.personList }">
			    			<option value="${person.pId }">${person.pName}</option>
			    	</c:forEach>
			    </select>
			  </div>
			  <div class="form-group" style="margin-left:255px;">
			    <label for="exampleInputEmail1">考勤日期:</label>
			    <input type="text" style="width:500px;" class="form-control" id="checkDate"  placeholder="checkDate">
			  </div>
			  <div class="form-group" style="margin-left:255px;">
			    <label for="exampleInputPassword1">考勤状态:</label>
			    <select id="checkType" class="form-control" style="width:500px;">
			    	<option value="0">请选择</option>
			    	<c:forEach var="check" items="${requestScope.checkList }">
			    		<option value="${check.cId }">${check.cName}</option>
			    	</c:forEach>
			    </select>
			  </div>
			  <br/><br/>
			  <button style="margin-left:400px;" type="button" class="btn btn-primary" id="addcheck" onclick="addCheck()">添加记录</button>
  			  <button style="margin-left:20px;" type="button" class="btn btn-primary" id="clear" >重置</button>
  			  <button style="margin-left:20px;" type="button" class="btn btn-primary" id="back">后退</button>
			</form>
  	</div>
	<!-- 底部导航条 -->
	<%@ include file="/static/common/footer.jsp"  %>
   	<script type="text/javascript" src="<%=path %>/static/js/bootstrap.js"></script>
   	<script type="text/javascript">
   		
   		//保存记录事件
   		function addCheck(){
   			//用户输入的值
   			var pId = $("#personId").val();
   			var checkDate = $("#checkDate").val();
   			var checkType = $("#checkType").val();
   			var $zDate = /^(19[0-9]2|200[0-9]|201[0-9]|2020)-([1-9]|1[0-2])-([1-9]|1[0-9]|2[0-9]|3[0-1])$/;
   			//非空判断
   			if(pId == ""){
   				alert("考勤员工不能为空!");
   				return;
   			}
   			if(checkDate == ""){
   				alert("考勤日期不能为空!");
   				return;
   			}
   			if($zDate.test(checkDate) == false){
   				alert("考勤日期格式错误!yyyy-MM-dd!");
   				return;
   			}
   			if(checkType == "0"){
   				alert("考勤状态不能为空!");
   				return;
   			}
   			var ise = {
   				"pId":pId,
   				"checkDate":checkDate,
   				"checkType":checkType
   			}
   			//ajax
   			$.ajax({
   				url		:		"<%=path%>/spring/check/Add",
   				method	:		"post",
   				data	:		ise,
   				success	:		function(data){
   					var json = eval('('+data+')');
   					if(json.status == 1){
   						alert(json.message);
   						location.href="<%=path%>/spring/check/index";
   					}else{
   						alert(json.message);
   						location.href="<%=path%>/spring/check/index";
   					}
   				}
   			});
   		}
   	
   	</script>
  </body>
</html>
