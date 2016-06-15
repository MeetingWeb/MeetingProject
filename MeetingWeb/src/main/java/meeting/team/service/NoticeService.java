package meeting.team.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import meeting.team.dao.NoticeDAO;
import meeting.team.vo.NoticeVO;
import meeting.team.vo.PageVO;
import meeting.team.vo.SearchVO;

@Service
public class NoticeService {
	
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	public String write(HttpServletRequest request){
		NoticeDAO ntDAO=sqlSessionTemplate.getMapper(NoticeDAO.class);
		JSONObject jsonObj=new JSONObject();
		NoticeVO board=new NoticeVO();
		board.setId(request.getParameter("id"));
		board.setTitle(request.getParameter("title"));
		board.setContents(request.getParameter("contents"));
		board.setRef(0);
		int res=ntDAO.insert(board);
		if(res==1){
			jsonObj.put("ok", true);
		}else jsonObj.put("ok", false);
		return jsonObj.toJSONString();		
	}
	
	public NoticeVO latelyRead(){		
		NoticeDAO ntDAO=sqlSessionTemplate.getMapper(NoticeDAO.class);
		return ntDAO.latelyRead();		
	}
	
	public NoticeVO read(int num){
		NoticeDAO ntDAO=sqlSessionTemplate.getMapper(NoticeDAO.class);
		NoticeVO board=ntDAO.read(num);
		int hit=board.getHit()+1;
		board.setHit(hit);
		ntDAO.hitUp(board);
		return board;		
	}
	
	public NoticeVO modifyForm(int num){		
		NoticeDAO ntDAO=sqlSessionTemplate.getMapper(NoticeDAO.class);
		return ntDAO.read(num);
	}
	
	public String modify(HttpServletRequest request){
		NoticeDAO ntDAO=sqlSessionTemplate.getMapper(NoticeDAO.class);
		JSONObject jsonObj=new JSONObject();
		NoticeVO board=new NoticeVO();		
		board.setNum(Integer.parseInt(request.getParameter("num")));
		board.setTitle(request.getParameter("title"));
		board.setContents(request.getParameter("contents"));
		int res=ntDAO.modify(board);
		if(res==1){
			jsonObj.put("ok", true);
		}else jsonObj.put("ok", false);
		return jsonObj.toJSONString();			
	}	
	
	public String delete(int num){
		NoticeDAO ntDAO=sqlSessionTemplate.getMapper(NoticeDAO.class);
		JSONObject jsonObj=new JSONObject();
		int res=ntDAO.delete(num);
		if(res==1){
			jsonObj.put("ok", true);
		}else jsonObj.put("ok", false);
		return jsonObj.toJSONString();	
	}
	public Map<String,Object> pagination(int page)
	{
		NoticeDAO ntDAO=sqlSessionTemplate.getMapper(NoticeDAO.class);
		Map<String,Object> map=new HashMap<String, Object>();
		
		PageVO pageVO=new PageVO();				
		pageVO.setCurrPage(page);			
		pageVO.setStartPage(3*((page-1)/3)+1);		
		pageVO.setEndPage(3*((page-1)/3)+1+(3-1));
		pageVO.setTotalPage(getTotalPage(ntDAO.getTotal()));
		
		map.put("list", getList(page));
		map.put("page", pageVO);
		map.put("condition", "normal");
		return map;		
	}
	
	public Map<String,Object> pagination(String key,int page)
	{
		NoticeDAO ntDAO=sqlSessionTemplate.getMapper(NoticeDAO.class);
		Map<String,Object> map=new HashMap<String, Object>();
		SearchVO searchVO=new SearchVO();
		searchVO.setKey(key);
		searchVO.setPage(page);	
		
		PageVO pageVO=new PageVO();		
		pageVO.setCurrPage(page);
		pageVO.setStartPage(3*((page-1)/3)+1);		
		pageVO.setEndPage(3*((page-1)/3)+1+(3-1));
		SearchVO search=new SearchVO();
		search.setKey(key);
		pageVO.setTotalPage(getTotalPage(ntDAO.getSearchTotal(search)));
		
		map.put("list", getSearchList(searchVO));
		map.put("page", pageVO);
		map.put("condition","search");
		map.put("key",key);
		return map;		
	}		
	//댓글목록 페이지내이션
	public Map<String,Object> pagination(int num,int page)
	{		
		NoticeDAO ntDAO=sqlSessionTemplate.getMapper(NoticeDAO.class);
		Map<String,Object> map=new HashMap<String, Object>();
		PageVO pageVO=new PageVO();
		
		pageVO.setCurrPage(page);
		pageVO.setStartPage(3*((page-1)/3)+1);		
		pageVO.setEndPage(3*((page-1)/3)+1+(3-1));
		pageVO.setTotalPage(getTotalPage(ntDAO.getReplyTotal(num)));
		pageVO.setListTotal(ntDAO.getReplyTotal(num));
		
		map.put("list", getReplyList(num,page));
		map.put("page", pageVO);
		map.put("condition","reply");
		return map;		
	}
	
