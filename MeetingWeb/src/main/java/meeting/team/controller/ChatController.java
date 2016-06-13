package meeting.team.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.ConcurrentHashMap;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import meeting.team.service.ChatService;


public class ChatController extends TextWebSocketHandler {
	//public static Set<WebSocketSession> session_set = new HashSet<WebSocketSession>();
	/*public static Map<String, WebSocketSession> session_map = new HashMap<String, WebSocketSession>();*/
	public static Map<String, WebSocketSession> session_map = new ConcurrentHashMap<String, WebSocketSession>();
	private String user_id;
	private Set<String> user_list;
	private JSONParser jsonParser = new JSONParser();
	@Autowired
	private ChatService chat_svc;

	// ������ ������ Ŭ���̾�Ʈ�� �����ϸ� ȣ��Ǵ� �޼ҵ�
	@SuppressWarnings("unchecked")
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		Map<String, Object> map = session.getAttributes();
		user_id = (String) map.get("userId");
		user_list = (Set<String>) map.get("user_list");
		System.out.println(user_id + "���ӵ�");
		session_map.put(user_id, session);
		//session_set.add(session);
	}

	// Ŭ���̾�Ʈ�� ������ �����ϸ� ȣ��Ǵ� �޼ҵ�
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		//session_set.remove(session);
		Map<String, Object> map = session.getAttributes();
		session_map.remove((String) map.get("userId"));
		//Iterator<WebSocketSession> it = session_set.iterator();
		Iterator<String> id_it = session_map.keySet().iterator();
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("cmd", "list");
		jsonObj.put("msg", user_id + " -> EXIT");
		
		for(int i = 0; i < user_list.size(); i++) {
			if(id_it.hasNext()){
				String id = id_it.next();
				if(id != null) {
					WebSocketSession userPath = session_map.get(id);
					if(userPath != null)
						userPath.sendMessage(new TextMessage(jsonObj.toJSONString()));
				}
			}
		}
		/*if (it != null) {
			while (it.hasNext()) {
				WebSocketSession userPath = it.next();
				userPath.sendMessage(new TextMessage(jsonObj.toJSONString()));
			}
		}*/

		System.out.println(user_id+"Ŭ���̾�Ʈ ��������");
	}

	// �޼��� �ް� ���� �� ����ϴ� �޼ҵ�
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		// Iterator<WebSocketSession> it = session_set.iterator();
		String payloadMessage = (String) message.getPayload();

		JSONObject jsonObj = (JSONObject) jsonParser.parse(payloadMessage);
		String master = (String) jsonObj.get("master");

		if (master != null) {
			ArrayList<String> list = chat_svc.getChatMember(master);
			for (int i = 0; i < list.size(); i++) {
				WebSocketSession userPath = session_map.get(list.get(i));
				if (userPath != null)
					userPath.sendMessage(new TextMessage(jsonObj.toJSONString()));
			}
		}

		/*
		 * while (it.hasNext()) {
		 * WebSocketSession userPath = it.next();
		 * userPath.sendMessage(new TextMessage(jsonObj.toJSONString()));
		 * }
		 */
	}

	// �޽��� ���۽ó� ���������� ������ �߻��� �� ȣ��Ǵ� �޼ҵ�
	@Override
	public void handleTransportError(WebSocketSession session, Throwable exception) throws Exception {
		super.handleTransportError(session, exception);
		System.out.println("���ۿ��� �߻�");
	}

}
