package meeting.team.dao;

import meeting.team.vo.FileVo;

public interface ReviewsDao {

	int fileOverLapCnt(String fileName);

	int uploadFile(FileVo uploadedFile);

}
