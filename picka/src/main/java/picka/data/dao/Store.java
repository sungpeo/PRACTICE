package picka.data.dao;

import java.text.DecimalFormat;
import java.util.List;

import org.springframework.data.annotation.Id;


public class Store {

    @Id
    private String storeId;//매장ID
    private String storeName;//매장명
    private String majorCategory;//대분류
    private String minorCategory;//소분류
    private String src; //이미지url
    private int capacity ; //최대 수용인원
    private List<Menu> menu; //메뉴 {메뉴명, 가격}
    private String phone; //연락처
    private String addr; //주소
    private double lat; //위도
    private double lng; //경도
    private int totUser; //총이용객수
    private int totPoint; //총평점 .. 평점낼 때 사용할 거
    private double avgPoint; //평점
    private int foodLevel; //푸드레벨
    private int drinksCode; //주종  
    private String bizStHour; //영업시작시간
    private String bizClsHour; //영업종료시간
    private String offDay; //평점
    private List<Review> review; //후기 {유저ID, 내용, 평점}
    
	public String getBizStHour() {
		return bizStHour;
	}

	public void setBizStHour(String bizStHour) {
		this.bizStHour = bizStHour;
	}

	public String getBizClsHour() {
		return bizClsHour;
	}

	public void setBizClsHour(String bizClsHour) {
		this.bizClsHour = bizClsHour;
	}

	public String getOffDay() {
		return offDay;
	}

	public void setOffDay(String offDay) {
		this.offDay = offDay;
	}

	public Store() {
		super();
	}

	public double getAvgPoint() {
		if(this.totUser==0)
		{
			this.avgPoint=0;
		}
		else
		{
			this.avgPoint = (double)this.totPoint/(double)this.totUser;
		}
		
		String pattern = "#.#";
		DecimalFormat dformat = new DecimalFormat(pattern);
		return Double.parseDouble(dformat.format(avgPoint));
	}

	public void setAvgPoint(double avgPoint) {
		this.avgPoint = avgPoint;
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
		if(this.majorCategory.equals("ko")) majorCategory="한식";
		if(this.majorCategory.equals("jp")) majorCategory="일식";
		if(this.majorCategory.equals("ch")) majorCategory="중식";
		if(this.majorCategory.equals("ws")) majorCategory="양식";
		if(this.majorCategory.equals("ac")) majorCategory="주점";
		return majorCategory;
	}

	public void setMajorCategory(String majorCategory) {
		this.majorCategory = majorCategory;
	}

	public String getMinorCategory() {
		if(this.minorCategory.equals("ko_0")) minorCategory="정통 한식";
		if(this.minorCategory.equals("ko_1")) minorCategory="탕, 찌개, 전골";
		if(this.minorCategory.equals("ko_2")) minorCategory="국수, 면요리";
		if(this.minorCategory.equals("ko_3")) minorCategory="고기 요리";
		if(this.minorCategory.equals("jp_0")) minorCategory="정통 일식";
		if(this.minorCategory.equals("jp_1")) minorCategory="회, 스시";
		if(this.minorCategory.equals("jp_2")) minorCategory="라멘, 소바, 우동";
		if(this.minorCategory.equals("jp_3")) minorCategory="철판 요리";
		if(this.minorCategory.equals("ch_0")) minorCategory="정통 중식";
		if(this.minorCategory.equals("ch_1")) minorCategory="딤섬, 만두";
		if(this.minorCategory.equals("ch_2")) minorCategory="퓨전 중식";
		if(this.minorCategory.equals("ch_3")) minorCategory="기타 중식";
		if(this.minorCategory.equals("ws_0")) minorCategory="이태리 음식";
		if(this.minorCategory.equals("ws_1")) minorCategory="스테이크, 바베큐";
		if(this.minorCategory.equals("ws_2")) minorCategory="시푸드 요리";
		if(this.minorCategory.equals("ws_3")) minorCategory="패밀리 레스토랑";
		if(this.minorCategory.equals("ac_0")) minorCategory="칵테일, 와인";
		if(this.minorCategory.equals("ac_1")) minorCategory="치킨, 호프, 펍";
		if(this.minorCategory.equals("ac_2")) minorCategory="전통 주점, 포차";
		if(this.minorCategory.equals("ac_3")) minorCategory="일반 주점";
		
		return minorCategory;
	}

