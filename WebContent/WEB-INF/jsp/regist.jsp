<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String emailV=(String)request.getAttribute("emailV");
%>
<!DOCTYPE HTML>
<html>
	<head>
	<base href="<%=basePath%>">
		<title>欢迎注册EasyMall</title>
		<meta http-equiv="Content-type" content="text/html; charset=UTF-8" />
		<link rel="stylesheet" href="${ pageContext.request.contextPath }/css/regist.css"/>
		<script  type="text/javascript" src="${ pageContext.request.contextPath }/js/jquery-1.4.2.js"></script>
		<script type="text/javascript" src="js/jsEmail.js"></script>
		<script type="text/javascript">
			/* 点击图片换一张验证码  */
			//浏览器只要发现图片的src地址变化，图片就会变化。
			$(function(){

				
				$("#img").click(function(){
					$(this).attr("src","${ pageContext.request.contextPath }/index/valiImage?time="+new Date().getTime());
				});
				
				//给所有输入框添加失去输入焦点的事件  当失去输入焦点时检查输入是否为空或者两次密码是否一致，或者邮箱格式是否正确。
				$("input[name='username']").blur(function(){
					if(!formobj.checkNull("username", "用户名不能为空！")){
						return false;						
					}else{
						var url="${ pageContext.request.contextPath }/user/checkUser";
						var username=$("input[name='username']").val();
						$.post(url,{"username":username},
							function(data){
								$("#username_msg").html(data);
							}
						);
					}
				});
				$("input[name='password']").blur(function(){
					formobj.checkNull("password", "密码不能为空！");	
					formobj.checkPassword("password","两次密码输入不一致");
				});
				$("input[name='password2']").blur(function(){
					formobj.checkNull("password2", "确认密码不能为空！");		
					formobj.checkPassword("password","两次密码输入不一致");
				});
				$("input[name='nickname']").blur(function(){
					formobj.checkNull("nickname", "昵称不能为空！");
				});
				$("input[name='email']").blur(function(){
					formobj.checkNull("email", "邮箱不能为空！");
					formobj.checkEmail("email", "邮箱格式不正确！");
				});
				$("input[name='valistr']").blur(function(){
					formobj.checkNull("valistr", "验证码不能为空！");
				});
				
			});
			var vv=0;
			/*注册表单的js校验*/
			var formobj={
				"checkForm":function(){
					//1.非空校验				
					var res1=this.checkNull("username", "用户名不能为空！");
					var res2=this.checkNull("password", "密码不能为空！");
					var res3=this.checkNull("password2", "确认密码不能为空！");
					var res4=this.checkNull("nickname", "昵称不能为空！");
					var res5=this.checkNull("email", "邮箱不能为空！");
					var res6=this.checkNull("valistr", "验证码不能为空！");
					var res7=this.checkPassword("password","两次密码输入不一致");
					var res8=this.checkEmail("email","邮箱格式不正确！");
					return res1 && res2 && res3 && res4 && res5 && res6 && res7 && res8;				
				},
				"checkEmailValistr":function(name,ms){
					
					$.ajax({
						url: 'EmailServlet?method=verify',
						type: 'post',
						data: {vcode: $("input[name='emailValistr']").val()},
						dataType: 'text',
						async:false,
						success: function(msg) {
							if(msg == 1){
								//console.log("msg="+msg);
								//console.log("成功");
								formobj.setMsg(name, msg);
								$("#message").html(msg);

							}
							else{
								//console.log("msg="+msg);
								//console.log("失败");
								formobj.setMsg(name, msg);
								$("#message").html(msg);
							}
						},
						error:function(msg){
							
						}
						
					});
					//console.log("checkEmailValistr中message="+$("#message").html());
					if($("#message").html()=="1"){
						return true;
					}
					return false;	
				},
				"checkNull":function(name,msg){
					var value=$("input[name='"+name+"']").val();  
					this.setMsg(name,"");
					if(value.trim()==""){
						this.setMsg(name, msg);
						return false;
					}
					return true;
				},
				/* 设置错误提示消息  */
				"setMsg":function(name,msg){
					var $span=$("input[name='"+name+"']").nextAll("span");	
					$span.html(msg);
					$span.css("color","red");
				},
				
				//2.两次密码是否一致校验
				"checkPassword":function(name,msg){
					var pwd=$("input[name='"+name+"2']").val().trim();
					var pwd2=$("input[name='"+name+"']").val().trim();
					
				  	if( pwd!="" && pwd2!=""){
				  		//清空之前的消息。
		//				this.setMsg(name+"2","");
				  		if(pwd!= pwd2){
							this.setMsg(name+"2", msg);
							return false;
						}
				  	}
				  	return true;
				},
				//3.邮箱格式校验
				"checkEmail":function(name,msg){
					var email=$("input[name='"+name+"']").val().trim();
					var regExp=/^\w+@\w+(\.\w+)+$/;
					if(email!=""){
						if(!regExp.test(email)){
							this.setMsg(name, msg);
							return false;
						}
					}
					return true;
				}
				
				
			};
			</script>
	</head>
	<body>
	<div id="line3">
		<div id="content">
			<ul>
				<li><a href="${ pageContext.request.contextPath}/index">返回</a></li>
			</ul>
		</div>
	</div>
	<!-- onsubmit事件在表单提交时触发，该事件会根据返回值决定是否提交表单，  
	          如果onsubmit="return true"会继续提交表单，如果onsubmit="return false" 
	          表单将不会提交 
	     onsubmit="" 引号中报错并不是因为代码有问题，而是MyEclipse工具在检查语法认为这个代码有问题。其实没有错误     
	-->
		<form  onsubmit="return formobj.checkForm();" action="${ pageContext.request.contextPath }/user/regist" method="POST">
			<h1>欢迎注册EasyMall</h1>
			<table>
				<tr>
					<td colspan="2" style="color:red;text-align:center;"></span>${ msg }</td>
				</tr>
			
				<tr>
					<td class="tds">用户名：</td>
					<td>
						<input type="text" name="username" value="${ param.username }"/>
						<span id="username_msg"></span>
					</td>
					
				</tr>
				<tr>
					<td class="tds">密码：</td>
					<td>
						<input type="password" name="password"  value="${ param.password }"/>
						<span></span>
					</td>
				</tr>
				<tr>
					<td class="tds">确认密码：</td>
					<td>
						<input type="password" name="password2" value="${ param.password2 }"/>
						<span></span>
					</td>
				</tr>
				<!--<tr>
					<td class="tds">昵称：</td>
					<td>
						<input type="text" name="nickname"  value="${ param.nickname }"/>
						<span></span>
					</td>
				</tr>
				<tr>
					<td class="tds">邮箱：</td>
					<td>
						<input type="text" name="email" value="${ param.email }"/>
						<button id="btnGetVcode" >获取验证码</button>
						<span></span>
					</td>
				<td>
                	
                </td>
				</tr>
				<tr>
					<td class="tds">邮箱验证：</td>
					<td>
						<input type="text" name="emailValistr" value="${ param.emailValistr }"/>
						<button type="button" id="btnVerify" style="cursor:pointer">验证</button>
						<span id="message"></span>
					</td>
					 
				</tr>
				<tr>
					<td class="tds">页面验证：</td>
					<td>
						<input  type="text" name="valistr" value=""/>
						
						<img id="img"  src="${ pageContext.request.contextPath }/index/valiImage"/>
						<span ></span>
					</td>
				</tr>
				-->
				<tr>
					<td class="sub_td" colspan="2" class="tds">
						<input type="submit" value="注册用户"/>
					</td>
				</tr>
			</table>
		</form>
		
	</body>
</html>