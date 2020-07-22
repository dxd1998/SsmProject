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
    <title>员工信息</title>
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
			    <label for="exampleInputName2">员工姓名</label>
			    <input type="text" class="form-control" id="pName" placeholder="${pName == null || pName == ''?'Name':pName}">
			  </div>
			  <div class="form-group">
			    <label for="exampleInputEmail2">所属部门</label>
			    <select id="dId" class="form-control" style="width:200px;display:inline-block;">
	  				<option value="0">Choose</option>
	  				<c:forEach var="ds" items="${requestScope.deList }">
	  					<option value="${ds.dId}">${ds.dName }</option>
	  				</c:forEach>
	  			</select>
			  </div>
			  &nbsp;&nbsp;&nbsp;&nbsp;
			  <button type="button" class="btn btn-default" id="select">查询</button>
			</form>
			<table class="table table-striped" style="width:1285px;">
				<tr>
					<td>员工编号</td>
					<td>员工姓名</td>
					<td>员工用户名</td>
					<td>员工年龄</td>
					<td>员工性别</td>
					<td>员工角色</td>
					<td>员工部门</td>
					<td>入职日期</td>
					<td>员工地址</td>
					<td>操作</td>
				</tr>
				<c:forEach var="per" items="${requestScope.personList }">
					<!-- 权限控制,普通员工只能看自己的信息,部门经理只能看自己部门的信息 -->
						<!-- 如果是员工登录 -->
							<c:if test="${sessionScope.loginUser.role.rId == 3 && per.pId == sessionScope.loginUser.pId}">
								<tr>
									<td>${per.pId }</td>
									<td>${per.pName }</td>
									<td>${per.pLoginName }</td>
									<td>${per.pAge }</td>
									<td>${per.pSex }</td>
									<td>${per.role.rName }</td>
									<td>${per.department.dName }</td>
									<td>${per.pDate }</td>
									<td> 
										<select class="form-control">
											<c:forEach var="address" items="${per.address }" varStatus="status">
												<option value="${address.addressId }">地址${status.index+1}:${address.addressName }</option>
											</c:forEach>
										</select>
									</td>
									<td>
										<div class="btn-group">
										  <button type="button" class="btn btn-primary dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
										    可选操作 <span class="caret"></span>
										  </button>
										  	<c:forEach var="level3" items="${sessionScope.loginUser.powerList}">
									    		<!-- 只循环员工管理父节点下的节点 -->
										    		<c:if test="${level3.powerId == 10}">
										    			<c:forEach var="level" items="${level3.level3Power }">
											    			<c:if test="${level.parentId == 1 && level.type == 2}">
											    				<input type="hidden" value="${per.pId }"/>
											    				${level.powerName}
											    			</c:if>
											    		</c:forEach>
										    		</c:if>
									    	</c:forEach>
										</div>
									</td>
								</tr>
							</c:if>
						<!-- 如果是经理 -->
							<c:if test="${sessionScope.loginUser.role.rId == 2 && per.department.dId == sessionScope.loginUser.department.dId }">
								<tr>
									<td>${per.pId }</td>
									<td>${per.pName }</td>
									<td>${per.pLoginName }</td>
									<td>${per.pAge }</td>
									<td>${per.pSex }</td>
									<td>${per.role.rName }</td>
									<td>${per.department.dName }</td>
									<td>${per.pDate }</td>
									<td> 
										<select class="form-control">
											<c:forEach var="address" items="${per.address }" varStatus="status">
												<option value="${address.addressId }">地址${status.index+1}:${address.addressName }</option>
											</c:forEach>
										</select>
									</td>
									<td>
										<div class="btn-group">
										  <button type="button" class="btn btn-primary dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
										    可选操作 <span class="caret"></span>
										  </button>
										  	<ul class="dropdown-menu" aria-labelledby="dropdownMenu1">
										    	<c:forEach var="level3" items="${sessionScope.loginUser.powerList}">
										    		<!-- 只循环员工管理父节点下的节点 -->
										    		<c:if test="${level3.powerId == 10}">
										    			<c:forEach var="level" items="${level3.level3Power }">
											    			<c:if test="${level.parentId == 1 && level.type == 2}">
											    				<input type="hidden" value="${per.pId }"/>
											    				${level.powerName}
											    			</c:if>
											    		</c:forEach>
										    		</c:if>
										    	</c:forEach>
										  	</ul>
										</div>
									</td>
								</tr>
							</c:if>
							<!-- 管理员登录 -->
							<c:if test="${sessionScope.loginUser.role.rId == 1}">
								<tr>
									<td>${per.pId }</td>
									<td>${per.pName }</td>
									<td>${per.pLoginName }</td>
									<td>${per.pAge }</td>
									<td>${per.pSex }</td>
									<td>${per.role.rName }</td>
									<td>${per.department.dName }</td>
									<td>${per.pDate }</td>
									<td> 
										<select class="form-control">
											<c:forEach var="address" items="${per.address }" varStatus="status">
												<option value="${address.addressId }">地址${status.index+1}:${address.addressName }</option>
											</c:forEach>
										</select>
									</td>
									<td>
										<div class="btn-group">
										  <button type="button" class="btn btn-primary dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
										    可选操作 <span class="caret"></span>
										  </button>
										  	<ul class="dropdown-menu" aria-labelledby="dropdownMenu1">
										    	<c:forEach var="level3" items="${sessionScope.loginUser.powerList}">
										    		<!-- 只循环员工管理父节点下的节点 -->
										    		<c:if test="${level3.powerId == 10}">
										    			<c:forEach var="level" items="${level3.level3Power }">
											    			<c:if test="${level.parentId == 1 && level.type == 2}">
											    				<input type="hidden" value="${per.pId }"/>
											    				${level.powerName}
											    			</c:if>
											    		</c:forEach>
										    		</c:if>
										    	</c:forEach>
										  	</ul>
										</div>
									</td>
								</tr>
							</c:if>
				</c:forEach>
			</table>
			<!-- 分页按钮 -->
			<nav aria-label="...">
			  <ul class="pager">
			  	<!-- 判断 -->
			  	<c:choose>
			  		<c:when test="${pager.currentPage > 1 }">
			  			<li class="previous"><a href="<%=path%>/${requestScope.pager.url}?currentPage=${requestScope.pager.currentPage-1}&pName=${requestScope.pName == null ?'':requestScope.pName}&dId=${requestScope.dId == null ? '0':requestScope.dId}"><span aria-hidden="true">&larr;</span> 上一页</a></li>
			  		</c:when>
			  		<c:otherwise>
			  		</c:otherwise>
			  	</c:choose>
			  	<div style="position:absolute;left:500px;bottom:200px;font-size:16px;font-weight:bold;">
			  		共有${pager.rowCount}条数据
			  		页数:${pager.currentPage}/${pager.pageCount}
			  	</div>
			  	<c:choose>
			  		<c:when test="${pager.currentPage < pager.pageCount }">
			  			<li class="next"><a href="<%=path%>/${requestScope.pager.url}?currentPage=${requestScope.pager.currentPage+1}&pName=${requestScope.pName == null ?'':requestScope.pName}&dId=${requestScope.dId == null ? '0':requestScope.dId}">下一页 <span aria-hidden="true">&rarr;</span></a></li>
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
    		//判断是否禁用条件查询
    		var roleId = '${sessionScope.loginUser.role.rId}';
    		if(roleId == "2"){
    			//禁用部门下拉框
    			$("#dId").attr("disabled",true);
    		}else if(roleId == "3"){
    			//禁用部门下拉框
    			$("#dId").attr("disabled",true);
    			//禁用员工输入框
    			$("#pName").attr("disabled",true);
    		}
    		//回显查询条件
    		var selectdId = '${requestScope.dId}';
    		if(selectdId != "0" && selectdId != ""){
    			$("#dId").val(selectdId);
    		}else{
    			$("#dId").val("0");
    		}
    		//查询按钮
    		$("#select").click(function(){
    			//用户输入
    			var pName = $("#pName").val();
    			var dId = $("#dId").val();
    			//查询
    			location.href="<%=path%>/spring/person/getPerson?pName="+pName+"&dId="+dId;
    		});
    		//删除点击事件
    		function isDel(obj){
    			//得到当前操作页
    			var currentPage = parseInt("${pager.currentPage}");
    			var rowCount = parseInt("${pager.rowCount}");
    			if(rowCount % 5 == 1){
    				currentPage = currentPage-1;
    			}
    			var aaa = obj.parent().prev().val();
    			var flag = window.confirm("确认删除该员工么?");
    			if(flag){
    				$.ajax({
    					url			:		"<%=path%>/spring/person/delPerson",
    					method		:		"post",
    					data		:		{"pId":aaa},
    					success		:		function(data){
    						var json = eval('('+data+')');
    						if(json.status == 1){
    							alert(json.message);
    							location.href="<%=path%>/spring/person/getPerson?currentPage="+currentPage;
    						}else{
    							alert(json.message);
    						}
    					}
    				});
    			}
    		}
    		//跳转去修改页面
    		function toUpdate(obj){
    			var pId = obj.parent().prev().val();
    			var currentPage = '${pager.currentPage}';
    			location.href="<%=path%>/spring/person/toUpdate?pId="+pId+"&currentPage="+currentPage;
    		}
    	</script>
  </body>
</html>
