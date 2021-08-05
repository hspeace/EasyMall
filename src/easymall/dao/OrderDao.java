package easymall.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import easymall.po.Orders;

@Repository("orderDao")
@Mapper
public interface OrderDao {
	void addOrder(Orders myOrder);
	List<Orders> findOrderByUserId(Integer user_id);
	public void delorder(String id);
	public void payorder(String id);
	List<Orders> findOrder();
}
