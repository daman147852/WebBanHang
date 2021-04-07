package ptithcm.controller;

import java.util.Date;

import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;


import ptithcm.bean.SentMail;
import ptithcm.entity.Order;
import ptithcm.entity.Product;
import ptithcm.entity.Type;
import ptithcm.entity.User;

@Transactional
@Controller
@RequestMapping("/home/")
public class HomeController {
	@Autowired
	SessionFactory factory;
	
	@Autowired
	SentMail SentMail;
	
	//Trang index
	@RequestMapping("index")
	public String index(ModelMap model, HttpServletRequest request, HttpServletResponse response){
		HttpSession UserSession = request.getSession();
		if(UserSession.getAttribute("user")==null){
			model.addAttribute("checkLogin", false);
		}
		else{
			model.addAttribute("checkLogin", true);
		}
		Session session = factory.getCurrentSession();
		String hql = "FROM Product";
		Query query = session.createQuery(hql);
		List<Product> list = query.list();
		model.addAttribute("products", list);
		model.addAttribute("types", getTypes());
		return "home/index";
	}
	
	// Đăng nhập
	@RequestMapping(value="login", method=RequestMethod.GET)
	public String login(){
		return "home/login";
	}
	
	@RequestMapping(value="login", method=RequestMethod.POST)
	public String login(HttpServletRequest request, ModelMap model){
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		
		Session session = factory.getCurrentSession();
		String hql = "FROM User";
		Query query = session.createQuery(hql);
		List<User> list = query.list();	
		System.out.println("flac1");
		for(User us : list){
			if(username.equals(us.getUsername()) == true){
				if(password.equals(us.getPassword()) == false){
					model.addAttribute("message2", "Sai mật khẩu!");
					return "home/login";
				}
				else{
					if(us.getRole() == true) {
						HttpSession AdminSession = request.getSession();
						AdminSession.setAttribute("admin", us);
						return "redirect:/admin/home.htm";
					}
					else {
						HttpSession UserSession = request.getSession();
						UserSession.setAttribute("user", us);
						return "redirect:/home/index.htm";
					}
				}
			}
		}
		model.addAttribute("message1", "Tài khoản đăng nhập không đúng!");
		return "home/login";
	}
	
	//Đăng xuất
	@RequestMapping("logout")
	public String logout(ModelMap model, HttpServletRequest request){
		HttpSession logoutsession = request.getSession();
		logoutsession.removeAttribute("user");	
		return "redirect:/home/index.htm";
	}
	
	// Đăng kí
	@RequestMapping(value="register", method=RequestMethod.GET)
	public String register(ModelMap model){
		model.addAttribute("user", new User());
		model.addAttribute("types", getTypes());
		return "home/register";
	}
	@RequestMapping(value="register", method=RequestMethod.POST)
	public String register1(ModelMap model, @ModelAttribute("user") User user, HttpServletRequest request, BindingResult errors){
		String repass = request.getParameter("repass");
		model.addAttribute("types", getTypes());
		if(user.getUsername().length()==0){
			errors.rejectValue("username", "user", "Username không được bỏ trống!");
		}
		if(user.getEmail().length()==0){
			errors.rejectValue("email", "user", "Vui lòng nhập địa chỉ mail!");
		}
//		if(user.getEmail().length()!=0){
//			if(checkEmail(user.getEmail())==false){
//				errors.rejectValue("email",  "user", "Địa chỉ mail không hợp lệ, vui lòng nhập lại!");
//			}
//		}
		if(user.getPassword().length()==0){
			errors.rejectValue("password", "user", "Mật khẩu không được bỏ trống!");
		}
		if(user.getFullname().length()==0){
			errors.rejectValue("fullname", "user", "Vui lòng nhập tên đầy đủ!");
		}
		if(user.getPhone().length()==0){
			errors.rejectValue("phone", "user", "Số điện thoại không được bỏ trống!");
		}
		if(user.getAddress().length()==0){
			errors.rejectValue("address", "user", "Vui lòng nhập địa chỉ!");
		}
		if(repass.length() == 0) {
			model.addAttribute("message_repass", "Vui lòng xác nhận mật khẩu!");
			return "home/register";
		}else{
			if(repass.equals(user.getPassword()) == false) {
				model.addAttribute("message_repass", "Xác nhận mật khẩu không đúng, vui lòng nhập lại!");
				return "home/register";
			}
			List<User> checkUser = getUsers();
			for(User us : checkUser) {
				if(user.getUsername().equals(us.getUsername()) == true) {
					errors.rejectValue("username", "user", "User đã tồn tại!");
					return "home/register";
				}
			}
			Session session = factory.openSession();
			Transaction t = session.beginTransaction();
			try{
				user.setRole(false);
				session.save(user);
				t.commit();
				SentMail.send("moaccquyen@gmail.com", user.getEmail(), "XÁC NHẬN ĐÃ ĐĂNG KÍ TÀI KHOẢN", "Đăng kí thành công tài khoản trên SonShop với User: " + user.getUsername() + ". Chào mừng bạn tới cửa hàng của chúng tôi!!");
				model.addAttribute("message", "Đăng kí thành công!");
				return "redirect:/home/login.htm";
			}
			catch(Exception e){
				t.rollback();
				System.out.println(e);
				model.addAttribute("message", "Đăng kí thất bại!");
			}
			finally{
				session.close();
			}
		}
		return "home/register";
	}
	
