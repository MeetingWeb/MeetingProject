package meeting.team.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import meeting.team.service.UserSearchService;
import meeting.team.vo.UserVo;

@RequestMapping("/")
@Controller
public class UserSearchController {
	
	@Autowired
	UserSearchService usService;
	
	@RequestMapping(value="sarchForm", method=RequestMethod.GET)
	public String SearchForm() {
		return "include/searchUser";
	}
	
	// ID 찾기
	@ResponseBody
	@RequestMapping(value="searchID", method=RequestMethod.POST)
	public Map<String, Object> searchID(UserVo userVo) throws Exception {
		return usService.searchID(userVo);
	}
	
	// PW 찾기
	@ResponseBody
	@RequestMapping(value="searchPW", method=RequestMethod.POST)
	public Map<String, Object> searchPW(UserVo userVo) throws Exception {
		return usService.searchPW(userVo);
	}
	
}
