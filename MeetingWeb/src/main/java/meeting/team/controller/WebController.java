package meeting.team.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@RequestMapping("/meeting/")
@Controller
public class WebController {
	@RequestMapping(value="main", method = RequestMethod.GET)
	public String mainPage() {
		return "mainPage";
	}
}
