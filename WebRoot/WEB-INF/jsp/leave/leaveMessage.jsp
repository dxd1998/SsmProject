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
    <title>请假记录</title>
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
			    <label for="exampleInputName2">请假员工:</label>
			    <input type="text" class="form-control" id="pName" placeholder="${pName == null || pName == '' ? 'Name' : pName }">
			  </div>
			   <div class="form-group">
			    <label for="exampleInputEmail2">处理类型:</label>
			    <select id="tId" class="form-control" style="width:200px;display:inline-block;">
	  				<option value="">Choose</option>
	  				<c:forEach var="type" items="${requestScope.typeList }">
	  					<option value="${type.tId}">${type.tName }</option>
	  				</c:forEach>
	  			</select>
			  </div>
			  &nbsp;&nbsp;&nbsp;&nbsp;
			  <button type="button" class="btn btn-default" id="select">查询</button>
			</form>
			<table class="table table-striped">
				<tr>
					<td>记录编号</td>
					<td>请假开始日</td>
					<td>请假结束日</td>
					<td>请假员工</td>
					<td>请假类型</td>
					<td>处理类型</td>
					<td>操作</td>
				</tr>
				<c:forEach var="leave" items="${requestScope.leaveList }">
					<tr>
						<td>${leave.leaveId}</td>
						<td>${leave.leaveStart}</td>
						<td>${leave.leaveEnd}</td>
						<td>${leave.person.pName}</td>
						<td>${leave.leave.lName}</td>
						<td>${leave.type.tName}</td>
						<td>
							<div class="btn-group">
							  <button type="button" class="btn btn-primary dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
							    可选操作 <span class="caret"></span>
							  </button>
							  	<ul class="dropdown-menu" aria-labelledby="dropdownMenu1">
							    	<li>
							    		<a href="javascript:void(0)" onclick="isDel('${leave.leaveId}','${leave.type.tId }')">删除记录</a>
							    	</li>
							  		<c:if test="${leave.type.tId == 1 }">
							  			<li role="separator" class="divider"></li>
							  			<li><a href="javascript:void(0)" onclick="yesLeave('${leave.leaveId}')">通过审批</a></li>
							  			<li role="separator" class="divider"></li>
							  			<li><a href="javascript:void(0)" onclick="noLeave('${leave.leaveId}')">拒绝审批</a></li>
							  		</c:if>
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
		<!-- 处理类型查询条件记录 -->
		<input type="hidden" id="tId2" value="${requestScope.tId }"/>
		<!-- 记录在哪一页进行操作 -->
		<input type="hidden" id="currentPage" value="${currentPage}"/>
		<!-- 底部导航条 -->
		<%@ include file="/static/common/footer.jsp"  %>
    	<script type="text/javascript" src="<%=path %>/static/js/bootstrap.js"></script>
    	<script type="text/javascript">
    		
    		if($("#tId2").val() != ""){
    			$("#tId").val($("#tId2").val());
    		}
    		//查询按钮
    		$("#select").click(function(){
    			//用户输入
    			var pName = $("#pName").val();
    			var tId = $("#tId").val();
    			location.href = "<%=path%>/spring/leave/index?pName="+pName+"&tId="+tId;
    		});
    		//删除请假记录
    		function isDel(leaveId,typeId){
    			var flag = window.confirm("确认删除该条请假记录?");
    			var currentPage = '${pager.currentPage}';
    			var tId = $("#tId2").val();
    			if(flag){
    				if(typeId == "1"){
    					alert("该请假记录未审核!不能删除!");
    				}else{
    					//使用ajax
    					$.ajax({
    						url		:		"<%=path%>/spring/leave/del",
    						method	:		"post",
    						data	:		{"leaveId":leaveId},
    						success	:		function(data){
    							var json = eval('('+data+')');
    							if(json.status == 1){
    								alert(json.message);
    								//判断是否根据条件查询并执行了删除操作
    								location.href = "<%=path%>/spring/leave/index?currentPage="+currentPage+"&tId="+tId;
    							}else{
    								alert(json.message);
    								location.href = "<%=path%>/spring/leave/index?currentPage="+currentPage+"&tId="+tId;
    							}
    						}
    					});
    				}
    			}
    		};
    		
    		//通过审批
    		function yesLeave(leaveId){
    			var currentPage = '${pager.currentPage}';
    			var tId = $("#tId2").val();
    			var flag = window.confirm("确认通过审核吗?");
    			if(flag){
    				$.ajax({
	    				url		:		"<%=path%>/spring/leave/updateLeave",
	    				method	:		"post",
	    				data	:		{"leaveId":leaveId,"tId":"2"},
	    				success	:		function(data){
	    					var json = eval('('+data+')');
	    					if(json.status == 1){
	    						alert(json.message);
	    						location.href = "<%=path%>/spring/leave/index?currentPage="+currentPage+"&tId="+tId;
	    					}else{
	    						alert(json.message);
	    						location.href = "<%=path%>/spring/leave/index?currentPage="+currentPage+"&tId="+tId;
	    					}
		    			}
	    			});
    			}
    		};
    		//拒绝审批
    		function noLeave(leaveId){
    			var currentPage = '${pager.currentPage}';
    			var tId = $("#tId2").val();
    			var flag = window.confirm("确认拒绝审核吗?");
    			if(flag){
    				$.ajax({
	    				url		:		"<%=path%>/spring/leave/updateLeave",
	    				method	:		"post",
	    				data	:		{"leaveId":leaveId,"tId":"3"},
	    				success	:		function(data){
	   						var json = eval('('+data+')');
	    					if(json.status == 1){
	    						alert(json.message);
	    						location.href = "<%=path%>/spring/leave/index?currentPage="+currentPage+"&tId="+tId;
	    					}else{
	    						alert(json.message);
	    						location.href = "<%=path%>/spring/leave/index?currentPage="+currentPage+"&tId="+tId;
	    					}
		    			}
	    			});
    			}
    		};
    	</script>
  </body>
</html>
