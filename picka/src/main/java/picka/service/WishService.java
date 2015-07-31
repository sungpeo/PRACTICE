package picka.service;

import java.util.ArrayList;
import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import picka.data.dao.Store;
import picka.data.dao.User;
import picka.data.repository.StoreRepository;
import picka.data.repository.UserRepository;

@Controller
@RequestMapping("wishList")
public class WishService {
	
	private final Logger logger = Logger.getLogger(this.getClass());
	
	@Autowired
	private UserRepository userRepository;
	
	@Autowired
	private StoreRepository storeRepository;
	
	//찜 가져오기
	public List<Store> getList(String userId){
		List<Store> wishStoreList = new ArrayList<Store>();
		
		List<User> userList = userRepository.findByUserId(userId);
		logger.info("userList.size()="+userList.size());
		if(!userList.isEmpty()){
			List<String> wishList = userList.get(0).getWish();
			if(wishList==null){
				wishList = new ArrayList<String>();
			}
			for(String storeId : wishList){
				logger.info("storeId in WishList="+storeId);
				wishStoreList.add(storeRepository.findByStoreId(storeId));
			}
		}
		
		return wishStoreList;
	}
	
	public boolean insertWish(String userId, String storeId){
		User user = userRepository.findByUserId(userId).get(0);
		logger.info("Before Change"+user);
		if(user.getWish()==null){
			user.setWish(new ArrayList<String>());
		}
		user.getWish().add(storeId);
		userRepository.save(user);
		logger.info("After Change"+user);
		return true;
	}
	
	
	public boolean deleteWish(String userId, String storeId){
		User user = userRepository.findByUserId(userId).get(0);
		logger.info("Before Change"+user);
		List<String> wishStoreList = user.getWish();
		for(int i=0; i<wishStoreList.size(); i++){
			if(storeId.equals(wishStoreList.get(i))){
				wishStoreList.remove(i);
			}
		}
		userRepository.save(user);
		logger.info("After Change"+user);
		return true;
	}
	
	public String getWishYn(String userId, String storeId){
		User user = userRepository.findByUserId(userId).get(0);
		List<String> wishStoreList = user.getWish();
		if( wishStoreList!=null && !wishStoreList.isEmpty() ){
			for(String wishStoreId : wishStoreList){
				if(storeId.equals(wishStoreId)){
					return "Y";
				}
			}
		}
		return "N";
	}
}
