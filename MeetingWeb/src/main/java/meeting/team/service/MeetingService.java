package meeting.team.service;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.net.URL;
import java.text.ParseException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.codec.binary.Base64;
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

	@SuppressWarnings("unchecked")
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
			jsonObj.put("contents",list.get(i).getContents());
			jsonObj.put("endTime",list.get(i).getEnd_time().toString());
			jsonObj.put("master",list.get(i).getMaster());
			jsonObj.put("field",list.get(i).getField());
			jsonObj.put("startTime",list.get(i).getStart_time().toString());			
			jsonObj.put("title",list.get(i).getTitle());	
			//---------------------
			jsonArr.add(jsonObj);
		}
		return jsonArr.toJSONString();
	}

	@SuppressWarnings("unchecked")
	public String getMeeting(int num) {
		meeting_dao = sql_temp.getMapper(MeetingDao.class);
		MeetingVo meeting = meeting_dao.getMeeting(num);
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("loc", meeting.getArea());
		jsonObj.put("num", meeting.getNum());
		jsonObj.put("contents", meeting.getContents());
		jsonObj.put("endTime", meeting.getEnd_time().toString());
		jsonObj.put("master", meeting.getMaster());
		jsonObj.put("type", meeting.getField());
		jsonObj.put("startTime", meeting.getStart_time().toString());
		jsonObj.put("title", meeting.getTitle());

		return jsonObj.toJSONString();

	}

	@SuppressWarnings("unchecked")
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
		meeting.setMap_name(roughMapSave(request));
		int ok = meeting_dao.insert(meeting);

		if (ok > 0) {
			json.put("ok", true);
		} else {
			json.put("ok", false);
		}
		return json.toJSONString();
	}
	
	@SuppressWarnings("unchecked")
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

	@SuppressWarnings("unchecked")
	public String mapSaveLocal(HttpServletRequest request) {
		JSONObject json = new JSONObject();
		String pdfPath = request.getSession().getServletContext().getRealPath("/resources/images/");
		String fileName = (String) request.getSession().getAttribute("id") + "RoughMap.png";
		String path = request.getParameter("path");
		try {
			URL url = new URL(path);
			BufferedImage img = ImageIO.read(url);
			File file = new File(pdfPath + fileName);
			ImageIO.write(img, "png", file);
			json.put("ok", true);
			json.put("filePath", "/resources/images/" + fileName);
		} catch (IOException e) {
			json.put("ok", false);
			e.printStackTrace();
		}
		return json.toJSONString();
	}

	public String roughMapSave(HttpServletRequest request) {
		String pdfPath = request.getSession().getServletContext().getRealPath("/resources/images/");
		String fileName = (String) request.getSession().getAttribute("id") + "RoughMap.png";
		String data = request.getParameter("imgData").replaceAll("data:image/png;base64,", "");
		byte[] imgBytes = Base64.decodeBase64(data.getBytes());
		FileOutputStream fos = null;
		try {
			fos = new FileOutputStream(new File(pdfPath + fileName));
			fos.write(imgBytes);
			fos.close();
			
			return fileName;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	public String chatInsert(HttpServletRequest request) {
		String user = request.getParameter("user");
		String master = request.getParameter("master");
		Map<String, String> chatMap = new HashMap<String, String>();
		chatMap.put("user", user);
		chatMap.put("master", master);
		
		JSONObject json = new JSONObject();
		int userInOk = meeting_dao.userExit(user);
		int ok = meeting_dao.chatInsert(chatMap);
		if(ok > 0) {
			json.put("ok", true);
		}
		return json.toJSONString();
	}

}