	public Boolean checkEmail(String email) {
        String emailPattern = "^[\\w!#$%&’*+/=?`{|}~^-]+(?:\\.[\\w!#$%&’*+/=?`{|}~^-]+)*@(?:[a-zA-Z0-9-]+\\.)+[a-zA-Z]{2,6}$";
        Pattern regex = Pattern.compile(emailPattern);
        Matcher matcher = regex.matcher(email);
        if (matcher.find()) {
            return true;
        } else {
            return false;
        }
	}
	
	public List<User> getUsers() {
		Session session = factory.getCurrentSession();
		String hql = "FROM User";
		Query query = session.createQuery(hql);
		List<User> list = query.list();
		return list;
	}
	

	public List<Type> getTypes() {
		Session session = factory.getCurrentSession();
		String hql = "FROM Type";
		Query query = session.createQuery(hql);
		List<Type> list = query.list();
		return list;
	}
	
	
	public List<Product> getProducts() {
		Session session = factory.getCurrentSession();
		String hql = "FROM Product";
		Query query = session.createQuery(hql);
		List<Product> list = query.list();
		return list;
	}
	
	//Thông tin Son
	@RequestMapping("product/{id}")
	public String show(ModelMap model, @PathVariable("id") Integer id, HttpServletRequest request, HttpServletResponse response){
		HttpSession UserSession = request.getSession();
		UserSession.getAttribute("user");
		if(UserSession.getAttribute("user")==null){
			model.addAttribute("checkLogin", false);
		}
		else{
			model.addAttribute("checkLogin", true);
		}
		Session session = factory.getCurrentSession();
		Product product = (Product) session.get(Product.class, id);
		model.addAttribute("product", product);
		model.addAttribute("products", getProducts());
		model.addAttribute("types", getTypes());
		return "home/show";
	}
	
	//Tìm kiếm Son
	@RequestMapping("{id}")
	public String search(ModelMap model, @PathVariable("id") Integer id, HttpServletRequest request, HttpServletResponse response){
		HttpSession UserSession = request.getSession();
		UserSession.getAttribute("user");
		if(UserSession.getAttribute("user")==null){
			model.addAttribute("checkLogin", false);
		}
		else{
			model.addAttribute("checkLogin", true);
		}
		Session session = factory.getCurrentSession();
		String hql = "FROM Product p WHERE p.type.id = " + id;
		Query query = session.createQuery(hql);
		List<Product> list = query.list();
		model.addAttribute("products", list);
		model.addAttribute("types", getTypes());
		return "home/search";
	}
	
	@RequestMapping("search")
	public String outputSearch(ModelMap model, HttpServletRequest request, HttpServletResponse response){
		HttpSession UserSession = request.getSession();
		UserSession.getAttribute("user");
		if(UserSession.getAttribute("user")==null){
			model.addAttribute("checkLogin", false);
		}
		else{
			model.addAttribute("checkLogin", true);
		}
		String kw = request.getParameter("search");
		Session session = factory.getCurrentSession();
		String hql = "FROM Product p WHERE p.name LIKE '%" + kw + "%'";
		Query query = session.createQuery(hql);
		List<Product> list = query.list();
		model.addAttribute("products", list);
		model.addAttribute("types", getTypes());
		model.addAttribute("keyword", kw);
		return "home/outputSearch";
	}
	
