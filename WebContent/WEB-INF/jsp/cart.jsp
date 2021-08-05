<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!DOCTYPE HTML>
<html>
	<head>
		<meta http-equiv="Content-type" content="text/html; charset=UTF-8" />
		<link href="${ pageContext.request.contextPath }/css/cart.css" rel="stylesheet" type="text/css">
	
<!-- 引入jQuery函数库 -->
<script type="text/javascript" src="${ pageContext.request.contextPath }/js/jquery-1.4.2.js"></script>
<script type="text/javascript">
	/* 文档就绪函数 */
	$(function() {
		/* 为"减号"绑定点击事件, 点击"减号"将购买数量输入框中的值减1
		 * 同时利用ajax将session中cartmap中的对应商品的数量减1
		 * 重新计算总金额(包括当前商品的总价和所有商品总价的和)
		 */
		$(".delNum").click(function() {
			//1.点击"减号"将购买数量输入框中的值减1
			//>>获取输入框
			var $buyNumInp = $(this).siblings("input")//input输入框
			var buyNum = $buyNumInp.val();
			var newBuyNum = buyNum;
			if (buyNum > 1) {//购买数量必须要大于等于1
				newBuyNum = buyNum - 1;
				$buyNumInp.val(newBuyNum);
			}

			//2.利用ajax将session中cartmap中的对应商品的购买数量减1
			//>>获取商品的id和购买数量(newBuyNum)
			//var pid = $buyNumInp.attr("id");
			var cartID = $buyNumInp.attr("id");
			//>>发送ajax请求
			$.post("${ pageContext.request.contextPath }/cart/updateBuyNum", {
				"cartID" : cartID,
				"buyNum" : newBuyNum
			});

			//3.重新计算总金额(包括当前商品的总价和所有商品总价的和)
			totalMoney(this, newBuyNum);
		});

		/* 重新计算总金额 */
		function totalMoney(thisobj, newBuyNum) {
			//1.获取当前商品的单价
			var arr = [];//初始化一个数组arr，用于保存获得多选框的值。
			$('input:checkbox:checked').each(function(){
				if($(this).attr("class") != "allC"){
					arr.push($(this).attr('id'));
				}
			});
			var cartIds=arr.toString();
			$("input[name='cartIds']").val(cartIds);
			var price = $(thisobj).parents("ul").find(".li_price").text();

			//2.计算当前商品的总价
			var prod_sum = price * newBuyNum;
			$(thisobj).parents("ul").find(".sum_price").text(prod_sum);

			//4.计算购物车所有商品的总价
			var totalMoney = 0;
			$(".sum_price").each(function() {
				totalMoney += parseFloat($(this).text());
			});

			//设置所有商品的总价
			$("#span_2").text(totalMoney);
		}

		/* 为"加号"绑定点击事件, 点击"加号"将购买数量输入框中的值加1
		 * 同时利用ajax将session中cartmap中的对应商品的数量加1
		 * 重新计算总金额(包括当前商品的总价和所有商品总价的和)
		 */
		$(".addNum").click(function() {
			//1.点击"加号"将购买数量输入框中的值加1
			//>>获取输入框
			var $buyNumInp = $(this).siblings("input")//input输入框
			var buyNum = $buyNumInp.val();
			var newBuyNum = parseInt(buyNum) + 1;
			$buyNumInp.val(newBuyNum);

			//2.利用ajax将session中cartmap中的对应商品的购买数量减1
			//>>获取商品的id和购买数量(newBuyNum)
			var cartID = $buyNumInp.attr("id");
			
			//>>发送ajax请求
			$.post("${ pageContext.request.contextPath }/cart/updateBuyNum", {
				"cartID" : cartID,
				"buyNum" : newBuyNum
			});

			//3.重新计算总金额(包括当前商品的总价和所有商品总价的和)
			totalMoney(this, newBuyNum);
		});

		/* 设置全选和全不选 */
		$(".allC").click(function() {
			$(".prodC").attr("checked", $(this).attr("checked"));
			
		});
		
		/*
		删除所有选中的商品
		*/
		$(".del_all").click(function(){
			//1.删除所有选中的商品
			$("input:checked").each(function(){
				if($(this).attr("class") != "allC"){	
					var cartID=$(this).attr("id"); 				
					$.post("${ pageContext.request.contextPath }/cart/delCart",
							{"cartID":cartID});	
					$(this).parents("ul").remove();
				}
			});
			//2.重新计算购物车中商品的总价
			var totalMoney = 0;
			$(".sum_price").each(function(){
						totalMoney += parseFloat($(this).text());
			});
			//3.设置所有商品的总价
			$("#span_2").text(totalMoney);
		});
		
		/* 删除当前商品 
			* 给每一个商品后面的删除按钮添加点击事件, 
			* 点击"删除"删除当前商品(通过也要删除购物车中的商品)
		*/
		$(".delProd").click(function(){
			//1.获取商品的id
			var cartID = $(this).attr("id");
						
			//2.利用ajax请求删除购物车中指定id的商品(-1后台会删除该商品)
			$.post("${ pageContext.request.contextPath }/cart/delCart",{"cartID":cartID});				
					
			//3.删除当前页面中的商品
			$(this).parents("ul").remove();
					
			//4.重新计算购物车中商品的总价
			var totalMoney = 0;
			$(".sum_price").each(function(){
						totalMoney += parseFloat($(this).text());
			});				
			//设置所有商品的总价
			$("#span_2").text(totalMoney);
			
		});	
		/*	去结算	*/
		$(".goto_order").click(function(){			
			var arr = [];//初始化一个数组arr，用于保存获得多选框的值。
			$('input:checkbox:checked').each(function(){
				if($(this).attr("class") != "allC"){
					arr.push($(this).attr('id'));
				}
			});
			var cartIds=arr.toString();
			//$("input[name='cartIds']").val(cartIds);
			//使用Ajax进行跳转，并带参数
		$.get("${ pageContext.request.contextPath}/order/order_add",{"cartIds":cartIds},function(){
			window.location="${pageContext.request.contextPath}/order/order_add?cartIds="+cartIds;
			});	
			
		});

	});
