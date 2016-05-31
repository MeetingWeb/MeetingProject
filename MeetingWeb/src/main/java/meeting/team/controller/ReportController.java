package meeting.team.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@RequestMapping("/report/")
@Controller
public class ReportController {
	
	@RequestMapping(value="list", method=RequestMethod.GET)
	public String ReportList() {
		return "report/reportList";
	}
	
}
