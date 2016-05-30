package meeting.team.vo;

import org.springframework.stereotype.Component;

@Component
public class UserVo {
	private String id;
	private String pw;
	private String pwc;
	private String name;
	private String email;
	private String power;
	private String interests; 
	
	

	public String getInterests() {
		return interests;
	}

	public void setInterests(String interests) {
		this.interests = interests;
	}

	public String getPwc() {
		return pwc;
	}

	public void setPwc(String pwc) {
		this.pwc = pwc;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getPw() {
		return pw;
	}

	public void setPw(String pw) {
		this.pw = pw;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPower() {
		return power;
	}

	public void setPower(String power) {
		this.power = power;
	}

}
