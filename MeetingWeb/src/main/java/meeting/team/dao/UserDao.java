package meeting.team.dao;

import java.util.HashMap;
import java.util.List;

import org.springframework.security.core.userdetails.UserDetails;

import meeting.team.vo.LoginVo;
import meeting.team.vo.UserVo;

public interface UserDao {
	public int join(UserVo uvo);
	public int joinhabby(HashMap<String, Object> map);
	public UserVo login(String id);
	public UserVo id_check(String id);
	public int changeLatlng(UserVo user);
	public String getMyLocation(String id);
	public List<String> getInterest(String id);
	public List<UserVo> getList();
	public int changeToMember(String id);
	public int changeToBlack(String id);
} 
