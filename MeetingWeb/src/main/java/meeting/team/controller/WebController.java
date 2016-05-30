package meeting.team.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import meeting.team.service.UserService;
import meeting.team.vo.UserVo;

@RequestMapping("/meeting/")
@Controller
public class WebController {
	@Autowired
	private UserService us;
	
	@RequestMapping(value="main", method = RequestMethod.GET)
	public String mainPage() {
		return "mainPage";
	}
	
	@RequestMapping(value="join", method = RequestMethod.POST)
	@ResponseBody
	public String join(UserVo uvo){
		return us.join(uvo);
	}
}