	public List<NoticeVO> getList(int page){
		NoticeDAO ntDAO=sqlSessionTemplate.getMapper(NoticeDAO.class);
		return ntDAO.getList(page);
	}
	
	public List<NoticeVO> getReplyList(int num,int page){
		NoticeDAO ntDAO=sqlSessionTemplate.getMapper(NoticeDAO.class);
		Map<String,Integer> map=new HashMap<String,Integer>();
		map.put("num", num);
		map.put("page",page);
		return ntDAO.getReplyList(map);
	
	}
	
	public List<NoticeVO> getSearchList(SearchVO searchVO){
		NoticeDAO ntDAO=sqlSessionTemplate.getMapper(NoticeDAO.class);	
		return ntDAO.getSearchList(searchVO);		
	}
		
	public int getTotalPage(int total){
		return (total-1)/5+1;				
	}
	
	public String allReply(int num){
		NoticeDAO ntDAO=sqlSessionTemplate.getMapper(NoticeDAO.class);
		
		JSONArray jsonArr=new JSONArray();
		List<NoticeVO>replylist=ntDAO.getAllReply(num);
		for(int i=0; i<replylist.size(); i++)
		{
			JSONObject jsonObj=new JSONObject();
			jsonObj.put("num",replylist.get(i).getNum());
			jsonObj.put("contents",replylist.get(i).getContents());
			jsonObj.put("id", replylist.get(i).getId());
			jsonArr.add(jsonObj);
		}
		return jsonArr.toJSONString();		
	}
	
	public String firstReply(int num){
		NoticeDAO ntDAO=sqlSessionTemplate.getMapper(NoticeDAO.class);		
		
		JSONArray replyArr=new JSONArray();
		JSONObject pageObj=new JSONObject();
		JSONObject resultObj=new JSONObject();			
		Map<String,Integer> map=new HashMap<String,Integer>();
		map.put("num", num);
		map.put("page",1);
		List<NoticeVO>replylist=ntDAO.getReplyList(map);
		for(int i=0; i<replylist.size(); i++)
		{
			JSONObject jsonObj=new JSONObject();
			jsonObj.put("num",replylist.get(i).getNum());
			jsonObj.put("contents",replylist.get(i).getContents());
			jsonObj.put("id", replylist.get(i).getId());
			replyArr.add(jsonObj);
		}
		pageObj.put("currPage", 1);
		pageObj.put("totalPage",ntDAO.getReplyTotal(num));
		resultObj.put("list", replyArr);
		resultObj.put("page",pageObj);
		return resultObj.toJSONString();	
		
	}	

	
	
	public String nextReply(int num,int page){
		NoticeDAO ntDAO=sqlSessionTemplate.getMapper(NoticeDAO.class);
		
		JSONArray replyArr=new JSONArray();
		JSONObject pageObj=new JSONObject();
		JSONObject resultObj=new JSONObject();		
		Map<String,Integer> map=new HashMap<String,Integer>();
		map.put("num", num);
		map.put("page",page+1);
		List<NoticeVO>list=ntDAO.getReplyList(map);
		for(int i=0; i<list.size(); i++)
		{
			JSONObject jsonObj=new JSONObject();
			jsonObj.put("num",list.get(i).getNum());
			jsonObj.put("contents",list.get(i).getContents());
			jsonObj.put("id", list.get(i).getId());
			replyArr.add(jsonObj);
		}
		pageObj.put("currPage", page+1);
		pageObj.put("totalPage", getTotalPage(ntDAO.getReplyTotal(num)));
		resultObj.put("list", replyArr);
		resultObj.put("page",pageObj);
		return resultObj.toJSONString();		
		
	}
	
