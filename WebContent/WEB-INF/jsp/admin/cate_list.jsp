<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE HTML>
<html>
<head>
<title>类别管理</title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<style type="text/css">
	body{
		font-family: "微软雅黑";
		background-color: #EDEDED;
	}
	h2{
		text-align: center;
	}
	table{ 
		margin: 0 auto; 
		/* width: 96%; */
		text-align: center;
		border-collapse:collapse;
	}
	td, th{ padding: 7px;}
	th{
		background-color: #DCDCDC;
	}
	th.ths{
		width: 100px;
	} 
	input.pnum{
		width:80px;
		height:25px;
		font-size: 18px;
		text-align:center;
	}
	
</style>

<!--引入jquery的js库-->
<script src="../js/jquery-1.4.2.js"></script>
<script type="text/javascript"></script>
<script type="text/javascript">
	/* 文档就绪函数 */
	$(function() {
		$(".del").click(function(){
			//1.获取商品的id
			var id = $(this).attr("id");
						
			//2.利用ajax请求删除购物车中指定id的商品(-1后台会删除该商品)
			$.post("${ pageContext.request.contextPath }/admin/delcate",{"id":id});				
					
			//3.删除当前页面中的商品
			$(this).parents("tr").remove();
		});	
		$(".update").change(function(){
			//1.获取商品的id
			var id = $(this).attr("id");
			var value=$(this).attr("value");
			$.post("${ pageContext.request.contextPath }/admin/updatecate",{
					"id":id,
					"name":value
				});
		});	
	});
	
</script>
</head>
<body>
	<h2>商品管理</h2>
	<div><a href="${pageContext.request.contextPath}/admin/manage">> 返回后台主页</a></div>
	<table border="1">
		<tr>
			<th width="200px">类别ID</th>
			<th class="ths">商品类别</th>
			<th width="50px">操 作</th>
		</tr>
		<c:forEach items="${categorys }" var="prod">
		<tr >
			<td>${prod.id}</td>
			<td>
			<input type="text" id="${prod.id}" class="update" value="${prod.name}"/>
			</td>
			<td><a id="${prod.id}"class="del" href="javascript:void(0)">删 除</a></td>
		</tr>
		</c:forEach>
	</table>
</body>
</html>
