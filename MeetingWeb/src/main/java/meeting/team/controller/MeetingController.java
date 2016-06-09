package meeting.team.controller;

import java.text.ParseException;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
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
	
	@RequestMapping(value = "insert", method = RequestMethod.POST)
	public @ResponseBody String insert(MeetingVo meeting, HttpServletRequest request){
		try {
			return meeting_svc.insert(meeting, request);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return null;
	}
	
	@RequestMapping(value="mapSaveLocal", method = RequestMethod.POST)
	public @ResponseBody String mapSaveLocal(HttpServletRequest request) {
		return meeting_svc.mapSaveLocal(request);
	}
	
	@RequestMapping(value = "roughMapSave", method = RequestMethod.POST)
	public @ResponseBody String roughMapSave(HttpServletRequest request) {
		return meeting_svc.roughMapSave(request);
	}
	
}
