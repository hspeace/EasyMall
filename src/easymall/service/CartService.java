package easymall.service;

import java.util.List;

import org.springframework.stereotype.Service;

import easymall.po.Cart;
import easymall.pojo.MyCart;
public interface CartService {
	public void addCart(Cart cart);
	public Cart findCart(Cart cart);
	public void updateCart(Cart cart);
	public List<MyCart> showcart(int user_id);
	public void updateBuyNum(Cart cart);
	public void delCart(Integer cartID);
	public MyCart findByCartID(Integer cartID);
}
