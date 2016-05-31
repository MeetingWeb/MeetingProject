package meeting.team.dao;

import java.util.List;

import meeting.team.vo.BoardVo;

public interface ReportDao {
	
	// 글 리스트
	
	// 글 등록
	public int insertReport(BoardVo bvo);
	
}
