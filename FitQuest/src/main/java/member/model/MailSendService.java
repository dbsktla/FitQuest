package member.model;

import java.util.Random;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Component;

@Component
public class MailSendService {
	@Autowired
	private JavaMailSenderImpl mailSender;
	private int authNumber; 
	
		public void makeRandomNumber() {
			// 난수의 범위 111111 ~ 999999 (6자리 난수)
			Random r = new Random();
			int checkNum = r.nextInt(888888) + 111111;
			System.out.println("인증번호 : " + checkNum);
			authNumber = checkNum;
		}
		
		
				//이메일 보낼 양식! 
		public String joinEmail(String email) {
			makeRandomNumber();
			String setFrom = ".com"; // email-config에 설정한 자신의 이메일 주소를 입력 
			String toMail = email;
			String title = "Fitquest 인증 이메일 입니다."; // 이메일 제목 
			String content = 
					"<h1><font color=\"#FAC710\">Fitquest에 방문해 주셔서 감사합니다.</font></h1>" + 	//html 형식으로 작성 ! 
	                "<br><br>" + 
				    "인증 번호는 <font color=\"red\">" + authNumber + "</font>입니다." + 
				    "<br>" + 
				    "해당 인증번호를 인증번호 확인란에 기입하여 주세요."; //이메일 내용 삽입
			mailSend(setFrom, toMail, title, content);
			return Integer.toString(authNumber);
		}
		
		public void questionEmail(String email, String qcontent, String qcomment) {
			String setFrom = ".com"; // email-config에 설정한 자신의 이메일 주소를 입력 
			String toMail = email;
			String title = "FitQuest 1:1 문의 답변 확인 부탁드립니다."; // 이메일 제목 
			String content = 
					"<h1><font color=\"#FAC710\">Fitquest에 방문해 주셔서 감사합니다.</font></h1>" + 	//html 형식으로 작성 ! 
				    "남겨주신 문의에 대한 답변을 남겼습니다.<br>" + 
				    "마이페이지 문의 내역을 통해 답변을 확인할 수 있습니다." + 
				    "<br><br>" + 
				    "<h3><font color=\"blue\" style=\"font-weight: bold;\">문의 내용</font></h3>" + 
				    "<font>" + qcontent + "</font>" + 
				    "<hr>" +
				    "<h3><font color=\"red\" style=\"font-weight: bold;\">관리자 답변</font></h3>" + 
				    "<font>" + qcomment + "</font>" + 
				    "<br><br>";
			mailSend(setFrom, toMail, title, content);
			System.out.println("이메일 전송 성공");
		}
		
		//이메일 전송 메소드
		public void mailSend(String setFrom, String toMail, String title, String content) { 
			MimeMessage message = mailSender.createMimeMessage();
			// true 매개값을 전달하면 multipart 형식의 메세지 전달이 가능.문자 인코딩 설정도 가능하다.
			try {
				MimeMessageHelper helper = new MimeMessageHelper(message,true,"utf-8");
				helper.setFrom(setFrom);
				helper.setTo(toMail);
				helper.setSubject(title);
				// true 전달 > html 형식으로 전송 , 작성하지 않으면 단순 텍스트로 전달.
				helper.setText(content,true);
				mailSender.send(message);
			} catch (MessagingException e) {
				e.printStackTrace();
			}
		}
		
	
}