	// Đặt hàng
	@RequestMapping(value="order/{id}", method=RequestMethod.GET)
	public String order(ModelMap model, @PathVariable("id") Integer id, HttpServletResponse response, HttpServletRequest request){
		HttpSession UserSession = request.getSession();
		UserSession.getAttribute("user");
		if(UserSession.getAttribute("user")==null){
			return "redirect:/home/index.htm";
		}
		Session session = factory.getCurrentSession();
		Product product = (Product) session.get(Product.class, id);
		model.addAttribute("product", product);
		model.addAttribute("products", getProducts());
		return "home/order";
	}
	
	@RequestMapping(value="order/{id}", method=RequestMethod.POST)
	public String order1(ModelMap model, @PathVariable("id") Integer id, HttpServletResponse response, HttpServletRequest request){
		HttpSession  UserSession = request.getSession();
		User user = (User)  UserSession.getAttribute("user");
		if( UserSession.getAttribute("user")==null){
			return "redirect:/home/index.htm";
		}
		Session session = factory.getCurrentSession();
		Product product = (Product) session.get(Product.class, id);
		model.addAttribute("product", product);
		model.addAttribute("products", getProducts());
		String fullname = request.getParameter("fullname");
		String address = request.getParameter("address");
		String	phone = request.getParameter("phone");
		String total = request.getParameter("amount");
		if(fullname.length()==0){
			model.addAttribute("message", "Vui lòng điền đầy đủ họ tên!");
			return "home/order";
		}
		else if(address.length()==0){
			model.addAttribute("message", "Vui lòng điền đầy đủ địa chỉ!");
			return "home/order";
		}
		else if(phone.length()==0){
			model.addAttribute("message", "Vui lòng điền số điện thoại!");
			return "home/order";
		}
		else if(total.length()==0){
			model.addAttribute("message", "Vui lòng điền số lượng!");
			return "home/order";
		}
		else{
			Session session1 = factory.openSession();
			Transaction t1 = session1.beginTransaction();
			Session session2 = factory.openSession();
			Transaction t2 = session2.beginTransaction();
			Order order = new Order();
			try{
				Integer newAmount = product.getAmount() - Integer.parseInt(total);
				product.setAmount(newAmount);
				session1.update(product);
				t1.commit();
				
			}catch(Exception e){
				t1.rollback();
			}
			try{
				order.setDate(new Date());
				order.setAmount(Integer.parseInt(total));
				order.setCusadd(address);
				order.setCusname(fullname);
				order.setCusphone(phone);
				order.setProduct(product);
				order.setUser(user);
				session2.save(order);
				t2.commit();
				model.addAttribute("message", "Đặt hàng thành công!");
				SentMail.send("moaccquyen@gmail.com", user.getEmail(), "ĐẶT HÀNG THÀNH CÔNG", "Đặt hàng thành công!! Đơn hàng đã được chuyển giao cho đơn vị xử lí"
						+ " sẽ giao cho bạn trong 2 ngày kể từ ngày đặt hàng"
						+ " SonShop xin cảm ơn!"
						);
			}
			catch(Exception e){
				t2.rollback();
				model.addAttribute("message", "Đặt hàng thất bại!");
			}
			finally {
				session1.close();
				session2.close();
			}
		}
		return "home/order";
	}
	
	@RequestMapping("history")
	public String history(ModelMap model, HttpServletRequest request, HttpServletResponse response)
	{
		HttpSession UserSession = request.getSession();
		UserSession.getAttribute("user");
		if(UserSession.getAttribute("user")==null){
			model.addAttribute("checkLogin", false);
			return "redirect:/home/login.htm";
		
		}
		else{
			model.addAttribute("checkLogin", true);
		}
		User user = (User) UserSession.getAttribute("user");
		model.addAttribute("types", getTypes());
		Session session = factory.getCurrentSession();
		String hql = "FROM Order o WHERE o.user.username = '" + user.getUsername()+ "'";
		Query query = session.createQuery(hql);
		List<Order> list = query.list();
		model.addAttribute("orders", list);
		return "home/history";
	}
}
