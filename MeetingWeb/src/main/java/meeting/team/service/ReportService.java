package meeting.team.service;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service("reportService")
public class ReportService {
	
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;

}
