package meeting.team.controller;

import java.io.File;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import meeting.team.service.ReviewsService;
import meeting.team.vo.NoticeVO;
import meeting.team.vo.ReviewsVo;

@Controller
@RequestMapping("/reviews/")
public class ReviewsController {
	@Autowired
	ReviewsService reviews_svc;

	@RequestMapping("writeForm")
	public String writeForm() {
		return "reviews/reviewsWrite";
	}
	
	@RequestMapping("list")
	public String list(Model model, HttpServletRequest request) {
		String sPage = request.getParameter("page");
		int page = 1;
		if(sPage != null)
			page = Integer.parseInt(sPage);
		model.addAttribute("list", reviews_svc.getList(page));
		return "reviews/reviewsList";
	}
	
	@RequestMapping(value = "moreList", method = RequestMethod.POST)
	public @ResponseBody String moreList(@RequestParam int page) {
		return reviews_svc.moreList(page);
	}

	@RequestMapping(value = "insert", method = RequestMethod.POST)
	public @ResponseBody String insert(ReviewsVo reviews, HttpServletRequest request){
		return reviews_svc.fileUpload(reviews, request);
	}
	
	@RequestMapping(value = "selectOne")
	public String selectOne(@RequestParam int num, Model model, HttpSession session) {
		model.addAttribute("data", reviews_svc.selectOne(num, session));
		Map<String,Object> map=reviews_svc.pagination(num,1);
		model.addAttribute("map",map);		
		return "reviews/reviewsRead";
	}
	
	@RequestMapping(value = "delete", method = RequestMethod.POST)
	public @ResponseBody String delete(@RequestParam int num) {
		return reviews_svc.delete(num);
	}
	
	@RequestMapping(value="/replyWrite")
	@ResponseBody
	public String replyWrite(HttpServletRequest request){
		return reviews_svc.replyWrite(request);
		
	}
	@RequestMapping(value="/nextReply")
	@ResponseBody
	public String nextReply(@ModelAttribute("num")int num,@ModelAttribute("page")int page){
		return reviews_svc.nextReply(num, page);		
	}
	
	@RequestMapping(value="/prevReply")
	@ResponseBody
	public String prevReply(@ModelAttribute("num")int num,@ModelAttribute("page")int page){
		return reviews_svc.prevReply(num,page);		
	}
	
	@RequestMapping(value="/allReply")
	@ResponseBody
	public String allReply(@ModelAttribute("num")int num){
		return reviews_svc.allReply(num);		
	}
	@RequestMapping(value="/firstReply")
	@ResponseBody
	public String firstReply(@ModelAttribute("num")int num){
		return reviews_svc.firstReply(num);		
	}
	
	@RequestMapping(value="/replyDel")
	@ResponseBody
	public String replyDel(HttpServletRequest request){
		return reviews_svc.replyDel(request);
	}
	
	@RequestMapping(value="/replyModify")
	@ResponseBody
	public String replyModify(HttpServletRequest request){
		return reviews_svc.replyModify(request);		
	}
	
	@RequestMapping(value="/modify")
	public String modify(Model model,@RequestParam("num")int num){		
		ReviewsVo data=reviews_svc.selectOne(num, null);		
		model.addAttribute("data",data);
		return "reviews/reviewsModify";
	}
	@RequestMapping(value="/modifygo" ,method = RequestMethod.POST)
	@ResponseBody
	public String modifygo(ReviewsVo reviews ,HttpServletRequest request){
		return reviews_svc.modify(reviews, request);		
	}
	///////////////////////////
	@RequestMapping(value="/latelyRead")
	public String latelyRead(Model model){
		ReviewsVo board=reviews_svc.latelyRead();
		model.addAttribute("data",board);
		int num=reviews_svc.getLatelyNum();
		Map<String,Object> map=reviews_svc.pagination(num,1);
		model.addAttribute("map",map);		
		return "reviews/reviewsRead";
	}
	
}
