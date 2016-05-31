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
	
	// �� ��ȸ(����Ʈ)
	public ModelAndView getReport(BoardVo bvo) {
		reportDao = sqlSessionTemplate.getMapper(ReportDao.class);
		return new ModelAndView("report/reportList", "listReport", reportDao.getReport());
	}
	
	// �� ���
	public Map<String, Object> insertReport(BoardVo bvo) {
		reportDao = sqlSessionTemplate.getMapper(ReportDao.class);
		int result = reportDao.insertReport(bvo);
		Map<String, Object> returnMap = new HashMap<String, Object>();
		
		if(result > 0) {
			returnMap.put("code", 200);
			returnMap.put("msg", "����� �Ϸ��Ͽ����ϴ�.");
			returnMap.put("url", "./list");
		} else {
			returnMap.put("code", 201);
			returnMap.put("msg", "����� �����Ͽ����ϴ�.");
		}
		
		return returnMap;
	}
	
}
