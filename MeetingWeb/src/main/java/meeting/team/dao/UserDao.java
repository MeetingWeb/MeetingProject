package meeting.team.dao;

import java.util.HashMap;

import org.springframework.security.core.userdetails.UserDetails;

import meeting.team.vo.LoginVo;
import meeting.team.vo.UserVo;

public interface UserDao {
	public int join(UserVo uvo);
	public int joinhabby(HashMap<String, Object> map);
	public UserVo login(String id);
	public UserVo id_check(String id);

}
