package easymall.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import easymall.po.Category;
import easymall.po.Products;

@Repository("productsDao")
@Mapper
public interface ProductsDao {
	public List<Products> proclass(Integer category);
	public Products oneProduct(String pid);
	public List<Category> allcategorys();
	public List<Products> prodlist(Map<String,Object> map);
	public void save(Products products);
	public void savecate(Category category);
	public Object findByImgurl(String imgurl);
	public void delproduct(String id);
	public void updateprod(Products product);
	public void delcate(String id);
	public void updatecate(Category category);
}
