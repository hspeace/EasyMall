package easymall.controller.admin;

import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.HorizontalAlignment;
import org.apache.poi.ss.util.CellRangeAddress;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import easymall.po.Category;
import easymall.po.OrderItem;
import easymall.po.Orders;
import easymall.po.Products;
import easymall.po.User;
import easymall.pojo.MyCategory;
import easymall.pojo.MyProducts;
import easymall.pojo.OrderInfo;
import easymall.service.OrderService;
import easymall.service.ProductsService;

@Controller("productsControllerAdmin")
@RequestMapping("/admin")
public class ProductsControllerAdmin {
	@Autowired
	private ProductsService productsService;
	@Autowired
	private OrderService orderService;
	@RequestMapping("/addprod")
	public String addprod(Model model){
		List<Category> categorys=productsService.allcategorys();
		model.addAttribute("categorys",categorys);
		model.addAttribute("myproducts",new MyProducts());
		return "admin/add_prod";
	}
	@RequestMapping("/addcate")
	public String addcate(Model model){
		model.addAttribute("mycategorys",new MyCategory());
		return "admin/add_cate";
	}
	@RequestMapping("/savecate")
	public String save(@Valid @ModelAttribute MyCategory mycategory,
			HttpServletRequest request,Model model,HttpSession session)
	throws Exception{
		String msg=productsService.savecate(mycategory,request);
		model.addAttribute("msg",msg);
		List<Category> categorys=productsService.allcategorys();
		session.setAttribute("categorys", categorys);
		return "redirect:/admin/addcate";
	}
	
	
	@RequestMapping("/save")
	public String save(@Valid @ModelAttribute MyProducts myproducts,
			HttpServletRequest request,Model model)
	throws Exception{
		String msg=productsService.save(myproducts,request);
		model.addAttribute("msg",msg);
		return "redirect:/admin/addprod";
	}
	@RequestMapping("/prod_list")
	public String tolist(Model model){
		double _minPrice=0;
		Double _maxPrice=Double.MAX_VALUE;
		Map<String,Object> map=new HashMap<>();
		map.put("minPrice", _minPrice);
		map.put("maxPrice", _maxPrice);
		List<Products> products=productsService.prodlist(map);
		model.addAttribute("minPrice", _minPrice);
		model.addAttribute("maxPrice", _maxPrice);
		model.addAttribute("products", products);
		return "admin/prod_list";
	}
	@RequestMapping("/delprod")
	public String delprod(String id,Model model){
		productsService.delproduct(id);;
		return "redirect:admin/prod_list";
	}
	@RequestMapping("/updateprod")
	public String updateprod(String id,String name,Double price,Integer category,Integer pnum,String description,
			Model model){
		Products p1 = productsService.oneProduct(id);
		if(!name.equals(" ")){
			p1.setName(name);
		}
		if(price!=-1){
			p1.setPrice(price);
		}
		if(category!=-1){
		p1.setCategory(category);
		}
		if(pnum!=-1){
		p1.setPnum(pnum);
		}
		if(!description.equals(" ")){
		p1.setDescription(description);
		}
		productsService.updateprod(p1);
		return "redirect:admin/prod_list";
	}
	@RequestMapping("/cate_list")
	public String tocatelist(Model model){
		List<Category> categorys=productsService.allcategorys();
		model.addAttribute("categorys", categorys);
		return "admin/cate_list";
	}
	@RequestMapping("/delcate")
	public String delcate(String id,Model model,HttpSession session){
		productsService.delcate(id);
		List<Category> categorys=productsService.allcategorys();
		session.setAttribute("categorys", categorys);
		return "redirect:admin/cate_list";
	}
	@RequestMapping("/updatecate")
	public String updatecate(Integer id,String name,Model model,HttpSession session){
		Category p1 = new Category();
		p1.setId(id);
		p1.setName(name);
		productsService.updatecate(p1);
		List<Category> categorys=productsService.allcategorys();
		session.setAttribute("categorys", categorys);
		return "redirect:admin/cate_list";
	}
	@RequestMapping("/allorder_list")
	public String allorder(HttpSession session,Model model){
		List<OrderInfo> orderInfoList=new ArrayList<OrderInfo>();
		List<Orders> orderList =orderService.findOrder();
		for(Orders order : orderList){
			List<OrderItem> orderitems=orderService.orderitem(order.getId());
			Map<Products,Integer> map=new HashMap<Products,Integer>();
			for(OrderItem orderItem:orderitems){
				Products product =productsService.oneProduct(orderItem.getProduct_id());
				map.put(product, orderItem.getBuynum());
		}
		OrderInfo orderInfo=new OrderInfo();
		orderInfo.setOrder(order);
		orderInfo.setMap(map);
		orderInfoList.add(orderInfo);
	}
		model.addAttribute("orderInfos",orderInfoList);
		return "admin/allorder_list";
	}
	@RequestMapping("/buyorder_list")
	public String buyorder_list(Model model){
		List<OrderItem> orderitems=orderService.allorderitem(); 
		ArrayList<String> listname=new ArrayList<String>();
		ArrayList<Integer> listnum=new ArrayList<Integer>();
		for(OrderItem order : orderitems){
			Products product = productsService.oneProduct(order.getProduct_id());
			order.setOrder_id(product.getName());
			listname.add(product.getName().substring(0,2));
			listnum.add(order.getBuynum());
		}
		model.addAttribute("orderitems", orderitems);
		model.addAttribute("listname",listname.toString());
//		System.out.println(listname.toString());
		model.addAttribute("listnum", listnum);
		return "admin/buyorder_list";
	}
	@RequestMapping("/downExcel")    
	public String exportExcel(HttpServletResponse response, HttpSession session, HttpServletRequest request) throws Exception {  
		List<OrderItem> items=orderService.allorderitem();
		for(OrderItem order : items){
			Products product = productsService.oneProduct(order.getProduct_id());
			order.setOrder_id(product.getName());
		}
		String[] tableHeaders = {"商品名字", "销量"}; 
		
		HSSFWorkbook workbook = new HSSFWorkbook();
		HSSFSheet sheet = workbook.createSheet("Sheet1");
		HSSFCellStyle cellStyle = workbook.createCellStyle();    
		cellStyle.setAlignment(HorizontalAlignment.CENTER);  

		
		Font font = workbook.createFont();   
		font.setBold(true);
		cellStyle.setFont(font);
		
		// 将第一行的三个单元格给合并
		sheet.addMergedRegion(new CellRangeAddress(0, 0, 0, 2));
		HSSFRow row = sheet.createRow(0);
		HSSFCell beginCell = row.createCell(0);
		beginCell.setCellValue("销量报表");	
		beginCell.setCellStyle(cellStyle);
		
		row = sheet.createRow(1);
		// 创建表头
		for (int i = 0; i < tableHeaders.length; i++) {
			HSSFCell cell = row.createCell(i);
			cell.setCellValue(tableHeaders[i]);
			cell.setCellStyle(cellStyle);    
		}
		
		for (int i = 0; i < items.size(); i++) {
			row = sheet.createRow(i + 2);
			
			OrderItem a = items.get(i);
			row.createCell(0).setCellValue(a.getOrder_id());     
			row.createCell(1).setCellValue(a.getBuynum());    
		}
		response.setHeader("Content-Type", "application/x-msdownload" );
		response.setHeader("Content-Disposition", "attachment;filename=template.xls");
		//得到响应对象的输出流，用于向客户端输出二进制数据
		OutputStream outputStream = response.getOutputStream();
		workbook.write(outputStream);
		outputStream.flush();   
		outputStream.close();
		return "admin/cart_table";
	}
}
