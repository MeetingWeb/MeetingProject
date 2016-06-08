package meeting.team.controller;

import java.net.UnknownHostException;
import java.text.ParseException;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import meeting.team.service.MeetingService;
import meeting.team.vo.MeetingVo;

@RequestMapping("/meeting/")
@Controller
public class MeetingController {
	@Autowired
	MeetingService meeting_svc;
	
	@RequestMapping("meetingList")
	public String getMeetingList(Model model, HttpServletRequest request) throws UnknownHostException {
		meeting_svc.getMeetingList(request);
		String[] ipArr = meeting_svc.getPosition();
		model.addAttribute("id", request.getParameter("id"));
		model.addAttribute("ip", ipArr);
		return "mainPage";
	}
	
	@RequestMapping(value = "insert", method = RequestMethod.POST)
	public @ResponseBody String insert(MeetingVo meeting, HttpServletRequest request){
		try {
			return meeting_svc.insert(meeting, request);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return null;
	}
	
}
