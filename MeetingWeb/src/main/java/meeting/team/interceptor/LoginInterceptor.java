package meeting.team.interceptor;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class LoginInterceptor extends HandlerInterceptorAdapter {

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		HttpSession session = request.getSession();
		if (session.getAttribute("id") == null) {
			request.setAttribute("login", false);
			String url = request.getRequestURI().split("/NowMeetingWeb/")[1];
			session.setAttribute("from", url);
			RequestDispatcher rd = request.getRequestDispatcher("/web/main");
			rd.forward(request, response);
			// response.sendRedirect("../login/form?login=" + false);
			return false;
		} else {
			return true;
		}

	}

}
