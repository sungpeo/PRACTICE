package picka.controller;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import picka.data.dao.Menu;
import picka.data.dao.Review;
import picka.data.dao.SerializableStore;
import picka.data.dao.Store;
import picka.data.repository.StoreRepository;
import picka.service.StoreService;

@Controller
public class StoreController {

	
	private final Logger logger = Logger.getLogger(this.getClass());

	@Autowired
	private StoreRepository storeRepository;

	@Autowired
	private WishController wishController;
	
	@Autowired
	private StoreService storeService;
	
	/**
	 * 특정 매장의 상세정보를 조회한다.
	 * 
	 * @return
	 */
	@RequestMapping("/viewDetail")
	String viewDetail(HttpServletRequest req, HttpServletResponse res, Model m) {
		
		String storeId = req.getParameter("storeId") == null ? "" : req.getParameter("storeId");
		String userId = req.getParameter("userId") == null ? "" : req.getParameter("userId");
		
		Store store = storeService.viewDetail(storeId, userId);
		
		logger.info(store.toString());
		m.addAttribute("store", store);
		m.addAttribute("menuList", store.getMenu());
		m.addAttribute("wishFlag", wishController.getWishYn(userId, storeId));
		return "storeDetail";
	}

	/**
	 * 특정 매장의 상세정보를 조회한다.
	 * 
	 * @return
	 */
	@RequestMapping("/detail")
	String detail() {
		return "detail";
	}

	/**
	 * admin.jsp로 화면 전환
	 * 
	 * @return
	 */
	@RequestMapping("/admin")
	String admin() {
		return "admin";
	}

	/**
	 * 필터에 지정한 조건에 따라 store 목록을 조회한다.
	 * 
	 * @return
	 */
	@RequestMapping("/getStoreListByConditions")
	String getStoreListByConditions(HttpServletRequest req, HttpServletResponse res, Model m) {
		logger.info("getStoreListByConditions..........");
 
		List<Store> storeList = storeService.getStoreListByConditions(req);
		
		m.addAttribute("storeList", storeList);
		m.addAttribute("gubun", "filter");
		return "storeList";
	}

	
 
	@RequestMapping("/getSecondStoreList")
	String getSecondStoreList(HttpServletRequest req, HttpServletResponse res, Model m) {
		
		List<Store> storeList = storeService.getSecondStoreList(req);
		
		m.addAttribute("storeList", storeList);
		m.addAttribute("gubun", "nextPlace");

		if(logger.isInfoEnabled()){
			logger.info("output    storeList.size(): " + storeList.size());
			for (Store s : storeList) {
				logger.info(s.toString());
			}
		}
		return "storeList";

	}

 
	@RequestMapping("/filter")
	String filter() {
		return "filter";
	}

	/**
	 * 위도와 경도로 매장 목록을 조회한다.
	 * 
	 * @return
	 */
	@RequestMapping("/getStoreListByLatLng")
	@ResponseBody

	List<Store> getStoreList(double lat, double lng) {
		List<Store> storeList = storeRepository.findByLatBetweenAndLngBetween(lat - 0.03, lat + 0.03, lng - 0.03,
				lng + 0.03);
		for (Store s : storeList) {
			logger.info(s.toString());
		}
		return storeList;
	}

	/**
	 * 
	 * @param request
	 * @param storeInfo
	 * @return
	 */
	@RequestMapping("/insertStore")
	@ResponseBody

	String insertStore(HttpServletRequest request, @ModelAttribute SerializableStore storeInfo){
		 
		///////////////////////////////////////////////////////////////////////////////////

		//file
		/*MultipartFile src = storeInfo.getSrc();
		String realSrcName = "photo_" + System.currentTimeMillis()
		+ "_" + src.getOriginalFilename();
		File file = new File("C:\\picka_dev\\photo_data\\" + realSrcName);

		try {
			src.transferTo(file);

		} catch (Exception e) {
			e.printStackTrace();
		}*/

		// file
		/*
		 * MultipartFile src = storeInfo.getSrc(); String realSrcName = "photo_"
		 * + System.currentTimeMillis() + "_" + src.getOriginalFilename(); File
		 * file = new File("C:\\picka_dev\\photo_data\\" + realSrcName);
		 * 
		 * try { src.transferTo(file);
		 * 
		 * } catch (Exception e) { e.printStackTrace(); }
		 */


		///////////////////////////////////////////////////////////////////////////////////


		//menu와 price 가져오기
		List<Menu> menuList = new ArrayList<Menu>();

		// menu와 price 가져오기
		String[] arrMenuName = storeInfo.getMenuName().split(",");
		for (String s : arrMenuName) {
			logger.info(s);
		}

		String[] arrPrice = storeInfo.getPrice().split(",");
		String[] arrSrc = storeInfo.getMenuSrc().split(",");
		
		for(int i = 0; i<arrMenuName.length; i++) {
			Menu oMenu = new Menu();
			oMenu.setMenuName(arrMenuName[i]);
			int price = Integer.parseInt(arrPrice[i]);
			oMenu.setPrice(price);
			oMenu.setmenuSrc(arrSrc[i]);
			logger.info(arrMenuName[i]);
			logger.info(price);
			logger.info(arrSrc[i]);
			menuList.add(oMenu);
		}

		//DB에 저장

		for (String s : arrPrice) {
			logger.info(s);
		}

		// DB에 저장
		Store oStore = new Store();
		oStore.setStoreId(String.valueOf(System.currentTimeMillis()));
		oStore.setStoreName(storeInfo.getStoreName());
		oStore.setMajorCategory(storeInfo.getMajorCategory());
		oStore.setMinorCategory(storeInfo.getMinorCategory());
 
//		oStore.setSrc(realSrcName);
 
		oStore.setSrc(storeInfo.getImgUrl());
		oStore.setCapacity(storeInfo.getCapacity());
		oStore.setPhone(storeInfo.getPhone());
 
		oStore.setMenu(menuList);
		// oStore.setMenu(storeInfo.getMenu());
		// oStore.setLoc(storeInfo.getLoc());
 
		storeRepository.save(oStore);

		return "admin";
	}
	
	@RequestMapping("/review")
	String mypage() {
		return "review";	
	}
	
	@RequestMapping("/saveReview")
	@ResponseBody
	List<Review> saveReview(HttpServletRequest req, @ModelAttribute Review review) {
		return storeService.saveReview(req, review);
	}
	
	@RequestMapping("/getReviewList")
	@ResponseBody
	List<Review> getReviewList(@ModelAttribute Store store) {
		List<Review> resultList = null;
		Store s = storeRepository.findByStoreId(store.getStoreId());
		if (s != null) {
			resultList = s.getReview();
			Collections.reverse(resultList);
		}
		return resultList;
	}
}
