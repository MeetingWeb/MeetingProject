package meeting.team.dao;

import java.util.List;

import meeting.team.vo.ReviewsVo;

public interface ReviewsDao {

	int fileOverLapCnt(String fileName);

	int insert(ReviewsVo uploadedFile);

	int currNum(String id);

	ReviewsVo selectOne(int num);

	List<ReviewsVo> getList();

	int delete(int num);

}
