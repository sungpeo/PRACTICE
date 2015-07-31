package picka.data.dao;

public class Menu {
	private String menuName;
	private int price;
	private String menuSrc;
	
	public Menu() {
		super();
	}
	
	public Menu(String menuName, int price, String menuSrc) {
		super();
		this.menuName = menuName;
		this.price = price;
		this.menuSrc = menuSrc;
	}
	
	public String getMenuName() {
		return menuName;
	}
	
	public void setMenuName(String menuName) {
		this.menuName = menuName;
	}
	
	public int getPrice() {
		return price;
	}
	
	public void setPrice(int price) {
		this.price = price;
	}
	
	public String getmenuSrc() {
		return menuSrc;
	}

	public void setmenuSrc(String menuSrc) {
		this.menuSrc = menuSrc;
	}

	@Override
	public String toString() {
		return "Menu [menuName=" + menuName + ", price=" + price + ", menuSrc=" + menuSrc + "]";
	}
}
