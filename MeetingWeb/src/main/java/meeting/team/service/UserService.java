package meeting.team.service;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.URL;
import java.net.URLConnection;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.JSONValue;
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

import meeting.team.controller.MeetingController;
import meeting.team.dao.MeetingDao;
import meeting.team.dao.UserDao;
import meeting.team.validator.JoinValidator;
import meeting.team.vo.EmailVo;
import meeting.team.vo.MeetingVo;
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
	
	double latitude;
	double longitude;
	String regionAddress;

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
				
				if(fe.getField().equals("email")){
					String eamilErr = messageSource.getMessage("required5.user.email", null, Locale.getDefault());
					json.put("emailErr", eamilErr);
				}
				
				if(fe.getField().equals("emailfalse")){
					String eamilErr = messageSource.getMessage("required6.user.email", null, Locale.getDefault());
					json.put("emailErr", eamilErr);
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
	
		
		if(user.getInterest()==null) user.setInterest("null");
		String[] arr = user.getInterest().split(",");
		
		if(tf==true)
		{
			HashMap<String,Object> maps = new HashMap<String, Object>();
			maps.put("id", id);
			maps.put("location", user.getLocation());
			user_dao.joinlocation(maps);
			
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
		try {
			mailSender.send(new MimeMessagePreparator() {
				public void prepare(MimeMessage mimeMessage) throws MessagingException {
					MimeMessageHelper message = new MimeMessageHelper(mimeMessage, true, "UTF-8");
					message.setFrom("red5423@naver.com");
					message.setTo(email.getReceiver());
					message.setSubject(email.getSubject());
					message.setText(email.getContent(), true);

				}
			});

			return true;
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return false;
	}

	public boolean changeLatlng(HttpServletRequest request) {
		UserDao user_dao = sqlSessionTemplate.getMapper(UserDao.class);
		String latlng = request.getParameter("latlng");
		String id = (String) request.getSession().getAttribute("id");
		UserVo user = new UserVo();
		user.setId(id);
		user.setLatlng(latlng);
		int res = user_dao.changeLatlng(user);
		if (res == 1)
			return true;
		else
			return false;
	}

	public String getMyLocation(HttpServletRequest request) {
		UserDao user_dao = sqlSessionTemplate.getMapper(UserDao.class);
		String id = (String) request.getSession().getAttribute("id");
		String myLOC = user_dao.getMyLocation(id);
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("latlng", myLOC);
		return jsonObj.toJSONString();
	}

	public List<String> getInterest(HttpServletRequest request) {
		UserDao user_dao = sqlSessionTemplate.getMapper(UserDao.class);
		String id = (String) request.getSession().getAttribute("id");
		List<String> interest = user_dao.getInterest(id);
		return interest;

	}

	public List<UserVo> getList() {
		UserDao user_dao = sqlSessionTemplate.getMapper(UserDao.class);
		return user_dao.getList();
	}

	public void setChatList(String userId) {
		Map<String, ArrayList<String>> map = MeetingController.chatMap;
		MeetingDao meeting_dao = sqlSessionTemplate.getMapper(MeetingDao.class);
		// meeting_dao.getAllChatList();
	}

	public String powerUpdate(HttpServletRequest request) {
		String[] resultmember = request.getParameterValues("resultmember");
		String[] resultblack = request.getParameterValues("resultblack");
		UserDao user_dao = sqlSessionTemplate.getMapper(UserDao.class);
		int res = 0;
		int membersize = 0;
		int blacksize = 0;
		if (resultmember != null) {
			membersize = resultmember.length;
			for (int i = 0; i < resultmember.length; i++) {
				res += user_dao.changeToMember(resultmember[i]);

			}
		}

		if (resultblack != null) {
			blacksize = resultblack.length;
			for (int i = 0; i < resultblack.length; i++) {
				res += user_dao.changeToBlack(resultblack[i]);
			}
		}

		JSONObject jsonObj = new JSONObject();
		if (res == (membersize + blacksize)) {
			jsonObj.put("ok", true);
		} else
			jsonObj.put("ok", false);
		return jsonObj.toJSONString();
	}
	
	
	
	public String personal_info(String id) {
	      UserDao user_dao = sqlSessionTemplate.getMapper(UserDao.class);
	      UserVo personal_info = user_dao.personal_info(id);
	      List<UserVo> personal_info2 = user_dao.personal_info2(id);
	      System.out.println(id);
	      //String[] interest = new String[personal_info.size()];
	      JSONArray interest = new JSONArray();
	      for(int i=0; i<personal_info2.size();i++)
	      {
	         interest.add(personal_info2.get(i).getInterest());
	         //interest[i] = personal_info.get(i).getInterest();
	         //System.out.println("interest"+personal_info.get(i).getInterests());
	      }
	   
	      JSONObject jsonObj=new JSONObject();   
	      jsonObj.put("email", personal_info.getEmail());
	      jsonObj.put("id", personal_info.getId());
	      jsonObj.put("name", personal_info.getName());
	      jsonObj.put("interests", interest);
	      return jsonObj.toJSONString();
	   }

	public String pwchange(String id, String pw) {
		UserDao user_dao = sqlSessionTemplate.getMapper(UserDao.class);
		HashMap<String, Object> map = new HashMap<String, Object>();
		String encodedPw = encoder.encode(pw);
		map.put("id", id);
		map.put("pw", encodedPw);
		
		int n = user_dao.pwchange(map);
		boolean tf = n > 0 ? true:false;
		
		JSONObject jsonObj=new JSONObject();	
		jsonObj.put("ok", tf);
		
		return jsonObj.toJSONString();
	}

	public String interests(String id, String interests) {
		UserDao user_dao = sqlSessionTemplate.getMapper(UserDao.class);
		int ns = user_dao.delete(id);
		boolean tf = ns > 0 ? true:false;

		
		if(interests==null) interests="null";
		String[] arr = interests.split(",");

		if(tf==true)
		{
			HashMap<String, Object> map = new HashMap<String, Object>();
			for(int i=0;i<arr.length;i++)
			{
			
			map.put("id", id);
			map.put("interest", arr[i]);
			user_dao.interestschange(map);
			
			}
		}
		
		

		
		JSONObject jsonObj=new JSONObject();	
		jsonObj.put("ok", true);
		
		return jsonObj.toJSONString();
		
	
	}

	public List<MeetingVo> create_join(String id) throws Exception {
		UserDao user_dao = sqlSessionTemplate.getMapper(UserDao.class);
		List<MeetingVo> list = user_dao.create_join(id);
		for (int i = 0; i < list.size(); i++) {
			MeetingVo meeting = list.get(i);
			String[] addr = meeting.getArea().split(",");
			this.latitude = Double.parseDouble(addr[0]);
			this.longitude = Double.parseDouble(addr[1]);
			this.regionAddress = getRegionAddress(getJSONData(getApiAddress()));
			meeting.setArea(this.regionAddress);
		}
		return list;
		
	}
	
	private String getApiAddress() {
		String apiURL = "http://maps.googleapis.com/maps/api/geocode/json?latlng=" + latitude + "," + longitude
				+ "&language=ko";
		return apiURL;
	}
	
	private String getJSONData(String apiURL) throws Exception {
		String jsonString = new String();
		String buf;
		URL url = new URL(apiURL);
		URLConnection conn = url.openConnection();
		BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));
		while ((buf = br.readLine()) != null) {
			jsonString += buf;
		}
		return jsonString;
	}
	
	private String getRegionAddress(String jsonString) {
		JSONObject jObj = (JSONObject) JSONValue.parse(jsonString);
		JSONArray jArray = (JSONArray) jObj.get("results");
		jObj = (JSONObject) jArray.get(0);
		return (String) jObj.get("formatted_address");
	}

}
