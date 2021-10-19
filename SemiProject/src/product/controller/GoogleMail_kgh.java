package product.controller;

import java.util.Properties;

import javax.mail.*;
import javax.mail.internet.*;

public class GoogleMail_kgh {

	public void sendmail(String recipient, String odrcode, String orderdate, String sumtotalprice) throws Exception {
        
		// 1. 정보를 담기 위한 객체
		Properties prop = new Properties(); 
      
		// 2. SMTP(Simple Mail Transfer Protocoal) 서버의 계정 설정
		//    Google Gmail 과 연결할 경우 Gmail 의 email 주소를 지정 
		prop.put("mail.smtp.user", "alsgur7308@gmail.com");
      
  
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
    
  
		Authenticator smtpAuth = new MySMTPAuthenticator_kgh();
		Session ses = Session.getInstance(prop, smtpAuth);
     
		// 메일을 전송할 때 상세한 상황을 콘솔에 출력한다.
		ses.setDebug(true);
          
		// 메일의 내용을 담기 위한 객체생성
		MimeMessage msg = new MimeMessage(ses);

		// 제목 설정
		String subject = "이케아 주문이 완료되었습니다.";
		msg.setSubject(subject);
          
		// 보내는 사람의 메일주소
		String sender = "alsgur7308@gmail.com";
		Address fromAddr = new InternetAddress(sender);
		msg.setFrom(fromAddr);
          
		// 받는 사람의 메일주소
		Address toAddr = new InternetAddress(recipient);
		msg.addRecipient(Message.RecipientType.TO, toAddr); 
		
    	// 메시지 본문의 내용과 형식, 캐릭터 셋 설정
    	msg.setContent( "<div style=\"padding-left:130px;\">\r\n" + 
		    			"	<div style=\"border: 20px solid #d6e0f5; width: 550px;\">\r\n" + 
		    			"	<table style=\"padding: 20px 50px;\">\r\n" + 
		    			"		<tr>\r\n" + 
		    			"			<th style=\"font-size:26px; 	padding-bottom: 40px; padding-left: 120px;\">주문 완료</th>\r\n" + 
		    			"		</tr>\r\n" + 
		    			"		<tbody style=\"font-size:10pt; width: 150px;\">\r\n" + 
		    			"			<tr >\r\n" + 
		    			"				<td colspan=\"2\" >\r\n" + 
		    			"					IKEA에서 쇼핑해 주셔서 감사합니다.\r\n" + 
		    			"				</td>\r\n" + 
		    			"			</tr>\r\n" + 
		    			"			<tr>\r\n" + 
		    			"				<td>\r\n" + 
		    			"					주문 번호는 <span style=\"font-weight: bold;\">" + odrcode + "</span>입니다.<br><br><br>\r\n" + 
		    			"				</td>\r\n" + 
		    			"			</tr>\r\n" + 
		    			"			<tr style=\"padding-top: 50px; margin-bottom: 50px;\">\r\n" + 
		    			"				<td style=\"font-weight: bold; font-size: 14pt;\">\r\n" + 
		    			"					주문 정보<br>\r\n" + 
		    			"				</td>\r\n" + 
		    			"			</tr>\r\n" + 
		    			"			<tr style=\"padding-top: 50px;\">\r\n" + 
		    			"				<td >\r\n" + 
		    			"					주문번호\r\n" + 
		    			"				</td>\r\n" + 
		    			"				<td style=\"padding-right: 20px; text-align: right;\">\r\n" + 
		    			"					" + odrcode + "\r\n" + 
		    			"				</td>\r\n" + 
		    			"			</tr>\r\n" + 
		    			"			<tr>\r\n" + 
		    			"				<td >\r\n" + 
		    			"					주문일자\r\n" + 
		    			"				</td>\r\n" + 
		    			"				<td style=\"padding-right: 20px; text-align: right;\">\r\n" + 
		    			"					" + orderdate + "\r\n" + 
		    			"				</td>\r\n" + 
		    			"			</tr>\r\n" + 
		    			"			<tr style=\"padding-top: 50px;\">\r\n" + 
		    			"				<td>\r\n" + 
		    			"					<br>주문금액\r\n" + 
		    			"				</td>\r\n" + 
		    			"				<td style=\"padding-right: 20px; text-align: right;\">\r\n" + 
		    			"					<br>" + sumtotalprice + "&nbsp;원\r\n" + 
		    			"				</td>\r\n" + 
		    			"			</tr>\r\n" + 
		    			"			<tr style=\"padding-top: 50px;\">\r\n" + 
		    			"				<td >\r\n" + 
		    			"					배송예정일\r\n" + 
		    			"				</td>\r\n" + 
		    			"				<td style=\"padding-right: 20px; text-align: right;\">\r\n" + 
		    			"					주문일로 3일 이내 배송 시작\r\n" + 
		    			"				</td>\r\n" + 
		    			"			</tr>\r\n" + 
		    			"			<tr>\r\n" + 
		    			"				<td style=\"padding-top:55px; font-weight: bold;\" >\r\n" + 
		    			"					IKEA 이케아 올림.\r\n" + 
		    			"				</td>\r\n" + 
		    			"			</tr>\r\n" + 
		    			"		</tbody>\r\n" + 
		    			"	</table>\r\n" + 
		    			"	</div>\r\n" + 
		    			"	</div>", "text/html;charset=UTF-8");
    	        
    	// 메일 발송하기
    	Transport.send(msg);
    	
    }// end of sendmail(String recipient, String certificationCode)-----------------		
	
}
