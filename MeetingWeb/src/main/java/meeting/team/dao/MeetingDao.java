package meeting.team.dao;

import java.util.List;
import java.util.Map;

import meeting.team.vo.MeetingVo;

public interface MeetingDao {

	List<MeetingVo> getMeetingList(String id);
	List<MeetingVo> getAllMeeting();
	MeetingVo getMeeting(int num);
	List<MeetingVo> getRecommend(String interest);
	int insert(MeetingVo meeting);
	int chatInsert(Map<String, String> chatMap);
	int userExit(String user);

}
