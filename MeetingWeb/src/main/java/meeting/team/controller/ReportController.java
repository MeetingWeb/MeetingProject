package meeting.team.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import meeting.team.interceptor.PageUtil;
import meeting.team.service.ReportService;
import meeting.team.vo.BoardResVo;
import meeting.team.vo.BoardVo;

@RequestMapping("/")
@Controller
public class ReportController {
	
	@Autowired
	private ReportService reportService;
	
	// �� ��ȸ(����Ʈ)
	@RequestMapping(value="reportList")
	public ModelAndView list(
			@RequestParam(value="keyField", required=false) String keyField, 
			@RequestParam(value="keyword", required=false) String keyword, 
			@RequestParam(value="pageNum", defaultValue="1") int pageNum) {
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("keyField", keyField);
		map.put("keyword", keyword);
		
		int totalRowCount = reportService.getCount(map);
		PageUtil pu = new PageUtil(pageNum, totalRowCount, 10, 10);
		
		map.put("startNum", String.valueOf(pu.getStartRow()) );
		map.put("endNum", String.valueOf(pu.getEndRow()) );
		
		List<BoardVo> list = reportService.getReport(map);
		ModelAndView mav = new ModelAndView();
		mav.addObject("listReport", list);
		
		// �˻� ����
		mav.addObject("keyField", keyField);
		mav.addObject("keyword", keyword);
		
		// ����¡
		mav.addObject("startPageNum", pu.getStartPageNum());
		mav.addObject("endPageNum", pu.getEndPageNum());
		mav.addObject("totalPageCount", pu.getTotalPageCount());
		mav.addObject("pageNum", pageNum);
		
		// jsp ���
		mav.setViewName("report/reportList");
		
		return mav;
	}
	
	// �� ���
	@RequestMapping(value="reportForm", method=RequestMethod.GET)
	public ModelAndView writeForm() {
		return new ModelAndView("report/reportWrite");
	}
	
	@ResponseBody
	@RequestMapping(value="reportWrite", method=RequestMethod.POST)
	public Map<String, Object> addReport(BoardVo bvo) {
		return reportService.insertReport(bvo);
	}
	
	// �� ����ȸ
	@RequestMapping(value="reportInfo", method=RequestMethod.GET)
	public String reportView(@RequestParam int num, Model model) {
		
		BoardVo bvo = reportService.infoReport(num);
		
		model.addAttribute("info", bvo);
		model.addAttribute("prev", reportService.getPrev(num));
		model.addAttribute("next", reportService.getNext(num));
		// ��� ��ȸ
		model.addAttribute("replyList", reportService.getReply(num));
		
		return "report/reportView";
	}
	
	// �� ����
	@RequestMapping(value="editForm", method=RequestMethod.GET)
	public String editForm(@RequestParam int num, Model model) {
		BoardVo bvo = reportService.infoReport(num);
		model.addAttribute("info", bvo);
		
		return "report/reportEdit";
	}
	
	@ResponseBody
	@RequestMapping(value="reportEdit", method=RequestMethod.POST)
	public Map<String, Object> editReport(BoardVo bvo) {
		return reportService.updateReport(bvo);
	}
	
	// �� ����
	@ResponseBody
	@RequestMapping(value="reportRemove", method=RequestMethod.POST)
	public Map<String, Object> removeReport(BoardVo bvo) {
		return reportService.deleteReport(bvo);
	}
	
	/* ------���------ */
	
	// ��� ���
	@ResponseBody
	@RequestMapping(value="replyWrite", method=RequestMethod.POST)
	public Map<String, Object> addReply(BoardResVo brvo) {
		return reportService.insertReply(brvo);
	}
	
	// ��� ����
	@ResponseBody
	@RequestMapping(value="replyEdit", method=RequestMethod.POST)
	public Map<String, Object> replyEdit(@RequestParam int num, @RequestParam String contents) {
		
		BoardResVo brvo = new BoardResVo();
		brvo.setNum(num);
		brvo.setContents(contents);
		
		return reportService.updateReply(brvo);
	}
	
	// ��� ����
	@ResponseBody
	@RequestMapping(value="replyRemove", method=RequestMethod.POST)
	public Map<String, Object> removeReply(@RequestParam int num) {
		return reportService.deleteReply(num);
	}
	
	// �̹��� ���ε�
	@RequestMapping(value="imgUpload", method=RequestMethod.POST)
	public void imgUpload(HttpServletRequest request, HttpServletResponse response, 
			MultipartHttpServletRequest mRequest, @RequestParam MultipartFile upload) throws Exception {
		
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset-utf-8");
		
		reportService.imgUpload(request, response, mRequest, upload);
	}
	
}
