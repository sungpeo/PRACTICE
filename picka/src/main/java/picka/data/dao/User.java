package picka.data.dao;

import java.util.List;

import org.springframework.data.annotation.Id;


public class User {

    @Id
    private String userId;
    private String phone;
    private String pw;
    private String nickName;
    private List<String> wish;
    private List<String> contact;
    private String requestCd;
    
	public User() {
		super();
		// TODO Auto-generated constructor stub
	}

	public User(String userId, String phone, String pw, String nickName, List<String> wish, List<String> contact,
			String requestCd) {
		super();
		this.userId = userId;
		this.phone = phone;
		this.pw = pw;
		this.nickName = nickName;
		this.wish = wish;
		this.contact = contact;
		this.requestCd = requestCd;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getPw() {
		return pw;
	}

	public void setPw(String pw) {
		this.pw = pw;
	}

	public String getNickName() {
		return nickName;
	}

	public void setNickName(String nickName) {
		this.nickName = nickName;
	}

	public List<String> getWish() {
		return wish;
	}

	public void setWish(List<String> wish) {
		this.wish = wish;
	}

	public List<String> getContact() {
		return contact;
	}

	public void setContact(List<String> contact) {
		this.contact = contact;
	}

	public String getRequestCd() {
		return requestCd;
	}

	public void setRequestCd(String requestCd) {
		this.requestCd = requestCd;
	}

	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("User [userId=");
		builder.append(userId);
		builder.append(", phone=");
		builder.append(phone);
		builder.append(", pw=");
		builder.append(pw);
		builder.append(", nickName=");
		builder.append(nickName);
		builder.append(", wish=");
		builder.append(wish);
		builder.append(", contact=");
		builder.append(contact);
		builder.append(", requserCd=");
		builder.append(requestCd);
		builder.append("]");
		return builder.toString();
	}
    
}