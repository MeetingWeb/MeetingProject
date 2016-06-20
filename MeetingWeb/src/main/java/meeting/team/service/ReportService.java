package meeting.team.service;

import java.io.*;
import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import meeting.team.dao.ReportDao;
import meeting.team.vo.BoardResVo;
import meeting.team.vo.BoardVo;

@Service
public class ReportService {
	
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	ReportDao reportDao;
	
	// 글 조회(리스트)
	public List<BoardVo> getReport(Map<String, Object> map) {
		reportDao = sqlSessionTemplate.getMapper(ReportDao.class);
		return reportDao.getReport(map);
	}
	
	// 글 등록
	public Map<String, Object> insertReport(BoardVo bvo) {
		reportDao = sqlSessionTemplate.getMapper(ReportDao.class);
		
		int result = reportDao.insertReport(bvo);
		Map<String, Object> map = new HashMap<String, Object>();

		int maxNum = reportDao.getNum(bvo.getId());
		
		if(result > 0) {
			map.put("code", 200);
			map.put("msg", "등록을 완료하였습니다.");
			map.put("maxNum", maxNum);
		} else {
			map.put("code", 201);
			map.put("msg", "등록을 실패하였습니다.");
			map.put("url", "./reportList");
		}
		
		return map;
	}
	
	// 글 상세조회
	public BoardVo infoReport(int num) {
		reportDao = sqlSessionTemplate.getMapper(ReportDao.class);
		return reportDao.infoReport(num);
	}
	
	// 글 수정 등록
	public Map<String, Object> updateReport(BoardVo bvo) {
		reportDao = sqlSessionTemplate.getMapper(ReportDao.class);
		int result = reportDao.updateReport(bvo);
		Map<String, Object> map = new HashMap<String, Object>();
		
		if(result > 0) {
			map.put("code", 200);
			map.put("msg", "수정을 완료하였습니다.");
			map.put("url", "./reportInfo?num=");
		} else {
			map.put("code", 201);
			map.put("msg", "수정을 실패하였습니다.");
			map.put("url", "./reportInfo?num=");
		}
		
		return map;
	}
	
	// 글 삭제
	public Map<String, Object> deleteReport(BoardVo bvo) {
		reportDao = sqlSessionTemplate.getMapper(ReportDao.class);
		int result = reportDao.deleteReport(bvo);
		Map<String, Object> map = new HashMap<String, Object>();
		
		if(result > 0) {
			map.put("code", 200);
			map.put("msg", "삭제가 완료되었습니다.");
			map.put("url", "./reportList");
		} else {
			map.put("code", 201);
			map.put("msg", "삭제에 실패했습니다.");
			map.put("url", "./reportList");
		}
		return map;
	}
	
	/* ------댓글------ */
	
	// 댓글 등록
	public Map<String, Object> insertReply(BoardResVo brvo) {
		reportDao = sqlSessionTemplate.getMapper(ReportDao.class);
		
		int result = reportDao.insertReply(brvo);
		Map<String, Object> map = new HashMap<String, Object>();
		
		if(result > 0) {
			map.put("code", 200);
			map.put("msg", "등록을 완료하였습니다.");
			map.put("url", "./reportInfo?num=");
		} else {
			map.put("code", 201);
			map.put("msg", "등록을 실패하였습니다.");
			map.put("url", "./reportInfo?num=");
		}
		
		return map;
	}
	
	// 댓글 조회(리스트)
	public List<BoardResVo> getReply(int num) {
		reportDao = sqlSessionTemplate.getMapper(ReportDao.class);
		return reportDao.getReply(num);
	}
	
	// 댓글 수정
	public Map<String, Object> updateReply(BoardResVo brvo) {
		reportDao = sqlSessionTemplate.getMapper(ReportDao.class);
		int result = reportDao.updateReply(brvo);
		Map<String, Object> map = new HashMap<String, Object>();
		
		if(result > 0) {
			map.put("code", 200);
			map.put("msg", "수정을 완료하였습니다.");
			map.put("url", "./reportInfo?num=");
		} else {
			map.put("code", 201);
			map.put("msg", "수정을 실패하였습니다.");
			map.put("url", "./reportInfo?num=");
		}
		
		return map;
	}
	
