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

import meeting.team.controller.MeetingController;
import meeting.team.dao.MeetingDao;
import meeting.team.vo.MeetingPageVo;
import meeting.team.vo.MeetingVo;
import meeting.team.vo.ReplyVo;

@Service("meetingservice")
public class MeetingService {
	@Autowired
	private SqlSessionTemplate sql_temp;
	private MeetingDao meeting_dao;
	private HashMap<String, Object> pageMap = new HashMap<String, Object>();
	private final int SHOWROW = 10;
	private final int SHOWNAVIPAGE = 5;

	double latitude;
	double longitude;
	String regionAddress;

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
		//meeting.setDivision("now");

		Map<String, String> chatMap = new HashMap<String, String>();
		int chatOk = 0;
		if (meeting.getDivision().equals("now")) {
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
		if (userInOk > 0) {
			json.put("ok", true);
		} else {
			int ok = meeting_dao.chatInsert(chatMap);
			if (ok > 0) {
				json.put("ok", true);
			}
		}
		return json.toJSONString();
	}

	@SuppressWarnings("unchecked")
	public String getMeetings(String[] key) {
		meeting_dao = sql_temp.getMapper(MeetingDao.class);
		JSONArray jsonArr = new JSONArray();
		for (int i = 0; i < key.length; i++) {
			List<MeetingVo> meetings = meeting_dao.getRecommend(key[i]);
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

	public HashMap<String, Object> selectOne(int ref, HttpSession session) {
		meeting_dao = sql_temp.getMapper(MeetingDao.class);
		if (ref == 0) {
			ref = meeting_dao.maxNum((String) session.getAttribute("id"));
		}
		HashMap<String, Object> map = new HashMap<String, Object>();
		int[] navi = getNaviNum(1);
		int maxPage = meeting_dao.getRowCount(ref);
		pageMap.put("page", 1);
		pageMap.put("ref", ref);
		pageMap.put("showRow", SHOWROW);
		map.put("data", meeting_dao.selectOne(ref));
		map.put("reply", meeting_dao.getReplyList(pageMap));
		map.put("endPage", navi[0]);
		map.put("startPage", navi[1]);
		map.put("maxPage", maxPage);
		return map;
	}

	@SuppressWarnings("unchecked")
	public String addReply(ReplyVo reply) {
		meeting_dao = sql_temp.getMapper(MeetingDao.class);
		int ok = meeting_dao.addReply(reply);

		JSONArray arr = new JSONArray();
		if (ok > 0) {
			pageMap.put("page", 1);
			pageMap.put("ref", reply.getRef());
			pageMap.put("showRow", SHOWROW);
			List<ReplyVo> list = meeting_dao.getReplyList(pageMap);
			int maxPage = meeting_dao.getRowCount(reply.getRef());
			for (int i = 0; i < list.size(); i++) {
				JSONObject json = new JSONObject();
				ReplyVo data = list.get(i);
				json.put("id", data.getId());
				json.put("num", data.getNum());
				json.put("contents", data.getContents());
				json.put("ref", data.getRef());
				arr.add(json);
			}
			int[] navi = getNaviNum(1);
			arr.add(navi[0]);
			arr.add(navi[1]);
			arr.add(maxPage);
		}
		return arr.toJSONString();
	}

	@SuppressWarnings("unchecked")
	public String replyNavi(int page, int ref) {
		JSONArray arr = new JSONArray();
		pageMap.put("page", page);
		pageMap.put("ref", ref);
		pageMap.put("showRow", SHOWROW);
		List<ReplyVo> list = meeting_dao.getReplyList(pageMap);
		int maxPage = meeting_dao.getRowCount(ref);
		for (int i = 0; i < list.size(); i++) {
			JSONObject json = new JSONObject();
			ReplyVo data = list.get(i);
			json.put("id", data.getId());
			json.put("num", data.getNum());
			json.put("contents", data.getContents());
			json.put("ref", data.getRef());
			arr.add(json);
		}
		int[] navi = getNaviNum(page);
		arr.add(navi[0]);
		arr.add(navi[1]);
		arr.add(maxPage);
		return arr.toJSONString();
	}

	@SuppressWarnings("unchecked")
	public String replyDelete(int ref, int num, int page) {
		JSONArray arr = new JSONArray();
		pageMap.put("page", page);
		pageMap.put("ref", ref);
		pageMap.put("num", num);
		pageMap.put("showRow", SHOWROW);
		
		if(meeting_dao.replyDelete(pageMap) > 0) {
			List<ReplyVo> list = meeting_dao.getReplyList(pageMap);
			int maxPage = meeting_dao.getRowCount(ref);
			for (int i = 0; i < list.size(); i++) {
				JSONObject json = new JSONObject();
				ReplyVo data = list.get(i);
				json.put("id", data.getId());
				json.put("num", data.getNum());
				json.put("contents", data.getContents());
				json.put("ref", data.getRef());
				arr.add(json);
			}
			int[] navi = getNaviNum(page);
			arr.add(navi[0]);
			arr.add(navi[1]);
			arr.add(maxPage);
		}
		return arr.toJSONString();
	}
	
	@SuppressWarnings("unchecked")
	public String replyModify(int ref, int num, int page, String contents) {
		JSONArray arr = new JSONArray();
		pageMap.put("page", page);
		pageMap.put("ref", ref);
		pageMap.put("num", num);
		pageMap.put("showRow", SHOWROW);
		pageMap.put("contents", contents);
		
		if(meeting_dao.replyModify(pageMap) > 0) {
			List<ReplyVo> list = meeting_dao.getReplyList(pageMap);
			int maxPage = meeting_dao.getRowCount(ref);
			for (int i = 0; i < list.size(); i++) {
				JSONObject json = new JSONObject();
				ReplyVo data = list.get(i);
				json.put("id", data.getId());
				json.put("num", data.getNum());
				json.put("contents", data.getContents());
				json.put("ref", data.getRef());
				arr.add(json);
			}
			int[] navi = getNaviNum(page);
			arr.add(navi[0]);
			arr.add(navi[1]);
			arr.add(maxPage);
		}
		return arr.toJSONString();
	}

	private int[] getNaviNum(int currPage) {
		int[] navi = new int[2];
		int endPage = (int) (Math.floor((currPage - 1) / SHOWNAVIPAGE) * SHOWNAVIPAGE + SHOWNAVIPAGE);
		int startPage = (int) (Math.floor((currPage - 1) / SHOWNAVIPAGE) * SHOWNAVIPAGE + 1);
		navi[0] = endPage;
		navi[1] = startPage;
		return navi;
	}

	public ArrayList<String> getChatList(HttpSession session) {
		meeting_dao = sql_temp.getMapper(MeetingDao.class);
		ArrayList<String> list = meeting_dao.getChatList((String) session.getAttribute("id"));
		return list;
	}

	public HashMap<String, Object> getNotNowMeetingList(MeetingPageVo page) throws Exception {
		meeting_dao = sql_temp.getMapper(MeetingDao.class);
		ArrayList<MeetingVo> list = meeting_dao.getNotNowMeetingList(page);
		for (int i = 0; i < list.size(); i++) {
			MeetingVo meeting = list.get(i);
			String[] addr = meeting.getArea().split(",");
			this.latitude = Double.parseDouble(addr[0]);
			this.longitude = Double.parseDouble(addr[1]);
			this.regionAddress = getRegionAddress(getJSONData(getApiAddress()));
			meeting.setArea(this.regionAddress);
		}
		int[] navi = getNaviNum(page.getCurrPage());
		int maxPage = meeting_dao.getMeetingRowCount();
		page.setMaxPage(maxPage);
		page.setEndPage(navi[0]);
		page.setStartPage(navi[1]);
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("list", list);
		map.put("page", page);
		return map;
	}

	private String getApiAddress() {
		String apiURL = "http://maps.googleapis.com/maps/api/geocode/json?latlng=" + latitude + "," + longitude
				+ "&language=ko";
		return apiURL;
	}

	private String getJSONData(String apiURL) throws Exception {
		String jsonString = new String();
		String buf;
		URL url = new URL(apiURL);
		URLConnection conn = url.openConnection();
		BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));
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
	
	public List<MeetingVo> getMeetingList(HttpServletRequest request) {
		meeting_dao = sql_temp.getMapper(MeetingDao.class);
		HttpSession session = request.getSession();
		String id = (String) request.getParameter("id");
		session.setAttribute("id", id);
		return meeting_dao.getMeetingList(id);
	}


	public MeetingVo modifyForm(int num) throws Exception {
		meeting_dao = sql_temp.getMapper(MeetingDao.class);
		MeetingVo meeting = meeting_dao.selectOne(num);
		String area = meeting.getArea();
		String[] addr = area.split(",");
		this.latitude = Double.parseDouble(addr[0]);
		this.longitude = Double.parseDouble(addr[1]);
		this.regionAddress = getRegionAddress(getJSONData(getApiAddress()));
		meeting.setArea(this.regionAddress + "/" + area);
		
		return meeting;
	}

	public String getMyLocation(HttpSession session) {
		meeting_dao = sql_temp.getMapper(MeetingDao.class);
		return meeting_dao.getMyLocation((String) session.getAttribute("id"));
	}

	@SuppressWarnings("unchecked")
	public String modify(MeetingVo meeting, HttpServletRequest request) {
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
		//meeting.setDivision("now");

		Map<String, String> chatMap = new HashMap<String, String>();
		chatMap.put("master", master);
		chatMap.put("member", master);
		int chatOk = 0;
		if (meeting.getDivision().equals("now")) {
			chatOk = meeting_dao.chatInsert(chatMap);
			meeting_dao.updateUser(master);
		} else {
			chatOk = meeting_dao.chatDelete(master);
		}
		
		int ok = meeting_dao.updateMeeting(meeting);
		
		if (ok > 0) {
			json.put("ok", true);
		} else {
			json.put("ok", false);
		}
		return json.toJSONString();
	}
}
