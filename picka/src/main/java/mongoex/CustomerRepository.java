package mongoex;

import java.util.List;

import org.springframework.data.mongodb.repository.MongoRepository;

public interface CustomerRepository extends MongoRepository<Customer, String> {
/*
What makes Spring Data MongoDB so useful is the fact
 that you don’t have to create this implementation.
  Spring Data MongoDB creates it on the fly when you run the application.
 */
    public Customer findByFirstName(String firstName);
    public List<Customer> findByLastName(String lastName);

}