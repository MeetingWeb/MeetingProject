package meeting.team.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/reviews/")
public class ReviewsController {
	@RequestMapping("writeForm")
	public String writeForm() {
		return "reviews/reviewsWrite";
	}
}
