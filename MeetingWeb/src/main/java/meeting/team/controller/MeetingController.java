package meeting.team.controller;

import java.net.InetAddress;
import java.net.UnknownHostException;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import meeting.team.service.MeetingService;

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
	
}
