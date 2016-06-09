package meeting.team.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;

import org.json.simple.JSONObject;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.mail.javamail.MimeMessagePreparator;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;

import meeting.team.dao.UserDao;
import meeting.team.validator.JoinValidator;
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
	
	@Autowired
	private MessageSource messageSource;
	

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
	
	public String check(UserVo user, BindingResult result, HttpServletRequest request){
		new JoinValidator().validate(user, result);
		
		JSONObject json = null;
		if(result.hasErrors()){
			json = new JSONObject();
			
			List<FieldError> list = result.getFieldErrors();
			for(int i=0;i<list.size();i++) {
				
				FieldError fe = list.get(i);
				System.out.println("오류필드:"+fe.getField());
				
				if(fe.getField().equals("id")){
					String idErr = messageSource.getMessage("required.user.id", null, Locale.getDefault());
					json.put("idErr", idErr);

				}
				
				if(fe.getField().equals("ids")){
					String idErr = messageSource.getMessage("required2.user.ids", null, Locale.getDefault());
					json.put("idErr", idErr);
				}
				
				if(fe.getField().equals("pw")){
					String idErr = messageSource.getMessage("required.user.pw", null, Locale.getDefault());
					json.put("pwdErr", idErr);
				}
				
				if(fe.getField().equals("pws")){
					String idErr = messageSource.getMessage("required2.user.pws", null, Locale.getDefault());
					json.put("pwdErr", idErr);
				}
				
				if(fe.getField().equals("pwc")){
					String idErr = messageSource.getMessage("required3.user.pwc", null, Locale.getDefault());
					json.put("pwdErr2", idErr);
				}
				
				if(fe.getField().equals("pwcc")){
					String idErr = messageSource.getMessage("required4.user.pwcc", null, Locale.getDefault());
					json.put("pwdErr2", idErr);
				}
				
				

			}
			return json.toJSONString();
		}
		
		
		json = new JSONObject();
		json.put("idErr", user.getId());
		return json.toJSONString(); 
	}
	
public String join(UserVo user, HttpServletRequest request){
		
		
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
	
	public String id_check(String id,HttpServletRequest request) {
	UserDao user_dao = sqlSessionTemplate.getMapper(UserDao.class);
	UserVo ids = user_dao.id_check(id);
	JSONObject json = new JSONObject();
	//System.out.println(ids.getId());
	if(ids==null)
	{
		json.put("msg", id);
		request.setAttribute("id_check", id);
		json.put("ok", true);
	}
	else
	{
		json.put("msg", ids.getId());
		json.put("ok", false);
	}
	
	
	return json.toJSONString();
}
	

	public boolean email_check(final EmailVo email) throws Exception {
        try{
	        mailSender.send(new MimeMessagePreparator() {            
	            public void prepare(MimeMessage mimeMessage) throws MessagingException {
	               MimeMessageHelper message=new MimeMessageHelper(mimeMessage,true,"UTF-8");
	               message.setFrom("red5423@naver.com");
	               message.setTo(email.getReceiver());
	               message.setSubject(email.getSubject());
	               message.setText(email.getContent(),true);
	            
	            }
	         });
	        
	        return true;
        }catch(Exception ex) {
        	ex.printStackTrace();
        }
        return false;
    }
	
	public boolean changeLatlng(HttpServletRequest request){
		System.out.println("들어옴");
		UserDao user_dao = sqlSessionTemplate.getMapper(UserDao.class);
		String latlng=request.getParameter("latlng");
		String id=(String)request.getSession().getAttribute("id");
		System.out.println(latlng);
		System.out.println(id);
		UserVo user=new UserVo();
		user.setId(id);
		user.setLatlng(latlng);
		int res=user_dao.changeLatlng(user);
		if(res==1)return true;
		else return false;		
	}
	
	public String getMyLocation(HttpServletRequest request){
		UserDao user_dao = sqlSessionTemplate.getMapper(UserDao.class);
		System.out.println(request.getSession().getAttribute("id"));
		String id=(String)request.getSession().getAttribute("id");
		String myLOC=user_dao.getMyLocation(id);
		System.out.println(myLOC);
		JSONObject jsonObj=new JSONObject();	
		jsonObj.put("latlng", myLOC);
		return jsonObj.toJSONString();
	}
	
	public List<String> getInterest(HttpServletRequest request)
	{
		UserDao user_dao = sqlSessionTemplate.getMapper(UserDao.class);
		String id=(String)request.getSession().getAttribute("id");
		List<String> interest=user_dao.getInterest(id);
		return interest;
		
	}
	


}
