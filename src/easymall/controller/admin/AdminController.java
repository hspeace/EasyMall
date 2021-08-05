package easymall.controller.admin;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import easymall.controller.BaseController;
import easymall.exception.UserLoginNoException;
import easymall.po.User;

@Controller
@RequestMapping("/admin")
public class AdminController extends BaseController{
	@RequestMapping("/manage")
	public String toManager(HttpSession session,HttpServletRequest request) throws UserLoginNoException{
		User admin=(User)session.getAttribute("admin");
		if(admin.getId()==1){
			return "admin/manage";
		}else{
			throw new UserLoginNoException("ÇëÏÈµÇÂ¼");
		}
	}
//	@RequestMapping("/login")
//	public String toLogin(){
//		return "admin/manage";
//	}
//	@RequestMapping("/prod_list")
//	public String tolist(){
//		return "admin/prod_list";
//	}
}
