<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="x" %>
<!-- 左侧导航 -->
<ul class="nav nav-pills nav-stacked" style="width:250px;font-weight:bolder;">
 	<!-- 动态加载员工权限 -->
 	<x:forEach var="power" items="${loginUser.powerList }">
 		<!-- 输出所有根节点权限 -->
 		<x:if test="${power.type == 0 || power.type == 999 }">
 			${power.powerName}
 			<!-- 输出根节点权限下绑定的子节点 -->
 			<x:forEach var="power2" items="${power.childPower }">
 				${power2.powerName}
 			</x:forEach>
 			<br/>
 		</x:if>
 	</x:forEach>
</ul>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/jquery-1.12.4.js"></script>
