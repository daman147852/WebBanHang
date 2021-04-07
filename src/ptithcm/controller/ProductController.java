package ptithcm.controller;
import java.io.File;

import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.transaction.Transactional;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import ptithcm.entity.Product;
import ptithcm.entity.Type;

@Transactional
@Controller
@RequestMapping("/product/")
public class ProductController {
	@Autowired 
	SessionFactory factory;
	
	@Autowired
	ServletContext context;
	
	@RequestMapping("index")
	public String index(ModelMap model, HttpServletRequest request, HttpServletResponse response ){
		HttpSession AdminSession = request.getSession();
		AdminSession.getAttribute("admin");
		if(AdminSession.getAttribute("admin") == null){
			return "redirect:/home/login.htm";
		}
		Session session = factory.getCurrentSession();
		String hql = "FROM Product";
		Query query = session.createQuery(hql);
		List<Product> list = query.list();
		model.addAttribute("products", list);
		return "product/index";
	}
	
	
	public List<Product> getProducts() {
		Session session = factory.getCurrentSession();
		String hql = "FROM Product";
		Query query = session.createQuery(hql);
		List<Product> list = query.list();
		return list;
	}
	
	@ModelAttribute("types")
	public List<Type> getTypes() {
		Session session = factory.getCurrentSession();
		String hql = "FROM Type";
		Query query = session.createQuery(hql);
		List<Type> list1 = query.list();
		return list1;
	}
	
	@RequestMapping(value="insert", method=RequestMethod.GET)
	public String insert(ModelMap model, HttpServletRequest request, HttpServletResponse response){
		HttpSession AminSession = request.getSession();
		AminSession.getAttribute("admin");
		if(AminSession.getAttribute("admin")==null){
			return "redirect:/home/login.htm";
		}
		model.addAttribute("product", new Product());
		return "product/insert";
	}
	
	@RequestMapping(value="insert", method=RequestMethod.POST)
	public String insert(ModelMap model, @ModelAttribute("product")Product product, @RequestParam("photo") MultipartFile photo, BindingResult errors, HttpServletResponse response){
	if(photo.isEmpty()) {
		model.addAttribute("message_image", "Chưa chọn hình ảnh Son!");
	}
	if(product.getName().length()==0){
		errors.rejectValue("name", "product", "Hãy nhập tên Son!");
	}
	if(product.getPrice() == null) {
		errors.rejectValue("price", "product", "Hãy nhập giá tiền!");
	}
	if(product.getDescription().length()==0){
		errors.rejectValue("description", "product", "Nhập mô tả Son!");
	}
	if(product.getAmount()==null){
		errors.rejectValue("amount", "product", "Nhập số lượng Son!");
	}
	else{
		Session session = factory.openSession();
		Transaction t = session.beginTransaction();
		try{
			product.setImage(photo.getOriginalFilename());
			String photoPath = context.getRealPath("./images/" + photo.getOriginalFilename());
			photo.transferTo(new File(photoPath));
			 
			session.save(product);
			t.commit();
			model.addAttribute("message", "Thêm mới thành công!");
			return "redirect:/product/index.htm";
		}
		catch(Exception e){
			t.rollback();
			model.addAttribute("message", "Thêm mới thất bại!");
		}
		finally{
			session.close();
		}
	}
	return "product/insert";
	}
	
	@RequestMapping("update/{id}")
	public String update(ModelMap model, @PathVariable("id") Integer id, HttpServletRequest request, HttpServletResponse response){ 
		HttpSession AminSession  = request.getSession();
		AminSession .getAttribute("admin");
		if(AminSession .getAttribute("admin")==null){
			return "redirect:/home/login.htm";
		}
		Session session = factory.getCurrentSession();
		Product product = (Product) session.get(Product.class, id);

		model.addAttribute("product", product);
		System.out.println(product.getId());
		model.addAttribute("products", getProducts());
		return "product/update";
	}
	
