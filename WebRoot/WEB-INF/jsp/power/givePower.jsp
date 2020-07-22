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
    <title>权限分配</title>
    <link rel="stylesheet" href="http://cdn.bootcss.com/bootstrap/3.3.0/css/bootstrap.min.css">
  </head>
  
  <body style="background:#EEEEEE">
  	<!-- 头部导航条 -->
  	<%@ include file="/static/common/header.jsp" %>
  	<!-- 左侧导航栏 -->
	<%@ include file="/static/common/left.jsp" %>
	<div id="divDom" style="font-size:17px;width:1200px;height:750px;;position: absolute;top:50px;left:300px;">
  			<h1 style="margin-left:410px;">权限分配</h1>
  			<br/>
  			<form>
  			  <div class="form-group" style="margin-left:255px;">
			    <label for="exampleInputPassword1">员工姓名:</label>
			    <select id="person" class="form-control" style="width:500px;">
			    	<option value="0">请选择</option>
			    	<c:forEach var="person" items="${requestScope.personList }">
			    		<option value="${person.pId }">${person.pName}</option>
			    	</c:forEach>
			    </select>
			  </div><br/><br/>
			  <div class="form-group" id="powerDom" style="margin-left:170px;">
			  		<label for="exampleInputPassword1">二级权限分配: </label>
			   		<c:forEach var="power1" items="${requestScope.power1List }" varStatus="status">
			   			<label class="checkbox-inline" style="display:inline-block;">
	  						<input type="checkbox" name="power1" value="${power1.powerId}"/>${power1.powerDesc}
	  					</label>
	  					&nbsp;&nbsp;
	  					<c:if test="${(status.index+1)%5 == 0 }">
	  						<br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	  						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	  					</c:if>
			   		</c:forEach>
			  </div>
			  <br/><br/>
			   <div class="form-group" id="powerDom" style="margin-left:170px;">
			  		<label for="exampleInputPassword1">三级权限分配: </label>
			   		<c:forEach var="level3" items="${requestScope.level3List }" varStatus="status">
			   			<label class="checkbox-inline" style="display:inline-block;">
	  						<input type="checkbox" name="power1" value="${level3.powerId}"/>${level3.powerDesc}
	  					</label>
	  					&nbsp;&nbsp;
	  					<c:if test="${(status.index+1)%5 == 0 }">
	  						<br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	  						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	  					</c:if>
			   		</c:forEach>
			  </div>
			  <br/><br/><br/><br/><br/>
	  		  <button style="margin-left:370px;" type="button" class="btn btn-primary" id="addPower" onclick="givePower()">确认分配</button>
	  		  <button style="margin-left:20px;" type="button" class="btn btn-primary" id="clear" >重置</button>
	  		  <button style="margin-left:20px;" type="button" class="btn btn-primary" id="back">后退</button>
			</form>
  		</div>
	<!-- 底部导航条 -->
	<%@ include file="/static/common/footer.jsp"  %>
    <script type="text/javascript" src="<%=path %>/static/js/bootstrap.js"></script>
    <script type="text/javascript">
    //员工下拉框改变触发
    	$("#person").change(function(){
    		var personId = $("#person").val();
    		//移除多选按钮选中
    		var checkboxAll2 = $("input:checkbox[name='power1']");
    		$.each(checkboxAll2,function(j,checkbox){
    			$(checkbox).removeAttr("checked");
    		});
    		if(personId != "0"){
    			//ajax
    			$.ajax({
    				url		:		"<%=path%>/spring/power/backPower",
    				method	:		"post",
    				dataType:		"json",
   					data	: 		{"personId":personId},
   					success	:		function(data){
   						//获得所有checkbox
   						var checkboxAll = $("input:checkbox[name='power1']");
   						//循环data
   						for(var i=0;i<data.length;i++){
   							var powerId = data[i].powerId;
   							//alert(powerId);
   							$.each(checkboxAll,function(j,checkbox){
   								var checkValue = $(checkbox).val();
   								if(powerId == checkValue){
   									$(checkbox).prop("checked",true);
   								}
   							});
   						}
   					}
    			});
    		}
    	});
    	//确认分配点击事件
    	function givePower(){
    		var flag = window.confirm("确认分配权限嘛?");
    		if(flag){
    			//员工id
	    		var personId = $("#person").val();
	    		//获得所有被选中多选按钮
	    		var checkboxAll = $("input:checkbox[name='power1']:checked");
	    		var array = new Array();
	    		//遍历多选按钮,并向数组中添加数据
	    		$.each(checkboxAll,function(j,checkbox){
	    			array.push($(checkbox).val());
	    		});
	    		//非空判断
	    		if(personId == "0"){
	    			alert("请选择需要分配权限的员工!");
	    			return;
	    		}
	    		//使用ajax
	    		var ise = {
	    			"pId":personId,
	    			"array":array
	    		}
	    		$.ajax({
	    			url		:		"<%=path%>/spring/power/givePower",
	    			method	:		"post",
	    			traditional :   true,
	    			data	:		ise,
	    			success	:		function(data){
	    				var json = eval('('+data+')');
	    				if(json.status == 1){
	    					//判断修改的是不是当前登录用户
	    					var loginUserId = '${sessionScope.loginUser.pId}';
	    					if(loginUserId == personId){
	    						alert(json.message+"请重新登录!");
	    						//退出登录
	    						location.href="<%=path%>/spring/login/exit";
	    					}else{
	    						alert(json.message+"即将返回首页!");
	    						//返回首页
	    						location.href="<%=path%>/spring/login/index";
	    					}
	    				}else{
	    					alert(json.message);
	    				}
	    			}
	    		});
    		}
    	}
    	
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
