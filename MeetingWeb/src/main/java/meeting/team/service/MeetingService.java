package meeting.team.service;

import java.awt.image.BufferedImage;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.URL;
import java.net.URLConnection;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.codec.binary.Base64;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.JSONValue;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.google.code.geocoder.Geocoder;

import meeting.team.controller.MeetingController;
import meeting.team.dao.MeetingDao;
import meeting.team.vo.MeetingVo;

@Service("meetingservice")
public class MeetingService {
	@Autowired
	private SqlSessionTemplate sql_temp;
	private MeetingDao meeting_dao;
	
	double latitude;
	double longitude;
	String regionAddress;

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
			jsonObj.put("contents", list.get(i).getContents());
			jsonObj.put("endTime", list.get(i).getEnd_time().toString());
			jsonObj.put("master", list.get(i).getMaster());
			jsonObj.put("field", list.get(i).getField());
			jsonObj.put("startTime", list.get(i).getStart_time().toString());
			jsonObj.put("title", list.get(i).getTitle());
			// ---------------------
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

		String master = (String) request.getSession().getAttribute("id");
		String sTime = request.getParameter("s_time");
		String eTime = request.getParameter("e_time");
		String meetingDay = request.getParameter("meetingDay");
		sTime = sTime.replaceAll("-", "0");
		eTime = eTime.replaceAll("-", "0");
		String sDate = meetingDay + " " + sTime + ":00";
		String eDate = meetingDay + " " + eTime + ":00";

		java.sql.Timestamp s_stamp = java.sql.Timestamp.valueOf(sDate);
		java.sql.Timestamp e_stamp = java.sql.Timestamp.valueOf(eDate);
		
		meeting.setStart_time(s_stamp);
		meeting.setEnd_time(e_stamp);
		meeting.setMaster(master);
		meeting.setMap_name(roughMapSave(request));
		meeting.setDivision("now");
		
		Map<String, String> chatMap = new HashMap<String, String>();
		int chatOk = 0;
		if(meeting.getDivision().equals("now")) {
			// MeetingController.chatMap.put(meeting.getMaster(), null);
			chatMap.put("master", master);
			chatMap.put("member", master);
			chatOk = meeting_dao.chatInsert(chatMap);
			meeting_dao.updateUser(master);
		}

		int ok = meeting_dao.insert(meeting);
		if (ok > 0) {
			json.put("ok", true);
		} else {
			json.put("ok", false);
		}
		return json.toJSONString();
	}

	@SuppressWarnings("unchecked")
	public String getRecommend(List<String> interests) {
		meeting_dao = sql_temp.getMapper(MeetingDao.class);
		JSONArray jsonArr = new JSONArray();
		for (int i = 0; i < interests.size(); i++) {
			List<MeetingVo> meetings = meeting_dao.getRecommend(interests.get(i));
			for (int j = 0; j < meetings.size(); j++) {
				JSONObject jsonObj = new JSONObject();
				jsonObj.put("loc", meetings.get(j).getArea());
				jsonObj.put("num", meetings.get(j).getNum());
				jsonObj.put("contents", meetings.get(j).getContents());
				jsonObj.put("endTime", meetings.get(j).getEnd_time().toString());
				jsonObj.put("master", meetings.get(j).getMaster());
				jsonObj.put("startTime", meetings.get(j).getStart_time().toString());
				jsonObj.put("title", meetings.get(j).getTitle());
				jsonObj.put("field", meetings.get(j).getField());
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
		String member = request.getParameter("member");
		String master = request.getParameter("master");
		ArrayList<String> list = MeetingController.chatMap.get(master);
		Map<String, String> chatMap = new HashMap<String, String>();
		
		chatMap.put("member", member);
		chatMap.put("master", master);
		
		JSONObject json = new JSONObject();
		int userInOk = meeting_dao.userExit(chatMap);
		if(userInOk > 0) {
			json.put("ok", true);
		} else {
			int ok = meeting_dao.chatInsert(chatMap);
			if (ok > 0) {
				json.put("ok", true);
			}
		}
		return json.toJSONString();
	}

	public String getMeetings(String[] key){
		meeting_dao = sql_temp.getMapper(MeetingDao.class);
		JSONArray jsonArr=new JSONArray();
		for(int i=0; i<key.length; i++)
		{
			List<MeetingVo> meetings=meeting_dao.getRecommend(key[i]);
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

	public MeetingVo selectOne(int num, HttpSession session) {
		meeting_dao = sql_temp.getMapper(MeetingDao.class);
		if (num == 0) {
			num = meeting_dao.maxNum((String) session.getAttribute("id"));
		}
		return meeting_dao.selectOne(num);
	}

	public ArrayList<String> getChatList(HttpSession session) {
		meeting_dao = sql_temp.getMapper(MeetingDao.class);
		ArrayList<String> list = meeting_dao.getChatList((String) session.getAttribute("id"));
		return list;
	}

	public ArrayList<MeetingVo> getNotNowMeetingList() throws Exception {
		meeting_dao = sql_temp.getMapper(MeetingDao.class);
		ArrayList<MeetingVo>list = meeting_dao.getNotNowMeetingList();
		for(int i = 0; i < list.size(); i++) {
			MeetingVo meeting = list.get(i);
			String[] addr = meeting.getArea().split(",");
			this.latitude = Double.parseDouble(addr[0]);
			this.longitude = Double.parseDouble(addr[1]);
			this.regionAddress = getRegionAddress(getJSONData(getApiAddress()));
			meeting.setArea(this.regionAddress);
		}
		return list;
	}
	
	private String getApiAddress() {
		String apiURL = "http://maps.googleapis.com/maps/api/geocode/json?latlng="
				+ latitude + "," + longitude + "&language=ko";
		return apiURL;
	}

	private String getJSONData(String apiURL) throws Exception {
		String jsonString = new String();
		String buf;
		URL url = new URL(apiURL);
		URLConnection conn = url.openConnection();
		BufferedReader br = new BufferedReader(new InputStreamReader(
				conn.getInputStream(), "UTF-8"));
		while ((buf = br.readLine()) != null) {
			jsonString += buf;
		}
		return jsonString;
	}

	private String getRegionAddress(String jsonString) {
		JSONObject jObj = (JSONObject) JSONValue.parse(jsonString);
		JSONArray jArray = (JSONArray) jObj.get("results");
		jObj = (JSONObject) jArray.get(0);
		return (String) jObj.get("formatted_address");
	}

	public String getAddress() {
		return regionAddress;
	}

}
