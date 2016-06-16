package meeting.team.dao;

import java.util.Map;

import meeting.team.vo.UserVo;



public interface UserSearchDao {
	
	// ID ã��
	public Map<String, Object> searchID(UserVo userVo);
	
	// PW ã��
	public Map<String, Object> searchPW(UserVo userVo);
	
	// ����� PW ����
	public void updatePassword(UserVo userVo);
	
}