	@RequestMapping(value="update", method=RequestMethod.POST)
	public String update(ModelMap model, @ModelAttribute("product")Product product, @RequestParam("photo") MultipartFile photo, BindingResult errors, HttpServletRequest request, HttpServletResponse response){
		HttpSession AminSession = request.getSession();
		AminSession.getAttribute("admin");
		if(AminSession.getAttribute("admin")==null){
			return "redirect:/home/login.htm";
		}
		System.out.println(product.getId());
		if(photo.isEmpty()) {
			if(product.getName().length()==0){
				errors.rejectValue("name", "product", "Hãy nhập tên Son!");
			}
			if(product.getPrice() == null) {
				errors.rejectValue("price", "product", "Hãy nhập giá tiền!");
			}
			if(product.getDescription().length()==0){
				errors.rejectValue("description", "product", "Nhập mô tả Son!");
			}
			if(product.getAmount()==null){
				errors.rejectValue("amount", "product", "Nhập số lượng Son!");
			}
			else {
				String old = product.getImage();
				Session session = factory.openSession();
				Transaction t = session.beginTransaction();
				try{
					product.setImage(old);
					session.update(product);
					t.commit();
					model.addAttribute("message", "Cập nhật thành công!");
					return "redirect:/product/index.htm";
				}
				catch(Exception e){
					t.rollback();
					System.out.println(e);
					model.addAttribute("message", "Cập nhật thất bại!");
				}
				finally{
					session.close();
				}
			}
			
			return "product/update";
		}
		else{
			if(product.getName().length()==0){
				errors.rejectValue("name", "product", "Hãy nhập tên Son!");
			}
			if(product.getPrice() == null) {
				errors.rejectValue("price", "product", "Hãy nhập giá tiền!");
			}
			if(product.getDescription().length()==0){
				errors.rejectValue("description", "product", "Nhập mô tả Son!");
			}
			if(product.getAmount()==null){
				errors.rejectValue("amount", "product", "Nhập số lượng Son!");
			}
			else{
				Session session = factory.openSession();
				Transaction t = session.beginTransaction();
				try{
					product.setImage(photo.getOriginalFilename());
					String photoPath = context.getRealPath("./files/" + photo.getOriginalFilename());
					photo.transferTo(new File(photoPath));

					session.update(product);
					t.commit();
					model.addAttribute("message", "Cập nhật thành công!");
					return "redirect:/product/index.htm";
				}
				catch(Exception e){
					t.rollback();
					System.out.println(e);
					model.addAttribute("message", "Cập nhật thất bại!");
				}
				finally{
					session.close();
				}
			}
			return "product/update";
		}
	}
	
	@RequestMapping("delete/{id}")
	public String delete(ModelMap model, @PathVariable("id") Integer id, HttpServletRequest request, HttpServletResponse response){
		HttpSession AminSession = request.getSession();
		AminSession.getAttribute("admin");
		if(AminSession.getAttribute("admin")==null){
			return "redirect:/home/login.htm";
		}
		Session session = factory.getCurrentSession();
		Product product = (Product) session.get(Product.class, id);
		
		model.addAttribute("product", product);
		System.out.println(product.getId());
		model.addAttribute("products", getProducts());
		return "product/delete";
	}
	
	@RequestMapping(value="delete")
	public String delete(ModelMap model, @ModelAttribute("product") Product product, HttpServletRequest request, HttpServletResponse response) {
		HttpSession adsession = request.getSession();
		adsession.getAttribute("admin");
		if(adsession.getAttribute("admin")==null){
			return "redirect:/home/login.htm";
		}
		System.out.println(product.getId());
		Session session = factory.openSession();
		Transaction t = session.beginTransaction();
		try {
			session.delete(product);
			t.commit();
			model.addAttribute("message", "Xóa thành công !");
			return "redirect:/product/index.htm";
		}
		catch(Exception e) {
			t.rollback();
			model.addAttribute("message", "Xóa thất bại !");
		}
		finally {
			session.close();
		}
		return "product/delete";
	}
}
	
