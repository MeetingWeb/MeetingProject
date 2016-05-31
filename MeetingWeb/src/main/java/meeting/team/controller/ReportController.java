package meeting.team.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import meeting.team.service.ReportService;
import meeting.team.vo.BoardVo;

@RequestMapping("/report/")
@Controller
public class ReportController {
	
	@Autowired
	private ReportService reportService;
	
	// �� ��ȸ(����Ʈ)
	@RequestMapping(value="list", method=RequestMethod.GET)
	public ModelAndView reportList(BoardVo bvo) {
		return reportService.getReport(bvo);
	}
	
	// �� ���
	@RequestMapping(value="writeForm", method=RequestMethod.GET)
	public ModelAndView writeForm() {
		return new ModelAndView("report/reportWrite");
	}
	
	@ResponseBody
	@RequestMapping(value="write", method=RequestMethod.POST)
	public Map<String, Object> addReport(BoardVo bvo) {
		return reportService.insertReport(bvo);
	}
	
}
