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
		 width: 30%; 
		text-align:left;
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
<script src="${ pageContext.request.contextPath }/js/echarts.js" ></script>
</head>
<body>
	<h2>销售榜单</h2>
	<div><a href="${pageContext.request.contextPath}/admin/manage">> 返回后台主页</a></div>
	<table border="1">
		<tr>
			<th class="ths">商品名称</th>
			<th class="ths">销售量</th>
		</tr>
		<c:forEach items="${orderitems }" var="prod">
		<tr >
			<td>${prod.order_id}</td>
			<td>${prod.buynum}</td>
		</tr>
		</c:forEach>
	</table>
	<table >
	<tr>
                <td>
                    <!-- 为ECharts准备一个具备大小（宽高）的Dom -->
                    <div  id="main" style="width: 400px;height:400px;text-align:right"></div>
                    <div id="main2" style="width: 400px;height:400px;text-align:left" ></div>
                    <script type="text/javascript">
                        // 基于准备好的dom，初始化echarts实例
                        var myChart2 = echarts.init(document.getElementById('main'));
						var listnum2=${listnum};
						//var listname=${listname};
						//alert(listname);
                        // 指定图表的配置项和数据
                        option2 = {
                    title : {
                        text: '销售量',
                       // subtext: '纯属虚构'
                    },
                    tooltip : {
                        trigger: 'axis'
                    },
                    legend: {
                        data:['销售量']
                    },
                    toolbox: {
                        show : true,
                        feature : {
                            dataView : {show: true, readOnly: false},
                            magicType : {show: true, type: ['line', 'bar']},
                            restore : {show: true},
                            saveAsImage : {show: true}
                        }
                    },
                    calculable : true,
                    xAxis : [
                        {
                            type : 'category',
                            data : ['1','2','3','4','5','6','7','8','9','10','11','12']
                        }
                    ],
                    yAxis : [
                        {
                            type : 'value'
                        }
                    ],
                    series : [
                        {
                            name:'蒸发量',
                            type:'bar',//[2.0, 4.9, 7.0, 23.2, 25.6, 76.7, 135.6, 162.2, 32.6, 20.0, 6.4, 3.3]
                            data:listnum2,
                            markPoint : {
                                data : [
                                    {type : 'max', name: '最大值'},
                                    {type : 'min', name: '最小值'}
                                ]
                            },
                            markLine : {
                                data : [
                                    {type : 'average', name: '平均值'}
                                ]
                            }
                        }
                    ]
                };

                        // 使用刚指定的配置项和数据显示图表。
                        myChart2.setOption(option2);
                    </script>
                </td>
            </tr>
     
	 <tr>
    <script type="text/javascript">
        // 基于准备好的dom，初始化echarts实例
        var myChart = echarts.init(document.getElementById('main2'));
        var listnum3=${listnum};
        // 指定图表的配置项和数据
        var option = {
            title: {
                text: '销售量'
            },
            tooltip: {},
            legend: {
                data:['销量']
            },
            xAxis: {
                data: ["1","2","3","4","5","6"]
            },
            yAxis: {},
            series: [{
                name: '销量',
                type: 'pie',
                data: listnum3
            }]
        };
 
        // 使用刚指定的配置项和数据显示图表。
        myChart.setOption(option);
        </script>
            </tr>
</table>
	<div style="float: right">
    	<form action="${pageContext.request.contextPath}/admin/downExcel">
        	<input type="submit" value="报表导出">
    	</form>
	</div>
</body>
</html>
