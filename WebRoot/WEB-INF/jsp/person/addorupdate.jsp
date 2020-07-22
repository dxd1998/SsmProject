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
    <title>员工操作</title>
    <link rel="stylesheet" href="http://cdn.bootcss.com/bootstrap/3.3.0/css/bootstrap.min.css">
  </head>
  
  <body style="background:#EEEEEE">
  		<!-- 头部导航条 -->
	  	<%@ include file="/static/common/header.jsp" %>
	  	<!-- 左侧导航栏 -->
		<%@ include file="/static/common/left.jsp" %>
  		<!-- 修改 -->
  		<div id="divDom" style="font-size:17px;width:1200px;height:750px;;position: absolute;top:50px;left:300px;">
  			<c:choose>
  				<c:when test="${not empty requestScope.person }">
  					<h1 style="margin-left:410px;">修改员工信息</h1>
  				</c:when>
  				<c:otherwise>
  					<h1 style="margin-left:410px;">添加员工信息</h1>
  				</c:otherwise>
  			</c:choose>
  			<br/>
  			<form>
			  <div class="form-group">
			    <label for="exampleInputEmail1">员工姓名</label>
			    <input type="text" style="width:500px;" class="form-control" id="pName" value="${person.pName }" placeholder="Name">
			  </div>
			  <div class="form-group">
			    <label for="exampleInputPassword1">员工年龄</label>
			    <input type="text" style="width:500px;" class="form-control" id="pAge" value="${person.pAge }" placeholder="Age">
			  </div>
			  <div class="form-group">
			    <label for="exampleInputPassword1">员工用户名</label><div id="tishi" style="color:red;font-weight:bolder;display:none;">该用户名已存在!</div>
			    <input type="text" onblur="checkloginname()" style="width:500px;" class="form-control" id="pLoginName" value="${person.pLoginName }" placeholder="LoginName">
			  </div>
			  <div class="form-group">
			    <label for="exampleInputPassword1">员工密码</label>
			    <input type="password" style="width:500px;" class="form-control" id="pPassword" value="${person.pPassword }" placeholder="Password">
			  </div>
			  <div class="form-group">
			    <label for="exampleInputPassword1">重复密码</label>
			    <input type="password" style="width:500px;" class="form-control" id="rePassword" value="${person.pPassword }" placeholder="Password">
			  </div>
			  <div class="form-group">
			    <label for="exampleInputPassword1">入职时间</label>
			    <input type="text" style="width:500px;" class="form-control" id="pDate" value="${person.pDate }" placeholder="yyyy-MM-dd">
			  </div>
			  <div class="form-group" style="position: absolute;
			  top:92px;left:550px;">
			    <label for="exampleInputPassword1">员工性别</label>
			    <select id="pSex" class="form-control" style="width:300px;">
			    	<option value="0">请选择</option>
			    	<option value="男">男</option>
			    	<option value="女">女</option>
			    </select>
			  </div>
			  <div class="form-group" style="position: absolute;
			  top:172px;left:550px;">
			  	<label for="exampleInputPassword1">员工部门:</label>
			  	<c:forEach var="de" items="${requestScope.deList}">
			  		<label class="radio-inline" style="display:inline-block;">
 						<input type="radio" name="department" value="${de.dId }"/>${de.dName}
 					</label>
			  		&nbsp;&nbsp;
			  	</c:forEach>
			  </div>
			  <div class="form-group" style="position: absolute;
			  top:250px;left:550px;">
			    <label for="exampleInputPassword1">员工角色:</label>
			    <c:forEach var="role" items="${requestScope.roleList }">
			    	<label class="radio-inline" style="display:inline-block;">
 						<input type="radio" name="Role" value="${role.rId }"/>${role.rName}
 					</label>
			    	&nbsp;&nbsp;
			    </c:forEach>
			  </div>
			
			  <div class="form-group" id="addressDom" style="position: absolute;
			  top:300px;left:550px;">
			    <label for="exampleInputPassword1">员工地址:</label>
			    <c:forEach var="address" items="${person.address}" varStatus="status">
			    	<div class="form-group">
				   	 	<label for="exampleInputPassword1">地址${status.index+1}:</label>
			    		<input type="text" class="form-control" id="address${status.index+1}" value="${address.addressName}"placeholder="无"/>
			    		<input type="button" id="deleteAddress" onclick="delAddress('${address.addressId}')" value="删除地址"/>&nbsp;&nbsp;&nbsp;&nbsp;
				  	</div>
			    </c:forEach>
			  </div>
			  <div class="form-group"style="position: absolute;
			  top:300px;left:800px;">
			  	<label class="radio-inline" style="display:inline-block;">
					<input type="radio" name="addressRadio" value="old"/>
					<strong>已存地址:</strong>
				</label>
			    <select id="address" style="width:300px;" class="form-control">
			    	<option value="0">请选择</option>
			    	<c:forEach var="add" items="${requestScope.addressList }">
			    		<option value="${add.addressId }">${add.addressName}</option>
			    	</c:forEach>
			    </select><br/>
			    <label class="radio-inline" style="display:inline-block;">
					<input type="radio" name="addressRadio" value="new"/>
					<strong>新增地址:</strong>
				</label>
			  	<input type="text" style="width:300px;" class="form-control" id="newAddress" placeholder="NewAddress"/>
			  </div>
			 	<br/><br/>
			  <c:choose>
			  		<c:when test="${not empty person }">
			  			<button style="margin-left:260px;" type="button" class="btn btn-primary" id="saveUpdate"  onclick="updatePerson()">保存修改</button>
			  			<button style="margin-left:20px;" type="button" class="btn btn-primary" id="clear" >重置</button>
			  			<button style="margin-left:20px;" type="button" class="btn btn-primary" id="back">后退</button>
			  		</c:when>
			  		<c:otherwise>
			  			<button style="margin-left:400px;" type="button" class="btn btn-primary" id="addPerson" onclick="addperson()">添加员工</button>
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
    		//回显多项数据
    			//性别回显
    			var sex = '${person.pSex}';
    			if(sex != ''){
    				$("#pSex").val(sex);
    			}else{
    				$("#pSex").val("0");
    			}
    			//部门回显
    			var dId = '${person.department.dId}'
    			//得到部门所有单选按钮
    			var radioAll = $("input:radio[name='department']");
    			$.each(radioAll,function(j,radio){
    				var radioValue = $(radio).val();
    				if(dId == radioValue){
    					$(radio).attr("checked","checked");
    				}
    			});
    			//角色回显
    			var rId = '${person.role.rId}';
    			//得到角色所有单选按钮
    			var roleRadio = $("input:radio[name='Role']");
    			$.each(roleRadio,function(j,radio){
    				var radioValue = $(radio).val();
    				if(rId == radioValue){
    					$(radio).attr("checked","checked");
    				}
    			});
    		//如果为添加员工
    			var personId = '${person.pId}';
    			var loginUserId = '${loginUser.pId}';
    			if(personId == ""){
    				$("#addressDom").hide();
    			}else if(personId != "" && personId != loginUserId){
    				$("#pLoginName").attr("disabled",true);
    				$("#pPassword").attr("disabled",true);
    				$("#pDate").attr("disabled",true);
    				$("#rePassword").attr("disabled",true);
    			}
    		//修改员工
    			function updatePerson(){
    				//修改的值
    				var pName = $("#pName").val();
    				var pAge = $("#pAge").val();
    				var pSex = $("#pSex").val();
    				var pLoginName = $("#pLoginName").val();
    				var pPassword = $("#pPassword").val();
    				var rePassword=$("#rePassword").val();
    				var pDate = $("#pDate").val();
    				//操作页面
    				var currentPage = $("#currentPage").val();
    				//部门
    				var dId = $("input:radio[name='department']:checked").val();
    				//角色
    				var rId = $("input:radio[name='Role']:checked").val();
    				//地址
    				var oldorNew = $("input:radio[name='addressRadio']:checked").val();
    				var addressName = ""; //录入地址名
    				var addressId = "";	 //已存地址id
    				//判断使用已存地址还是录入地址
    				if(oldorNew == "old"){ //已存地址
    					addressId = $("#address").val();
    				}else if(oldorNew == "new"){
    					addressName = $("#newAddress").val();
    				}else{
    					/* alert("请选择该员工地址!");
    					return; */
    				}
    				//非空验证
    				if(pName == ""){
    					alert("员工姓名不能为空!");
    					return;
    				}
    				if(pAge == ""){
    					alert("员工年龄不能为空!");
    					return;
    				}
    				if(isNaN(pAge) == true){
    					alert("员工年龄必须为数字!");
    					return;
    				}
    				if(pSex == "0"){
    					alert("员工性别不能为空!");
    					return;
    				}
    				if(dId == ""){
    					alert("员工部门不能为空!");
    					return;
    				}
    				if(rId == ""){
    					alert("员工角色不能为空!");
    					return;
    				}
    				if(oldorNew == "old" && addressId == "0"){
    					alert("请选择已存地址!");
    					return;
    				}
    				if(oldorNew == "new" && addressName == ""){
    					alert("新增地址不能为空!");
    					return;
    				}
    				//使用ajax
    				var ise = {
    					"pId":personId,
    					"pName":pName,
    					"pAge":pAge,
    					"pSex":pSex,
    					"addressId":addressId,
    					"newAddress":addressName,
    					"rId":rId,
    					"dId":dId
    				};
    				$.ajax({
    					url		:		"<%=path%>/spring/person/saveUpdate",
    					method	:		"post",
    					traditional:true,
    					data	:		ise,
    					success	:		function(data){
    						var json = eval('('+data+')');
    						if(json.status == 1){
    							alert(json.message);
    							location.href="<%=path%>/spring/person/getPerson?currentPage="+currentPage;
    						}else{
    							alert(json.message);
    						}
    					}
    				});
    			};
    			
    			//删除地址点击事件
    			function delAddress(addressId){
    				//操作页面
    				var currentPage = $("#currentPage").val();
    				var pId='${person.pId}';
    				var flag = window.confirm("确认删除该地址么?");
    				if(flag){
    					$.ajax({
    						url		:		"<%=path%>/spring/person/delAddress",
    						method	:		"post",
    						data	:		{"pId":pId,"addressId":addressId},
    						success	:		function(data){
    							var json = eval('('+data+')');
    							if(json.status == 1){
    								alert(json.message);
    								//刷新
    								location.href="<%=path%>/spring/person/toUpdate?currentPage="+currentPage+"&pId="+pId ;
    							}else{
    								alert(json.message);
    							}
    						}
    					})
    				}
    			};
    		//地址下拉框改变事件
    		$("#address").change(function(){
    			var dId = $("#address").val();
    			var pId = '${person.pId}';
    			if(dId != "0" && pId != ""){
    				//判断该员工是否存在该地址
    				$.ajax({
    					url		:		"<%=path%>/spring/person/checkAddress",
    					method	:		"post",
    					data	:		{"pId":pId,"dId":dId},
    					success	:		function(data){
    						var json = eval('('+data+')');
    						if(json.status == -1){
    							alert(json.message);
    							//修改按钮锁定
    							$("#saveUpdate").attr("disabled",true);
    						}else{
    							$("#saveUpdate").removeAttr("disabled");
    						}
    					}
    				});
    			}
    		});
    		//新增员工信息
    		function addperson(){
    			//入职时间正则表达式
    			var $zDate = /^(19[0-9]2|200[0-9]|201[0-9]|2020)-([1-9]|1[0-2])-([1-9]|1[0-9]|2[0-9]|3[0-1])$/;
    			//添加的值
    				var pName = $("#pName").val();
    				var pAge = $("#pAge").val();
    				var pSex = $("#pSex").val();
    				var pLoginName = $("#pLoginName").val();
    				var pPassword = $("#pPassword").val();
    				var rePassword=$("#rePassword").val();
    				var pDate = $("#pDate").val();
    				//操作页面
    				var currentPage = $("#currentPage").val();
    				//部门
    				var dId = $("input:radio[name='department']:checked").val();
    				//角色
    				var rId = $("input:radio[name='Role']:checked").val();
    				//非空验证
    				if(pName == ""){
    					alert("员工姓名不能为空!");
    					return;
    				}
    				if(pAge == ""){
    					alert("员工年龄不能为空!");
    					return;
    				}
    				if(isNaN(pAge) == true){
    					alert("员工年龄必须为数字!");
    					return;
    				}
    				if(pLoginName == ""){
    					alert("员工用户名不能为空!");
    					return;
    				}
    				if(pPassword == ""){
    					alert("员工密码不能为空!");
    					return;
    				}
    				if(rePassword != pPassword){
    					alert("二次密码输入不一致!");
    					return;
    				}
    				if($zDate.test(pDate) == false){
    					alert("日期格式错误! yyyy-M-dd");
    					return;
    				}
    				if(pSex == "0"){
    					alert("员工性别不能为空!");
    					return;
    				}
    				if(dId == null){
    					alert("员工部门不能为空!");
    					return;
    				}
    				if(rId == null){
    					alert("员工角色不能为空!");
    					return;
    				}
    				//地址
    				var oldorNew = $("input:radio[name='addressRadio']:checked").val();
    				var addressName = ""; //录入地址名
    				var addressId = "";	 //已存地址id
    				//判断使用已存地址还是录入地址
    				if(oldorNew == "old"){ //已存地址
    					addressId = $("#address").val();
    				}else if(oldorNew == "new"){
    					addressName = $("#newAddress").val();
    				}else{
    					alert("请选择该员工地址!");
    					return;
    				}
    				if(oldorNew == "old" && addressId == "0"){
    					alert("请选择已存地址!");
    					return;
    				}
    				if(oldorNew == "new" && addressName == ""){
    					alert("新增地址不能为空!");
    					return;
    				}
    				//使用ajax
    				var ise = {
    					"pName":pName,
    					"pAge":pAge,
    					"pSex":pSex,
    					"pLoginName":pLoginName,
    					"pPassword":pPassword,
    					"pDate":pDate,
    					"addressId":addressId,
    					"newAddress":addressName,
    					"rId":rId,
    					"dId":dId
    				};
    				$.ajax({
    					url		:		"<%=path%>/spring/person/addPerson",
    					method	:		"post",
    					traditional:	true,
    					data	:		ise,
    					success	:		function(data){
    						var json = eval('('+data+')');
    						if(json.status == 1){
    							alert(json.message);
    							//刷新
    							location.href="<%=path%>/spring/person/getPerson";
    						}else{
    							alert(json.message);
    							//刷新
    							location.href="<%=path%>/spring/person/getPerson";
    						}
    					}
    				});
    		}
    		//判断员工用户名是否存在
    		function checkloginname(){
    			var pLoginName = $("#pLoginName").val();
    			//使用ajax
    			$.ajax({
    				url		:		"<%=path%>/spring/person/checkName",
    				method	:		"post",
    				data	:		{"pLoginName":pLoginName},
    				success	:		function(data){
    					var json = eval('('+data+')');
    					if(json.status == -1){
    						$("#pLoginName").attr("placeholder",json.message);
    						//锁定焦点
    						$("#pLoginName").focus();
    						$("#pLoginName").css("border-color","red");
    						$("#tishi").show();
    					}else{
    						$("#tishi").hide();
    						$("#pLoginName").css("border-color","");
    					}
    				}
    			})
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
