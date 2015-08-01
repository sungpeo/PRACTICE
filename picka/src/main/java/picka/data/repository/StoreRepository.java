package picka.data.repository;

import java.util.List;

import org.springframework.data.mongodb.repository.MongoRepository;

import picka.data.dao.Store;

public interface StoreRepository extends MongoRepository<Store, String> {
	
	//@Query(value = "{'lat' : ?0 , 'lng' : ?1}", fields = "{'lat' : {$gte : 49.9, $lte : 51.1}}") //{$gte : lat-0.1, $lte : lat+0.1}
	public List<Store> findByLatAndLng(double lat, double lng);
	public List<Store> findByLatBetweenAndLngBetween(double latgt, double latlt, double lnggt, double lnglt);
	public Store findByStoreId(String storeId); //storeId로 특정 매장의 정보를 조회. pmk
/*
What makes Spring Data MongoDB so useful is the fact
 that you don’t have to create this implementation.
  Spring Data MongoDB creates it on the fly when you run the application.
 */
//    public Store findByFirstName(String firstName);
//    public List<Store> findByLastName(String lastName);

}