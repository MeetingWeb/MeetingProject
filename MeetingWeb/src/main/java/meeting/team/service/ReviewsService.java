package meeting.team.service;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import meeting.team.dao.NoticeDAO;
import meeting.team.dao.ReviewsDao;
import meeting.team.vo.NoticeVO;
import meeting.team.vo.PageVO;
import meeting.team.vo.ReviewsVo;

@Service
public class ReviewsService {
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;

	public String fileUpload(ReviewsVo uploadedFile, HttpServletRequest request) {
		ReviewsDao reviews_dao = sqlSessionTemplate.getMapper(ReviewsDao.class);
		MultipartFile file = uploadedFile.getFile();
		String fileName = file.getOriginalFilename();

		uploadedFile.setId((String) request.getSession().getAttribute("id"));
		uploadedFile.setOri_file_name(fileName);

		String mod_name = fileName;
		int cnt = reviews_dao.fileOverLapCnt(fileName);

		if (cnt > 0) {
			mod_name = cnt + fileName;
		}

		uploadedFile.setMod_file_name(mod_name);
		String pdfPath = request.getSession().getServletContext().getRealPath("/resources/images/");
		int ok = reviews_dao.insert(uploadedFile);
		JSONObject json = new JSONObject();
		if (ok > 0) {
			InputStream inputStream = null;
			OutputStream outputStream = null;
			try {
				inputStream = file.getInputStream();
				File newFile = new File(pdfPath + mod_name);
				if (!newFile.exists()) {
					newFile.createNewFile();
				}
				outputStream = new FileOutputStream(newFile);

				int read = 0;
				byte[] bytes = new byte[1024];
				while ((read = inputStream.read(bytes)) != -1) {
					outputStream.write(bytes, 0, read);
				}
			} catch (IOException e) {
				e.printStackTrace();
			} finally {
				try {
					outputStream.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
			json.put("ok", true);
		} else {
			json.put("ok", false);
		}

		return json.toJSONString();
	}
	
	public String modify(ReviewsVo uploadedFile, HttpServletRequest request) {
		ReviewsDao reviews_dao = sqlSessionTemplate.getMapper(ReviewsDao.class);
		MultipartFile file = uploadedFile.getFile();		
		if(file.getSize()!=0){			
			String fileName = file.getOriginalFilename();
			uploadedFile.setId((String) request.getSession().getAttribute("id"));
			uploadedFile.setOri_file_name(fileName);
			
			String mod_name = fileName;
			int cnt = reviews_dao.fileOverLapCnt(fileName);

			if (cnt > 0) {
				mod_name = cnt + fileName;
			}

			uploadedFile.setMod_file_name(mod_name);
			String pdfPath = request.getSession().getServletContext().getRealPath("/resources/images/");
			
			InputStream inputStream = null;
			OutputStream outputStream = null;
			try {
				inputStream = file.getInputStream();
				File newFile = new File(pdfPath + mod_name);
				if (!newFile.exists()) {
					newFile.createNewFile();
				}
				outputStream = new FileOutputStream(newFile);

				int read = 0;
				byte[] bytes = new byte[1024];
				while ((read = inputStream.read(bytes)) != -1) {
					outputStream.write(bytes, 0, read);
				}
			} catch (IOException e) {
				e.printStackTrace();
			} finally {
				try {
					outputStream.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}			
		}

		int ok = reviews_dao.modify(uploadedFile);
		JSONObject json = new JSONObject();			
		if(ok>0){
			json.put("ok", true);
		}else {
			json.put("ok", false);
		}
		return json.toJSONString();
	}

	public ReviewsVo selectOne(int num, HttpSession session) {
		ReviewsDao reviews_dao = sqlSessionTemplate.getMapper(ReviewsDao.class);
		if(num == 0) {
			num = reviews_dao.currNum((String) session.getAttribute("id"));
		}
		ReviewsVo reviews = reviews_dao.selectOne(num);
		return reviews;
	}

	public List<ReviewsVo> getList() {
		ReviewsDao reviews_dao = sqlSessionTemplate.getMapper(ReviewsDao.class);
		return reviews_dao.getList();
	}

	public String delete(int num) {
		ReviewsDao reviews_dao = sqlSessionTemplate.getMapper(ReviewsDao.class);
		int ok = reviews_dao.delete(num);
		JSONObject json = new JSONObject();
		if(ok > 0)
			json.put("ok", true);
		else 
			json.put("ok", false);
		return json.toJSONString();
	}
	
	public Map<String,Object> pagination(int num,int page)
	{
		ReviewsDao reviews_dao = sqlSessionTemplate.getMapper(ReviewsDao.class);
		Map<String,Object> map=new HashMap<String,Object>();
		PageVO pageVO=new PageVO();
		pageVO.setCurrPage(page);
		pageVO.setStartPage(3*((page-1)/3)+1);		
		pageVO.setEndPage(3*((page-1)/3)+1+(3-1));
		pageVO.setTotalPage(getTotalPage(reviews_dao.getReplyTotal(num)));
		pageVO.setListTotal(reviews_dao.getReplyTotal(num));
		
		map.put("list", getReplyList(num,page));
		map.put("page", pageVO);
		map.put("condition","reply");
		return map;	
		
	}
	
	public List<NoticeVO> getReplyList(int num,int page){
		ReviewsDao reviews_dao = sqlSessionTemplate.getMapper(ReviewsDao.class);
		Map<String,Integer> map=new HashMap<String,Integer>();
		map.put("num", num);
		map.put("page",page);
		return reviews_dao.getReplyList(map);
	
	}
	public int getTotalPage(int total){
		return (total-1)/5+1;				
	}
	
	public int getLatelyNum(){
		ReviewsDao reviews_dao = sqlSessionTemplate.getMapper(ReviewsDao.class);
		return reviews_dao.getLatelyNum();
	}
	
	public String replyWrite(HttpServletRequest request){
		ReviewsDao reviews_dao = sqlSessionTemplate.getMapper(ReviewsDao.class);
		ReviewsVo board=new ReviewsVo();
		board.setContents(request.getParameter("contents"));
		board.setTitle("-");
		board.setId(request.getParameter("id"));
		board.setRef(Integer.parseInt(request.getParameter("ref")));
		board.setOri_file_name("");
		board.setMod_file_name("");
		int res=reviews_dao.insert(board);
		String newReplyList="";
		if(res==1){
			newReplyList=firstReply(Integer.parseInt(request.getParameter("ref")));			
		}
		return newReplyList;		
	}
	
	public String firstReply(int num){
		ReviewsDao reviews_dao = sqlSessionTemplate.getMapper(ReviewsDao.class);
		
		JSONArray replyArr=new JSONArray();
		JSONObject pageObj=new JSONObject();
		JSONObject resultObj=new JSONObject();			
		Map<String,Integer> map=new HashMap<String,Integer>();
		map.put("num", num);
		map.put("page",1);
		List<NoticeVO>replylist=reviews_dao.getReplyList(map);
		for(int i=0; i<replylist.size(); i++)
		{
			JSONObject jsonObj=new JSONObject();
			jsonObj.put("num",replylist.get(i).getNum());
			jsonObj.put("contents",replylist.get(i).getContents());
			jsonObj.put("id", replylist.get(i).getId());
			replyArr.add(jsonObj);
		}
		pageObj.put("currPage", 1);
		pageObj.put("totalPage",reviews_dao.getReplyTotal(num));
		resultObj.put("list", replyArr);
		resultObj.put("page",pageObj);
		return resultObj.toJSONString();	
		
	}	
	
	public String nextReply(int num,int page){
		ReviewsDao reviews_dao = sqlSessionTemplate.getMapper(ReviewsDao.class);
		
		JSONArray replyArr=new JSONArray();
		JSONObject pageObj=new JSONObject();
		JSONObject resultObj=new JSONObject();		
		Map<String,Integer> map=new HashMap<String,Integer>();
		map.put("num", num);
		map.put("page",page+1);
		List<NoticeVO>list=reviews_dao.getReplyList(map);
		for(int i=0; i<list.size(); i++)
		{
			JSONObject jsonObj=new JSONObject();
			jsonObj.put("num",list.get(i).getNum());
			jsonObj.put("contents",list.get(i).getContents());
			jsonObj.put("id", list.get(i).getId());
			replyArr.add(jsonObj);
		}
		pageObj.put("currPage", page+1);
		pageObj.put("totalPage", getTotalPage(reviews_dao.getReplyTotal(num)));
		resultObj.put("list", replyArr);
		resultObj.put("page",pageObj);
		return resultObj.toJSONString();		
		
	}
	
	public String prevReply(int num,int page){
		ReviewsDao reviews_dao = sqlSessionTemplate.getMapper(ReviewsDao.class);
		
		JSONArray replyArr=new JSONArray();
		JSONObject pageObj=new JSONObject();
		JSONObject resultObj=new JSONObject();		
		Map<String,Integer> map=new HashMap<String,Integer>();
		map.put("num", num);
		map.put("page",page-1);
		List<NoticeVO>list=reviews_dao.getReplyList(map);
		for(int i=0; i<list.size(); i++)
		{
			JSONObject jsonObj=new JSONObject();
			jsonObj.put("num",list.get(i).getNum());
			jsonObj.put("contents",list.get(i).getContents());
			jsonObj.put("id", list.get(i).getId());		
			replyArr.add(jsonObj);
		}
		pageObj.put("currPage", page-1);
		pageObj.put("totalPage", getTotalPage(reviews_dao.getReplyTotal(num)));
		resultObj.put("list", replyArr);
		resultObj.put("page",pageObj);
		return resultObj.toJSONString();		
		
	}
	
	public String allReply(int num){
		ReviewsDao reviews_dao = sqlSessionTemplate.getMapper(ReviewsDao.class);
		
		JSONArray jsonArr=new JSONArray();
		List<NoticeVO>replylist=reviews_dao.getAllReply(num);
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
	
	public String replyDel(HttpServletRequest request){
		int ref=Integer.parseInt(request.getParameter("ref"));
		int num=Integer.parseInt(request.getParameter("num"));
		int page=Integer.parseInt(request.getParameter("page"));
		ReviewsDao reviews_dao = sqlSessionTemplate.getMapper(ReviewsDao.class);
		int res=reviews_dao.delete(num);
		String newReplyList="";
		if(res==1){
			newReplyList=nowReplyList(ref, page);			
		}
		return newReplyList;		
	}
	
	public String nowReplyList(int num,int page){
		ReviewsDao reviews_dao = sqlSessionTemplate.getMapper(ReviewsDao.class);
		
		JSONArray replyArr=new JSONArray();
		JSONObject pageObj=new JSONObject();
		JSONObject resultObj=new JSONObject();
		Map<String,Integer> map=new HashMap<String,Integer>();	
		map.put("num", num);
		map.put("page",page);
		List<NoticeVO>list=reviews_dao.getReplyList(map);
		for(int i=0; i<list.size(); i++)
		{
			JSONObject jsonObj=new JSONObject();
			jsonObj.put("num",list.get(i).getNum());
			jsonObj.put("contents",list.get(i).getContents());
			jsonObj.put("id", list.get(i).getId());		
			replyArr.add(jsonObj);
		}
		pageObj.put("currPage", page);
		pageObj.put("totalPage", getTotalPage(reviews_dao.getReplyTotal(num)));
		resultObj.put("list", replyArr);
		resultObj.put("page",pageObj);
		return resultObj.toJSONString();		
		
	}
	public String replyModify(HttpServletRequest request){
		int num=Integer.parseInt(request.getParameter("num"));
		int ref=Integer.parseInt(request.getParameter("ref"));
		int page=Integer.parseInt(request.getParameter("page"));
		String contents=request.getParameter("contents");
		ReviewsDao reviews_dao = sqlSessionTemplate.getMapper(ReviewsDao.class);
		NoticeVO board=new NoticeVO();
		board.setContents(contents);
		board.setNum(num);
		int res=reviews_dao.replyModify(board);				
		String newReplyList="";
		if(res==1){
			newReplyList=nowReplyList(ref, page);		
		}
		return newReplyList;		
	}
	public ReviewsVo latelyRead(){		
		ReviewsDao reviews_dao = sqlSessionTemplate.getMapper(ReviewsDao.class);
		return reviews_dao.latelyRead();		
	}
	
	
	
}
