package meeting.team.service;

import java.util.HashMap;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import meeting.team.dao.ReportDao;
import meeting.team.vo.BoardVo;

@Service
public class ReportService {
	
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	ReportDao reportDao;
	
	// 글 조회(리스트)
	public ModelAndView getReport(BoardVo bvo) {
		reportDao = sqlSessionTemplate.getMapper(ReportDao.class);
		return new ModelAndView("report/reportList", "listReport", reportDao.getReport());
	}
	
	// 글 등록
	public Map<String, Object> insertReport(BoardVo bvo) {
		reportDao = sqlSessionTemplate.getMapper(ReportDao.class);
		int result = reportDao.insertReport(bvo);
		Map<String, Object> returnMap = new HashMap<String, Object>();
		
		if(result > 0) {
			returnMap.put("code", 200);
			returnMap.put("msg", "등록을 완료하였습니다.");
			returnMap.put("url", "./list");
		} else {
			returnMap.put("code", 201);
			returnMap.put("msg", "등록을 실패하였습니다.");
		}
		
		return returnMap;
	}
	
}
