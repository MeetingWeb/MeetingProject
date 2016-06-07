package meeting.team.service;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;

import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import meeting.team.dao.ReviewsDao;
import meeting.team.vo.ReviewsVo;

@Service
public class ReviewsService {
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;

	public String fileUpload(ReviewsVo uploadedFile, HttpSession session) {
		ReviewsDao reviews_dao = sqlSessionTemplate.getMapper(ReviewsDao.class);
		MultipartFile file = uploadedFile.getFile();
		String fileName = file.getOriginalFilename();

		uploadedFile.setId((String) session.getAttribute("id"));
		uploadedFile.setOri_file_name(fileName);

		String mod_name = fileName;
		int cnt = reviews_dao.fileOverLapCnt(fileName);

		if (cnt > 0) {
			mod_name = cnt + fileName;
		}

		uploadedFile.setMod_file_name(mod_name);

		int ok = reviews_dao.insert(uploadedFile);
		JSONObject json = new JSONObject();
		if (ok > 0) {
			InputStream inputStream = null;
			OutputStream outputStream = null;
			try {
				inputStream = file.getInputStream();
				File newFile = new File("C:/meeting/upload/" + mod_name);
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
			json.put("ok", true);
		} else {
			json.put("ok", false);
		}

		return json.toJSONString();
	}
}
