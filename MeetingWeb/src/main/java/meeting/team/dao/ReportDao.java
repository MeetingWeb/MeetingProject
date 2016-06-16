package meeting.team.dao;

import java.util.List;
import java.util.Map;

import meeting.team.vo.BoardResVo;
import meeting.team.vo.BoardVo;


public interface ReportDao {
	
	// �� ��ȸ(����Ʈ)
	public List<BoardVo> getReport(Map<String, Object> map);
	
	// �� ���
	public int insertReport(BoardVo bvo);
	
	// �� ����ȸ
	public BoardVo infoReport(int num);
	
	// �� ����
	public int updateReport(BoardVo bvo);
	
	// �� ����
	public int deleteReport(BoardVo bvo);
	
	// �ڽ��� ���� �������� ���� �޼ҵ�
	public int getNum(String id);
	
	/* ------���------- */
	
	// ��� ���
	public int insertReply(BoardResVo brvo);
	
	// ��� ��ȸ(����Ʈ)
	public List<BoardResVo> getReply(int num);
	
	// ��� ����
	public int updateReply(BoardResVo brvo);
	
	// ��� ����
	public int deleteReply(int num);
	
	/* ------�Խ��� ����¡------ */
	
	// ��ü �� ����
	public int getCount(Map<String, Object> map);
	
	// ������ ����
	public BoardVo getPrev(int num);
	
	// ������ ����
	public BoardVo getNext(int num);
	
}
