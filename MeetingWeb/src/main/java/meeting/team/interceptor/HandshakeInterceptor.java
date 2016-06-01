package meeting.team.interceptor;

import java.util.HashSet;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.http.server.ServerHttpRequest;
import org.springframework.http.server.ServerHttpResponse;
import org.springframework.http.server.ServletServerHttpRequest;
import org.springframework.http.server.ServletServerHttpResponse;
import org.springframework.web.socket.WebSocketHandler;
import org.springframework.web.socket.server.support.HttpSessionHandshakeInterceptor;

public class HandshakeInterceptor extends HttpSessionHandshakeInterceptor {
	private static Set<String> user_list = new HashSet<String>();
	
	@Override
	public boolean beforeHandshake(ServerHttpRequest request, ServerHttpResponse response, WebSocketHandler wsHandler, Map<String, Object> attributes) throws Exception {
		ServletServerHttpRequest ssreq = (ServletServerHttpRequest) request;

		HttpServletRequest req = ssreq.getServletRequest();
		
		Object id = req.getSession().getAttribute("id");
		
		user_list.add((String) id);
		req.getServletContext().setAttribute("user_list", user_list);
		
		if (req.getSession().getAttribute("id") != null) {
			
			attributes.put("userId", id);
			attributes.put("user_list", user_list);
			return true;
		}
		return false;
	}

	@Override
	public void afterHandshake(ServerHttpRequest request, ServerHttpResponse response, WebSocketHandler wsHandler, Exception ex) {
		super.afterHandshake(request, response, wsHandler, ex);
	}
}
