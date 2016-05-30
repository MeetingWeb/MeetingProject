package meeting.team.service;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import meeting.team.dao.UserDao;
import meeting.team.vo.UserVo;

@Service("userservice")
public class UserService implements UserDetailsService {
	/*@Autowired
	private SqlSessionTemplate sqlSessionTemplate;*/

	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		/*UserDao user_dao = sqlSessionTemplate.getMapper(UserDao.class);
		UserVo login = user_dao.login(username);
		if (login != null) {
			GrantedAuthority role = new SimpleGrantedAuthority(login.getPower());

			List<GrantedAuthority> roles = new ArrayList<GrantedAuthority>();
			roles.add(role);
			User user = new User(login.getId(), login.getPw(), roles);

			return user;
		}*/
		return null;
	}

}
