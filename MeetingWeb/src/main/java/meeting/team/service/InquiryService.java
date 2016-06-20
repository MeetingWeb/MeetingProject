package meeting.team.service;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import meeting.team.dao.InquiryDao;
import meeting.team.vo.InquiryVo;

@Service
public class InquiryService {
	
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	public String write(InquiryVo ivo,HttpServletRequest request)
	{
		if(ivo.getFile().getSize()==0||ivo.getImg_name()=="") ivo.setImg_name("null");
		if(ivo.getFile().getSize()!=0)
		{
			MultipartFile file2 = ivo.getFile();  
		    String fileName = file2.getOriginalFilename();  
		 
		    ivo.setImg_name(fileName);
		 
		    //Date dt = new Date();
		    //SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss a"); 
		    //ivo.setImg_name(sdf.format(dt).toString()+fileName);
		    //ivo.setFilesize((int) file2.getSize());
		    
			
		    InputStream inputStream = null;  
		    OutputStream outputStream = null;  
			
			try {  
		        inputStream = file2.getInputStream();  
		        String path = request.getSession().getServletContext().getRealPath("/resources/images/" + ivo.getImg_name());
		        File newFile = new File(path);  
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
			
		
		
		
		
		InquiryDao idao = sqlSessionTemplate.getMapper(InquiryDao.class);

		
		
		int n = idao.iwrite(ivo);
		boolean tf = n > 0 ? true:false;
		JSONObject json = new JSONObject();
		if(tf==true)
		{
			json.put("ok", true);
		}
		else
		{
			json.put("ok", false);
		}
		
		return json.toJSONString();		
	}
	
	
	public String updates(InquiryVo ivo, HttpServletRequest request) {
		if(ivo.getFile().getSize()==0||ivo.getImg_name()=="") ivo.setImg_name("null");
		if(ivo.getFile().getSize()!=0)
		{
			MultipartFile file2 = ivo.getFile();  
		    String fileName = file2.getOriginalFilename();  
		 
		    ivo.setImg_name(fileName);
		    
		    InputStream inputStream = null;  
		    OutputStream outputStream = null;  
			
			try {  
		        inputStream = file2.getInputStream();  
		        String path = request.getSession().getServletContext().getRealPath("/resources/images/" + ivo.getImg_name());
		        File newFile = new File(path);  
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
		InquiryDao idao = sqlSessionTemplate.getMapper(InquiryDao.class);
		int n = idao.iupdate(ivo);
		boolean tf = n > 0 ? true:false;
		JSONObject json = new JSONObject();
		if(tf==true)
		{
			json.put("ok", true);
		}
		else
		{
			json.put("ok", false);
		}
		return json.toJSONString();	
	}

	
	
	
	
	
	public InquiryVo read(int num)
	{
		InquiryDao idao = sqlSessionTemplate.getMapper(InquiryDao.class);
		InquiryVo ivo = idao.iread(num);
		return ivo;
	}

	public InquiryVo lread() {
		InquiryDao idao = sqlSessionTemplate.getMapper(InquiryDao.class);
		InquiryVo ivo = idao.lread();
		return ivo;
	}

	public String deletes(int num) {
		InquiryDao idao = sqlSessionTemplate.getMapper(InquiryDao.class);
		int n = idao.idelete(num);
		boolean tf = n > 0 ? true:false;
		JSONObject json = new JSONObject();
		if(tf==true)
		{
			json.put("ok", true);
		}
		else
		{
			json.put("ok", false);
		}
		return json.toJSONString();		
	}


	public InquiryVo update(int num) {
		InquiryDao idao = sqlSessionTemplate.getMapper(InquiryDao.class);
		InquiryVo ivo = idao.iread(num);
		return ivo;
	}
	
	public String repleupdates(InquiryVo ivo) {
		InquiryDao idao = sqlSessionTemplate.getMapper(InquiryDao.class);
		int n = idao.repleiupdate(ivo);
		boolean tf = n > 0 ? true:false;
		JSONObject json = new JSONObject();
		if(tf==true)
		{
			json.put("ok", true);
		}
		else
		{
			json.put("ok", false);
		}
		return json.toJSONString();	
	}

	public List<InquiryVo> ilist(int page, HttpServletRequest request, int check, String id) 
	{
		InquiryDao idao = sqlSessionTemplate.getMapper(InquiryDao.class);
		List<InquiryVo> list = null;
		int ptotal = 0;
		int n = 0;
		if(check==1)
		{
			request.setAttribute("check", 1);
			list = idao.ilist(page);
			ptotal = idao.pageTotals(id);
		}
		
		else if(check==2)
		{
			request.setAttribute("check", 2);
			String serch = request.getParameter("serch");
			String select = request.getParameter("select");
			
			request.setAttribute("serch", serch);
			request.setAttribute("select", select);
			
			String sel = null;
			if(select.equals("제 목"))
			{
				System.out.println("제 목");
				sel = "title";
			}
			if(select.equals("내 용"))
			{
				System.out.println("내 용");
				sel = "contents";
			}
			if(select.equals("작성자"))
			{
				System.out.println("작성자");
				sel = "id";
			}
			String ser = serch;
			
			InquiryVo ivo = new InquiryVo();
			ivo.setPage(page);
			ivo.setSelect(sel);
			ivo.setSerch(ser);
			

			
			
			list = idao.serchlist(ivo);
			ptotal = idao.serchlisttotal(ivo);
		}
		 
		
		
		if(ptotal%10==0) 
		{
			n = ptotal/10;
		}
		else 
		{
			n = ptotal/10+1;
		}

		
		request.setAttribute("ptotal",n);
		return list;
	}
	
	public List<InquiryVo> replyList(int page,int num, HttpServletRequest request)
	{
		InquiryDao idao = sqlSessionTemplate.getMapper(InquiryDao.class);
		List<InquiryVo> list = null;
		int ptotal = 0;
		int n = 0;

		
		
		Map<String,Integer> map=new HashMap<String,Integer>();
		map.put("num", num);
		map.put("page",page);
		
		list = idao.repleilist(map);
		System.out.println(num);
		ptotal = idao.replepageTotals(num);
		
		if(ptotal%10==0) 
		{
			n = ptotal/10;
		}
		else 
		{
			n = ptotal/10+1;
		}

		
		request.setAttribute("repleptotal",n);
		return list;
	}

}
