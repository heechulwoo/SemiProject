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
    	msg.setContent( "<div style=\"width:568px; height:40px; padding-left:130px; padding-top:30px\"><img src=\"https://www.ikea.com/kr/ko/static/ikea-logo.f7d9229f806b59ec64cb.svg\" alt=\"IKEA_logo\" width=\"90\" height=\"35\"></div>\r\n" + 
    					"<div style=\"padding-left:130px; font-family: Arial\">\r\n" + 
    					"<div style=\"border: 29px solid #f4f6f8; width:535px; height:300px\">\r\n" + 
    					"<table style=\"padding:25px\">\r\n" + 
    					"	<tr>\r\n" + 
    					"		<td style=\"font-size:25px; padding-bottom:20px\"><b>안녕하세요 "+paraMap.get("name")+"님!</b></td>\r\n" + 
    					"	</tr>\r\n" + 
    					"	<tbody style=\"font-size:13px\">\r\n" + 
    					"		<tr>\r\n" + 
    					"			<td>요청하신 제품의 셀프반품 신청이 완료되었습니다.<br> 아래의 정보가 맞는지 확인 후 이케아를 방문해주세요.<br>\r\n" + 
    					"			주문번호 : <span style='font-size:13pt; color:#00579c; font-weight: bold;'>"+paraMap.get("fk_odrcode")+"</span><br>\r\n" + 
    					"			신청인 아이디 : <span style='font-size:13pt; color:#00579c; font-weight: bold;'>"+paraMap.get("fk_userid")+"</span><br>\r\n" + 
    					"			신청인 : <span style='font-size:13pt; color:#00579c; font-weight: bold;'>"+paraMap.get("name")+"</span><br>\r\n" + 
    					"			구입처 : <span style='font-size:13pt; color:#00579c; font-weight: bold;'>"+paraMap.get("wherebuy")+"</span><br>\r\n" + 
    					"			반품사유 : <span style='font-size:13pt; color:#00579c; font-weight: bold;'>"+paraMap.get("whyreturn")+"</span><br>\r\n" + 
    					"			추가내용 : <span style='font-size:13pt; color:black; font-weight: bold;'>"+paraMap.get("plusReason")+"</span><br><br><br>\r\n" + 
    					"			<span style='font-size:7pt; color:black; font-weight: bold;'> >>> 반품에 필요한 정보를 입력한 후 송부된 이메일을 제품, 영수증과 함께<br>매장 내 교환환불 코너에 오시면 됩니다. 저희 IKEA를 이용해주셔서 감사합니다. <<< </span>" + 
    					"		</tr>\r\n" + 
    					"		<tr><td style=\"padding-top:55px\"><b>IKEA Semi</b></td>\r\n" + 
    					"	</tr>\r\n" + 
    					"		\r\n" + 
    					"\r\n" + 
    					"	</tbody>\r\n" + 
    					"</table>\r\n" + 
    					"</div>\r\n" + 
    					"</div>", "text/html;charset=UTF-8");
    	        
    	
    	
    	
    	// 메일 발송하기
    	Transport.send(msg);
    	
    }// end of sendmail(String recipient, String certificationCode)-----------------		
	
	
	
	
	// 주문 배송완료 이메일
	public void sendShipmail(String recipient, Map<String, String> paraMap) throws Exception {
		
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
    	msg.setContent( "<div style=\"width:568px; height:40px; padding-left:130px; padding-top:30px\"><img src=\"https://www.ikea.com/kr/ko/static/ikea-logo.f7d9229f806b59ec64cb.svg\" alt=\"IKEA_logo\" width=\"90\" height=\"35\"></div>\r\n" + 
    					"<div style=\"padding-left:130px; font-family: Arial\">\r\n" + 
    					"<div style=\"border: 29px solid #f4f6f8; width:535px; height:300px\">\r\n" + 
    					"<table style=\"padding:25px\">\r\n" + 
    					"	<tr>\r\n" + 
    					"		<td style=\"font-size:25px; padding-bottom:20px\"><b>배송 완료 안내 메세지입니다.</b></td>\r\n" + 
    					"	</tr>\r\n" + 
    					"	<tbody style=\"font-size:13px\">\r\n" + 
    					"		<tr>\r\n" + 
    					"			<td>주문하신 제품의 배송이 완료되었습니다.<br><br>\r\n" + 
    					"			주문번호 : <span style='font-size:13pt; color:#00579c; font-weight: bold;'>"+paraMap.get("fk_odrcode")+"</span><br>\r\n" + 
    					"			주문상세번호 : <span style='font-size:13pt; color:#00579c; font-weight: bold;'>"+paraMap.get("odrseqnum")+"</span><br>\r\n" + 
    					"			이메일 : <span style='font-size:13pt; color:#00579c; font-weight: bold;'>"+paraMap.get("email")+"</span><br>\r\n" + 
    					"			상품명 : <span style='font-size:13pt; color:#00579c; font-weight: bold;'>"+paraMap.get("pname")+"</span><br>\r\n" + 
    					"			주문수량 : <span style='font-size:13pt; color:#00579c; font-weight: bold;'>"+paraMap.get("oqty")+"</span><br>\r\n" + 
    					"			<span style='font-size:7pt; color:black; font-weight: bold;'> >>> 해당 제품 배송이 완료되었습니다. 저희 IKEA를 이용해주셔서 감사합니다. <<< </span>" + 
    					"		</tr>\r\n" + 
    					"		<tr><td style=\"padding-top:55px\"><b>IKEA Semi</b></td>\r\n" + 
    					"	</tr>\r\n" + 
    					"		\r\n" + 
    					"\r\n" + 
    					"	</tbody>\r\n" + 
    					"</table>\r\n" + 
    					"</div>\r\n" + 
    					"</div>", "text/html;charset=UTF-8");
    	        
    	
    	
    	
    	// 메일 발송하기
    	Transport.send(msg);
    	
		
	}// end of public void sendShipmail(String email, Map<String, String> paraMap)--------------
	
}
