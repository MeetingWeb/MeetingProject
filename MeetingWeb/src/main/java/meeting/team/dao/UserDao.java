package meeting.team.dao;

import org.springframework.security.core.userdetails.UserDetails;

import meeting.team.vo.LoginVo;
import meeting.team.vo.UserVo;

public interface UserDao {
	public int join(UserVo uvo);
	public int joinhabby(String interests, String id);
	public UserVo login(String id);

}
