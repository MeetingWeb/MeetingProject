package meeting.team.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
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
	
	@RequestMapping(value="check", method = RequestMethod.POST)
	@ResponseBody
	public String check(@Valid UserVo uvo,BindingResult result,HttpServletRequest request){
		return us.check(uvo,result,request);
	}
	
	@RequestMapping(value="addForm", method = RequestMethod.GET)
	public String addMeetingForm() {
		return "addMeetingForm";
	}
	
	@RequestMapping("mobileLogin")
	public String mobileLoginForm(){
		return "mobile/mobileLoginForm";
	}
	
	@RequestMapping("chatForm")
	public String chatForm(Model model, HttpSession session){
		ArrayList<String> list = ms.getChatList(session);
		model.addAttribute("list", list);
		return "include/chat_view";
	}
	
	@RequestMapping(value="join", method = RequestMethod.POST)
	@ResponseBody
	public String join(UserVo uvo,HttpServletRequest request){
		return us.join(uvo,request);
	}
	
	@RequestMapping("loginSuccess")
	public String loginSuccess() {
		return "loginSuccess";
	}
	
	@RequestMapping(value="id_check", method = RequestMethod.POST)
	@ResponseBody
	public String id_check(@RequestParam("id") String id, HttpServletRequest request){
		return us.id_check(id,request);
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
        email.setContent("<form target='my' method='post' action='http://192.168.8.27:8088/NowMeetingWeb/web/email_join'>"

        		+ "<input type='hidden' name='sess' value='"+session.getId()+"'> "
        				+ "<button type='submit'>인증확인</button></form>");
        
    
    	System.out.println(email.getContent());
    	
        boolean result = us.email_check(email);
        JSONObject json = new JSONObject();
      
        json.put("ok", result);
        return json.toJSONString();
    }
	
	
	
	@RequestMapping("email_join")
	public String email_join(HttpSession session,HttpServletRequest request, Model model) {
    	
    	String sessionid = request.getParameter("sess");
    	String userId = request.getParameter("id");
 
    		HttpSession sessions = request.getServletContext().getAttribute(sessionid)==null ? 		
        	    	request.getSession() : (HttpSession)request.getServletContext().getAttribute(sessionid);	
        	    	
        	    	request.setAttribute("email", sessions.getAttribute("email"));
        	    	request.setAttribute("ok", true);
        	    	request.getServletContext().removeAttribute(session.getId()); 
    	    	
    	return "mainPage";
	}
	
	 @RequestMapping({"main",""})
		public String mainPage(HttpSession session,HttpServletRequest request, Model model) {
	    	String sessionid = request.getParameter("sess");
	    	String userId = request.getParameter("id");	
	    	String search = request.getParameter("search");		    	
	    	if(userId != null) {
	    		us.setChatList(userId);
	    		session.setAttribute("id", userId);
	    		model.addAttribute("id", userId);	  	    		
	    	}	 
	    	model.addAttribute("search",search);
	    	
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
	 @RequestMapping(value="search")
	 @ResponseBody
	 public String search(@RequestParam("data")String[] list){
	 	return ms.getMeetings(list);
	 }
	 @RequestMapping(value="blackList")
	 public String getBlacklist(Model model){
		 List<UserVo> list=us.getList();
		 model.addAttribute("list", list);
		 return "blackList";
				 
	 }
	 @RequestMapping(value="powerUpdate")
	 @ResponseBody
	 public String powerUpdate(HttpServletRequest request){
		
		 return us.powerUpdate(request);
		  
	 }
	 
	 
	 @RequestMapping(value="personal_info")
	 @ResponseBody
	 public String personal_info(@RequestParam("id")String id){
		

		 return us.personal_info(id);
	 }
	  
	 @RequestMapping(value="personal_form", method = RequestMethod.GET)
		public String personal_form(HttpServletRequest request,Model model) throws Exception {
		 String id = (String) request.getSession().getAttribute("id");
		 List<MeetingVo> list =  us.create_join(id);
		 System.out.println("제목뜨냐"+list.get(0).getTitle());
		 model.addAttribute("mlist", list);
		 return "parsonal/personal_info";
		}
	 
	 
	 @RequestMapping(value="pwchange")
	 @ResponseBody
	 public String pwchange(@RequestParam("id")String id, @RequestParam("pw")String pw){
		 return us.pwchange(id,pw);
	 }
	 
	 @RequestMapping(value="interests")
	 @ResponseBody
	 public String interests(@RequestParam("id")String id, @RequestParam("interests")String interests){
		 return us.interests(id,interests);
	 }
	 
    
}
