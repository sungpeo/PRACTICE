package picka.data.repository;


import java.util.List;

import org.springframework.data.mongodb.repository.MongoRepository;

import picka.data.dao.User;

public interface UserRepository extends MongoRepository<User, String> {
/*
What makes Spring Data MongoDB so useful is the fact
 that you don’t have to create this implementation.
  Spring Data MongoDB creates it on the fly when you run the application.
 */
    public List<User> findByUserId(String userId);
    public List<User> findByUserIdAndPw(String userId, String pw);
    public List<User> findByNickName(String nickName);
    
}