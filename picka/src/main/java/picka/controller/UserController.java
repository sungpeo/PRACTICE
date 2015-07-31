package picka.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import org.springframework.web.bind.annotation.ResponseBody;

import picka.data.dao.SerializableStore;
import picka.data.dao.Store;
import picka.data.dao.User;
import picka.data.repository.StoreRepository;
import picka.data.repository.UserRepository;

@Controller
public class UserController {

	@Autowired
	private UserRepository repository;

	@Autowired
	private StoreRepository storeRepository;
	
	private final Logger logger = Logger.getLogger(this.getClass());
	
	@RequestMapping("/test")
	String test() {
		return "test";
	}
	
	@RequestMapping("/insertTest")
	@ResponseBody
	String insertTest(HttpServletRequest request, @ModelAttribute SerializableStore storeInfo) throws IllegalStateException, IOException {
		System.out.println("insertTest!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
		System.out.println(storeInfo.toString());
		//file
		MultipartFile src = storeInfo.getSrc();// 실제 file 받아옴
		String realSrcName = "photo_" + System.currentTimeMillis()
		+ src.getOriginalFilename();// 파일 이름이 중복될 수 있으므로
									// 현재시간+filename을 저장할 파일
									// 이름으로 설정
		File file = new File("C:\\picka_dev\\photo_data\\" + realSrcName);// File(String
		src.transferTo(file);// 지정한 경로에 파일 저장
		
		return "A photo is saved";
	}
	
	
	@RequestMapping("/dbusertest")
	String start() {
		System.out.println("db start");
		List<String> wishList = new ArrayList<String>();
		wishList.add("location1");
		List<String> contactList = new ArrayList<String>();
		contactList.add("some place");

		repository.save(new User("cccid","01053125512","555","kook",wishList,contactList, null));

		// fetch all customers
		System.out.println("Users found with findAll():");
		System.out.println("-------------------------------");
		for (User user : repository.findAll()) {
			System.out.println(user);
		}
		System.out.println();
		return "index";
	}
	
	@RequestMapping("/userJoin")
	String InsertUser(@ModelAttribute User user) {
		System.out.println(user);
		String returnAddr = null;

		if (("mdif".equals(user.getRequestCd())) || ("mdpw".equals(user.getRequestCd()))) {
			returnAddr = "mypage";
		} else {
			returnAddr = "index";
		}
		
		//db connection
		repository.save(user);
		System.out.println(repository.findAll().size());
		
		return returnAddr;
	}
	
	@RequestMapping("/userJoin/isUserIdValid")
	@ResponseBody
	boolean isUserIdValid(@ModelAttribute User user) {
		System.out.println(user);
		
		//db connection
		List<User> userList = repository.findByUserId(user.getUserId());
		
		//user 존재 여부
		return userList.isEmpty();
	}
	
	@RequestMapping("/userJoin/isNickNameValid")
	@ResponseBody
	boolean isNickNameValid(@ModelAttribute User user) {
		System.out.println(user);
		
		//db connection
		List<User> userList = repository.findByNickName(user.getNickName());
		
		//user 존재 여부
		return userList.isEmpty();
	}
	
	@RequestMapping("/userJoin/isUserIdPwdValid")
	@ResponseBody
	boolean isUserIdPwdValid(@ModelAttribute User user) {
		System.out.println(user);
		
		//db connection
		List<User> userList = repository.findByUserIdAndPw(user.getUserId(),user.getPw());
		
		//user 존재 여부
		return !userList.isEmpty();
	}
	
	@RequestMapping("/userModify")
	String modifyUser(@ModelAttribute User user) {
		return "memberMgmt";
	}
	
	@RequestMapping("/userModify/getUserInfo")
	@ResponseBody
	User getUserInfo(@ModelAttribute User user) {
		User result = null;
		
		//db connection
		List<User> userList = repository.findByUserId(user.getUserId());
		if ((userList != null) && (!userList.isEmpty())) {
			result = userList.get(0);
		}
		
		return result;
	}
	
	@RequestMapping("/changePw")
	String changePw(@ModelAttribute User user) {
		return "pwMgmt";
	}
	
	@RequestMapping("/insertContact")
	@ResponseBody
	public boolean insertContact(@RequestParam String userId, @RequestParam String storeId){
		logger.info("insertContact");
		User user = repository.findByUserId(userId).get(0);
		logger.info("Before Change"+user);
		if(user.getContact()==null){
			user.setContact(new ArrayList<String>());
		}
		
		try{
			//새로 넣은 기능 불안해서 그냥 try catch로 덮음 . 2015-07-31 13:51
			for(int i=0; i<user.getContact().size(); i++){
				if(storeId.equals(user.getContact().get(i))){
					user.getContact().remove(i); //겹치는 게 있었다면 삭제 먼저 한다.
				}
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		
		
		user.getContact().add(storeId);
		repository.save(user);
		logger.info("After Change"+user);
		return true;
	}
	
	@RequestMapping("/getContactList")
	String getContactList(@RequestParam String userId, Model m){
		List<Store> resultList = new ArrayList<Store>();
		
		List<User> userList = repository.findByUserId(userId);
		if(!userList.isEmpty()){
			List<String> contactList = userList.get(0).getContact();
			if(contactList==null){
				contactList = new ArrayList<String>();
			}
			for(String contactStoreId : contactList){
				logger.info("storeId in WishList="+contactStoreId);
				resultList.add(storeRepository.findByStoreId(contactStoreId));
			}
		}
		
		Collections.reverse(resultList);
		
		m.addAttribute("storeList", resultList);
		m.addAttribute("gubun", "contactList");
		
		return "storeList";
	}
	
}
