package picka.service;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.MongoOperations;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.stereotype.Service;

import picka.data.dao.Review;
import picka.data.dao.Store;
import picka.data.repository.StoreRepository;

@Service
public class StoreService {
	private final Logger logger = Logger.getLogger(this.getClass());

	@Autowired
	private StoreRepository storeRepository;
	
	@Autowired
	private MongoOperations mongoOps;
	
	public Store viewDetail(String storeId, String userId) {
		logger.info("viewDetail..........");
		return storeRepository.findByStoreId(storeId);
	}
	
	public List<Store> getStoreListByConditions(HttpServletRequest req) {

		String majorCategory = req.getParameter("majorCategory") == null? "":req.getParameter("majorCategory");
		String minorCategory = req.getParameter("minorCategory") == null? "":req.getParameter("minorCategory");
		String capacity      = req.getParameter("capacity") == null? "":req.getParameter("capacity");
		String minPrice      = req.getParameter("minPrice") == null? "":req.getParameter("minPrice");
		String maxPrice      = req.getParameter("maxPrice") == null? "":req.getParameter("maxPrice");
		logger.info("input    "+majorCategory+":"+minorCategory+":"+capacity+":"+minPrice+":"+maxPrice);
 

		/* dynamic으로 쿼리 작성 */
		Query query = new Query();
		if (!majorCategory.isEmpty()) {
			query.addCriteria(Criteria.where("majorCategory").is(majorCategory));
		}
		
		if (!minorCategory.isEmpty()) {
			query.addCriteria(Criteria.where("minorCategory").is(minorCategory));
		}
		
		if (!capacity.isEmpty()) {
			query.addCriteria(Criteria.where("capacity").not().gt(capacity));
		}
 
		if (!minPrice.isEmpty()&&!maxPrice.isEmpty()) {
			query.addCriteria(Criteria.where("price")
					.gt(minPrice).lt(maxPrice));
		}
		
		List<Store> storeList = mongoOps.find(query, Store.class);
		
		if(logger.isInfoEnabled()){
			logger.info(query.toString());
			logger.info("output    storeList.size(): " + storeList.size());
			for (Store s : storeList) {
				logger.info(s.toString());
			}
		}
		
		return storeList;
	}
	
	public List<Store> getSecondStoreList(HttpServletRequest req){
		String storeId = req.getParameter("storeId") == null ? "" : req.getParameter("storeId");
		String majorCategory = req.getParameter("majorCategory") == null ? "" : req.getParameter("majorCategory");
		int foodLevel = req.getParameter("foodLevel") == null ? 0 : Integer.parseInt(req.getParameter("foodLevel"));
		int drinksCode = req.getParameter("drinksCode") == null ? 0 : Integer.parseInt(req.getParameter("drinksCode"));
		double lat = req.getParameter("lat") == null ? 0 : Double.parseDouble(req.getParameter("lat"));
		double lng = req.getParameter("lng") == null ? 0 : Double.parseDouble(req.getParameter("lng"));

//		if("한식".equals(majorCategory)){
//			majorCategory = "ko";
//		}else if("중식".equals(majorCategory)){
//			majorCategory = "ch";
//		}else if("일식".equals(majorCategory)){
//			majorCategory = "jp";
//		}else if("양식".equals(majorCategory)){
//			majorCategory = "ws";
//		}else {
//			majorCategory = "ac";
//		}
		
		switch(majorCategory){
		case "한식":
			majorCategory = "ko";
			break;

		case "중식":
			majorCategory = "ch";
			break;
		
		case "일식":
			majorCategory = "jp";
			break;
		
		case "양식":
			majorCategory = "ws";
			break;
		
		default :
			majorCategory = "ac";
			
		}
		
		
		/* dynamic 쿼리 */
		Query query = new Query();
		
		query.addCriteria(Criteria.where("storeId").ne(storeId));
		if (!majorCategory.isEmpty()) {
			query.addCriteria(Criteria.where("majorCategory").ne(majorCategory));
		}

		if (foodLevel >= 1) {
			query.addCriteria(Criteria.where("foodLevel").lte(11 - foodLevel));
		}

		query.addCriteria(Criteria.where("drinksCode").gte(2));

		query.addCriteria(Criteria.where("lat").gt(lat - 0.03).lt(lat + 0.03));

		query.addCriteria(Criteria.where("lng").gt(lng - 0.03).lt(lng + 0.03));

		logger.info(query.toString());
		return mongoOps.find(query, Store.class);
	}
	
	public List<Review> saveReview(HttpServletRequest req, Review review){
		String storeId = req.getParameter("storeId");
		Store s = storeRepository.findByStoreId(storeId);
		if (s != null) {
			if (s.getReview() != null) {
				s.getReview().add(review);
			} else {
				List<Review> reviewList = new ArrayList<Review>();
				reviewList.add(review);
				s.setReview(reviewList);
			}
			s.setTotUser(s.getTotUser() + 1);
			s.setTotPoint(s.getTotPoint() + review.getPoint());
		}
		storeRepository.save(s);
		List<Review> resultList = storeRepository.findByStoreId(storeId).getReview();
		if ((resultList != null) && (!resultList.isEmpty())) {
			Collections.reverse(resultList);
		}
		return resultList;
	}
	
}
