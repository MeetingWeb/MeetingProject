package meeting.team.dao;

import java.util.List;
import java.util.Map;

import meeting.team.vo.BoardResVo;
import meeting.team.vo.BoardVo;


public interface ReportDao {
	
	// 글 조회(리스트)
	public List<BoardVo> getReport(Map<String, Object> map);
	
	// 글 등록
	public int insertReport(BoardVo bvo);
	
	// 글 상세조회
	public BoardVo infoReport(int num);
	
	// 글 수정
	public int updateReport(BoardVo bvo);
	
	// 글 삭제
	public int deleteReport(BoardVo bvo);
	
	// 자신의 글을 가져오기 위한 메소드
	public int getNum(String id);
	
	/* ------댓글------- */
	
	// 댓글 등록
	public int insertReply(BoardResVo brvo);
	
	// 댓글 조회(리스트)
	public List<BoardResVo> getReply(int num);
	
	// 댓글 수정
	public int updateReply(BoardResVo brvo);
	
	// 댓글 삭제
	public int deleteReply(int num);
	
	/* ------게시판 페이징------ */
	
	// 전체 글 갯수
	public int getCount(Map<String, Object> map);
	
	// 이전글 정보
	public BoardVo getPrev(int num);
	
	// 다음글 정보
	public BoardVo getNext(int num);
	
}
