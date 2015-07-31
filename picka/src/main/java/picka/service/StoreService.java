package picka.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.MongoOperations;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.stereotype.Service;

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
}
