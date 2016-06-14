package meeting.team.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import meeting.team.vo.MeetingVo;
import meeting.team.vo.ReplyVo;

public interface MeetingDao {

	List<MeetingVo> getMeetingList(String id);
	List<MeetingVo> getAllMeeting();
	MeetingVo getMeeting(int num);
	List<MeetingVo> getRecommend(String interest);
	int insert(MeetingVo meeting);
	int chatInsert(Map<String, String> chatMap);
	int userExit(Map<String, String> chatMap);
	int maxNum(String id);
	MeetingVo selectOne(int num);
	ArrayList<String> getChatList(String id);
	ArrayList<String> getChatGroup(String master);
	int updateUser(String master);
	ArrayList<MeetingVo> getNotNowMeetingList();
	int addReply(ReplyVo reply);
	List<ReplyVo> getReplyList(HashMap<String, Integer> pageMap);
	int getRowCount(int ref);
	int replyDelete(HashMap<String, Integer> pageMap);
}
