package easymall.service;

import easymall.po.User;
public interface UserService {
	public User login(User user);
	public Boolean checkUsername(String username);
	public int regist(User user);

}
