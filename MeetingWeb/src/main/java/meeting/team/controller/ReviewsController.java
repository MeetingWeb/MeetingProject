package meeting.team.controller;

import java.io.File;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import meeting.team.service.ReviewsService;
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
	public String list(Model model) {
		model.addAttribute("list", reviews_svc.getList());
		return "reviews/reviewsList";
	}

	@RequestMapping(value = "insert", method = RequestMethod.POST)
	public @ResponseBody String insert(ReviewsVo reviews, HttpServletRequest request){
		return reviews_svc.fileUpload(reviews, request);
	}
	
	@RequestMapping(value = "selectOne")
	public String selectOne(@RequestParam int num, Model model, HttpSession session) {
		model.addAttribute("data", reviews_svc.selectOne(num, session));
		return "reviews/reviewsRead";
	}
	
	@RequestMapping(value = "delete", method = RequestMethod.POST)
	public @ResponseBody String delete(@RequestParam int num) {
		return reviews_svc.delete(num);
	}
}
