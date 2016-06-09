package meeting.team.dao;

import java.util.List;
import java.util.Map;

import meeting.team.vo.InquiryVo;

public interface InquiryDao {
	public int iwrite(InquiryVo ivo);
	public InquiryVo iread(int num);
	public InquiryVo lread();
	public int idelete(int num);
	public int iupdate(InquiryVo ivo);
	public List<InquiryVo> ilist(int page);
	public Integer pageTotals();
	
	public List<InquiryVo> serchlist(InquiryVo ivo);
	public int serchlisttotal(InquiryVo ivo);
	
	public List<InquiryVo> repleilist(Map<String,Integer> map);
	public Integer replepageTotals(int num);
	
	public int repleiupdate(InquiryVo ivo);

}
