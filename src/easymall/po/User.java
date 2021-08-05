package easymall.po;

import javax.validation.constraints.NotNull;
import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;

import org.hibernate.validator.constraints.Email;
import org.hibernate.validator.constraints.NotEmpty;

public class User {
	private Integer id;       
	private String username; 
	private String password;
	private String nickname;
	private String email;
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
//	@NotNull(message="�û�����Ϊ��") 
//    @NotEmpty(message="�û�����Ϊ��")
//	@Pattern(regexp="^[a-zA-Z]\\w{5,13}$",message="�û��������Ϲ���")
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
//	@Size(min = 3,max = 12,message = "���볤�Ȳ��Ϸ�")
//	@NotEmpty(message="���벻��Ϊ��")
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
//	@NotEmpty(message="�ǳƲ���Ϊ��")
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
//	@NotEmpty(message="���䲻��Ϊ��")
//	@Email(message="�����ʽ����ȷ")
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public User(Integer id, String username, String password, String nickname, String email) {
		super();
		this.id = id;
		this.username = username;
		this.password = password;
		this.nickname = nickname;
		this.email = email;
	}
	
}
