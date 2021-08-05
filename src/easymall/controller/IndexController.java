package easymall.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import easymall.po.Category;
import easymall.service.ProductsService;

@Controller("indexController")
//@RequestMapping("/index")
public class IndexController {
	@RequestMapping("index")
	public String index(){
		return "redirect:/index.jsp";
	}
	@RequestMapping("index/login")
	public String login(){
		return "login";
	}
	@RequestMapping("index/regist")
	public String register(){
		return "regist";
	}
	@RequestMapping("index/logout")
	public String logout(HttpSession session){
		session.invalidate();
		return "redirect:/index.jsp";
	}

}
