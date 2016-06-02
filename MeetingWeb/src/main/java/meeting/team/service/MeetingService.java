package meeting.team.service;

import java.net.InetAddress;
import java.net.UnknownHostException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fasterxml.jackson.databind.jsonFormatVisitors.JsonAnyFormatVisitor;

import meeting.team.dao.MeetingDao;
import meeting.team.vo.MeetingVo;

@Service("meetingservice")
public class MeetingService {
	@Autowired
	private SqlSessionTemplate sql_temp;
	private MeetingDao meeting_dao;

	public List<MeetingVo> getMeetingList(HttpServletRequest request) {
		meeting_dao = sql_temp.getMapper(MeetingDao.class);
		HttpSession session = request.getSession();
		String id = (String) request.getParameter("id");
		session.setAttribute("id", id);
		return meeting_dao.getMeetingList(id);
	}

	public String[] getPosition() throws UnknownHostException {
		String localHostIpAddress = InetAddress.getLocalHost().getHostAddress();
		return null;
	}
	
	public String getAllMeeting(){
		meeting_dao=sql_temp.getMapper(MeetingDao.class);
		List<MeetingVo> list=meeting_dao.getAllMeeting();
		JSONArray jsonArr=new JSONArray();
		for(int i=0; i<list.size(); i++)
		{
			JSONObject jsonObj=new JSONObject();
			jsonObj.put("loc",list.get(i).getArea());
			//가져와야 하는것 추가
			//---------------------
			
			//---------------------
			jsonArr.add(jsonObj);
		}
		return jsonArr.toJSONString();	
	}

}
