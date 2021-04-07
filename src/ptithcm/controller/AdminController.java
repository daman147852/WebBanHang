package ptithcm.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.transaction.Transactional;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import jdk.management.resource.internal.inst.SocketOutputStreamRMHooks;
import ptithcm.entity.Admin;
import ptithcm.entity.Order;

@Transactional
@Controller
@RequestMapping("admin")
public class AdminController {
	@Autowired
	SessionFactory factory;
	
	@RequestMapping("home")
	public String home(HttpServletRequest request, HttpServletResponse response){
		HttpSession adsession = request.getSession();
		adsession.getAttribute("admin");
		if(adsession.getAttribute("admin")==null){
			return "redirect:/home/login.htm";
		}
		return "admin/home";
	}
	
	@RequestMapping("logout")
	public String logout(HttpServletRequest request){
		HttpSession logoutsession = request.getSession();
		logoutsession.removeAttribute("admin");
		return "redirect:/home/index.htm";
	}
	
	public List<Order> getOrders() {
		Session session = factory.getCurrentSession();
		String hql = "FROM Order";
		Query query = session.createQuery(hql);
		List<Order> list = query.list();
		return list;
	}
	
	@RequestMapping("manage")
	public String manage(ModelMap model, HttpServletRequest request, HttpServletResponse response){
		HttpSession adsession = request.getSession();
		adsession.getAttribute("admin");
		if(adsession.getAttribute("admin")==null){
			return "redirect:/home/login.htm";
		}
		model.addAttribute("orders", getOrders());
		return "admin/manage";
	}
}