	public String prevReply(int num,int page){
		NoticeDAO ntDAO=sqlSessionTemplate.getMapper(NoticeDAO.class);
		
		JSONArray replyArr=new JSONArray();
		JSONObject pageObj=new JSONObject();
		JSONObject resultObj=new JSONObject();		
		Map<String,Integer> map=new HashMap<String,Integer>();
		map.put("num", num);
		map.put("page",page-1);
		List<NoticeVO>list=ntDAO.getReplyList(map);
		for(int i=0; i<list.size(); i++)
		{
			JSONObject jsonObj=new JSONObject();
			jsonObj.put("num",list.get(i).getNum());
			jsonObj.put("contents",list.get(i).getContents());
			jsonObj.put("id", list.get(i).getId());		
			replyArr.add(jsonObj);
		}
		pageObj.put("currPage", page-1);
		pageObj.put("totalPage", getTotalPage(ntDAO.getReplyTotal(num)));
		resultObj.put("list", replyArr);
		resultObj.put("page",pageObj);
		return resultObj.toJSONString();		
		
	}
	
	public String nowReplyList(int num,int page){
		NoticeDAO ntDAO=sqlSessionTemplate.getMapper(NoticeDAO.class);
		
		JSONArray replyArr=new JSONArray();
		JSONObject pageObj=new JSONObject();
		JSONObject resultObj=new JSONObject();
		Map<String,Integer> map=new HashMap<String,Integer>();	
		map.put("num", num);
		map.put("page",page);
		List<NoticeVO>list=ntDAO.getReplyList(map);
		for(int i=0; i<list.size(); i++)
		{
			JSONObject jsonObj=new JSONObject();
			jsonObj.put("num",list.get(i).getNum());
			jsonObj.put("contents",list.get(i).getContents());
			jsonObj.put("id", list.get(i).getId());		
			replyArr.add(jsonObj);
		}
		pageObj.put("currPage", page);
		pageObj.put("totalPage", getTotalPage(ntDAO.getReplyTotal(num)));
		resultObj.put("list", replyArr);
		resultObj.put("page",pageObj);
		return resultObj.toJSONString();		
		
	}
	
	public String replyWrite(HttpServletRequest request){
		NoticeDAO ntDAO=sqlSessionTemplate.getMapper(NoticeDAO.class);
		NoticeVO board=new NoticeVO();
		board.setContents(request.getParameter("contents"));
		board.setTitle("-");
		board.setId(request.getParameter("id"));
		board.setRef(Integer.parseInt(request.getParameter("ref")));
		int res=ntDAO.insert(board);
		String newReplyList="";
		if(res==1){
			newReplyList=firstReply(Integer.parseInt(request.getParameter("ref")));			
		}
		return newReplyList;		
	}
	
	
	public String replyDel(HttpServletRequest request){
		int ref=Integer.parseInt(request.getParameter("ref"));
		int num=Integer.parseInt(request.getParameter("num"));
		int page=Integer.parseInt(request.getParameter("page"));
		NoticeDAO ntDAO=sqlSessionTemplate.getMapper(NoticeDAO.class);
		int res=ntDAO.delete(num);
		String newReplyList="";
		if(res==1){
			newReplyList=nowReplyList(ref, page);			
		}
		return newReplyList;		
	}
	
	public String replyModify(HttpServletRequest request){
		int num=Integer.parseInt(request.getParameter("num"));
		int ref=Integer.parseInt(request.getParameter("ref"));
		int page=Integer.parseInt(request.getParameter("page"));
		String contents=request.getParameter("contents");
		NoticeDAO ntDAO=sqlSessionTemplate.getMapper(NoticeDAO.class);
		NoticeVO board=new NoticeVO();
		board.setContents(contents);
		board.setNum(num);
		int res=ntDAO.replyModify(board);				
		String newReplyList="";
		if(res==1){
			newReplyList=nowReplyList(ref, page);		
		}
		return newReplyList;		
	}
	
	public int getLatelyNum(){
		NoticeDAO ntDAO=sqlSessionTemplate.getMapper(NoticeDAO.class);
		return ntDAO.getLatelyNum();
	}

}
