package meeting.team.service;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;

import javax.servlet.http.HttpSession;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.multipart.MultipartFile;

import meeting.team.dao.ReviewsDao;
import meeting.team.vo.FileVo;

public class ReviewsService {
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;

	public boolean fileUpload(FileVo uploadedFile, HttpSession session) {
		ReviewsDao upload_dao = sqlSessionTemplate.getMapper(ReviewsDao.class);
		MultipartFile file = uploadedFile.getFile();
		String fileName = file.getOriginalFilename();

		uploadedFile.setAuthor((String) session.getAttribute("id"));
		uploadedFile.setFile_size(file.getSize());
		uploadedFile.setOri_file_name(fileName);

		String mod_name = fileName;
		int cnt = upload_dao.fileOverLapCnt(fileName);

		if (cnt > 0) {
			mod_name = cnt + fileName;
		}

		uploadedFile.setMod_file_name(mod_name);

		int ok = upload_dao.uploadFile(uploadedFile);
		if (ok > 0) {
			InputStream inputStream = null;
			OutputStream outputStream = null;
			try {
				inputStream = file.getInputStream();
				File newFile = new File("C:/test/upload/" + mod_name);
				if (!newFile.exists()) {
					newFile.createNewFile();
				}
				outputStream = new FileOutputStream(newFile);

				int read = 0;
				byte[] bytes = new byte[1024];
				while ((read = inputStream.read(bytes)) != -1) {
					outputStream.write(bytes, 0, read);
				}
			} catch (IOException e) {
				e.printStackTrace();
			} finally {
				try {
					outputStream.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}

		return ok > 0 ? true : false;
	}
}
