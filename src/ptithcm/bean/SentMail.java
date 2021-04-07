package ptithcm.bean;

import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

@Service("SentMail")
public class SentMail {
	@Autowired
	JavaMailSender SentMail;
	
	public void send(String from, String to, String subject, String body){
		try{
			MimeMessage mail = SentMail.createMimeMessage();
			MimeMessageHelper helper = new MimeMessageHelper(mail, true, "utf-8");
			helper.setFrom(from, from);
			helper.setTo(to);
			helper.setSubject(subject);
			helper.setReplyTo(from, from);
			helper.setText(body, true);
			
			SentMail.send(mail);
		}
		catch(Exception ex){
			throw new RuntimeException(ex);
		}
	}
}
