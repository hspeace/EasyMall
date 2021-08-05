package easymall.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import easymall.po.Category;
import easymall.po.Products;
import easymall.pojo.MyCategory;
import easymall.pojo.MyProducts;

public interface ProductsService {
	public List<Products> proclass(Integer category);
	public Products oneProduct(String pid);
	public List<Category> allcategorys();
	public List<Products> prodlist(Map<String,Object> map);
	public String save(MyProducts myproducts,HttpServletRequest request);
	public void delproduct(String id);
	public void updateprod(Products product);
	public void delcate(String id);
	public void updatecate(Category category);
	public String savecate(MyCategory category,HttpServletRequest request);
}
