package meeting.team.dao;

import java.util.List;

import meeting.team.vo.MeetingVo;

public interface MeetingDao {

	List<MeetingVo> getMeetingList(String id);
	List<MeetingVo> getAllMeeting();
	MeetingVo getMeeting(int num);

}
