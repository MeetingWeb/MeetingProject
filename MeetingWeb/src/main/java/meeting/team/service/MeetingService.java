package meeting.team.service;

import java.net.InetAddress;
import java.net.UnknownHostException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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

	public String getAllMeeting() {
		meeting_dao = sql_temp.getMapper(MeetingDao.class);
		List<MeetingVo> list = meeting_dao.getAllMeeting();
		JSONArray jsonArr = new JSONArray();
		for (int i = 0; i < list.size(); i++) {
			JSONObject jsonObj = new JSONObject();
			jsonObj.put("loc", list.get(i).getArea());
			// 가져와야 하는것 추가
			// ---------------------
			jsonObj.put("num", list.get(i).getNum());
<<<<<<< Upstream, based on origin/GO
			jsonObj.put("contents", list.get(i).getContents());
			jsonObj.put("endTime", list.get(i).getEnd_time().toString());
			jsonObj.put("master", list.get(i).getMaster());
			jsonObj.put("type", list.get(i).getMeetingType());
			jsonObj.put("startTime", list.get(i).getStart_time().toString());
			jsonObj.put("title", list.get(i).getTitle());
			// ---------------------
=======
			jsonObj.put("contents",list.get(i).getContents());
			jsonObj.put("endTime",list.get(i).getEnd_time().toString());
			jsonObj.put("master",list.get(i).getMaster());
			jsonObj.put("field",list.get(i).getField());
			jsonObj.put("startTime",list.get(i).getStart_time().toString());			
			jsonObj.put("title",list.get(i).getTitle());	
			//---------------------
>>>>>>> c608f52 gudRJ
			jsonArr.add(jsonObj);
		}
		return jsonArr.toJSONString();
	}
<<<<<<< Upstream, based on origin/GO

	public String getMeeting(int num) {
		meeting_dao = sql_temp.getMapper(MeetingDao.class);
		MeetingVo meeting = meeting_dao.getMeeting(num);
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("loc", meeting.getArea());
		jsonObj.put("num", meeting.getNum());
		jsonObj.put("contents", meeting.getContents());
		jsonObj.put("endTime", meeting.getEnd_time().toString());
		jsonObj.put("master", meeting.getMaster());
		jsonObj.put("type", meeting.getMeetingType());
		jsonObj.put("startTime", meeting.getStart_time().toString());
		jsonObj.put("title", meeting.getTitle());
=======
	
	public String getMeeting(int num){
		meeting_dao=sql_temp.getMapper(MeetingDao.class);
		MeetingVo meeting=meeting_dao.getMeeting(num);
		JSONObject jsonObj=new JSONObject();
		jsonObj.put("loc",meeting.getArea());
		jsonObj.put("num",meeting.getNum());
		jsonObj.put("contents",meeting.getContents());
		jsonObj.put("endTime",meeting.getEnd_time().toString());
		jsonObj.put("master",meeting.getMaster());
		jsonObj.put("field",meeting.getField());
		jsonObj.put("startTime",meeting.getStart_time().toString());			
		jsonObj.put("title",meeting.getTitle());
>>>>>>> c608f52 gudRJ
		return jsonObj.toJSONString();

	}

	public String insert(MeetingVo meeting, HttpServletRequest request) throws ParseException {
		meeting_dao = sql_temp.getMapper(MeetingDao.class);
		JSONObject json = new JSONObject();

		String id = (String) request.getSession().getAttribute("id");
		String sTime = request.getParameter("s_time");
		String eTime = request.getParameter("e_time");
		String meetingDay = request.getParameter("meetingDay");
		String sDate = meetingDay + " " + sTime + ":00";
		String eDate = meetingDay + " " + eTime + ":00";
		
		java.sql.Timestamp s_stamp = java.sql.Timestamp.valueOf(sDate);
		java.sql.Timestamp e_stamp = java.sql.Timestamp.valueOf(eDate);
		meeting.setStart_time(s_stamp);
		meeting.setEnd_time(e_stamp);
		meeting.setMaster(id);
		meeting.setDivision("now");
		int ok = meeting_dao.insert(meeting);

		if (ok > 0) {
			json.put("ok", true);
		} else {
			json.put("ok", false);
		}
		return json.toJSONString();
	}
	
	public String getRecommend(List<String> interests){
		meeting_dao=sql_temp.getMapper(MeetingDao.class);
		JSONArray jsonArr=new JSONArray();		
		for(int i=0 ; i<interests.size(); i++)
		{
			List<MeetingVo> meetings=meeting_dao.getRecommend(interests.get(i));
			for(int j=0; j<meetings.size(); j++)
			{
				JSONObject jsonObj=new JSONObject();
				jsonObj.put("loc",meetings.get(j).getArea());
				jsonObj.put("num",meetings.get(j).getNum());
				jsonObj.put("contents",meetings.get(j).getContents());
				jsonObj.put("endTime",meetings.get(j).getEnd_time().toString());
				jsonObj.put("master",meetings.get(j).getMaster());			
				jsonObj.put("startTime",meetings.get(j).getStart_time().toString());			
				jsonObj.put("title",meetings.get(j).getTitle());
				jsonObj.put("field",meetings.get(j).getField());
				jsonArr.add(jsonObj);	
			}
		
		}
		return jsonArr.toJSONString();		
	}

}
