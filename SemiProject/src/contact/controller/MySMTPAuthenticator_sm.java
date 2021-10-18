package contact.controller;

import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;

public class MySMTPAuthenticator_sm extends Authenticator {

	@Override
	public PasswordAuthentication getPasswordAuthentication() {
		
		// Gmail 의 경우 @gmail.com 을 제외한 아이디만 입력한다.
		return new PasswordAuthentication("si6626730","qwer1234$"); 
	}	
	
}
