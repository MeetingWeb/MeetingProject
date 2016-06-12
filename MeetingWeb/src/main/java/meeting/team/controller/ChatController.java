package meeting.team.controller;

import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.Map;
import java.util.Set;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

@Controller
public class ChatController extends TextWebSocketHandler {
	static private Set<WebSocketSession> session_set = new HashSet<WebSocketSession>();
	static private Map<String, WebSocketSession> session_map = new HashMap<String, WebSocketSession>();
	private String user_id;
	private Set<String> user_list;
	private JSONParser jsonParser = new JSONParser();

	// 웹소켓 서버에 클라이언트가 접속하면 호출되는 메소드
	@SuppressWarnings("unchecked")
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		Map<String, Object> map = session.getAttributes();
		user_id = (String) map.get("userId");
		user_list = (Set<String>) map.get("user_list");
		System.out.println(user_id + "접속됨");
		session_map.put(user_id, session);
		session_set.add(session);
	}

	// 클라이언트가 접속을 종료하면 호출되는 메소드
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		session_set.remove(session);
		session_map.remove(user_id);
		Iterator<WebSocketSession> it = session_set.iterator();
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("cmd", "list");
		jsonObj.put("msg", user_id + " -> EXIT");
		
		while (it.hasNext()) {
			WebSocketSession userPath = it.next();
			userPath.sendMessage(new TextMessage(jsonObj.toJSONString()));
		}
		
		System.out.println("클라이언트 접속해제");
	}

	// 메세지 받고 보낼 때 사용하는 메소드
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		Iterator<WebSocketSession> it = session_set.iterator();
		String payloadMessage = (String) message.getPayload();
		
		JSONObject jsonObj = (JSONObject) jsonParser.parse(payloadMessage);
		
		while (it.hasNext()) {
			WebSocketSession userPath = it.next();
			userPath.sendMessage(new TextMessage(jsonObj.toJSONString()));
		}
	}

	// 메시지 전송시나 접속해제시 오류가 발생할 때 호출되는 메소드
	@Override
	public void handleTransportError(WebSocketSession session, Throwable exception) throws Exception {
		super.handleTransportError(session, exception);
		System.out.println("전송오류 발생");
	}

}
