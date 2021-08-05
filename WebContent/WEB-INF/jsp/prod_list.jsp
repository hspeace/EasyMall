<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!DOCTYPE HTML>
<html>
<head>
	<meta http-equiv="Content-type" content="text/html; charset=UTF-8" />
	<link href="${ pageContext.request.contextPath }/css/prodList.css" rel="stylesheet" type="text/css">
</head>
<body>

	<%@ include file="_head.jsp" %>
	<div id="content">
		<div id="search_div">
			<form method="post" action="${ pageContext.request.contextPath}/prodlist">
				<span class="input_span">商品名：<input type="text" name="name"/ value="${name}"/></span>
				<span class="input_span">商品种类：</span>
				<select name="category">
					<option value="">不限</option>
					<c:forEach items="${categorys}" var="c">
						<option value="${c.id}">${c.name}</option>
					</c:forEach>
				</select>
				<span class="input_span">商品价格区间：</span>
					<input type="text" name="minprice"   value="${minprice}"/> 
					-<input type="text" name="maxprice"  value="${maxprice}"/>
				<input type="submit" value="查 询">
			</form>
		</div>
		<div id="prod_content">
		<c:forEach items="${products }" var="prod">
			<div class="prod_div">
			<a href="${ pageContext.request.contextPath }/prodInfo?pid=${prod.id}" target="_blank">
				<img src="${ pageContext.request.contextPath }${prod.imgurl}" border="0"/>
			</a>	
				<div id="prod_name_div">
				<a href="${ pageContext.request.contextPath }/prodInfo?pid=${prod.id}" target="_blank">
					${prod.name }
				</a>
				</div>
				<div id="prod_price_div">
					${prod.price }
				</div>
				<div>
					<div id="gotocart_div">
						<a href="${ pageContext.request.contextPath }/cart/addCart?pid=${prod.id}&buyNum=1">加入购物车</a>
					</div>					
					<div id="say_div">
						133人评价
					</div>					
				</div>
			</div>
		</c:forEach>
			<div style="clear: both"></div>
		</div>
	</div>
	<%@ include file="_foot.jsp" %>
</body>
</html>
