package contact.controller;

import java.util.Map;
import java.util.Properties;

import javax.mail.*;
import javax.mail.internet.*;

public class GoogleMail_sm {

	public void sendmail(String recipient, Map<String, String> paraMap) throws Exception {
        
    	// 1. 정보를 담기 위한 객체
    	Properties prop = new Properties(); 
    	
    	// 2. SMTP(Simple Mail Transfer Protocoal) 서버의 계정 설정
   	    //    Google Gmail 과 연결할 경우 Gmail 의 email 주소를 지정 
    	prop.put("mail.smtp.user", "si6626730@gmail.com");
        	
    	
    	// 3. SMTP 서버 정보 설정
    	//    Google Gmail 인 경우  smtp.gmail.com
    	prop.put("mail.smtp.host", "smtp.gmail.com");
         	
    	
    	prop.put("mail.smtp.port", "465");
    	prop.put("mail.smtp.starttls.enable", "true");
    	prop.put("mail.smtp.auth", "true");
    	prop.put("mail.smtp.debug", "true");
    	prop.put("mail.smtp.socketFactory.port", "465");
    	prop.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
    	prop.put("mail.smtp.socketFactory.fallback", "false");
    	
    	prop.put("mail.smtp.ssl.enable", "true");
    	prop.put("mail.smtp.ssl.trust", "smtp.gmail.com");
      	
    	
    	Authenticator smtpAuth = new MySMTPAuthenticator_sm(); 
    	Session ses = Session.getInstance(prop, smtpAuth);
    		
    	// 메일을 전송할 때 상세한 상황을 콘솔에 출력한다.
    	ses.setDebug(true);
    	        
    	// 메일의 내용을 담기 위한 객체생성
    	MimeMessage msg = new MimeMessage(ses);

    	// 제목 설정
    	String subject = ">>> [(semi)IKEA 고객지원] "+paraMap.get("name")+" 회원님의 셀프 반품 이메일 발송 <<<";
    	msg.setSubject(subject);
    	        
    	// 보내는 사람의 메일주소
    	String sender = "si6626730@gmail.com";
    	Address fromAddr = new InternetAddress(sender);
    	msg.setFrom(fromAddr);
    	        
    	// 받는 사람의 메일주소
    	Address toAddr = new InternetAddress(recipient);
    	msg.addRecipient(Message.RecipientType.TO, toAddr);
    	        
    	// 메시지 본문의 내용과 형식, 캐릭터 셋 설정
    	msg.setContent(" [(semi)IKEA 고객지원] 안녕하세요 요청하신 제품 셀프반품 신청이 완료되었습니다.<br> "
    			+ " 제품번호 : <span style='font-size:14pt; color:blue;'>"+paraMap.get("odrcode")+"</span><br>"
    			+ " 신청인 : <span style='font-size:14pt; color:blue;'>"+paraMap.get("name")+"</span><br>"
    			+ " 구입처 : <span style='font-size:14pt; color:blue;'>"+paraMap.get("wherebuy")+"</span><br>"
    			+ " 반품사유 : <span style='font-size:14pt; color:blue;'>"+paraMap.get("whyreturn")+"</span><br>"
    			+ " 추가내용 : <span style='font-size:14pt; color:blue;'>"+paraMap.get("plusReason")+"</span><br>"
    			+ " 반품에 필요한 정보를 입력한 후 송부된 이메일을 제품, 영수증과 함께 매장 내 교환환불 코너에 오시면 됩니다. IKEA를 이용해주셔서 감사합니다.", "text/html;charset=UTF-8");
    	        
    	// 메일 발송하기
    	Transport.send(msg);
    	
    }// end of sendmail(String recipient, String certificationCode)-----------------		
	
}
