package easymall.service;

import java.awt.image.BufferedImage;
import java.io.File;
import java.util.List;
import java.util.Map;
import java.util.Random;
import java.util.UUID;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import easymall.dao.ProductsDao;
import easymall.po.Category;
import easymall.po.Products;
import easymall.pojo.MyCategory;
import easymall.pojo.MyProducts;
@Service("productsService")
public class ProductsServiceImpl implements ProductsService {
	@Autowired
	private ProductsDao productsDao;
	@Override
	public List<Category> allcategorys() {
		List<Category> categorys=productsDao.allcategorys();
		return categorys;
	}

	@Override
	public List<Products> prodlist(Map<String, Object> map) {
		List<Products> products = productsDao.prodlist(map);
		return products;
	}

	@Override
	public Products oneProduct(String pid) {
		return productsDao.oneProduct(pid);
	}

	@Override
	public List<Products> proclass(Integer proclass) {
		List<Products> products=productsDao.proclass(proclass);
		return products;
	}

	@Override
	public String save(MyProducts myproducts, HttpServletRequest request) {
		String originName=myproducts.getImgurl().getOriginalFilename();
		String extName=originName.substring(originName.lastIndexOf("."));
		if(!(extName.equalsIgnoreCase(".jpg")||extName.equalsIgnoreCase(".png")
				||extName.equalsIgnoreCase(".gif"))){
			return "图片后缀不合法";
		}
		try{
			BufferedImage bufImage=ImageIO.read(myproducts.getImgurl().getInputStream());
			bufImage.getHeight();
			bufImage.getWidth();
		}catch(Exception e){
			return "该文件不是图片！";
		}
		String imgurl ="";
		for(int i=0; i<8;i++){
			imgurl +="/"+Integer.toHexString(new Random().nextInt(16));
		}
		String realpath=request.getServletContext().getRealPath("/WEB-INF");
		realpath+="/upload";
		System.out.println(realpath+imgurl);
		File file=new File(realpath+imgurl,originName);
		if(!file.exists()){
			file.mkdirs();
		}
		try{
			myproducts.getImgurl().transferTo(file);
		}catch(Exception ex){
			ex.printStackTrace();
		}
		imgurl="/upload"+imgurl+"/"+originName;
		String id=UUID.randomUUID().toString();
		Products products= new Products();
		products.setId(id);
		products.setName(myproducts.getName());
		products.setCategory(myproducts.getCategory());
		products.setPrice(myproducts.getPrice());
		products.setPnum(myproducts.getPnum());
		products.setImgurl(imgurl);
		products.setDescription(myproducts.getDescription());
		if(productsDao.findByImgurl(products.getImgurl())==null){
			productsDao.save(products);
		}else{
			String fname=imgurl.substring(0,imgurl.lastIndexOf("."));
			imgurl=fname+System.currentTimeMillis()+extName;
			products.setImgurl(imgurl);
			System.out.println(products.getImgurl());
			productsDao.save(products);
		}
		return "商品添加成功";
	}

	@Override
	public void delproduct(String id) {
		productsDao.delproduct(id);
	}

	@Override
	public void updateprod(Products product) {
		productsDao.updateprod(product);
	}

	@Override
	public void delcate(String id) {
		productsDao.delcate(id);	
	}

	@Override
	public void updatecate(Category category) {
		productsDao.updatecate(category);
	}

	@Override
	public String savecate(MyCategory category,HttpServletRequest request) {
		Category categorys= new Category();
		categorys.setId(category.getId());
		categorys.setName(category.getName());
		categorys.setDescription(category.getDescription());
		productsDao.savecate(categorys);
		return "商品类别添加成功";
	}

}
