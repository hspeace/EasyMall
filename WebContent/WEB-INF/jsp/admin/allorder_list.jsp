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
		width:20px;
		height:15px;
		font-size: 18px;
		text-align:center;
	}
	div.divcss5{
	margin:0 auto;border:1px solid #000;width:200px;height:30px
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
	<h2>订单管理</h2>
	<div><a href="${pageContext.request.contextPath}/admin/manage">> 返回后台主页</a></div>
	<table border="1">
		<c:forEach items="${orderInfos }" var="orderInfo"> 
	<div style="margin: 0 auto;width:999px;">
		<dl class="Order_information">
			<dt>
				<h3>订单信息</h3>
			</dt>
			<dd style="line-height: 26px;">
				订单编号：${orderInfo.order.id }
				<br />
				下单时间：${orderInfo.order.ordertime }
				<br /> 
				订单金额：${orderInfo.order.money }
				<br /> 
				支付状态：
				<c:if test="${orderInfo.order.paystate==0 }">
						<font color="red">未支付</font>&nbsp;&nbsp;
						<a href="${ pageContext.request.contextPath }/order/delorder?id=${orderInfo.order.id}">
							<img src="${ pageContext.request.contextPath }/img/orderList/sc.jpg" 
							width="69" height="19"/>
							</a>
							&nbsp;
							<a href="${ pageContext.request.contextPath }/order/payorder?id=${orderInfo.order.id}">
							<img src="${ pageContext.request.contextPath }/img/orderList/zx.jpg" width="69" height="19"/>
						</a>
				</c:if>
				<c:if test="${orderInfo.order.paystate==1 }">
						<font color="blue">已支付</font>&nbsp;&nbsp;
						<a href="${ pageContext.request.contextPath }/order/payorder?id=${orderinfo.order.id}">
						确认收货
						</a>
				</c:if>
				<br /> 
				所属用户：${user.username }
				<br/> 
				收货地址：${orderInfo.order.receiverinfo }
				<br/> 
				支付方式：在线支付
			</dd>
		</dl>
	
		<table width="999" border="0" cellpadding="0"
			cellspacing="1" style="background:#d8d8d8;color:#333333">
			<tr>
				<th width="276" height="30" align="center" valign="middle" bgcolor="#f3f3f3">商品图片</th>
				<th width="247" align="center" valign="middle" bgcolor="#f3f3f3">商品名称</th>
				<th width="231" align="center" valign="middle" bgcolor="#f3f3f3">商品单价</th>
				<th width="214" align="center" valign="middle" bgcolor="#f3f3f3">购买数量</th>
				<th width="232" align="center" valign="middle" bgcolor="#f3f3f3">总价</th>
			</tr>
			<c:forEach items="${orderInfo.map }" var="entry">
			<tr>
				<td align="center" valign="middle" bgcolor="#FFFFFF">
					<img src="${ pageContext.request.contextPath }${entry.key.imgurl}" width="90" height="105">
				</td>
				<td align="center" valign="middle" bgcolor="#FFFFFF">${entry.key.name}</td>
				<td align="center" valign="middle" bgcolor="#FFFFFF">${entry.key.price}元</td>
				<td align="center" valign="middle" bgcolor="#FFFFFF">${entry.value}件</td>
				<td align="center" valign="middle" bgcolor="#FFFFFF">${entry.key.price*entry.value}元</td>
			</tr>
			</c:forEach>
		</table>
		<div  class="divcss5">订单总价：${orderInfo.order.money}元</div>
	</div>
	</c:forEach>
	</table>
</body>
</html>
