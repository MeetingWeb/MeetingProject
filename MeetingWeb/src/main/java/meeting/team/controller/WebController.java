package meeting.team.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import meeting.team.service.UserService;
import meeting.team.vo.UserVo;

@RequestMapping({"/"})
@Controller
public class WebController {
	@Autowired
	private UserService us;
	
	@RequestMapping({"main",""})
	public String mainPage() {
		return "mainPage";
	}
	
	@RequestMapping(value="join", method = RequestMethod.POST)
	@ResponseBody
	public String join(UserVo uvo){
		return us.join(uvo);
	}
	
	@RequestMapping(value="id_check", method = RequestMethod.POST)
	@ResponseBody
	public String id_check(@RequestParam("id") String id){
		return us.id_check(id);
	}
	/*
	@RequestMapping(value="eamil_check", method = RequestMethod.POST)
	@ResponseBody
	public String email_check(@RequestParam("email") String email,HttpSession session) throws Exception{
		return us.email_check(email,session);
	}
	
    @RequestMapping(value="/eamil_check" ,method = RequestMethod.POST)
    @ResponseBody
    public HashMap<String, Object> email_check(@RequestParam("email")String email2,HttpSession session) throws Exception {

    	
        EmailVo email = new EmailVo();
        session.setAttribute("email", email2);
        email.setReceiver(email2);
        email.setSubject("이메일 확인입니다.");
        email.setContent("<a href='http://192.168.8.27:8088/SpringWeb/email/join?sess="+session.getId()+"' target='uf'>인증 완료</a>");
    
    	
    	
        boolean result = us.email_check(email);
        HashMap<String,Object> hsm = new HashMap<String, Object>();
		hsm.put("ok", result);
		
        
        return hsm;
    }
    
    @RequestMapping(value="/email_join")
    public String email_join(@RequestParam("sess") String sessionid,HttpSession session,HttpServletRequest request)
    {
    	System.out.println("ggggggggggggg");
    	HttpSession sessions = request.getServletContext().getAttribute(sessionid)==null ? 		
    	request.getSession() : (HttpSession)request.getServletContext().getAttribute(sessionid);	
    	
    	request.setAttribute("email", sessions.getAttribute("email"));
    	request.setAttribute("session_id", sessions.getId());
    	
    	request.getServletContext().removeAttribute(session.getId()); 
		
    	return "views/mainPage";
    }*/
}
