package meeting.team.controller;

import java.text.ParseException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import meeting.team.service.MeetingService;
import meeting.team.vo.MeetingVo;

@RequestMapping("/meeting/")
@Controller
public class MeetingController {
	@Autowired
	MeetingService meeting_svc;
	public static Map<String, ArrayList<String>> chatMap = new HashMap<String, ArrayList<String>>();

	@RequestMapping(value = "insert", method = RequestMethod.POST)
	public @ResponseBody String insert(MeetingVo meeting, HttpServletRequest request) {
		try {
			return meeting_svc.insert(meeting, request);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return null;
	}
	
	@RequestMapping(value = "meetingView", method = RequestMethod.GET)
	public String meetingView(@RequestParam int num, Model model, HttpSession session){
		model.addAttribute("data", meeting_svc.selectOne(num, session));
		return "meetingView";
	}

	@RequestMapping(value = "mapSaveLocal", method = RequestMethod.POST)
	public @ResponseBody String mapSaveLocal(HttpServletRequest request) {
		return meeting_svc.mapSaveLocal(request);
	}
	
	@RequestMapping(value = "chatInsert", method = RequestMethod.POST)
	public @ResponseBody String chatInsert(HttpServletRequest request){
		return meeting_svc.chatInsert(request);
	}
	
	@RequestMapping(value = "notNowList", method = RequestMethod.GET)
	public String getList(Model model) throws Exception {
		model.addAttribute("list", meeting_svc.getNotNowMeetingList());
		return "MeetingList";
	}
}
