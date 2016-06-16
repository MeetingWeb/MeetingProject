package meeting.team.controller;

import java.util.List;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import meeting.team.service.MeetingService;
import meeting.team.service.UserService;
import meeting.team.vo.EmailVo;
import meeting.team.vo.MeetingVo;
import meeting.team.vo.UserVo;

@RequestMapping({"/web/"})
@Controller
public class WebController {
	@Autowired
	private UserService us;
	
	@Autowired
	private MeetingService ms;
	
	@RequestMapping(value="addForm", method = RequestMethod.GET)
	public String addMeetingForm() {
		return "addMeetingForm";
	}
	
	@RequestMapping(value="join", method = RequestMethod.POST)
	@ResponseBody
	public String join(UserVo uvo){
		return us.join(uvo);
	}
	
	@RequestMapping("loginSuccess")
	public String loginSuccess() {
		return "loginSuccess";
	}
	
	@RequestMapping(value="id_check", method = RequestMethod.POST)
	@ResponseBody
	public String id_check(@RequestParam("id") String id){
		return us.id_check(id);
	}
	
	
	@RequestMapping(value="eamil_check")
    @ResponseBody
    public String email_check(@RequestParam("email")String email2,HttpSession session) throws Exception {

    	//System.out.println(email2);
        EmailVo email = new EmailVo();
        String my = "my";
        session.setAttribute("email", email2);
        email.setReceiver(email2);
        email.setSubject("이메일 확인입니다.");
        email.setContent("<form target='my' method='post' action='http://192.168.8.27:8088/NowMeetingWeb/web/main'>"
        		+ "<input type='hidden' name='sess' value='"+session.getId()+"'> "
        				+ "<button type='submit'>인증확인</button></form>");
        //email.setContent("<a target="+my+" href='http://192.168.8.27:8088/NowMeetingWeb/email_join?sess="+session.getId()+"'>인증 완료</a>");
    
    	System.out.println(email.getContent());
    	
        boolean result = us.email_check(email);
        JSONObject json = new JSONObject();
      
        json.put("ok", result);
        return json.toJSONString();
    }
	
	 @RequestMapping({"main",""})
		public String mainPage(HttpSession session,HttpServletRequest request, Model model) {
	    	
	    	String sessionid = request.getParameter("sess");
	    	String userId = request.getParameter("id");	    	
	    	if(userId != null) {
	    		session.setAttribute("id", userId);
	    		model.addAttribute("id", userId);		    		    		
	    	}	  	    	    	
	    	return "mainPage";
		}
	 
	 @RequestMapping(value="myLocation")
	 public String myLocationForm(){
		 return "myLocation";
	 }
	 
	 @RequestMapping(value="getAllMeeting")
	 @ResponseBody
	 public String getAllMeeting(){
		 return ms.getAllMeeting();
	 }
	 @RequestMapping(value="getMeeting")
	 @ResponseBody
	 public String getMeeting(@ModelAttribute("num")int num){
		 return ms.getMeeting(num);
	 }
    
	 @RequestMapping(value="changeMyLOC")
	 public String changeLOC(HttpServletRequest request,Model model){
		 boolean ok=us.changeLatlng(request);
		 if(ok)System.out.println("위치저장완료");
		 return "mainPage";
	 }
	 @RequestMapping(value="choiceLOC")		
	 public String choiceLOC(HttpSession session,HttpServletRequest request, Model model)
	 {
		 	String userId = request.getParameter("id");		
	    	if(userId != null) {
	    		session.setAttribute("id", userId);
	    		model.addAttribute("id", userId);		    		    		
	    	}	  	    	    	
	    	return "choiceLocationMenu";
	 }
	 
	 @RequestMapping(value="getMyLocation")
	 @ResponseBody
	 public String getMyLocation(HttpServletRequest request)
	 {		
		 return us.getMyLocation(request);		 
	 }
	 
	 @RequestMapping(value="getRecommend")
	 @ResponseBody
	 public String getRecommend(HttpServletRequest request)
	 {	
		 return ms.getRecommend(us.getInterest(request));		 
	 }
    
}
