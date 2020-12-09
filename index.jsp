<%-- 
    Document   : newjsp
    Created on : 9 Dec, 2020, 7:14:11 AM
    Author     : siva guru
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.Properties" %>
<%@page import="javax.mail.*" %>
<%@page import="javax.mail.internet.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>sending mail</title>
         </head>
    <body onload="display()">
        <%!
            public static class SMTPAuthenticator extends Authenticator{
            public PasswordAuthentication getPasswordAuthentication(){
              return new PasswordAuthentication(uname","password");
             }
}
%>
<%
    int result=0;
    if (request.getParameter("send")!=null){
        String uname="user id";//example: karma12
        String pass="password";
        String host="smtp.gmail.com";
        int port=465;
        
        String mto=new String();
        String from="gmail";
        String text=new String();
        
     if (request.getParameter("to")!=null){
      mto=request.getParameter("to");
    }
    if (request.getParameter("message")!=null){
      text="welcome";
      text=text.concat(request.getParameter("message"));
    }
    Properties props=new Properties();
    SMTPAuthenticator auth=new SMTPAuthenticator();
    Session ses=Session.getInstance(props,auth);
    MimeMessage msg=new MimeMessage(ses);
    msg.setContent(text,"text/html");
    msg.setFrom(new InternetAddress(from));
    msg.addRecipient(Message.RecipientType.TO,new InternetAddress(mto));
    try{
        Transport transport=ses.getTransport("smtps");
        transport.connect(host,port,uname,pass);
        transport.sendMessage(msg,msg.getAllRecipients());
        transport.close();
        result=1;
    }catch(Exception e){
        out.println(e);
    }
    
    }
    %>
   
    <form name="myform" action="index.jsp" method="POST">
            TO:<input type="text"  name="to"/> <br>
            FROM:<input type="text" name="from"/><br>
            <textarea name="message" rows="4" cols="50">
            </textarea> <br>
            <input type="hidden" name="hidden" value="<%= result%>" /><br>
            SUBMIT:<input type="submit" name="send" value="send"/>
    </form>
            <script language="JavaScript">
                function display(){
                    if(document.myform.hidden.value==="1")
                    {
                        alert("mail was send");
                    }
                }
             </script>
    </body>
</html>