	public void setMinorCategory(String minorCategory) {
		this.minorCategory = minorCategory;
	}

	public String getSrc() {
		return src;
	}

	public void setSrc(String src) {
		this.src = src;
	}

	public int getCapacity() {
		return capacity;
	}

	public void setCapacity(int capacity) {
		this.capacity = capacity;
	}

	public List<Menu> getMenu() {
		return menu;
	}

	public void setMenu(List<Menu> menu) {
		this.menu = menu;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getAddr() {
		return addr;
	}

	public void setAddr(String addr) {
		this.addr = addr;
	}

	public double getLat() {
		return lat;
	}

	public void setLat(double lat) {
		this.lat = lat;
	}

	public double getLng() {
		return lng;
	}

	public void setLng(double lng) {
		this.lng = lng;
	}

	public int getTotUser() {
		return totUser;
	}

	public void setTotUser(int totUser) {
		this.totUser = totUser;
	}

	public int getTotPoint() {
		return totPoint;
	}

	public void setTotPoint(int totPoint) {
		this.totPoint = totPoint;
	}

	public List<Review> getReview() {
		return review;
	}

	public void setReview(List<Review> review) {
		this.review = review;
	}
    
	public int getFoodLevel() {
		return foodLevel;
	}

	public void setFoodLevel(int foodLevel) {
		this.foodLevel = foodLevel;
	}
	
	public int getDrinksCode() {
		return drinksCode;
	}

	public void setDrinksCode(int drinksCode) {
		this.drinksCode = drinksCode;
	}
	
	
	public Store(String storeId, String storeName, String majorCategory, String minorCategory, String src, int capacity,
			List<Menu> menu, String phone, String addr, double lat, double lng, int totUser, int totPoint, int avgPoint,
			 int foodLevel, int drinksCode, 
			String bizStHour, String bizClsHour, String offDay, List<Review> review) {
		super();
		this.storeId = storeId;
		this.storeName = storeName;
		this.majorCategory = majorCategory;
		this.minorCategory = minorCategory;
		this.src = src;
		this.capacity = capacity;
		this.menu = menu;
		this.phone = phone;
		this.addr = addr;
		this.lat = lat;
		this.lng = lng;
		this.totUser = totUser;
		this.totPoint = totPoint;
		this.avgPoint = avgPoint;
		this.bizStHour = bizStHour;
		this.bizClsHour = bizClsHour;
		this.offDay = offDay;
		this.review = review;
		this.foodLevel = foodLevel; 
		this.drinksCode = drinksCode; 
	}

	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("Store [storeId=");
		builder.append(storeId);
		builder.append(", storeName=");
		builder.append(storeName);
		builder.append(", majorCategory=");
		builder.append(majorCategory);
		builder.append(", minorCategory=");
		builder.append(minorCategory);
		builder.append(", src=");
		builder.append(src);
		builder.append(", capacity=");
		builder.append(capacity);
		builder.append(", menu=");
		builder.append(menu);
		builder.append(", phone=");
		builder.append(phone);
		builder.append(", addr=");
		builder.append(addr);
		builder.append(", lat=");
		builder.append(lat);
		builder.append(", lng=");
		builder.append(lng);
		builder.append(", totUser=");
		builder.append(totUser);
		builder.append(", totPoint=");
		builder.append(totPoint);
		builder.append(", avgPoint=");
		builder.append(avgPoint);
		builder.append(", foodLevel=");
		builder.append(foodLevel);
		builder.append(", drinksCode=");
		builder.append(drinksCode);
		builder.append(", review=");
		builder.append(review);
		builder.append("]");
		builder.append("Store [storeId=").append(storeId).append(", storeName=").append(storeName)
				.append(", majorCategory=").append(majorCategory).append(", minorCategory=").append(minorCategory)
				.append(", src=").append(src).append(", capacity=").append(capacity).append(", menu=").append(menu)
				.append(", phone=").append(phone).append(", addr=").append(addr).append(", lat=").append(lat)
				.append(", lng=").append(lng).append(", totUser=").append(totUser).append(", totPoint=")
				.append(totPoint).append(", avgPoint=").append(avgPoint).append(", bizStHour=").append(bizStHour)
				.append(", bizClsHour=").append(bizClsHour).append(", offDay=").append(offDay).append(", review=")
				.append(review).append("]");
		return builder.toString();
	}

	





}