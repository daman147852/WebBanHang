package ptithcm.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import ptithcm.entity.AccountInfo;


@Controller
@RequestMapping("/manages/")
public class AccountController {
	//Hiển thị from đăng nhập
	 
	 @RequestMapping(value = "login", method = RequestMethod.GET)
	public String login(){
		return "Admin/login";
	}
	
	@RequestMapping(value = "login", method = RequestMethod.POST)
	public String login(ModelMap model, @RequestParam("userName")String id,
			@RequestParam("password") String password){
		model.addAttribute("message", "Ma đăng nhập là" + id);
		return "Admin/login";
	}
	
	@RequestMapping(value = "register")
		public String register(){
			return "Admin/register";
	}
	
	@RequestMapping(value  = "register", method= RequestMethod.POST)
	public String register(ModelMap model, @ModelAttribute("user") AccountInfo info){
		model.addAttribute("message", "Đăng kí thành công!");
		return "Admin/success";
	}
	
	@RequestMapping(value = "{id}/activate", method = RequestMethod.GET)
	public String activate(ModelMap model, @PathVariable("id")String id){
		model.addAttribute("message", "Tài khoản" +id+ "đã được kich hoạt");
		return "Amin/activate";
	}
	
}
