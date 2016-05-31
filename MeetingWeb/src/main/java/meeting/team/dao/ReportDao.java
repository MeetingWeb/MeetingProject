package meeting.team.dao;

import java.util.List;

import meeting.team.vo.BoardVo;

public interface ReportDao {
	
	// 글 조회(리스트)
	public List<BoardVo> getReport();
	
	// 글 등록
	public int insertReport(BoardVo bvo);
	
}
