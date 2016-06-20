package meeting.team.service;

import java.util.HashMap;
import java.util.Map;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.mail.javamail.MimeMessagePreparator;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import meeting.team.dao.UserSearchDao;
import meeting.team.interceptor.NumberUtil;
import meeting.team.interceptor.StringUtil;
import meeting.team.vo.EmailVo;
import meeting.team.vo.UserVo;

@Service
public class UserSearchService {

	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;

	@Autowired
	protected JavaMailSender mailSender;
	
	@Autowired
	BCryptPasswordEncoder passwordEncoder;

	UserSearchDao usDao;

	// ID 찾기
	public Map<String, Object> searchID(UserVo userVo) throws Exception {
		usDao = sqlSessionTemplate.getMapper(UserSearchDao.class);
		Map<String, Object> resultMap = usDao.searchID(userVo);
		Map<String, Object> returnMap = new HashMap<String, Object>();
		
		resultMap.put("email", userVo.getEmail());
		resultMap.put("name", userVo.getName());
		
		// 사용자가 입력한 정보
		String email = (String) resultMap.get("email");
		String name = (String) resultMap.get("name");
		
		// DB에서 받아온 정보
		String id = (String) resultMap.get("ID");

		final EmailVo emailVo = new EmailVo();

		emailVo.setReceiver(email);
		emailVo.setContent("<h1>아이디 발송!!</h1> <br><h3>" + name + "님</h3> 반갑습니다. 찾으시는 ID는 <h3>" + id + "</h3> 입니다.");
		
		if (resultMap != null && resultMap.size() > 0) {
			
			returnMap.put("code", 200);
			returnMap.put("msg", "ID가 메일로 발송되었습니다.");

			mailSender.send(new MimeMessagePreparator() {
				public void prepare(MimeMessage mimeMessage) throws MessagingException {
					MimeMessageHelper message = new MimeMessageHelper(mimeMessage, true, "UTF-8");
					message.setFrom("red5423@naver.com");
					message.setTo(emailVo.getReceiver());
					message.setSubject("NowMeetingWeb에서 ID 발송");
					message.setText(emailVo.getContent(), true);
				}
			});

		} else {
			returnMap.put("code", 201);
			returnMap.put("msg", "ID 찾기 실패!");
		}

		return returnMap;
	}
	
	// PW 찾기
	public Map<String, Object> searchPW(UserVo userVo) throws Exception {
		usDao = sqlSessionTemplate.getMapper(UserSearchDao.class);
		Map<String, Object> resultMap = usDao.searchPW(userVo);
		Map<String, Object> returnMap = new HashMap<String, Object>();
		
		resultMap.put("id", userVo.getId());
		resultMap.put("email", userVo.getEmail());
		
		String id = (String) resultMap.get("id");
		String email = (String) resultMap.get("email");
		
		if (resultMap != null && resultMap.size() > 0) {
			returnMap.put("code", 200);
			returnMap.put("msg", "패스워드가 메일로 발송되었습니다.");
			
			// 임시 패스워드 생성(영+영+숫+영+영+숫=6자리)
	    	String newPassword = "";
	    	for (int i = 1; i <= 6; i++) {
	    		// 영자
	    		if (i % 3 != 0) {
	    			newPassword += StringUtil.getRandomStr('a', 'z');
	    		// 숫자
	    		} else {
	    			newPassword += NumberUtil.getRandomNum(0, 9);
	    		}
	    	}
	    	
	    	// 임시 비밀번호를 암호화하여 DB에 저장한다.
	    	String encodedPwd = passwordEncoder.encode(newPassword);
	    	userVo.setPw(encodedPwd);
	    	usDao.updatePassword(userVo);
	    	
	    	final EmailVo emailVo = new EmailVo();
			emailVo.setReceiver(email);
			emailVo.setContent("<h1>임시 패스워드 발송!!</h1> <br><h3>" + id + "님</h3>의 "
					+ "임시 패스워드는 <h3>" + newPassword + "</h3> 입니다.");
			
			mailSender.send(new MimeMessagePreparator() {
				public void prepare(MimeMessage mimeMessage) throws MessagingException {
					MimeMessageHelper message = new MimeMessageHelper(mimeMessage, true, "UTF-8");
					message.setFrom("red5423@naver.com");
					message.setTo(emailVo.getReceiver());
					message.setSubject("NowMeetingWeb에서 패스워드 발송");
					message.setText(emailVo.getContent(), true);
				}
			});
			
		} else {
			returnMap.put("code", 201);
			returnMap.put("msg", "패스워드 찾기 실패!");
		}
		
		return returnMap;
	}

}
