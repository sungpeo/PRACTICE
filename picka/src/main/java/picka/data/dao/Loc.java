package picka.data.dao;

public class Loc {
	private String addr;
	private String lat;
	private String lng;
	public String getAddr() {
		return addr;
	}
	public void setAddr(String addr) {
		this.addr = addr;
	}
	public String getLat() {
		return lat;
	}
	public void setLat(String lat) {
		this.lat = lat;
	}
	public String getLng() {
		return lng;
	}
	public void setLng(String lng) {
		this.lng = lng;
	}
	public Loc() {
		super();
	}
	public Loc(String addr, String lat, String lng) {
		super();
		this.addr = addr;
		this.lat = lat;
		this.lng = lng;
	}
}
