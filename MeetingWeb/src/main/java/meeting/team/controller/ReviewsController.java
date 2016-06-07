package meeting.team.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
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

	@RequestMapping(value = "insert", method = RequestMethod.POST)
	public @ResponseBody String insert(ReviewsVo reviews, HttpSession session){
		return reviews_svc.fileUpload(reviews, session);
	}
}
