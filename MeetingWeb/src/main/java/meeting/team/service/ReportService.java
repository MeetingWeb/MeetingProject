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
	
	// �� ��ȸ(����Ʈ)
	public List<BoardVo> getReport(Map<String, Object> map) {
		reportDao = sqlSessionTemplate.getMapper(ReportDao.class);
		return reportDao.getReport(map);
	}
	
	// �� ���
	public Map<String, Object> insertReport(BoardVo bvo) {
		reportDao = sqlSessionTemplate.getMapper(ReportDao.class);
		
		int result = reportDao.insertReport(bvo);
		Map<String, Object> map = new HashMap<String, Object>();

		int maxNum = reportDao.getNum(bvo.getId());
		
		if(result > 0) {
			map.put("code", 200);
			map.put("msg", "����� �Ϸ��Ͽ����ϴ�.");
			map.put("maxNum", maxNum);
		} else {
			map.put("code", 201);
			map.put("msg", "����� �����Ͽ����ϴ�.");
			map.put("url", "./reportList");
		}
		
		return map;
	}
	
	// �� ����ȸ
	public BoardVo infoReport(int num) {
		reportDao = sqlSessionTemplate.getMapper(ReportDao.class);
		return reportDao.infoReport(num);
	}
	
	// �� ���� ���
	public Map<String, Object> updateReport(BoardVo bvo) {
		reportDao = sqlSessionTemplate.getMapper(ReportDao.class);
		int result = reportDao.updateReport(bvo);
		Map<String, Object> map = new HashMap<String, Object>();
		
		if(result > 0) {
			map.put("code", 200);
			map.put("msg", "������ �Ϸ��Ͽ����ϴ�.");
			map.put("url", "./reportInfo?num=");
		} else {
			map.put("code", 201);
			map.put("msg", "������ �����Ͽ����ϴ�.");
			map.put("url", "./reportInfo?num=");
		}
		
		return map;
	}
	
	// �� ����
	public Map<String, Object> deleteReport(BoardVo bvo) {
		reportDao = sqlSessionTemplate.getMapper(ReportDao.class);
		int result = reportDao.deleteReport(bvo);
		Map<String, Object> map = new HashMap<String, Object>();
		
		if(result > 0) {
			map.put("code", 200);
			map.put("msg", "������ �Ϸ�Ǿ����ϴ�.");
			map.put("url", "./reportList");
		} else {
			map.put("code", 201);
			map.put("msg", "������ �����߽��ϴ�.");
			map.put("url", "./reportList");
		}
		return map;
	}
	
	/* ------���------ */
	
	// ��� ���
	public Map<String, Object> insertReply(BoardResVo brvo) {
		reportDao = sqlSessionTemplate.getMapper(ReportDao.class);
		
		int result = reportDao.insertReply(brvo);
		Map<String, Object> map = new HashMap<String, Object>();
		
		if(result > 0) {
			map.put("code", 200);
			map.put("msg", "����� �Ϸ��Ͽ����ϴ�.");
			map.put("url", "./reportInfo?num=");
		} else {
			map.put("code", 201);
			map.put("msg", "����� �����Ͽ����ϴ�.");
			map.put("url", "./reportInfo?num=");
		}
		
		return map;
	}
	
	// ��� ��ȸ(����Ʈ)
	public List<BoardResVo> getReply(int num) {
		reportDao = sqlSessionTemplate.getMapper(ReportDao.class);
		return reportDao.getReply(num);
	}
	
	// ��� ����
	public Map<String, Object> updateReply(BoardResVo brvo) {
		reportDao = sqlSessionTemplate.getMapper(ReportDao.class);
		int result = reportDao.updateReply(brvo);
		Map<String, Object> map = new HashMap<String, Object>();
		
		if(result > 0) {
			map.put("code", 200);
			map.put("msg", "������ �Ϸ��Ͽ����ϴ�.");
			map.put("url", "./reportInfo?num=");
		} else {
			map.put("code", 201);
			map.put("msg", "������ �����Ͽ����ϴ�.");
			map.put("url", "./reportInfo?num=");
		}
		
		return map;
	}
	
	// ��� ����
	public Map<String, Object> deleteReply(int num) {
		reportDao = sqlSessionTemplate.getMapper(ReportDao.class);
		int result = reportDao.deleteReply(num);
		Map<String, Object> map = new HashMap<String, Object>();
		
		if(result > 0) {
			map.put("code", 200);
			map.put("msg", "������ �Ϸ�Ǿ����ϴ�.");
			map.put("url", "./reportInfo?num=");
		} else {
			map.put("code", 201);
			map.put("msg", "������ �����߽��ϴ�.");
			map.put("url", "./reportInfo?num=");
		}
		return map;
	}
	
	/* ------�Խ��� ����¡------ */
	
	// ��ü �� ����
	public int getCount(Map<String, Object> map) {
		reportDao = sqlSessionTemplate.getMapper(ReportDao.class);
		return reportDao.getCount(map);
	}
	
	// ������ ����
	public BoardVo getPrev(int num) {
		reportDao = sqlSessionTemplate.getMapper(ReportDao.class);
		return reportDao.getPrev(num);
	}
	
	// ������ ����
	public BoardVo getNext(int num) {
		reportDao = sqlSessionTemplate.getMapper(ReportDao.class);
		return reportDao.getNext(num);
	}
	
	// �̹��� ���ε�
	public void imgUpload (HttpServletRequest request, HttpServletResponse response, 
    		MultipartHttpServletRequest mRequest, MultipartFile upload) {
//		System.out.println("�̹��� ���ε� ��Ʈ�ѷ�");
		
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
    					String uploadPath =  path + "/temp/" + fileName; //������
    		            out = new FileOutputStream(new File(uploadPath));
    		            
    				} catch (Exception e) {
    					e.printStackTrace();
    				} 
    			}
    		}
            
            out.write(bytes);
            String callback = request.getParameter("CKEditorFuncNum");
 
            printWriter = response.getWriter();
            String fileUrl = "http://192.168.8.19:7777/NowMeetingWeb/temp/" + fileName; //url���
 
            printWriter.println("<script type='text/javascript'>window.parent.CKEDITOR.tools.callFunction("
                    + callback
                    + ",'"
                    + fileUrl
                    + "','�̹����� ���ε� �Ͽ����ϴ�.'"
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