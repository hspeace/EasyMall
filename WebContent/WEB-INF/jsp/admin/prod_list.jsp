<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE HTML>
<html>
<head>
<title>商品管理</title>
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
			$.post("${ pageContext.request.contextPath }/admin/delprod",{"id":id});				
					
			//3.删除当前页面中的商品
			$(this).parents("tr").remove();
		});	
		$(".update").change(function(){
			//1.获取商品的id
			var id = $(this).attr("id");
			var value=$(this).attr("value");
			var index=$(this).parent().index();
			switch(index){
			case 2:
				$.post("${ pageContext.request.contextPath }/admin/updateprod",{
					"id":id,
					"name":value,
					"category":-1,
					"price":-1,
					"pnum":-1,
					"description":" "
				});
				break;
			case 3:
				$.post("${ pageContext.request.contextPath }/admin/updateprod",{
					"id":id,
					"category":value,
					"name":" ",
					"price":-1,
					"pnum":-1,
					"description":" "
				});
				break;
			case 4:
				$.post("${ pageContext.request.contextPath }/admin/updateprod",{
					"id":id,
					"price":value,
					"category":-1,
					"name":" ",
					"pnum":-1,
					"description":" "
				});
				break;
			case 5:
			$.post("${ pageContext.request.contextPath }/admin/updateprod",{
				"id":id,
				"pnum":value,
				"category":-1,
				"name":" ",
				"price":-1,
				"description":" "
			});
			//alert("ddd");
			break;
			default:
				$.post("${ pageContext.request.contextPath }/admin/updateprod",{
					"id":id,
					"description":value,
					"category":-1,
					"name":" ",
					"price":-1,
					"pnum":-1,
				});
			}
					
			//alert(index);
		});	
	});
	
</script>
</head>
<body>
	<h2>商品管理</h2>
	<div><a href="${pageContext.request.contextPath}/admin/manage">> 返回后台主页</a></div>
	<table border="1">
		<tr>
			<th>商品图片</th>
			<th width="200px">商品ID</th>
			<th class="ths">商品名称</th>
			<th class="ths">商品种类</th>
			<th class="ths">商品单价</th>
			<th class="ths">库存数量</th>
			<th>描述信息</th>
			<th width="50px">操 作</th>
		</tr>
		<c:forEach items="${products }" var="prod">
		<tr >
			<td>
				<img width="120px" height="120px" src="${ pageContext.request.contextPath }${prod.imgurl}" alt="" >
			</td>
			<td>${prod.id}</td>
			<td>
			<input type="text" id="${prod.id}" class="update" value="${prod.name}"/>
			</td>
			<td>
			<input type="text" id="${prod.id}" class="update" value="${prod.category}"/>
			</td>
			<td>
			<input type="text" id="${prod.id}" class="update" value="${prod.price }"/>
			</td>
			<td>
				<input type="text" id="${prod.id}" class="update" value="${prod.pnum}"/>
			</td>
			<td>
			<input type="text" id="${prod.id}" class="update" value="${prod.description}"/>
			</td>
			<td><a id="${prod.id}"class="del" href="javascript:void(0)">删 除</a></td>
		</tr>
		</c:forEach>
	</table>
</body>
</html>
