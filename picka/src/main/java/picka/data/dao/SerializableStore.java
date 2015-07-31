package picka.data.dao;


import java.io.Serializable;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

public class SerializableStore implements Serializable {
	/**
	 * Spring의 annotation을 적용한 Controller 메서드 작성시 인자로 @ModelAttribute로 적용할 Bean의
	 * 속성 이름은 input 양식의 name과 같아야 한다.
	 */

	private MultipartFile src;
	private String imgUrl;//이미지url
	private String storeId;//매장ID
    private String storeName;//매장명
    private String majorCategory;//대분류
    private String minorCategory;//소분류
    private int capacity ; //최대 수용인원
    private String menuName; //
    private String price; //
    private String menuSrc; //
    private String avgPrice; //
    private String phone; //연락처
//    private List<Loc> loc; //위치 {주소, 위도, 경도}
    private String totUser; //총이용객수
    private String totPoint; //총평점 .. 평점낼 때 사용할 거
//    private List<Review> review; //후기 {유저ID, 내용, 평점}
    

	public SerializableStore() {
	}

    public String getImgUrl() {
		return imgUrl;
	}


	public void setImgUrl(String imgUrl) {
		this.imgUrl = imgUrl;
	}

	public MultipartFile getSrc() {
		return src;
	}


	public void setSrc(MultipartFile src) {
		this.src = src;
	}


	public String getStoreId() {
		return storeId;
	}


	public void setStoreId(String storeId) {
		this.storeId = storeId;
	}


	public String getStoreName() {
		return storeName;
	}


	public void setStoreName(String storeName) {
		this.storeName = storeName;
	}


	public String getMajorCategory() {
		return majorCategory;
	}


	public void setMajorCategory(String majorCategory) {
		this.majorCategory = majorCategory;
	}


	public String getMinorCategory() {
		return minorCategory;
	}


	public void setMinorCategory(String minorCategory) {
		this.minorCategory = minorCategory;
	}


	public int getCapacity() {
		return capacity;
	}


	public void setCapacity(int capacity) {
		this.capacity = capacity;
	}

	public String getMenuName() {
		return menuName;
	}

	public void setMenuName(String menuName) {
		this.menuName = menuName;
	}

	public String getPrice() {
		return price;
	}

	public void setPrice(String price) {
		this.price = price;
	}

	public String getMenuSrc() {
		return menuSrc;
	}

	public void setMenuSrc(String menuSrc) {
		this.menuSrc = menuSrc;
	}

	
	public String getAvgPrice() {
		return avgPrice;
	}

	public void setAvgPrice(String avgPrice) {
		this.avgPrice = avgPrice;
	}

	public String getPhone() {
		return phone;
	}


	public void setPhone(String phone) {
		this.phone = phone;
	}


/*	public List<Loc> getLoc() {
		return loc;
	}


	public void setLoc(List<Loc> loc) {
		this.loc = loc;
	}*/


	public String getTotUser() {
		return totUser;
	}


	public void setTotUser(String totUser) {
		this.totUser = totUser;
	}


	public String getTotPoint() {
		return totPoint;
	}


	public void setTotPoint(String totPoint) {
		this.totPoint = totPoint;
	}


/*	public List<Review> getReview() {
		return review;
	}


	public void setReview(List<Review> review) {
		this.review = review;
	}*/


/*	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("SerializableStore [imgUrl=").append(src).append(", storeId=").append(storeId)
				.append(", storeName=").append(storeName).append(", majorCategory=").append(majorCategory)
				.append(", minorCategory=").append(minorCategory).append(", capacity=").append(capacity)
				.append(", menu=").append(menu).append(", phone=").append(phone).append(", loc=").append(loc)
				.append(", totUser=").append(totUser).append(", totPoint=").append(totPoint).append(", review=")
				.append(review).append("]");
		return builder.toString();
	}*/



}