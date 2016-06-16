package meeting.team.dao;

import java.util.Map;

import meeting.team.vo.UserVo;



public interface UserSearchDao {
	
	// ID 찾기
	public Map<String, Object> searchID(UserVo userVo);
	
	// PW 찾기
	public Map<String, Object> searchPW(UserVo userVo);
	
	// 변경된 PW 저장
	public void updatePassword(UserVo userVo);
	
}
