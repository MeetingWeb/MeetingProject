package meeting.team.dao;

import java.util.List;

import meeting.team.vo.BoardVo;

public interface ReportDao {
	
	// �� ��ȸ(����Ʈ)
	public List<BoardVo> getReport();
	
	// �� ���
	public int insertReport(BoardVo bvo);
	
}
