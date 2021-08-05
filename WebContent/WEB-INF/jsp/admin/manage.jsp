<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE HTML>
<html>
	<head>
		<title>后台管理页面</title>
		<meta charset="utf-8"/>
		<link href="${ pageContext.request.contextPath }/css/managestyle.css" rel="stylesheet" type="text/css">
	</head>
	<body>
	<div class="top">
		<h1>&nbsp;&nbsp;EasyMall商城管理后台</h1>
	</div>	
	<div class="content">
		<div class="left">			
			<%@ include file = "_left.jsp" %>
		</div>
	<div class="right">	
	<div id="wel">欢迎登陆EasyMall商城后台管理系统 ...
	<c:if test="${ !(empty sessionScope.admin) }">
		 	 	"欢迎${ sessionScope.admin.username }回来~~&nbsp;"
		 	<a href="${ pageContext.request.contextPath }/index/logout">退出</a>		 
		 </c:if>
	</div>
	</div>
	</div>		
	</body>	
</html>