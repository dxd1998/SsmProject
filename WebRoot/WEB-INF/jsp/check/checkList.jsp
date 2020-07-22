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
    <title>考勤记录</title>
    <link rel="stylesheet" href="http://cdn.bootcss.com/bootstrap/3.3.0/css/bootstrap.min.css">
  	<style type="text/css">
		table tr:first-child {
			font-weight:bolder;
		}
  	</style>
  </head>
  
  <body style="background:#EEEEEE">
  		<!-- 头部导航条 -->
	  	<%@ include file="/static/common/header.jsp" %>
	  	<!-- 左侧导航栏 -->
		<%@ include file="/static/common/left.jsp" %>
		<div id="divDom" style="width:1300px;height:750px;
			position: absolute;left:260px;top:80px;">
			<form class="form-inline" style="margin-left:300px;">
			  <div class="form-group">
			    <label for="exampleInputName2">考勤员工:</label>
			    <input type="text" class="form-control" id="pName" placeholder="${pName == null || pName == '' ? 'Name' : pName }">
			  </div>
			   <div class="form-group">
			    <label for="exampleInputEmail2">考勤类型:</label>
			    <select id="cId" class="form-control" style="width:200px;display:inline-block;">
	  				<option value="">Choose</option>
	  				<c:forEach var="type" items="${requestScope.typeList }">
	  					<option value="${type.cId}">${type.cName }</option>
	  				</c:forEach>
	  			</select>
			  </div>
			  &nbsp;&nbsp;&nbsp;&nbsp;
			  <button type="button" class="btn btn-default" id="select">查询</button>
			</form>
			<table class="table table-striped">
				<tr>
					<td>记录编号</td>
					<td>考勤员工</td>
					<td>考勤状态</td>
					<td>考勤日期</td>
					<td>操作</td>
				</tr>
				<c:forEach var="check" items="${requestScope.checkList }">
					<tr>
						<td>${check.checkId}</td>
						<td>${check.person.pName}</td>
						<td>${check.check.cName}</td>
						<td>${check.checkDate}</td>
						<td>
							<div class="btn-group">
							  <button type="button" class="btn btn-primary dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
							    可选操作 <span class="caret"></span>
							  </button>
							  	<ul class="dropdown-menu" aria-labelledby="dropdownMenu1">
							    	<li>
							    		<a href="javascript:void(0)" onclick="isDel('${check.checkId}')">删除记录</a>
							    	</li>
							  	</ul>
							</div>
						</td>
					</tr>
				</c:forEach>
			</table>
			<!-- 分页按钮 -->
			<nav aria-label="...">
			  <ul class="pager">
			  	<!-- 判断 -->
			  	<c:choose>
			  		<c:when test="${pager.currentPage > 1 }">
			  			<li class="previous"><a href="<%=path%>/${requestScope.pager.url}?currentPage=${requestScope.pager.currentPage-1}"><span aria-hidden="true">&larr;</span> 上一页</a></li>
			  		</c:when>
			  		<c:otherwise>
			  		</c:otherwise>
			  	</c:choose>
			  	<div style="position: absolute;left:500px;
			  		bottom:20px; font-size:16px;font-weight:bold;">
			  		共有${pager.rowCount}条数据
			  		页数:${pager.currentPage}/${pager.pageCount}
			  	</div>
			  	<c:choose>
			  		<c:when test="${pager.currentPage < pager.pageCount }">
			  			<li class="next"><a href="<%=path%>/${requestScope.pager.url}?currentPage=${requestScope.pager.currentPage+1}">下一页 <span aria-hidden="true">&rarr;</span></a></li>
			  		</c:when>
			  		<c:otherwise>
			  		</c:otherwise>
			  	</c:choose>
			  </ul>
			</nav>
		</div>
		<!-- 底部导航条 -->
		<%@ include file="/static/common/footer.jsp"  %>
    	<script type="text/javascript" src="<%=path %>/static/js/bootstrap.js"></script>
    	<script type="text/javascript">
    		//回显查询条件
    		var checkId = '${requestScope.cId}';
    		if(checkId != ""){
    			$("#cId").val(checkId);
    		}else{
    			$("#cId").val("");
    		}
    		//查询事件
    		$("#select").click(function(){
    			var pName = $("#pName").val();
    			var cId = $("#cId").val();
    			//查询
    			location.href="<%=path%>/spring/check/index?pName="+pName+"&cId="+cId;
    		});
    		
    		//删除事件
    		function isDel(checkId){
    			//获得当前操作页
	    		var currentPage = '${pager.currentPage}';
	    		var rowCount = ${pager.rowCount};
	    		if(rowCount % 5 == 1){
	    			currentPage = parseInt(currentPage)-1;
	    		}
    			var flag = window.confirm("确认删除该条记录吗?");
    			if(flag){
    				//使用ajax
    				$.ajax({
    					url		:		"<%=path%>/spring/check/delCheck",
    					method	:		"post",
    					data	:		{"checkId":checkId},
    					success	:		function(data){
    						var json = eval('('+data+')');
    						if(json.status == 1){
    							alert(json.message);
    							location.href="<%=path%>/spring/check/index?currentPage="+currentPage;
    						}else{
    							alert(json.message);
    							location.href="<%=path%>/spring/check/index?currentPage="+currentPage;
    						}
    					}
    				});
    			}
    		}
    	</script>
  </body>
</html>
