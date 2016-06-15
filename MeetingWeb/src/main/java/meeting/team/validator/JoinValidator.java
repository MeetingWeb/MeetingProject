package meeting.team.validator;

import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

import meeting.team.vo.UserVo;

public class JoinValidator implements Validator
{

	public boolean supports(Class<?> arg0) {
		return UserVo.class.isAssignableFrom(arg0);
	}

	public void validate(Object target, Errors errors) {
		UserVo uvo = (UserVo) target;
		
		String id = uvo.getId();
		if(id==null) id="";
		String pw = uvo.getPw();
		if(pw==null) pw="";
		String pwc = uvo.getPwc();
		if(pwc==null) pwc="";
		String email = uvo.getEmail();
		if(email==null) email="";
		
		System.out.println(pw);
		System.out.println(pwc);
		
		
		String regex = "^[a-zA-Z]{1}[a-zA-Z0-9]{4,11}$";
		String pass = "^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{6,16}$";
		String emails = "^[_a-z0-9-]+(.[_a-z0-9-]+)*@(?:\\w+\\.)+\\w+$";
	
			if(email.matches(emails))
			{
				errors.rejectValue("email", "required5");
			}
			
			if(!(email.matches(emails)))
			{
				errors.rejectValue("emailfalse", "required6");
			}
		
		
			if(!(id.matches(regex)))
			{
				errors.rejectValue("id", "required");
				//break;
			}
			
			if(id.matches(regex))
			{
				errors.rejectValue("ids","required2");
			}
		
		
		
	
			if(!(pw.matches(pass)))
			{
				errors.rejectValue("pw","required");
			}
			
			if(pw.matches(pass))
			{
				errors.rejectValue("pws","required2");
			}
			
			if(pwc.matches(pw))
			{
				errors.rejectValue("pwc","required3");
			}
			
			if(!(pwc.matches(pw)))
			{
				errors.rejectValue("pwcc","required4");
			}
			
			
	
		

		/*
		if(pw!=null)
		{
			for(int i=0;i<pw.length();i++)
			{
				char ch = pw.charAt(i);
				if(!Character.isDigit(ch))
				{
					errors.rejectValue("pw", "required");
					break;
				}
			}
		}*/
	
		
		
	}

}
