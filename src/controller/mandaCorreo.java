package controller;
import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.apache.commons.mail.EmailException;



public class mandaCorreo {

		// skillsharingeam@gmail.com
		// EI1027aem
		// http://josedeveloper.com/2016/08/15/enviar-correo-gmail-java/
		public static void enviarMensaje(String correo, String tipo) throws AddressException, MessagingException, EmailException{
	       
		  	String SMTP_HOST_NAME = "smtp.gmail.com";
	    	int SMTP_HOST_PORT = 465;
	    	String SMTP_AUTH_USER = "skillsharingeam@gmail.com";
	    	String SMTP_AUTH_PWD  = "EI1027aem";
	    	
			
			
	    	Properties props = new Properties();

	        props.put("mail.transport.protocol", "smtps");
	        props.put("mail.smtps.host", SMTP_HOST_NAME);
	        props.put("mail.smtps.auth", "true");
	        // props.put("mail.smtps.quitwait", "false");

	        Session mailSession = Session.getDefaultInstance(props);
	        mailSession.setDebug(true);
	        Transport transport = mailSession.getTransport();

	        MimeMessage message = new MimeMessage(mailSession);
	        message.setSubject("Nueva colaboración en Skill Sharing");
	        message.setContent("<h2><strong>Hola!</strong></h2><p>Se ha generado una nueva colaboración en la que participas a partir de una "+tipo+" tuya, entra en skill sharing para tener más información.</p><p>Esperamos verte pronto por la plataforma.</p><br><p>El equipo de skill sharing</p>", "text/html; charset=utf-8");

	        message.addRecipient(Message.RecipientType.TO,
	             new InternetAddress(correo));

	        transport.connect
	          (SMTP_HOST_NAME, SMTP_HOST_PORT, SMTP_AUTH_USER, SMTP_AUTH_PWD);

	        transport.sendMessage(message,
	            message.getRecipients(Message.RecipientType.TO));
	        transport.close();
		}
	
}
