package meeting.team.controller;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
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
import org.springframework.web.multipart.MultipartFile;

import meeting.team.service.InquiryService;
import meeting.team.vo.InquiryVo;
import meeting.team.vo.NoticeVO;

@RequestMapping("/inquiry/")
@Controller
public class InquiryController {
	
	@Autowired
	private InquiryService is;
	
	@RequestMapping(value="/writeForm")
	public String writeForm(){		
		return "inquiry/inquiryWrite";
	}

	
	@RequestMapping(value="writesave", method=RequestMethod.POST)
	@ResponseBody
	public String writesave(InquiryVo ivo,HttpServletRequest request)
	{
	    return is.write(ivo,request);
	}
	
	@RequestMapping(value="/readForm", method=RequestMethod.GET)
	public String readForm(@RequestParam("num")int num,@RequestParam("page")int page, @RequestParam("start") int start,HttpServletRequest request,Model model){	
		request.setAttribute("start", start);
		InquiryVo ivo = is.read(num);
		List<InquiryVo> list = is.replyList(page, num, request);
		model.addAttribute("ivo", ivo);
		model.addAttribute("replylist", list);
		return "inquiry/inquiryRead";
	}
	
	@RequestMapping(value="lateread", method=RequestMethod.GET)
	public String lateread(Model model){
		model.addAttribute("start", 1);
		InquiryVo ivo = is.lread();
		System.out.println(ivo.getImg_name());
		model.addAttribute("ivo", ivo);
		model.addAttribute("repleptotal", 0);
		return "inquiry/inquiryRead";
	}
	
	@RequestMapping(value="deletes", method=RequestMethod.POST)
	@ResponseBody
	public String deletes(@RequestParam("num")int num)
	{
		return is.deletes(num);
	}
	
	@RequestMapping(value="update", method=RequestMethod.GET)
	public String update(@RequestParam("num")int num,Model model){		
		InquiryVo ivo = is.update(num);
		model.addAttribute("ivo", ivo);
		return "inquiry/inquiryUpdate";
	}
	
	@RequestMapping(value="updates", method=RequestMethod.POST)
	@ResponseBody
	public String updates(InquiryVo ivo)
	{
		return is.updates(ivo);
		
	}
	
	@RequestMapping(value="repleupdateform", method=RequestMethod.POST)
	@ResponseBody
	public String repleupdateform(@RequestParam("num")int num)
	{
		InquiryVo ivo = is.read(num);
		JSONObject json = new JSONObject();
		json.put("ok", true);
		json.put("contents", ivo.getContents());
		json.put("num", ivo.getNum());
		return json.toJSONString();
	}
	
	@RequestMapping(value="repleupdate", method=RequestMethod.POST)
	@ResponseBody
	public String repleupdate(InquiryVo ivo)
	{
		return is.repleupdates(ivo);
		
	}
	
	@RequestMapping(value="list",method=RequestMethod.GET)
	public String list(HttpServletRequest request, @RequestParam("page") int page, @RequestParam("start") int start, @RequestParam("check") int check)
	{
		request.setAttribute("start", start);
		List<InquiryVo> list = is.ilist(page,request,check);
		request.setAttribute("list", list);
		return "inquiry/inquiryList";
	}
	
	

}
