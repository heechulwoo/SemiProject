package member.controller;

import java.util.Properties;

import javax.mail.*;
import javax.mail.internet.*;

public class GoogleMail_jy {

	public void sendmail(String recipient, String certificationCode) throws Exception {
        
    	// 1. 정보를 담기 위한 객체
    	Properties prop = new Properties(); 
    	
    	// 2. SMTP(Simple Mail Transfer Protocoal) 서버의 계정 설정
   	    //    Google Gmail 과 연결할 경우 Gmail 의 email 주소를 지정 
    	prop.put("mail.smtp.user", "jubar22222@gmail.com");
        	
    	
    	// 3. SMTP 서버 정보 설정
    	//    Google Gmail 인 경우  smtp.gmail.com
    	prop.put("mail.smtp.host", "smtp.gmail.com");
         	
    	
    	prop.put("mail.smtp.port", "465");  // 465
    	prop.put("mail.smtp.starttls.enable", "true");
    	prop.put("mail.smtp.auth", "true");
    	prop.put("mail.smtp.debug", "true");
    	prop.put("mail.smtp.socketFactory.port", "465");  // 465
    	prop.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
    	prop.put("mail.smtp.socketFactory.fallback", "false");
    	
    	prop.put("mail.smtp.ssl.enable", "true");
    	prop.put("mail.smtp.ssl.trust", "smtp.gmail.com");
      	
    	
    	Authenticator smtpAuth = new MySMTPAuthenticator_jy(); 
    	Session ses = Session.getInstance(prop, smtpAuth);
    		
    	// 메일을 전송할 때 상세한 상황을 콘솔에 출력한다.
    	ses.setDebug(true);
    	        
    	// 메일의 내용을 담기 위한 객체생성
    	MimeMessage msg = new MimeMessage(ses);

    	// 제목 설정
    	String subject = "[IKEA]휴면해제를 위한 인증코드 발송";
    	msg.setSubject(subject);
    	        
    	// 보내는 사람의 메일주소
    	String sender = "jubar22222@gmail.com";
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
    					"		<td style=\"font-size:29px; padding-bottom:20px\"><b>안녕하세요.</b></td>\r\n" + 
    					"	</tr>\r\n" + 
    					"	<tbody style=\"font-size:13px\">\r\n" + 
    					"		<tr>\r\n" + 
    					"			<td>휴면해제를 요청하셨습니다.<br>\r\n" + 
    					"			고객님께서 요청하시지 않았다면, 보안을 위해 IKEA 고객센터로 문의해주세요.<br><br><br>\r\n" + 
    					"			휴면해제를 위한 인증번호는 <span style=\"font-size:15px; color:#00579c\"><b>"+certificationCode+"</b></span>입니다.</td>\r\n" + 
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
	
}
