package picka.controller;

import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import picka.service.AreaSearchListService;

@Controller
@RequestMapping("areaSearch")
public class AreaSearchController {
	
	private final Logger logger = Logger.getLogger(this.getClass());
	
	@Autowired
	AreaSearchListService areaSearchListService;
	
	@RequestMapping("")
    String areaSearch() {
        return "searchListPage";
    }
	
	
	@RequestMapping("getList")
	@ResponseBody
    List<String> getList(@RequestParam String area) throws Exception {
		logger.info("DEBUG::getList(area="+area+")");
		return areaSearchListService.getList(area);
    }
	
}