</script>			
</head>

	</head>
	<body>
	
	<%@ include file="_head.jsp" %>
		<div id="wrap">
			<!-- 标题信息 -->
			<ul id="title">
				<li>
					<input class="allC" name="allC" type="checkbox"/>
					<span id="title_checkall_text">全选</span>
				</li>
				<li class="li_prod">商品</li>
				<li>单价（元）</li>
				<li>数量</li>
				<li>小计（元）</li>
				<li>操作</li>
			</ul>

			<!-- 购物信息 -->
			<c:set var="sum" value="0"/>
			<c:forEach items="${carts}" var="cart">
			<ul class="prods">
				<li>
					<input type="checkbox" class="prodC" name="necartid" id="${cart.cartID }"/> 
				</li>
				<li class="li_prod">
					<img src="${ pageContext.request.contextPath }${cart.imgurl }" 
					width="90" height="90" class="prodimg" />
					<span class="prodname">${cart.name}</span>
				</li>
				<li class="li_price">${cart.price }</li>
				<li>
					<a href="javascript:void(0)" class="delNum" >-</a>
					<input class="buyNumInp" id="${cart.cartID }" type="text"
						 readonly="readonly" value="${cart.num }" />
					<a href="javascript:void(0)" class="addNum" >+</a>
				</li>
				<li class="sum_price">${cart.price*cart.num}</li>
				<li><a id="${ cart.cartID}" class="delProd" href="javascript:void(0)">删除</a></li>
			</ul>
			<c:set var="cartall" value="${cartall+cart.cartID}"/>
			<c:set var="sum" value="${sum + cart.price*cart.num }"/>
			</c:forEach>
			
			
			<!-- 总计条 -->
			<div id="total">
				<div id="total_1">
					<input type="checkbox" class="allC" name="allC"/> 
					<span>全选</span>
					<a id="del_a" class="del_all" href="javascript:void(0)">删除选中的商品</a>
					<div id="div_sum">
						<span id="span_1">总价：</span>
						<span>￥</span>
						<span id="span_2" class="total_sum_price">${sum}</span>&nbsp;&nbsp;&nbsp;
					</div>
				</div>
				
				<div id="total_2">	
					<!--<input name="" type="submit" value="去结算" class="goto_order">-->
					<!--<a class="goto_order" >去结算</a>-->
					 <a class="goto_order href="${pageContext.request.contextPath}/order/order_add?cartIds=${cartall}">去结算</a>
				</div>
				
			</div>
		</div>
	<%@ include file="_foot.jsp" %>
	</body>
</html>