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

	// ID ã��
	public Map<String, Object> searchID(UserVo userVo) throws Exception {
		usDao = sqlSessionTemplate.getMapper(UserSearchDao.class);
		Map<String, Object> resultMap = usDao.searchID(userVo);
		Map<String, Object> returnMap = new HashMap<String, Object>();
		
		resultMap.put("email", userVo.getEmail());
		resultMap.put("name", userVo.getName());
		
		// ����ڰ� �Է��� ����
		String email = (String) resultMap.get("email");
		String name = (String) resultMap.get("name");
		
		// DB���� �޾ƿ� ����
		String id = (String) resultMap.get("ID");

		final EmailVo emailVo = new EmailVo();

		emailVo.setReceiver(email);
		emailVo.setContent("<h1>���̵� �߼�!!</h1> <br><h3>" + name + "��</h3> �ݰ����ϴ�. ã���ô� ID�� <h3>" + id + "</h3> �Դϴ�.");
		
		if (resultMap != null && resultMap.size() > 0) {
			
			returnMap.put("code", 200);
			returnMap.put("msg", "ID�� ���Ϸ� �߼۵Ǿ����ϴ�.");

			mailSender.send(new MimeMessagePreparator() {
				public void prepare(MimeMessage mimeMessage) throws MessagingException {
					MimeMessageHelper message = new MimeMessageHelper(mimeMessage, true, "UTF-8");
					message.setFrom("red5423@naver.com");
					message.setTo(emailVo.getReceiver());
					message.setSubject("NowMeetingWeb���� ID �߼�");
					message.setText(emailVo.getContent(), true);
				}
			});

		} else {
			returnMap.put("code", 201);
			returnMap.put("msg", "ID ã�� ����!");
		}

		return returnMap;
	}
	
	// PW ã��
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
			returnMap.put("msg", "�н����尡 ���Ϸ� �߼۵Ǿ����ϴ�.");
			
			// �ӽ� �н����� ����(��+��+��+��+��+��=6�ڸ�)
	    	String newPassword = "";
	    	for (int i = 1; i <= 6; i++) {
	    		// ����
	    		if (i % 3 != 0) {
	    			newPassword += StringUtil.getRandomStr('a', 'z');
	    		// ����
	    		} else {
	    			newPassword += NumberUtil.getRandomNum(0, 9);
	    		}
	    	}
	    	
	    	// �ӽ� ��й�ȣ�� ��ȣȭ�Ͽ� DB�� �����Ѵ�.
	    	String encodedPwd = passwordEncoder.encode(newPassword);
	    	userVo.setPw(encodedPwd);
	    	usDao.updatePassword(userVo);
	    	
	    	final EmailVo emailVo = new EmailVo();
			emailVo.setReceiver(email);
			emailVo.setContent("<h1>�ӽ� �н����� �߼�!!</h1> <br><h3>" + id + "��</h3>�� "
					+ "�ӽ� �н������ <h3>" + newPassword + "</h3> �Դϴ�.");
			
			mailSender.send(new MimeMessagePreparator() {
				public void prepare(MimeMessage mimeMessage) throws MessagingException {
					MimeMessageHelper message = new MimeMessageHelper(mimeMessage, true, "UTF-8");
					message.setFrom("red5423@naver.com");
					message.setTo(emailVo.getReceiver());
					message.setSubject("NowMeetingWeb���� �н����� �߼�");
					message.setText(emailVo.getContent(), true);
				}
			});
			
		} else {
			returnMap.put("code", 201);
			returnMap.put("msg", "�н����� ã�� ����!");
		}
		
		return returnMap;
	}

}
