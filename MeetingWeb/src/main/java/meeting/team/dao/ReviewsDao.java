package meeting.team.dao;

import java.util.List;
import java.util.Map;

import meeting.team.vo.NoticeVO;
import meeting.team.vo.ReviewsVo;

public interface ReviewsDao {

	int fileOverLapCnt(String fileName);

	int insert(ReviewsVo uploadedFile);
	int modify(ReviewsVo uploadedFile);
	
	int currNum(String id);

	ReviewsVo selectOne(int num);

	List<ReviewsVo> getList();

	int delete(int num);
	
	public ReviewsVo latelyRead();
	public int getReplyTotal(int num);
	public List<NoticeVO> getReplyList(Map<String,Integer> map);	
	public List<NoticeVO> getAllReply(int num);
	public int getLatelyNum();
	public int replyModify(NoticeVO board);
}
