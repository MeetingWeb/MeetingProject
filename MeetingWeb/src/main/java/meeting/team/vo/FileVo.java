package meeting.team.vo;

import java.sql.Date;

import org.springframework.web.multipart.MultipartFile;

public class FileVo {
	private String author;
	private Date cre_date;
	private String ori_file_name;
	private String mod_file_name;
	private double file_size;
	private MultipartFile file;
	private boolean ok;

	public String getAuthor() {
		return author;
	}

	public void setAuthor(String author) {
		this.author = author;
	}

	public Date getCre_date() {
		return cre_date;
	}

	public void setCre_date(Date cre_date) {
		this.cre_date = cre_date;
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

	public double getFile_size() {
		return file_size;
	}

	public void setFile_size(double file_size) {
		this.file_size = file_size;
	}

	public MultipartFile getFile() {
		return file;
	}

	public void setFile(MultipartFile file) {
		this.file = file;
	}

	public boolean isOk() {
		return ok;
	}

	public void setOk(boolean ok) {
		this.ok = ok;
	}

}
