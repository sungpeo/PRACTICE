package picka.controller;

import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import picka.data.dao.Store;
import picka.service.WishService;

@Controller
@RequestMapping("wishList")
public class WishController {
	
	private final Logger logger = Logger.getLogger(this.getClass());
	
	@Autowired
	WishService wishService;
	
	@RequestMapping("getList")
    String getList(@RequestParam String userId, Model m) throws Exception {
		logger.info("userId="+userId);
		List<Store> list = wishService.getList(userId);
		
		m.addAttribute("storeList", list);
		m.addAttribute("gubun", "filter");
		
		return "storeList";
    }
	
	@RequestMapping("insertWish")
	@ResponseBody
	boolean insertWish(@RequestParam String userId, @RequestParam String storeId){
		return wishService.insertWish(userId, storeId);
	}
	
	
	@RequestMapping("deleteWish")
	@ResponseBody
	boolean deleteWish(@RequestParam String userId, @RequestParam String storeId){
		return wishService.deleteWish(userId, storeId);
	}
	
	@RequestMapping("getWishYn")
	@ResponseBody
	String getWishYn(@RequestParam String userId, @RequestParam String storeId){
		return wishService.getWishYn(userId, storeId);
	}
}
