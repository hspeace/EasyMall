<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE HTML>
<html>
<head>
	<meta http-equiv="Content-type" content="text/html; charset=UTF-8" />
	<link href="${ pageContext.request.contextPath }/css/addOrder.css" rel="stylesheet" type="text/css">
</head>
<body>
	<%@ include file = "_head.jsp" %>
	<div class="warp">
		<form action="${ pageContext.request.contextPath }/order/addOrder" name="form1" method="post">
			<h3>增加订单</h3>
			<div id="forminfo">
				<span class="lf" style="vertical-align: middle;">收货地址：</span> 
				 <textarea name="receiverinfo" id="textarea" cols="35" rows="3">佛山市南海区狮山镇狮山大学城华南师范大学南海校区</textarea>
				 </br>
				<!--   <%@ include file = "baidu.jsp" %>-->
				  <script> 
      //同步函数 <label for="textarea">233</label>
      //function synchronize(){ 
      //  document.getElementById('textarea').value =document.getElementById('cityName').value; 
        //alert("同步成功"); 
    // } 
      //执行同步 
     // setInterval(synchronize,500);//同步的时间间隔，每0.5秒同步一次 
      </script> 
				<br> 支付方式：在线支付
				  	   <input type="hidden" name="cartIds" value="${cartIds }">
			</div>
			<table width="999" height="80" border="1" cellpadding="0" cellspacing="0" bordercolor="#d8d8d8">
				<tr>
					<th width="276">商品图片</th>
					<th width="247">商品名称</th>
					<th width="231">商品单价</th>
					<th width="214">购买数量</th>
					<th width="232">总价</th>
				</tr>
			<c:set var="sum" value="0"/>
			<c:forEach items="${carts }" var="cart">
				<tr>
					<td><img src="${ pageContext.request.contextPath }${cart.imgurl}" 
					width="90" height="90" class="prodimg" /></td>
					<td>${cart.name}</td>
					<td>${cart.price}</td>
					<td>${cart.num}</td>
					<td>${cart.price*cart.num}</td>
				</tr>
				<c:set var="sum" value="${sum+cart.price*cart.num }"/>
				</c:forEach>
			</table>

			<div class="Order_price">总价：${sum}元</div>

			<div class="add_orderbox">
				<input name="" type="submit" value="增加订单" class="add_order_but">
			</div>
		</form>
	</div>
	<%@ include file = "_foot.jsp" %>
</body>
</html>
