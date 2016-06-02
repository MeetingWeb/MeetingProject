package meeting.team.dao;

import java.util.List;
import java.util.Map;

import meeting.team.vo.NoticeVO;
import meeting.team.vo.SearchVO;



public interface NoticeDAO {
	public int insert(NoticeVO board);
	public NoticeVO latelyRead();
	public NoticeVO read(int num);
	public int modify(NoticeVO board);
	public int delete(int num);
	public List<NoticeVO> getList(int num);
	public List<NoticeVO> getSearchList(SearchVO search);
	public int hitUp(NoticeVO board);
	public int getTotal();
	public int getSearchTotal(SearchVO search);
	public int getReplyTotal(int num);
	public List<NoticeVO> getReplyList(Map<String,Integer> map);	
	public List<NoticeVO> getAllReply(int num);
	public int replyModify(NoticeVO board);
	public int getLatelyNum();
	
}
