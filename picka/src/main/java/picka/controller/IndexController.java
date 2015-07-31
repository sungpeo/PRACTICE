package picka.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class IndexController {

	@RequestMapping("/")
	String start() {
		return "index";
	}
	
	@RequestMapping("/memberMgmt")
	String memberMgmt() {
		return "memberMgmt";
	}
	
	@RequestMapping("/loginForm")
	String loginForm() {
		return "loginForm";	
	}
	@RequestMapping("/home")
	String home() {
		return "home";	
	}
	@RequestMapping("/storeList")
	String storeList() {
		return "storeList";	
	}
	
	@RequestMapping("/mypage")
	String mypage() {
		return "mypage";	
	}
}
