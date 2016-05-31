package meeting.team.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMessage.RecipientType;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import meeting.team.dao.UserDao;
import meeting.team.vo.EmailVo;
import meeting.team.vo.UserVo;

@Service("userservice")
public class UserService implements UserDetailsService {
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	@Autowired
	private BCryptPasswordEncoder encoder;

	@Autowired
	protected JavaMailSender mailSender;
	

	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		UserDao user_dao = sqlSessionTemplate.getMapper(UserDao.class);
		UserVo login = user_dao.login(username);
		if (login != null) {
			GrantedAuthority role = new SimpleGrantedAuthority(login.getPower());

			List<GrantedAuthority> roles = new ArrayList<GrantedAuthority>();
			roles.add(role);
			User user = new User(login.getId(), login.getPw(), roles);

			return user;
		}
		return null;
	}
	
	public String join(UserVo user){
		String id = user.getId();
		UserDao user_dao = sqlSessionTemplate.getMapper(UserDao.class);
		String encodedPw = encoder.encode(user.getPw());
		user.setPw(encodedPw);
		int n = user_dao.join(user);
		boolean tf = n > 0 ? true:false;
	
		String[] arr = user.getInterests().split(",");
		
		if(tf==true)
		{
			for(int i=0;i<arr.length;i++)
			{
				HashMap<String, Object> map = new HashMap<String, Object>();
				map.put("a", id);
				map.put("b",arr[i]);
				user_dao.joinhabby(map);
				
			}
		}
		
		JSONObject json = new JSONObject();
		json.put("ok", tf);
		
		return json.toJSONString();
	}
	
	public String id_check(String id) {
		UserDao user_dao = sqlSessionTemplate.getMapper(UserDao.class);
		UserVo ids = user_dao.id_check(id);
		JSONObject json = new JSONObject();
		//System.out.println(ids.getId());
		if(ids==null)
		{
			json.put("msg", id);
			json.put("ok", true);
		}
		else
		{
			json.put("msg", ids.getId());
			json.put("ok", false);
		}
		
		
		return json.toJSONString();
	}
	
/*
	public String email_check(String email,HttpSession session) throws Exception {
		EmailVo emails = new EmailVo();
        session.setAttribute("email", email);
        emails.setReceiver(email);
        emails.setSubject("이메일 확인입니다.");
        emails.setContent("<a href='http://121.190.3.95:7777/MettingWeb/email_join?sess="+session.getId()+"' target='uf'>인증 완료</a>");
        boolean result = false;
		
        try{
	        MimeMessage msg = mailSender.createMimeMessage();
	 	msg.setFrom("aorder1234@gmail.com"); // 송신자를 설정해도 소용없지만 없으면 오류가 발생한다
	        msg.setSubject(emails.getSubject());
	        msg.setText(emails.getContent());
	        msg.setRecipient(RecipientType.TO , new InternetAddress(emails.getReceiver()));
	         
	        mailSender.send(msg);
	        result = true;
	        
	        JSONObject json = new JSONObject();
	        json.put("ok", result);
	        
	        return json.toJSONString();
        }catch(Exception ex) {
        	ex.printStackTrace();
        }
		return null;
        
        
        
    }
*/
	public boolean email_check(EmailVo email) throws Exception {
        try{
	        MimeMessage msg = mailSender.createMimeMessage();
	 	msg.setFrom("aorder1234@gmail.com"); // 송신자를 설정해도 소용없지만 없으면 오류가 발생한다
	        msg.setSubject(email.getSubject());
	        msg.setText(email.getContent());
	        msg.setRecipient(RecipientType.TO , new InternetAddress(email.getReceiver()));
	         
	        mailSender.send(msg);
	        return true;
        }catch(Exception ex) {
        	ex.printStackTrace();
        }
        return false;
    }



}
