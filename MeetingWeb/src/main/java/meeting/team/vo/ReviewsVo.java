package meeting.team.vo;

import java.sql.Date;

import org.springframework.web.multipart.MultipartFile;

public class ReviewsVo {
	private int num;
	private String id;
	private String title;
	private Date cre_date;
	private String contents;
	private int ref;
	private String ori_file_name;
	private String mod_file_name;
	private MultipartFile file;

	public int getNum() {
		return num;
	}

	public void setNum(int num) {
		this.num = num;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public Date getCre_date() {
		return cre_date;
	}

	public void setCre_date(Date cre_date) {
		this.cre_date = cre_date;
	}

	public String getContents() {
		return contents;
	}

	public void setContents(String contents) {
		this.contents = contents;
	}

	public int getRef() {
		return ref;
	}

	public void setRef(int ref) {
		this.ref = ref;
	}

	public String getOri_file_name() {
		return ori_file_name;
	}

	public void setOri_file_name(String ori_file_name) {
		this.ori_file_name = ori_file_name;
	}

	public String getMod_file_name() {
		return mod_file_name;
	}

	public void setMod_file_name(String mod_file_name) {
		this.mod_file_name = mod_file_name;
	}

	public MultipartFile getFile() {
		return file;
	}

	public void setFile(MultipartFile file) {
		this.file = file;
	}

}
