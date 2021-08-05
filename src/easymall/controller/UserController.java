package easymall.controller;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.CollectionUtils;
import org.springframework.validation.Errors;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import easymall.po.Category;
import easymall.po.User;
import easymall.service.ProductsService;
import easymall.service.UserService;
@Controller("userController")
public class UserController {
	@Autowired
	private ProductsService productsService;
	@Autowired
	private UserService userService;
	private static final Log logger = LogFactory.getLog(UserController.class);
	//�����¼
	@RequestMapping("/user/login")
	public String login(User user, HttpSession session, Model model) {	
		
		User muser=userService.login(user);
   		if(muser!=null){
   			session.setAttribute("user", muser);
   			User user2=new User(100,"xi","123","123","12@qq.com");
   			session.setAttribute("admin", user2);
   			List<Category> categorys=productsService.allcategorys();
			session.setAttribute("categorys", categorys);
   			if(muser.getId()==1){
   				session.setAttribute("admin", muser);
   				return "redirect:/admin/manage";
   			}
			logger.info("�ɹ�");
			model.addAttribute("message","��¼�ɹ�");
//			return "main";//����main.jsp
   			return "redirect:/index.jsp";
		}else {
			logger.info("ʧ��");
			model.addAttribute("message","��¼ʧ�ܣ��û������������");
//			System.out.println("ʧ��");
			return "login";//����login.jsp
		}
	}
	@RequestMapping("/user/regist")
	public String regist(@Valid User user,Errors error,String valistr,HttpSession session,Model model){
//			if(!valistr.equalsIgnoreCase(session.getAttribute("code").toString())){
//				model.addAttribute("msg", "��֤�����");
//				return "regist";
//			}
			List<ObjectError> objectErrorList = error.getAllErrors();
	        List<String> errorMessageList = new ArrayList<>();
	        if(!CollectionUtils.isEmpty(objectErrorList)){
	            //����ǿ�
	            for(ObjectError errors : objectErrorList){
	                 errorMessageList.add(errors.getDefaultMessage());
	            }
	        }
			if(userService.regist(user)>0&&!error.hasErrors()){
//				session.setAttribute("user",user);
	//?username=2&password=2&password2=2&nickname=2&email=2@2.com
				model.addAttribute("msg", "ע��ɹ�");
				return "regist";
			}else{
				model.addAttribute("msg", "ע��ʧ��"+errorMessageList);
				return "regist";	
			}
//		System.out.println(user.getEmail());
	}
	@RequestMapping(value="/user/checkUser",method=RequestMethod.POST)
	public void check(HttpServletRequest request,HttpServletResponse response)
			throws IOException{
		String username=request.getParameter("username");
		if(userService.checkUsername(username))
			response.getWriter().print("�û���"+username+"�ѱ�ע��!");
		else
			response.getWriter().print("��ϲ��,"+username+"����ʹ��!");		
	}	
}
