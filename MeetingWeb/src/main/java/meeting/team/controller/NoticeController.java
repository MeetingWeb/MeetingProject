package meeting.team.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import meeting.team.service.NoticeService;
import meeting.team.vo.NoticeVO;

@Controller
@RequestMapping(value="/notice")
public class NoticeController {
	
	@Autowired
	NoticeService ntSVC;
	
	@RequestMapping(value="/writeForm")
	public String getWriteForm(){		
		return "notice/noticeWrite";
	}	
	
	@RequestMapping(value="/modifyForm")
	public String getModifyForm(Model model,@ModelAttribute("num")int num){
		NoticeVO data=ntSVC.modifyForm(num);
		model.addAttribute("data", data);		
		return "notice/noticeModify";
	}
	
	@RequestMapping(value="/latelyRead")
	public String latelyRead(Model model){
		NoticeVO board=ntSVC.latelyRead();
		model.addAttribute("data",board);
		int num=ntSVC.getLatelyNum();
		Map<String,Object> map=ntSVC.pagination(num,1);
		model.addAttribute("map",map);		
		return "notice/noticeRead";
	}
	
	@RequestMapping(value="/read")
	public String read(@ModelAttribute("num")int num,Model model){
		NoticeVO board=ntSVC.read(num);		
		model.addAttribute("data",board);		
		Map<String,Object> map=ntSVC.pagination(num,1);
		model.addAttribute("map",map);
		
		return "notice/noticeRead";
	}
	
	@RequestMapping(value="/write")
	@ResponseBody
	public String write(HttpServletRequest request){
		return ntSVC.write(request);
	}
	
	@RequestMapping(value="/modify")
	@ResponseBody
	public String modify(HttpServletRequest request){		
		return ntSVC.modify(request);
	}
	
	@RequestMapping(value="/delete")
	@ResponseBody
	public String delete(@ModelAttribute("num")int num){		
		return ntSVC.delete(num);
	}
	
	@RequestMapping(value="/getList")
	public String getList(Model model){			
		Map<String,Object> map=ntSVC.pagination(1);
		model.addAttribute("map",map);
		return "notice/noticeList";
	}
	@RequestMapping(value="/getPage")
	public String getPage(@ModelAttribute("page")int page, Model model){		
		Map<String,Object> map=ntSVC.pagination(page);
		model.addAttribute("map",map);
		return "notice/noticeList";
	
	}
	@RequestMapping(value="/searchList")
	public String searchList(@ModelAttribute("key")String key,Model model){		
		Map<String,Object> map=ntSVC.pagination(key,1);
		model.addAttribute("map",map);
		return "notice/noticeList";
			
	}	
	@RequestMapping(value="/searchPage")
	public String searchList(@ModelAttribute("key")String key,@ModelAttribute("page")int page,Model model){		
		Map<String,Object> map=ntSVC.pagination(key,page);
		model.addAttribute("map",map);
		return "notice/noticeList";
			
	}	
	@RequestMapping(value="/allReply")
	@ResponseBody
	public String allReply(@ModelAttribute("num")int num){
		return ntSVC.allReply(num);		
	}
	
	@RequestMapping(value="/firstReply")
	@ResponseBody
	public String firstReply(@ModelAttribute("num")int num){
		return ntSVC.firstReply(num);		
	}
	
	@RequestMapping(value="/nextReply")
	@ResponseBody
	public String nextReply(@ModelAttribute("num")int num,@ModelAttribute("page")int page){
		return ntSVC.nextReply(num, page);		
	}
	
	@RequestMapping(value="/prevReply")
	@ResponseBody
	public String prevReply(@ModelAttribute("num")int num,@ModelAttribute("page")int page){
		return ntSVC.prevReply(num,page);		
	}
	
	@RequestMapping(value="/replyWrite")
	@ResponseBody
	public String replyWrite(HttpServletRequest request){
		return ntSVC.replyWrite(request);
		
	}
	
	@RequestMapping(value="/replyDel")
	@ResponseBody
	public String replyDel(HttpServletRequest request){
		return ntSVC.replyDel(request);
	}
	
	@RequestMapping(value="/replyModify")
	@ResponseBody
	public String replyModify(HttpServletRequest request){
		return ntSVC.replyModify(request);
		
	}
	
}
