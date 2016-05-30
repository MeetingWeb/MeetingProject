package meeting.team.dao;

import org.springframework.security.core.userdetails.UserDetails;

import meeting.team.vo.LoginVo;
import meeting.team.vo.UserVo;

public interface UserDao {

	public UserVo login(String id);

}
