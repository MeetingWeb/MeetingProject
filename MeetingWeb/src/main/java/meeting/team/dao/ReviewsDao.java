package meeting.team.dao;

import meeting.team.vo.ReviewsVo;

public interface ReviewsDao {

	int fileOverLapCnt(String fileName);

	int insert(ReviewsVo uploadedFile);

}
