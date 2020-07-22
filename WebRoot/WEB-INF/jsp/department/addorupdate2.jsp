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
    
    <title>部门操作</title>
     <link rel="stylesheet" href="http://cdn.bootcss.com/bootstrap/3.3.0/css/bootstrap.min.css">
  </head>
  
  <body style="background:#EEEEEE">
  		<!-- 头部导航条 -->
	  	<%@ include file="/static/common/header.jsp" %>
	  	<!-- 左侧导航栏 -->
		<%@ include file="/static/common/left.jsp" %>
  		<div id="divDom" style="font-size:17px;width:1200px;height:750px;;position: absolute;top:50px;left:300px;">
  			<c:choose>
  				<c:when test="${not empty requestScope.department }">
  					<h1 style="margin-left:410px;">修改部门信息</h1>
  				</c:when>
  				<c:otherwise>
  					<h1 style="margin-left:410px;">添加部门信息</h1>
  				</c:otherwise>
  			</c:choose>
  			<br/>
  			<form>
			  <div class="form-group" style="margin-left:255px;">
			    <label for="exampleInputEmail1">部门名称</label>
			    <input type="text" style="width:500px;" class="form-control" id="dName" value="${department.dName }" placeholder="DepartmentName">
			  </div>
			  <div class="form-group" style="margin-left:255px;">
			    <label for="exampleInputPassword1">部门负责人</label>
			    <select id="departmentPerson" class="form-control" style="width:500px;">
			    	<option value="0">请选择</option>
			    	<c:forEach var="person" items="${requestScope.personList }">
			    		<c:if test="${person.role.rId == 1 || person.role.rId == 2 }">
			    			<option value="${person.pId }">${person.pName}</option>
			    		</c:if>
			    	</c:forEach>
			    </select>
			  </div>
			  <div class="form-group" style="margin-left:255px;">
			    <label for="exampleInputPassword1">创建日期</label>
			    <input type="text" style="width:500px;" class="form-control" id="dDate" value="${department.dDate}" placeholder="createDate">
			  </div>
			  <br/><br/>
			  <c:choose>
			  		<c:when test="${not empty department }">
			  			<button style="margin-left:400px;" type="button" class="btn btn-primary" id="saveUpdate"  onclick="updateDepartment()">保存修改</button>
			  			<button style="margin-left:20px;" type="button" class="btn btn-primary" id="clear" >重置</button>
			  			<button style="margin-left:20px;" type="button" class="btn btn-primary" id="back">后退</button>
			  		</c:when>
			  		<c:otherwise>
			  			<button style="margin-left:400px;" type="button" class="btn btn-primary" id="addPerson" onclick="addDepartment()">添加部门</button>
			  			<button style="margin-left:20px;" type="button" class="btn btn-primary" id="clear" >重置</button>
			  			<button style="margin-left:20px;" type="button" class="btn btn-primary" id="back">后退</button>
			  		</c:otherwise>
			  </c:choose>
			</form>
  		</div>
  		<input type="hidden" id="currentPage" value="${currentPage}"/>
  		
  		<!-- 底部导航条 -->
		<%@ include file="/static/common/footer.jsp"  %>
    	<script type="text/javascript" src="<%=path %>/static/js/bootstrap.js"></script>
    	<script type="text/javascript">
    		//回显数据
    			//负责人
    			var personId = '${department.person.pId}';
    			if(personId != ""){
    				$("#departmentPerson").val(personId);
    				$("#dDate").attr("disabled",true);
    			}else{
    				$("#departmentPerson").val("0");
    			}
    		//修改部门
    			function updateDepartment(){
    				var dId = '${department.dId}';
    				var currentPage = $("#currentPage").val();
    				//修改的值
    				var dName = $("#dName").val();
    				var pId = $("#departmentPerson").val();
    				var dDate = $("#dDate").val();
    				//非空判断
    				if(dName == ""){
    					alert("部门名称不能为空!");
    					return;
    				}
    				if(pId == "0"){
    					alert("部门负责人不能为空!");
    					return;
    				}
    				if(dDate == ""){
    					alert("创建日期不能为空!");
    					return;
    				}
    				var ise  = {
    					"dName":dName,
    					"dId":dId,
    					"pId":pId
    				};
    				//使用ajax
    				$.ajax({
    					url		:		"<%=path%>/spring/department/saveUpdate",
    					method	:		"post",
    					data	:		ise,
    					success	:		function(data){
    						var json = eval('('+data+')');
    						if(json.status == 1){
    							alert(json.message);
    							//刷新
    							location.href="<%=path%>/spring/department/index?currentPage="+currentPage;
    						}else{
    							alert(json.message);
    							//刷新
    							location.href="<%=path%>/spring/department/index?currentPage="+currentPage;
    						}
    					}
    				});
    			};
    			//添加部门
    			function addDepartment(){
    				var $zDate = /^(19[0-9]2|200[0-9]|201[0-9]|2020)-([1-9]|1[0-2])-([1-9]|1[0-9]|2[0-9]|3[0-1])$/;
    				//添加的值
    				var dName = $("#dName").val();
    				var pId = $("#departmentPerson").val();
    				var dDate = $("#dDate").val();
    				//非空判断
    				if(dName == ""){
    					alert("部门名称不能为空!");
    					return;
    				}
    				if(pId == "0"){
    					alert("部门负责人不能为空!");
    					return;
    				}
    				if(dDate == ""){
    					alert("创建日期不能为空!");
    					return;
    				}
    				if($zDate.test(dDate) == false){
    					alert("时间格式错误!yyyy-MM-dd");
    					return;
    				}
    				var ise  = {
    					"dName":dName,
    					"dDate":dDate,
    					"pId":pId
    				};
    				//ajax
    				$.ajax({
    					url		:		"<%=path%>/spring/department/add",
    					method	:		"post",
    					data	:		ise,
    					success	:		function(data){
    						var json = eval('('+data+')');
    						if(json.status == 1){
    							alert(json.message);
    							//刷新
    							location.href = "<%=path%>/spring/department/index";
    						}else{
    							alert(json.message);
    						}
    					}
    				});
    			};
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
