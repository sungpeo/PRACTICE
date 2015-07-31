package mongoex;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

//@RestController
//public class GreetingController {
///*
//Create a resource controller
//
//In Spring’s approach to building RESTful web services, HTTP requests are handled by a controller. 
//These components are easily identified by the '@RestController' annotation,
// and the 'GreetingController' below 
// handles 'GET' requests for '/greeting' by returning a new instance of the 'Greeting' class:
//
//... ...
//
//This code uses Spring 4’s new @RestController annotation,
// which marks the class as a controller where every method returns a domain object instead of a view. 
//It’s shorthand for @Controller and @ResponseBody rolled together.
//
//
//
//link: http://spring.io/guides/gs/rest-service/
// */
//    private static final String template = "Hello, %s!";
//    private final AtomicLong counter = new AtomicLong();
//
//    @RequestMapping("/greeting")
//    public Greeting greeting(@RequestParam(value="name", defaultValue="World") String name) {
//        return new Greeting(counter.incrementAndGet(),
//                            String.format(template, name));
//    }
//}

@Controller
public class GreetingController {

    @RequestMapping("/greeting")
    public String greeting(@RequestParam(value="name", required=false, defaultValue="World") String name, Model model) {
        model.addAttribute("name", name);
        return "greeting";
    }

}
