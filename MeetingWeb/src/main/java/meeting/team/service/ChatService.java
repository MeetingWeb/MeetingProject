package meeting.team.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import meeting.team.dao.MeetingDao;
@Service
public class ChatService {
	@Autowired
	private SqlSessionTemplate sql_temp;
	private MeetingDao meeting_dao;
	
	public ArrayList<String> getChatMember(String master) {
		meeting_dao = sql_temp.getMapper(MeetingDao.class);
		return meeting_dao.getChatGroup(master);
	}
}
