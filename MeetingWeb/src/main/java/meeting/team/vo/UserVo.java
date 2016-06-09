package meeting.team.vo;

import org.hibernate.validator.constraints.NotEmpty;
import org.springframework.stereotype.Component;

@Component
public class UserVo {
	@NotEmpty
	private String id;
	@NotEmpty
	private String pw;
	@NotEmpty
	private String pwc;
	private String name;
	private String email;
	private String power;
	private String interests; 
	private String latlng;
	
	@NotEmpty
	private String ids;
	
	@NotEmpty
	private String pws;
	
	@NotEmpty
	private String pwcc;
	
	

	public String getIds() {
		return ids;
	}

	public void setIds(String ids) {
		this.ids = ids;
	}

	public String getPws() {
		return pws;
	}

	public void setPws(String pws) {
		this.pws = pws;
	}

	public String getPwcc() {
		return pwcc;
	}

	public void setPwcc(String pwcc) {
		this.pwcc = pwcc;
	}

	public String getLatlng() {
		return latlng;
	}

	public void setLatlng(String latlng) {
		this.latlng = latlng;
	}

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