	// 댓글 삭제
	public Map<String, Object> deleteReply(int num) {
		reportDao = sqlSessionTemplate.getMapper(ReportDao.class);
		int result = reportDao.deleteReply(num);
		Map<String, Object> map = new HashMap<String, Object>();
		
		if(result > 0) {
			map.put("code", 200);
			map.put("msg", "삭제가 완료되었습니다.");
			map.put("url", "./reportInfo?num=");
		} else {
			map.put("code", 201);
			map.put("msg", "삭제에 실패했습니다.");
			map.put("url", "./reportInfo?num=");
		}
		return map;
	}
	
	/* ------게시판 페이징------ */
	
	// 전체 글 갯수
	public int getCount(Map<String, Object> map) {
		reportDao = sqlSessionTemplate.getMapper(ReportDao.class);
		return reportDao.getCount(map);
	}
	
	// 이전글 정보
	public BoardVo getPrev(int num) {
		reportDao = sqlSessionTemplate.getMapper(ReportDao.class);
		return reportDao.getPrev(num);
	}
	
	// 다음글 정보
	public BoardVo getNext(int num) {
		reportDao = sqlSessionTemplate.getMapper(ReportDao.class);
		return reportDao.getNext(num);
	}
	
	// 이미지 업로드
	public void imgUpload (HttpServletRequest request, HttpServletResponse response, 
    		MultipartHttpServletRequest mRequest, MultipartFile upload) {
//		System.out.println("이미지 업로드 컨트롤러");
		
		OutputStream out = null;
        PrintWriter printWriter = null;
        response.setCharacterEncoding("utf-8");
        response.setContentType("text/html;charset=utf-8");
        
		String path = this.getClass().getClassLoader().getResource("").getPath();
//		System.out.println(path);
		path = path.substring(0, path.indexOf("/WEB-INF"));
		
		File dir = new File(path + "/temp");
		if(!dir.isDirectory()) {
			dir.mkdirs();
		}
		
        try{
 
            String fileName = upload.getOriginalFilename();
            byte[] bytes = upload.getBytes();
            
            Iterator<String> htmlName = mRequest.getFileNames();
    		while(htmlName.hasNext()) {
    			String html = htmlName.next();
    			upload = mRequest.getFile(html);

    			fileName = upload.getOriginalFilename();
    			
    			if(fileName != null && !fileName.equals("")) {
    				String name = fileName.substring(0, fileName.lastIndexOf("."));
    				String ext = fileName.substring(fileName.lastIndexOf(".") + 1);
    				
    				fileName = name + System.currentTimeMillis() + "." + ext;
    	
    				try {
    					String uploadPath =  path + "/temp/" + fileName; //저장경로
    		            out = new FileOutputStream(new File(uploadPath));
    		            
    				} catch (Exception e) {
    					e.printStackTrace();
    				} 
    			}
    		}
            
            out.write(bytes);
            String callback = request.getParameter("CKEditorFuncNum");
 
            printWriter = response.getWriter();
            String fileUrl = "http://192.168.8.19:7777/NowMeetingWeb/temp/" + fileName; //url경로
 
            printWriter.println("<script type='text/javascript'>window.parent.CKEDITOR.tools.callFunction("
                    + callback
                    + ",'"
                    + fileUrl
                    + "','이미지를 업로드 하였습니다.'"
                    + ")</script>");
            printWriter.flush();
 
        }catch(IOException e){
            e.printStackTrace();
        } finally {
            try {
                if (out != null) {
                    out.close();
                }
                if (printWriter != null) {
                    printWriter.close();
                }
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
 
        return;
    }
	
}